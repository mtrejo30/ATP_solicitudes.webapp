package com.atp.solicitudes.controller;

import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import org.jfree.util.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.manager.impl.DomainManagerImpl;
import com.atp.solicitudes.model.CancellationMotiveEnum;
import com.atp.solicitudes.model.DocumentoSolicitud;
import com.atp.solicitudes.model.OperationValidationStateEnum;
import com.atp.solicitudes.model.Profile;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.SolicitudAppointment;
import com.atp.solicitudes.model.SolicitudOperationTypeEnum;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserTransportistas;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.utils.JSONUtils;
import com.objectwave.webservice.model.ServerResponse;


@Controller
@RequestMapping ("solicitud")
public class SolicitudController extends LocalBaseController
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(SolicitudController.class);
	
	static String SEARCH_INFO_PARAM = "search_info";
	static int MAX_AUTOCOMPLETE_RESULTS = 10; // 0 = all results
	String id_user;
	String id_N4_user;
	List<String> listObj1;
	static String APPOINTMENTS= " - Con citas";
	
	@Resource(name=DomainManager.BEAN_NAME)
	private DomainManager domainManager;
	
	@Resource(name=DomainManagerImpl.BEAN_NAME)
	private DomainManager domainManager_;

	@Resource(name=DomainManagerN4.BEAN_NAME)
	private DomainManagerN4 domainManagerN4;
	
	@Resource(name=DomainManager.BEAN_NAME)
	DomainManager manager;
	
	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpServletRequest request)
	{
		try
		{
			// assigns ModelSession to model object
			setModelSession(request.getSession(), model);
			
			User loggedUser = getLoggedUser(request);
			model.put("perfil", loggedUser.getProfile().getCode());
			model.put("n4", getValueOrNull(loggedUser.getUsuarioN4_id()));

			// ensure we clear the current solicitud of the session
			request.getSession().removeAttribute(Solicitud.SLOT_NAME);

			// combo fields
			model.put("statusList", JSONUtils.getJSONFromObject(OperationValidationStateEnum.allValues));
			model.put("typeList", JSONUtils.getJSONFromObject(SolicitudOperationTypeEnum.allValues));		
			
			
			
			model.put("cancelList", JSONUtils.getJSONFromObject(CancellationMotiveEnum.allValues));			

			// return view name to be used
			return "solicitud";
		}
		catch (Exception ex)
		{
			String errorMsg = MessageFormat.format("error while rendering page", new Object[] {});
			logger.error(errorMsg, ex);

			model.put("errorMessage", errorMsg);
			return "error";
		}
	}

	@RequestMapping(value = "/nivel/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getUserTransportistasByUserN4(@PathVariable(value = "id") String id)
	{

		 System.out.println("-----TRANSPORTISTA----------   " );
		List<String> values = Collections.emptyList();
		
		try{
			//values = domainManager_.getUsersColumnPropertyValues_(id);
		}
		catch (Exception ex)
		{
			logger.error("error while getting column values", ex);
		}

		return values;		
	}
	
	
	
	@RequestMapping(value = "/solicitud-table-info", method = RequestMethod.GET)
	@ResponseBody
	public Object solicitudTableInfoRequest(HttpServletRequest request) throws Exception, DomainModelException
	{
		//
		JsonNode node = JSONUtils.getJSONFromString(request.getParameter(SEARCH_INFO_PARAM));
		logger.info(node.toString());
		User loggedUser = getLoggedUser(request);
		String app_nbr=node.get("nbrField").asText();
		String app_contenedor=node.get("contenedorField").asText();
		String app_booking =node.get("bookingField").asText();
		String app_bl =node.get("bl").asText();
		String variable="";
		
//getdocumentos

			if(node.get("nbrField").asText()!="" |  node.get("contenedorField").asText()!="" |  node.get("bookingField").asText()!="" | node.get("bl").asText()!="")
			{
				
//				Integer aux_2=domainManager.getSolicitudId(aux);
				User loggedUserFilter = getLoggedUser(request);
				List<String> listIdList= null;
				if(loggedUserFilter.getProfile().getCode().equals("AC"))
				{	
					Log.error("cliente");
					//col = getSolicitudes(query, order);
					listIdList = domainManager.getSolicitudByN4(loggedUserFilter.getUsuarioN4_id().toString(), loggedUserFilter.getId().toString());
				 
				}else if(loggedUserFilter.getProfile().getCode().equals("TRA"))
				{
					Log.error("Transportista");
					listIdList = domainManager.getSolicitudByN4(loggedUserFilter.getId().toString());
				
				}				
				//List<String> listObj = domainManager.getSolicitudByN4(idUser);Trans
				
				List<Solicitud> solicitudes = new ArrayList<Solicitud>();
				List<String> solicitudescontenedor = new ArrayList<String>();
				SolicitudAppointment solicitudAppointment= domainManager.getSolicitudAppointmentWithAppNbr(app_nbr, listIdList);
				
				if(app_contenedor!="" || app_booking!="" || app_bl!="")
				{
					if(app_contenedor!="")
					{
						 variable = "'%\"contenedor\"%\""+app_contenedor+"\"%'";
						// variable = "\'%\"contenedor\":{\"id\":%,\"label\":\""+ app_contenedor +"\"}%\'";
					}
					if(app_booking!="")
					{
						 variable = "\'%\"booking\":{\"id\":%,\"label\":\""+ app_booking +"\"}%\'";
					}
					if(app_bl!="")
					{
						 variable = "\'%\"bl\":{\"id\":%,\"label\":\""+ app_bl +"\"}%\'";
					}
					if(loggedUserFilter.getProfile().getCode().equals("TA") || loggedUserFilter.getProfile().getCode().equals("TI"))
					{	System.out.print("ADMIN");
						solicitudescontenedor= domainManager.getSolicitudAppointmentWithcontenedor(loggedUser.getId().toString(),variable);
					}
					else if(loggedUserFilter.getProfile().getCode().equals("AC"))
					{
						System.out.print("CONSULTA1 ");
						solicitudescontenedor= domainManager.getSolicitudAppointmentWithcontenedorcon(loggedUser.getUsuarioN4_id().toString(),variable);

					}
					else
					 if(loggedUser.getUsuarioN4_id().equals(305898) && loggedUser.getProfile().getCode().equals("CON") )
						    {
						 System.out.print("CONSULTA1 con n4 privilefio");
						 		solicitudescontenedor= domainManager.getSolicitudAppointmentWithcontenedor(loggedUser.getId().toString(),variable);
						    }
					 else
							if((loggedUserFilter.getProfile().getCode().equals("CON") && loggedUser.getUsuarioN4_id().toString()!="305898") )
							{	System.out.print("CONSULTA"); 
							solicitudescontenedor= domainManager.getSolicitudAppointmentWithcontenedorcon(loggedUser.getUsuarioN4_id().toString(),variable);

							}
					else
						
					if(loggedUserFilter.getProfile().getCode().equals("TRA") )
					{	 System.out.print("TRA");
						
						solicitudescontenedor= domainManager.getSolicitudAppointmentWithcontenedortra(loggedUser.getId().toString(),variable);
					}
					else
						{	
						System.out.print("NOSE");
							solicitudescontenedor= domainManager.getSolicitudAppointmentWithcontenedorAA(loggedUser.getId().toString(),variable);
						}
					DaoQuery query = getTableQuery(request);
					DaoOrder order = getTableOrder(request);
					
					// include the relation to the user
					query.fetchEAGER("user");
					System.out.print("-----------entro------");
					DaoResult<Solicitud> col = new DaoResult<Solicitud>();
					col = domainManager.getSolicitudesByAdmin(query, order, solicitudescontenedor);
					ObjectNode object = getTableMainNode(col);
					ArrayNode rows = getSolicitudNodes(col.getCollection());
					object.put("rows", rows);
					String profileCode = loggedUser.getProfile().getCode();
				
					if (profileCode.equals(Profile.TA) ||  loggedUser.getProfile().getCode().equals("AC") || profileCode.equals(Profile.DEP) || profileCode.equals(Profile.LN) || profileCode.equals(Profile.RF) || profileCode.equals(Profile.TRA) || profileCode.equals(Profile.CLI) || profileCode.equals(Profile.CON) || profileCode.equals(Profile.TI) || loggedUser.getProfile().getCode().equals("AA"))
					{
						return object;
					}
					else
					{
						return null;
					}
					
				}
				
			
				
				if (solicitudAppointment != null )
				{
					Solicitud solicitud = domainManager.getSolicitudWithFolio(solicitudAppointment.getSolicitud().getFolio());
					
					solicitudes.add(solicitud);
					//solicitudes.add(solicitud_contenedor);
					DaoResult<Solicitud> col = new DaoResult<Solicitud>();
					col.setCollection(solicitudes);
					ObjectNode object = getTableMainNode(col);

					// Populate table
					ArrayNode rows = getSolicitudNodes(col.getCollection());

					// set the rows property
					String profileCode = loggedUser.getProfile().getCode();
					object.put("rows", rows);

					// perform query
					// return the object to the UI table
					if (profileCode.equals(Profile.TA) || profileCode.equals(Profile.TI) || 
							profileCode.equals(Profile.TRA) || loggedUser.getProfile().getCode().equals("AC"))
					{
						return object;
					}
					else
					{
						if (solicitud.getUser().getId().equals(loggedUser.getId()) )
						{
							
							return object;
						}
						else
						{
							return null;
						}
					}
				}
				else
				{
					return null;
				}
			}
			User loggedUserFilter = getLoggedUser(request);
		if(loggedUserFilter.getProfile().getCode().equals("TRA"))	
		{
		}else{
			if(node.get("ferrocarril").asInt() !=0 || node.get("linea").asInt()!=0||node.get("impedimentosField").asText()!="" ||  node.get("blsField").asText() !="" )
			{
				String pedim="";
				String bls="";
			   	String linea="";
			   	String fer=""; 
			   
				if(node.get("impedimentosField").asText()==""){pedim="''";}else{pedim ="'%"+node.get("impedimentosField").asText()+"%'";}
				if(node.get("blsField").asText()==""){bls="''";}else{bls ="'%"+node.get("blsField").asText()+"%'";}
				if(node.get("linea").asInt()==0)
				{  
					linea="''";
				
				}
				else{
						if(node.get("linea").asInt()==1)
						{ linea ="'Activo'";}
						if(node.get("linea").asInt()==2)
						{ linea ="'Inactivo'";
						}
					}
				if(node.get("ferrocarril").asInt()==0)
				{  
					fer="''";
				
				}
				else{
						if(node.get("ferrocarril").asInt()==1)
						{ fer ="'Activo'";}
						if(node.get("ferrocarril").asInt()==2)
						{ fer ="'Inactivo'";
						}
					}
				
				//if(node.get("linea").asText()==""){linea="''";}else{linea ="'"+node.get("linea").asText()+"'";}
			
			   	
					List<String> solicitudescontenedor = new ArrayList<String>();
					if(loggedUserFilter.getProfile().getCode().equals("TA") || loggedUserFilter.getProfile().getCode().equals("TI"))
					{	System.out.print("ADMIN");
						solicitudescontenedor= domainManager.getdocumentostodos(bls,pedim,linea,fer,loggedUser.getId().toString());
					}
					else if(loggedUserFilter.getProfile().getCode().equals("AC"))
					{
						System.out.print("CONSULTA1 ");
						solicitudescontenedor= domainManager.getdocumentoscon(bls,pedim,linea,fer,loggedUser.getId().toString());
	
					}
					else
					 if(loggedUser.getUsuarioN4_id().equals(305898) && loggedUser.getProfile().getCode().equals("CON") )
						    {
						 System.out.print("CONSULTA1 con n4 privilefio");
						 		solicitudescontenedor= domainManager.getdocumentostodos(bls,pedim,linea,fer,loggedUser.getId().toString());
						    }
					 else
							if((loggedUserFilter.getProfile().getCode().equals("CON") && loggedUser.getUsuarioN4_id().toString()!="305898") )
							{	System.out.print("CONSULTA"); 
							solicitudescontenedor= domainManager.getdocumentoscon(bls,pedim,linea,fer,loggedUser.getId().toString());
	
							}
						
					/*if(loggedUserFilter.getProfile().getCode().equals("TRA") )
					{	 System.out.print("TRA");
						
						solicitudescontenedor= domainManager.getdocumentostra(bls,pedim,linea,fer,loggedUser.getId().toString());
					}*/
					if(loggedUserFilter.getProfile().getCode().equals("AA") )
						{	
						System.out.print("AA");
						solicitudescontenedor= domainManager.getdocumentos(bls,pedim,linea,fer,loggedUser.getId().toString());			 
						}		   	
				   	
				   	
				   	DaoQuery query_ = getTableQuery(request);
					DaoOrder order_ = getTableOrder(request);
					
					// include the relation to the user
					query_.fetchEAGER("user");
					System.out.print("-----------entro------");
					DaoResult<Solicitud> col_ = new DaoResult<Solicitud>();
					col_ = domainManager.getSolicitudesByAdmin(query_, order_, solicitudescontenedor);
					ObjectNode object_ = getTableMainNode(col_);
					ArrayNode rows_ = getSolicitudNodes(col_.getCollection());
					object_.put("rows", rows_);
					String profileCode_ = loggedUser.getProfile().getCode();
				
					if (profileCode_.equals(Profile.TA) ||  loggedUser.getProfile().getCode().equals("AC") || profileCode_.equals(Profile.DEP) || profileCode_.equals(Profile.LN) || profileCode_.equals(Profile.RF) || profileCode_.equals(Profile.TRA) || profileCode_.equals(Profile.CLI) || profileCode_.equals(Profile.CON) || profileCode_.equals(Profile.TI) || loggedUser.getProfile().getCode().equals("AA"))
					{
						return object_;
					}
					else
					{
						return null;
					}	
				
			}	
		}
		if(loggedUserFilter.getProfile().getCode().equals("TA") || loggedUserFilter.getProfile().getCode().equals("TI"))	
		{
			if(node.get("custumField").asText()!="")
			{
				variable = "'%"+node.get("custumField").asText()+"%'";
				List<String> solicitudescontenedor = new ArrayList<String>();
				if(loggedUserFilter.getProfile().getCode().equals("TA") || loggedUserFilter.getProfile().getCode().equals("TI"))
				{	System.out.print("ADMIN");
					solicitudescontenedor= domainManager.getpedimentos(variable);
				}
				
			   	DaoQuery query_ = getTableQuery(request);
				DaoOrder order_ = getTableOrder(request);
				
				// include the relation to the user
				query_.fetchEAGER("user");
				System.out.print("-----------entro------");
				DaoResult<Solicitud> col_ = new DaoResult<Solicitud>();
				col_ = domainManager.getSolicitudesByAdmin(query_, order_, solicitudescontenedor);
				ObjectNode object_ = getTableMainNode(col_);
				ArrayNode rows_ = getSolicitudNodes(col_.getCollection());
				object_.put("rows", rows_);
				String profileCode_ = loggedUser.getProfile().getCode();
			
				if (profileCode_.equals(Profile.TA) ||  profileCode_.equals(Profile.TI) )
				{
					return object_;
				}
				else
				{
					return null;
				}
			}
		}
					
		//String profileCode = loggedUser.getProfile().getCode();
		
		
		DaoQuery query = getTableQuery(request);
		DaoOrder order = getTableOrder(request);

		// include the relation to the user
		query.fetchEAGER("user");
		DaoResult<Solicitud> col = null;
		// Get users to be displayed on table
		if(loggedUser.getProfile().getCode().equals("AC") )
		{	
			
			//col = getSolicitudes(query, order);
		    col = getSolicitudes(query, order, loggedUser.getUsuarioN4_id().toString(), loggedUser.getId().toString());	  
		}
		else if(loggedUser.getProfile().getCode().equals("TRA"))
		{
			String vlNivel ;
			
		//UserTransportistas use_tras = new UserTransportistas();
			//use_tras.getNivel();
			/*HttpSession session = request.getSession();
			Solicitud solicitud = (Solicitud) session.getAttribute(Solicitud.SLOT_NAME);
			solicitud = manager.getSolicitudWithFolio(solicitud.getFolio());
			//model.put(Solicitud.SLOT_NAME, solicitud);
			solicitud = manager.getSolicitudWithFolio(solicitud.getFolio());
			User solicitudUser = manager.getUserFromSolicitud(solicitud);
		
			UserTransportistas objNivel = manager.getUserTransportistasWithIdN4Transport(solicitudUser.getId(),solicitudUser.getUsuarioN4_id(),loggedUser.getUsuarioN4_id());
			if(objNivel != null)
				vlNivel   = objNivel.getNivelString();
			else
				vlNivel="Ninguno";
			 System.out.println("-----TRANSPORTISTA----------   " + vlNivel);*/
			
			id_user =loggedUser.getId().toString();
			this.id_N4_user =loggedUser.getUsuarioN4_id().toString();
			col = getSolicitudes(query, order, loggedUser.getId().toString());
		}
		else if(loggedUser.getProfile().getCode().equals("TA") || loggedUser.getProfile().getCode().equals("TI"))
		{
			 col = getSolicitudes(query, order);
			//Log.error("Transportista");
			//col = getSolicitudes(query, order, loggedUser.getId().toString());
		}
		else
		{
			col = getSolicitudesdetodos(query, order, loggedUser.getId().toString());
			//col = getSolicitudes(query, order);
		}
	    if(loggedUser.getUsuarioN4_id().equals(305898) && loggedUser.getProfile().getCode().equals("CON") )
		    {
		
			   col = getSolicitudes(query, order);
		    }
		 else  if(loggedUser.getUsuarioN4_id().toString()!="305898" && loggedUser.getProfile().getCode().equals("CON") )
		    {
			
			 col = getSolicitudes(query, order, loggedUser.getUsuarioN4_id().toString(), loggedUser.getId().toString());
		    }
		if(col != null)
		{
			ObjectNode object = getTableMainNode(col);
			
			// Populate table
			ArrayNode rows = getSolicitudNodes(col.getCollection());

			// set the rows property
			object.put("rows", rows);

			// return the object to the UI table
			return object;
		}
		else
		{return null;}
		
		
	}

	private DaoQuery getTableQuery(HttpServletRequest request)
	{
		// map for query filters
		DaoQuery query = null;
		
		try
		{
			query = domainManager.getQueryWithUserFilter(getLoggedUser(request));

			// request parameters that defines the page and number of rows to get
			injectTablePaginationParameters(query, request);

			// request total rows
			query.setRequestTotalRows(true);
		
			JsonNode node = JSONUtils.getJSONFromString(request.getParameter(SEARCH_INFO_PARAM));

			// if no search info, return an empty query map
			if (node == null)
				return query;

			addIntegerParameterToQuery(query, node, "folio", "folio");
			addStringParameterToQuery(query, node, "reference", "reference");
			addStringParameterToQuery(query, node, "usuario", "user.username");
			addObjectParameterToQuery(query, node, "status", "status", new OperationValidationStateEnum.IdResolver());
			addObjectParameterToQuery(query, node, "operationType", "operationType", new SolicitudOperationTypeEnum.IdResolver());
//			addStringParameterToQuery(query, node, "nbrField", "nbrField");
//			addStringParameterToQuery(query, node, "hasDocuments", "hasDocuments");
		}		
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("error while processing query information", new Object[] {});
			logger.error(errorMsg, e);	
		}
		//TODO obtain nbr
		return query;
	}

	
	@RequestMapping(value = "/solicitud-table-row", method = RequestMethod.POST)
	@ResponseBody
	public Object solicitudTableRowRequest(@RequestBody JsonNode nodeQuery) throws Exception
	{
		DaoQuery query = DaoQuery.withFilter("folio", nodeQuery.get("id").asInt());
		query.fetchEAGER("user");
		DaoOrder order = new DaoOrder();

		DaoResult<Solicitud> col = getSolicitudes(query, order);
		
		// collection to hold all the rows
		ArrayNode rows = getSolicitudNodes(col.getCollection());
		
		ServerResponse response = new ServerResponse();
		
		response.setBody(rows.get(0));

		return response;
	}

	private DaoResult<Solicitud> getSolicitudes(DaoQuery query, DaoOrder order)
	{
		DaoResult<Solicitud> col = null;

		// perform query
		try
		{
			col = domainManager.querySolicitud(query, order);
		}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("Error_while_retrieving_solicitudes", new Object[] {});
			logger.error(getMessageFromResource(errorMsg), e);
		}

		return col;
	}
	
	private DaoResult<Solicitud> getSolicitudes(DaoQuery query, DaoOrder order, String userN4, String idUser) 
	{
		DaoResult<Solicitud> col = new DaoResult<Solicitud>();
		List<Solicitud> obj = null;
		
		try
		{
			List<String> listIdList = domainManager.getSolicitudByN4(userN4, idUser);
			
			
			col = domainManager.getSolicitudesByAdmin(query, order, listIdList);
		}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("Error_while_retrieving_solicitudes", new Object[] {});
			logger.error(getMessageFromResource(errorMsg), e);
		}
		return col;
	}
	
	private DaoResult<Solicitud> getSolicitudes(DaoQuery query, DaoOrder order, String idUser) throws Exception, DomainModelException
	{
		DaoResult<Solicitud> col = new DaoResult<Solicitud>();

		// perform query
		try
		{
			List<String> listObj = domainManager.getSolicitudByN4(idUser);
			
			 listObj1 = domainManager.getUsersColumnPropertyValues_(this.id_user,this.id_N4_user);
			/*String[] listId = new String[listObj.size()];
			for (int i = 0; i < listObj.size()-1; i++)
			{http://localhost:8080/solicitudes/solicitud.page
				listId[i] = listObj.get(i);
			}*/
			 
				 col = domainManager.getSolicitudesByAdmin(query, order, listObj);
					
			
			//col = domainManager.getSolicitudesByAdmin(query, order,idUser);
			}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("Error_while_retrieving_solicitudes", new Object[] {});
			logger.error(getMessageFromResource(errorMsg), e);
		}
		return col;
	}
	 
	
	// prueba
	private DaoResult<Solicitud> getSolicitudesdetodos(DaoQuery query, DaoOrder order, String User)
	{
		DaoResult<Solicitud> col = new DaoResult<Solicitud>();
		List<Solicitud> obj = null;
		// perform query
		try
		{
			List<String> listIdList = domainManager.getSolicitudByN4_(User);
			col = domainManager.getSolicitudesByAdmin(query, order, listIdList);
		}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("Error_while_retrieving_solicitudes", new Object[] {});
			logger.error(getMessageFromResource(errorMsg), e);
		}
		return col;
	}
	
	
	private ArrayNode getSolicitudNodes(List<Solicitud> col) throws Exception
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		DateFormat formatter = (DateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss");

		// loop through the resulting objects
		for (Solicitud eachObj : col)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			eachObject.put("id", eachObj.getFolio());

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);

			//
			Solicitud sol= domainManager.getSolicitudWithFolio(eachObj.getFolio());
			List <SolicitudAppointment> appointments= domainManager.getSolicitudAppointmentWithSolicitud(sol);
			DocumentoSolicitud doc= domainManager.getDocumentoSolicitudBySolicitudId(sol);
			StringBuilder rest = new StringBuilder();
			if(doc!=null)
			{
				rest.append("Si");
				if(appointments!=null)
				{
					rest.append(APPOINTMENTS);
				}
			}
			else
			{
				rest.append("No");
				if(appointments!=null )
				{
					rest.append(APPOINTMENTS);
				}
			}
			//
			// column info
			eachArray.add(eachObj.getFolio());
			eachArray.add(eachObj.getReference());
			eachArray.add(eachObj.getUser().getUsername());
			eachArray.add(eachObj.getOperationType().getName());
			eachArray.add(eachObj.getStatus().getName());
//			eachArray.add(eachObj.getDateScheduled() == null ? "" : formatter.format(eachObj.getDateScheduled()));
			eachArray.add(formatter.format(eachObj.getDateCreated()));
			eachArray.add(formatter.format(eachObj.getDateUpdated()));
			eachArray.add(rest.toString());

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}
	
	@RequestMapping (value = "/update-solicitud-status", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse updateSolicitudStatusRequest(@RequestBody JsonNode node, Map<String, Object> model, HttpServletRequest request)
	{
		ServerResponse serverResponse = new ServerResponse();
		Solicitud solicitud = null;
		
		try
		{
			// retrieve the Solicitud
			solicitud = domainManager.getSolicitudWithFolio(node.get("id").asInt());
			
			if (solicitud == null)
				throw new Exception();
			
			// retrieve the request status 
			OperationValidationStateEnum newStatus = OperationValidationStateEnum.withId(node.get("status").asInt());			
			
			User loggedUser = getLoggedUser(request);
			// update solicitud status
			domainManager.updateSolicitudStatus(solicitud, newStatus, loggedUser.getProfile());

			if(newStatus.toString().equalsIgnoreCase("CANCELADO"))
				domainManagerN4.cancelSolicitud(solicitud);

			ObjectNode responseNode = new ObjectNode(JsonNodeFactory.instance);

			responseNode.put("id", solicitud.getFolio());
			responseNode.put("status", newStatus.getName());
			
			responseNode.put("agenciaAduanal_Id", solicitud.getAgentId());
			responseNode.put("cliente_Id", solicitud.getClienteId());
			
			SimpleDateFormat dateFormatter = (SimpleDateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss");
			String dateUpdate = dateFormatter.format(solicitud.getDateUpdated());

			responseNode.put("dateUpdated", dateUpdate);
	
			serverResponse.setBody(responseNode);
			serverResponse.setMessage(getMessageFromResource("Solicitud_updated"));
			
		}
		catch (DomainModelException ex)
		{
			String msg = getMessageFromResource(ex.getMessage());
			
			serverResponse.setError(true);
			serverResponse.setMessage(msg);
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_getting_solicitud");

			logger.error(msg, ex);
			serverResponse.setError(true);
			serverResponse.setMessage(msg);
		}		
		return serverResponse;
	}

	@RequestMapping (value = "/citas-solicitud", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse citasSolicitudRequest(@RequestBody JsonNode node, HttpServletRequest request) throws DomainModelException
	{
		ServerResponse response = new ServerResponse();

		Solicitud solicitud = null;
		
		try
		{
			// retrieve the Solicitud
			solicitud = domainManager.getSolicitudWithFolio(node.get("id").asInt());
			// retrieve the User from the Solicitud (a different SQL request for this)
			domainManager.getUserFromSolicitud(solicitud);

			//TODO validate if we can edit the solicitud, return an error			
			
			// save the solicitud on the session object  
			HttpSession session = request.getSession();
			session.setAttribute(Solicitud.SLOT_NAME, solicitud);

  			
			if(domainManager.getDocumentoSolicitudBySolicitudId(solicitud)==null)
			{
			// set the proper view for the operation type
			response.setBody(solicitud.getOperationType().getView());
			}
			else
			if(domainManager.getDocumentoSolicitudBySolicitudId(solicitud)!=null)
			{
				if(solicitud.getStatus().toString().equals("VALIDADO"))
				{
					response.setBody(solicitud.getOperationType().getView());
				}
				else
				{
					throw new DomainModelException ("Solicitud_has_not_been_validated");
				}
			}
			
		}
		catch (DomainModelException ex)
		{
			String msg = getMessageFromResource("Solicitud_has_not_been_validated");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);
		}
		
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_getting_solicitud");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);
		}
		
		return response;
	}

	@RequestMapping (value = "/save-solicitud", method = RequestMethod.POST)
	@ResponseBody
	public Object saveSolicitudRequest(@RequestBody JsonNode node, Map<String, Object> model, HttpServletRequest request)
	{
		ServerResponse serverResponse = new ServerResponse();
		
		try
		{
			Solicitud solicitud = null;
			
			Integer id = node.get("folio").asInt(); 
			if (id == 0)
				solicitud = new Solicitud();
			else
				solicitud = domainManager.getSolicitudWithFolio(id);

			Map<String,Object> context = Collections.emptyMap();

			solicitud.fillFrom(node, context);

			Date d = new Date();
			solicitud.setDateCreated(d);
			solicitud.setDateUpdated(d);
			solicitud.setUser(getLoggedUser(request));
			solicitud.setStatus(OperationValidationStateEnum.CARGADO);
 			//TODO check
 			int appointments_canceled=0;
			if (solicitud.getFolio() == null)
			{
				if (solicitud.getAgenciaAduanalId() != 0 && solicitud.getClienteId() != 0)
				{
					if (solicitud.getCodigoId() == null || solicitud.getCodigoId() != 0)
					{
						domainManager.saveSolicitud(solicitud);
					}
					else
					{
						throw new DomainModelException("Solicitud_must_have_a_custom_code");
					}
				}
				else
				{
					throw new DomainModelException("Solicitud_should_contains_agent_and_client");
				}
			}
			else
				if (solicitud.getFolio() != null)
				{
					if (solicitud.getAgenciaAduanalId() != 0 && solicitud.getClienteId() != 0)
					{
						if (solicitud.getCodigoId() == null || solicitud.getCodigoId() != 0)
						{
							List<SolicitudAppointment> appointments = domainManager.getSolicitudAppointmentWithSolicitud(solicitud);
							if (appointments == null)
								domainManager.saveSolicitud(solicitud);
							else
								if (appointments != null)
								{
									for (int i = 0; i < appointments.size(); i++)
									{
										if (!appointments.get(i).getStatus().getName().equals("CANCELED"))
										{
											appointments_canceled = appointments_canceled + 1;
										}
									}
									if (appointments_canceled == appointments.size())
										domainManager.saveSolicitud(solicitud);
								}
							if (appointments != null)
							{
								throw new DomainModelException("Solicitud_can_not_be_modified");
							}
						}
						else
						{
							throw new DomainModelException("Solicitud_must_have_a_custom_code");
						}
					}
					else
					{
						throw new DomainModelException("Solicitud_should_contains_agent_and_client");
					}
				}
			
			ObjectNode responseNode = new ObjectNode(JsonNodeFactory.instance);
			responseNode.put("id", solicitud.getFolio());
			
			serverResponse.setBody(responseNode);
			serverResponse.setMessage(getMessageFromResource("Solicitud_registered"));
		}
		catch (DomainModelException ex)
		{
			String msg = getMessageFromResource(ex.getMessage());
			serverResponse.setErrorMessage(msg );
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_saving_solicitud");

			logger.error(msg, ex);
			serverResponse.setErrorMessage(msg );
		}

		return serverResponse;
	}
 	
	@RequestMapping(value = "/solicitud-reference", method = RequestMethod.GET)
	@ResponseBody
	public Object getSolicitudReferenceRequest(@RequestParam("term") String queryPattern)
	{
		DomainManager manager = getDomainManager();
		
		List<String> names = Collections.emptyList();

		try
		{
			names = manager.getSolicitudColumnValues("reference", "%" + queryPattern.trim() + "%", MAX_AUTOCOMPLETE_RESULTS);
		}
		catch (Exception ex)
		{
			logger.error(getMessageFromResource("Error_when_getting_solicitudreference"), ex);
		}

		return names;					
	}

	@RequestMapping(value = "/solicitud-folio", method = RequestMethod.GET)
	@ResponseBody
	public Object getSolicitudFolioRequest(@RequestParam("term") String queryPattern)
	{
		DomainManager manager = getDomainManager();
		
		List<String> names = Collections.emptyList();
		
		String colName = "cast(id as string)";

		try
		{
			names = manager.getSolicitudColumnValues(colName, "%" + queryPattern.trim() + "%", MAX_AUTOCOMPLETE_RESULTS);
		}
		catch (Exception ex)
		{
			logger.error(getMessageFromResource("Error_when_getting_solicitudfolio"), ex);
		}

		return names;					
	}
	
	
	@RequestMapping(value = "/solicitud-nbr", method = RequestMethod.GET)
	@ResponseBody
	public Object getSolicitudNbrRequest(@RequestParam("term") String queryPattern)
	{
		DomainManager manager = getDomainManager();
		
		List<String> names = Collections.emptyList();
		
		String colName = "cast(folio as string)";

		try
		{
			names = manager.getSolicitudColumnValues(colName, "%" + queryPattern.trim() + "%", MAX_AUTOCOMPLETE_RESULTS);
		}
		catch (Exception ex)
		{
			logger.error(getMessageFromResource("Error_when_getting_solicitudfolio"), ex);
		}

		return names;					
	}
	
	
	@RequestMapping(value = "/usuario", method = RequestMethod.GET)
	@ResponseBody
	public Object getUsuarioRequest(@RequestParam("term") String queryPattern)
	{
		DomainManager manager = getDomainManager();
		
		List<String> names = Collections.emptyList();
		
		String colName = "username";

		try
		{
			names = manager.getUsersColumnPropertyValues(colName, "%" + queryPattern.trim() + "%", MAX_AUTOCOMPLETE_RESULTS);
		}
		catch (Exception ex)
		{
			logger.error(getMessageFromResource("Error_when_getting_usernames"), ex);
		}

		return names;					
	}

	@RequestMapping(value = "/edit-solicitud", method = RequestMethod.POST)
	public @ResponseBody Object editSolicitudRequest(@RequestBody JsonNode obj) throws Exception
	{			
		ServerResponse response = new ServerResponse();
//		HttpSession session = request.getSession();
		Solicitud solicitud=null;
//		Solicitud solicitud = (Solicitud) session.getAttribute(Solicitud.SLOT_NAME);
		//get the id of the solicitud to edit
		 
		 
//		solicitud = domainManager.getSolicitudWithFolio(solicitud.getFolio());
		//get the solicitud
		try
		{  
			DomainManager manager = getDomainManager();
			solicitud = manager.getSolicitudWithFolio(obj.get("id").asInt());
 		}
		catch (Exception e)
		{
			// Something was wrong while doing the search
			String msg = "Error while executing query";
			response.setError(true);
			response.setMessage(msg + " - " + e);
			return response;
		}
		
		response.setBody(solicitud); 
		return response;
	}
	
	
	
	
	@RequestMapping (value = "/documents-solicitud", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse documentsSolicitudRequest(@RequestBody JsonNode node, HttpServletRequest request)
	{
		ServerResponse response = new ServerResponse();

		Solicitud solicitud = null;
		
		try
		{
			// retrieve the Solicitud
			solicitud = domainManager.getSolicitudWithFolio(node.get("id").asInt());
			// retrieve the User from the Solicitud (a different SQL request for this)
			domainManager.getUserFromSolicitud(solicitud);
			
			// save the solicitud on the session object  
			HttpSession session = request.getSession();
			session.setAttribute(Solicitud.SLOT_NAME, solicitud);
				
			if (SolicitudOperationTypeEnum.IMPO.equals(solicitud.getOperationType())
					||SolicitudOperationTypeEnum.EXPO.equals(solicitud.getOperationType())
					   ||SolicitudOperationTypeEnum.ENTREGA_VACIO.equals(solicitud.getOperationType())
					     ||SolicitudOperationTypeEnum.RECEPCION_VACIO.equals(solicitud.getOperationType())
					       ||SolicitudOperationTypeEnum.DESISTIMIENTO.equals(solicitud.getOperationType())
					)
				response.setBody("user-document");
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_getting_solicitud");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);
		}
		
		return response;
	}
	
}