package com.atp.solicitudes.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.AgenciaAduanal;
import com.atp.solicitudes.model.CancellationMotiveEnum;
import com.atp.solicitudes.model.Cliente;
import com.atp.solicitudes.model.OperadorTransportista;
import com.atp.solicitudes.model.OperationValidationStateEnum;
import com.atp.solicitudes.model.PaqueteComercial;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.SolicitudAppointment;
import com.atp.solicitudes.model.SolicitudOperationTypeEnum;
import com.atp.solicitudes.model.Transportista;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.objectwave.exception.DomainModelException;
import com.objectwave.utils.JSONUtils;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping("appointment")
public class AppointmentController extends LocalBaseController
{
	protected static Logger logger = LoggerFactory.getLogger(AppointmentController.class);

	static int MAX_AUTOCOMPLETE_RESULTS = 20; // 0 = all results
	
	@Resource(name=DomainManagerN4.BEAN_NAME)
	DomainManagerN4 managerN4;
	
	@Resource(name=DomainManager.BEAN_NAME)
	DomainManager manager;
	
	@Resource(name = "domainManager_reports")
	ReportsDomainManager managerReports;

	@RequestMapping
	public String show(Map<String, Object> model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		setModelSession(session, model);

		Solicitud solicitud = (Solicitud) session.getAttribute(Solicitud.SLOT_NAME);

		try
		{
			solicitud = manager.getSolicitudWithFolio(solicitud.getFolio());
			model.put(Solicitud.SLOT_NAME, solicitud);

			// set the user owner of the solicitud
			User solicitudUser = manager.getUserFromSolicitud(solicitud);
			model.put("solicitudUser", solicitudUser);

			List<SolicitudAppointment> col = manager.getSolicitudAppointmentFromSolicitud(solicitud);
			
			//Get all the transporters rows
			if(col !=null  && col.size() >0)
			{
				List<String> transporterRows = new ArrayList<String>();
			
				for (SolicitudAppointment each : col)
				{
					if(!transporterRows.contains(each.getTransportistaId()+"_"+each.getOperadorId()+"_"+each.getPlacas()+"_"+each.getDateScheduled().toString()))
					{
						transporterRows.add(each.getTransportistaId()+"_"+each.getOperadorId()+"_"+each.getPlacas()+"_"+each.getDateScheduled().toString());
					}
				}
				
				//Get all the appointments for each transporter row
				
				ObjectMapper mapper = new ObjectMapper();
				ArrayNode allTransporters = mapper.createArrayNode();
				
				if(transporterRows.size()>0)
				{
					
					int tableTransporterId= 1;
					for(String eachTransporterRow : transporterRows)
					{
						String arrayTransporterRow [] = eachTransporterRow.split("_");
						
						String transporterID =arrayTransporterRow[0];
						String operatorID =arrayTransporterRow[1];
						String placas = arrayTransporterRow[2];
						String stringDate = arrayTransporterRow[3];
						
						ObjectNode  aTransporter = mapper.createObjectNode();
						
						Integer eachTranporterId = Integer.valueOf(transporterID);
						aTransporter.put("id", tableTransporterId);
						ObjectNode  transporterDetail = mapper.createObjectNode();
						transporterDetail.put("id", eachTranporterId);
						transporterDetail.put("label", managerN4.getTransportistaWithId(eachTranporterId).getNombre());
						aTransporter.put("transporter", transporterDetail);
						
						
						Integer operatorId = Integer.valueOf(operatorID);
						ObjectNode  operatorDetail = mapper.createObjectNode();
						operatorDetail.put("id", operatorId);
						operatorDetail.put("label", managerN4.getOperadorTransportistaWithGkey(operatorId).getName());
						aTransporter.put("operator", operatorDetail);
						
						aTransporter.put("plates",placas);
						
						DateFormat dayFormat = (DateFormat) getBean("dateFormatter_yyyy-MM-dd"); 
						DateFormat timeFormat = (DateFormat) getBean("dateFormatter_hh_mm_ss");
						aTransporter.put("date",stringDate == null ? null : dayFormat.format(dayFormat.parse(stringDate)));
						aTransporter.put("time", stringDate == null ? null : stringDate.substring(11,stringDate.length()-2));
						
						
						//Get appointments for current transporter row
						StringBuilder stringBuilder = new StringBuilder();
						stringBuilder.append("[");
						for (SolicitudAppointment eachAppoinment : col)
						{
							if((eachAppoinment.getTransportistaId()+"_"+eachAppoinment.getOperadorId()+"_"+eachAppoinment.getPlacas()+"_"+eachAppoinment.getDateScheduled().toString()).equals(eachTransporterRow))
							{	//Remove ".label" because it's causing problems.
								stringBuilder.append(eachAppoinment.getDefinition().replace(".label", ""));
								stringBuilder.append(",");
							}
						}
						stringBuilder.deleteCharAt(stringBuilder.length()-1);
						stringBuilder.append("]");
						
						aTransporter.put("appointments",stringBuilder.toString());
						allTransporters.add(aTransporter);
						tableTransporterId++;
					}
					model.put("transporters", allTransporters);
				}
				
			}
			
			
			AgenciaAduanal aa = managerN4.getAgenciaAduanalWithId(solicitud.getAgentId());
			Cliente cliente = managerN4.getClienteWithId(solicitud.getClienteId());
			PaqueteComercial paquete =managerN4.getPaqueteComercialWithId(solicitud.getCodigoId());

			model.put(AgenciaAduanal.SLOT_NAME, aa);
			model.put(Cliente.SLOT_NAME, cliente);
			model.put(PaqueteComercial.SLOT_NAME, paquete);

			model.put("cancelList", JSONUtils.getJSONFromObject(CancellationMotiveEnum.allValues));			

			model.put("title", getPageTitle());
			model.put("view", getViewName());
			model.put("maxContainers", getMaxContainers());
		}
		catch (Exception ex)
		{
			String msg = "error while retrieving solicitud info";
			logger.error(msg, ex);

			model.put("errorMessage", msg);
			
			return "error";
		}

		return getViewName();
	}
	
	@RequestMapping(value="/cancel-solicitud", method = RequestMethod.POST)
	@ResponseBody
	public Object cancelSolicitud(@RequestBody JsonNode requestNode,  HttpServletRequest request) throws DomainModelException
	{
		ServerResponse response = new ServerResponse();

		try
		{
			//TODO CHECK
 			Solicitud solicitud = manager.getSolicitudWithFolio(requestNode.get("id").asInt());
			
			if(!solicitud.getStatus().toString().equals("CANCELADO"))
			{
 				List <SolicitudAppointment> appointments = manager.getSolicitudAppointmentWithSolicitud(solicitud);
				
				if(appointments==null)
				{
					
					ObjectNode responseNode = JsonNodeFactory.instance.objectNode();
					responseNode.put("status",solicitud.getStatus().getName());
					response.setMessage(getMessageFromResource("Appointment_cancelled"));
					response.setBody(responseNode);
					manager.setSolicitudStatus(solicitud, OperationValidationStateEnum.CANCELADO);
				
			    }	
				else
				{
					throw new DomainModelException("Solicitud_can_not_be_canceled");
				}
			
			}
			else
				if(solicitud.getStatus().toString().equals("CANCELADO"))
				{
				throw new DomainModelException("Solicitud_already_canceled");
				}
				
		}
		catch (DomainModelException ex)
		{
			String msg = ex.getMessage();

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_updating_appointment_status");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);
		}

		return response;
	}

	@RequestMapping(value="/cancel-appointment", method = RequestMethod.POST)
	@ResponseBody
	public Object cancelAppointment(@RequestBody JsonNode requestNode,  HttpServletRequest request) throws DomainModelException
	{
		ServerResponse response = new ServerResponse();

		try
		{
			 
			Solicitud solicitud = (Solicitud) request.getSession().getAttribute(Solicitud.SLOT_NAME);
			Solicitud solicitud_with_folio=manager.getSolicitudWithFolio(solicitud.getFolio());
			//Get appointment by AppointmentId
			SolicitudAppointment appointment = manager.getSolicitudAppointmentWithId(requestNode.get("appointment").asInt());
			appointment.getSolicitud();
			//Validate Cancellation by status, if status is CREATED allows Cancellation
			String penalty = null;
			if (appointment.canBeCanceledByStatus())
			{
				//Validate if the appointment has penalty
				if (appointment.getCancellationMotive()==null)
							if (manager.validateCancelAppointmentHasPenalty(appointment.getDateScheduled()))
								penalty = "PENALIDAD";
							else
								penalty = "";
				
					//Get the motive to Cancel
					CancellationMotiveEnum cancellationMotive = CancellationMotiveEnum.withId(requestNode.get("cancelSolicitudId").asInt());
					
					//Save the motive to Cancel locally
					if (appointment.getCancellationMotive()==null)
							manager.setAppointmentCancellationMotive(appointment, cancellationMotive);
					
					//Cancel Appointment WebService
					managerN4.cancelAppointment(appointment);
					
					//Call Stored Procedure to assign cancel motive
				    if (appointment.getStatus().toString().equals("CANCELED"))
							managerN4.callStoredProcedureCancellationAppointments(appointment.getAppointmentNbr(), appointment.getCancellationMotive().getName().toString() + " + "+ penalty);
					
				    //Notify appointment penalty
//					if (manager.validateCancelAppointmentHasPenalty(solicitud_with_folio.getDateScheduled()))
//					{
//						throw new DomainModelException("La cita cancelada tiene penalidad");
//					}
				    
					ObjectNode responseNode = JsonNodeFactory.instance.objectNode();
			        responseNode.put("status", appointment.getStatus().getName());
		            response.setMessage(getMessageFromResource("Appointment_canceled"));
					response.setBody(responseNode);
			
			}
			else
				if (appointment.getStatus().toString().equals("CANCELED"))
				{
					throw new DomainModelException("Appointment_already_canceled");
				}
				else
					if (appointment.getStatus().toString().equals("CLOSED") || appointment.getStatus().toString().equals("USED") || appointment.getStatus().toString().equals("USEDLATE"))
						throw new DomainModelException("Appointment_closed");
		}
		catch (DomainModelException ex)
		{
			String msg = ex.getMessage();

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_updating_appointment_status");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);
		}

		return response;
	}

	
	@RequestMapping(value="/accept-general-information.json", method = RequestMethod.POST)
	@ResponseBody
	public Object acceptGeneralInformation(@RequestBody JsonNode node, HttpServletRequest request) throws DomainModelException
	{
		ServerResponse response = new ServerResponse();
		
		logger.info("acceptGeneralInformation JSON Information : {} ", node);

		try
		{
			// get solicitud from session
			Solicitud solicitud = (Solicitud) request.getSession().getAttribute(Solicitud.SLOT_NAME);
			// refresh solicitud
			solicitud = manager.getSolicitudWithFolio(solicitud.getFolio());
			
			String dateStr = node.get("dayScheduled").asText();
			String timeStr = node.get("timeScheduled").asText();
			DateFormat format = (DateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss");
			Date scheduleDate = format.parse(dateStr + " " + timeStr);

			//check if solicitud can be edited
//			manager.validateSolicitudCanBeModified(solicitud, scheduleDate);
				
			// get user from solicitud
			User solicitudUser = manager.getUserFromSolicitud(solicitud);

			Integer transportistaId = node.get("transportista").asInt();
			Transportista transportista = managerN4.getTransportistaWithId(transportistaId);
			if (transportista == null ||transportistaId==0)
				throw new Exception("Transportista not found");
			
			Integer operadorId = node.get("operador").asInt();
			OperadorTransportista operador = managerN4.getOperadorTransportistaWithGkey(operadorId);
			if (operador == null||operadorId==0)
				throw new Exception("Operador not found");
			

			String placas = node.get("placas").asText();
			
			Date current = new Date();
			solicitud.setDateUpdated(current);

			ArrayNode appointments = (ArrayNode) node.get("appointments");
			ArrayNode appointmentsResponse = JsonNodeFactory.instance.arrayNode();
			if(solicitud.getOperationType().toString().equals("IMPO")
					||solicitud.getOperationType().toString().equals("EXPO")
					   ||solicitud.getOperationType().toString().equals("DESISTIMIENTO"))
			{
				prepareImpoExpoAndDesistimiento(solicitud, appointments);
			}
			
			if(solicitud.getOperationType().toString().equals("RECEPCION_VACIO")||solicitud.getOperationType().toString().equals("ENTREGA_VACIO"))
			{
				prepareEntregaDeVacios(solicitud, appointments);
			}
				
			// builder for create response
			StringBuilder builder = new StringBuilder();
//			builder.append(getMessageFromResource("Appointment_registered_please_verify_data_matches_what_is_requested"));
			builder.append("\r\n");
			//TODO
			
			
			for (JsonNode each : appointments)
			{
				
				ObjectNode eachAppointmentNode = (ObjectNode) each;				 
				//TODO setgate
				
				// default gate
				String gateId = getGateIdFromUserAndNode(solicitudUser, eachAppointmentNode);
				eachAppointmentNode.put("gateId", gateId);
				logger.info("gateId = {}", gateId);
				
				//setting appointment details
				eachAppointmentNode.put("dayScheduled",dateStr);
				eachAppointmentNode.put("placas",placas);
				eachAppointmentNode.put("operadorId",operadorId);
				eachAppointmentNode.put("transportistaId",transportista.getId());
				eachAppointmentNode.put("timeScheduled", timeStr);
				
				// transaction type
				String tranType = getTranType();
				eachAppointmentNode.put("tranType", tranType);
				logger.info("tranType = {}", tranType);
   
				Integer opId = null;

				try
				{
					opId = eachAppointmentNode.get("id").asInt();
					//TODO
					SolicitudAppointment appointment = managerN4.processSaveAppointment(eachAppointmentNode, solicitud);
					
					appointment.setPlacas(placas);
					appointment.setDateScheduled(scheduleDate);
					appointment.setTransportistaId(transportistaId);
					appointment.setOperadorId(operadorId);
					
					manager.saveSolicitudAppointment(appointment);
					
					ObjectNode responseNode = JsonNodeFactory.instance.objectNode();
	
					String nbr = appointment.getAppointmentNbr();
					responseNode.put("id", opId);
					responseNode.put("appointmentNbr", nbr);
					responseNode.put("appointmentId", appointment.getId());
					responseNode.put("status", appointment.getStatus().getName());

					appointmentsResponse.add(responseNode);
					
//					String block = String.format(getMessageFromResource("Operation_%d_successfully_registered_with_NBR_%s"), opId, nbr);
					managerN4.callAsignAgentClientReferenceAppointment(appointment.getAppointmentNbr(), solicitud.getAgentId(), solicitud.getClienteId(), solicitud.getReference());
 					managerN4.callAsignAgentClientRefAppointment(appointment.getAppointmentNbr(), solicitud.getAgentId(), solicitud.getClienteId());

 						if(solicitud.getOperationType().toString().equals("ENTREGA_VACIO"))
						{
 							managerN4.callAsignBookingItemGkey(eachAppointmentNode.get("tipo").get("id").asInt(), appointment.getAppointmentNbr());
						}
 					
 					
					builder.append(getMessageFromResource("Appointment_registered_please_verify_data_matches_what_is_requested"));
					builder.append(": "+nbr);
					builder.append("\r\n");
//					builder.append(block);
				}
				catch (DomainModelException ex)
				{
					String block = String.format(getMessageFromResource("Error_while_registering_operation_%d\r\n%s"), opId, ex.getMessage());

					builder.append("\r\n");
					builder.append(block);
				}
				catch (Exception ex)
				{
					String block = String.format(getMessageFromResource("Error_while_registering_operation_%d\r\n%s"), opId, ex.getMessage());

					builder.append("\r\n");
					builder.append(block);
				}
			}
			
			// if no errors on Web Service, save solicitud
			//TODO
			 
			manager.saveSolicitud(solicitud);
	

			response.setBody(appointmentsResponse);
			response.setMessage(builder.toString());
		}
		catch (DomainModelException ex)
		{
			String errorMsg = getMessageFromResource("Error_accepting_appointment") + " - " + getMessageFromResource(ex.getMessage());
			response.setErrorMessage(errorMsg);
		}
		catch (Exception ex)
		{
			String errorMsg = getMessageFromResource("Error_accepting_appointment");
			response.setErrorMessage(errorMsg);
			
			logger.error(errorMsg, ex);
		}

		return response;
	}
	//TODO
	public void prepareEntregaDeVacios(Solicitud solicitud, ArrayNode appointments) throws Exception, DomainModelException
	{
//		if(appointments.size()>1)
//		{
			String auxForType=null;
			String type=null;
			String recinto=null;
			int i=0;
			for (JsonNode each : appointments)
			{
			ObjectNode eachAppointmentNode = (ObjectNode) each;	
				if(eachAppointmentNode.has("tipo"))
				{
						auxForType=	eachAppointmentNode.get("tipo").get("label").asText();
						if (auxForType.contains("R"))
						{
							type+="R";
						}
						if(auxForType.contains("T"))
						{
							type+="T";
						}
						if(auxForType.contains("P"))
						{
							type+="P";
						}
						i++;
				}
			}
			if(type!=null)
			{
				if(type.contains("R")||type.contains("T")||type.contains("P"))
				{
					recinto="ATP";
				}
			}
			
			Solicitud auxForSolicitudApp=manager.getSolicitudWithFolio(solicitud.getFolio());
			if(auxForSolicitudApp.getRecinto()!=null)
			{
				if(recinto==null)
				{
					solicitud.setRecinto("DEPOSITO");
				}
				else
				{
					solicitud.setRecinto(recinto);
				}
				
				manager.saveSolicitud(solicitud);
			}
			else
			{
				if(recinto==null)
				{
					solicitud.setRecinto("DEPOSITO");
					manager.saveSolicitud(solicitud);
				}
				else
				{
					solicitud.setRecinto(recinto);
					manager.saveSolicitud(solicitud);
					throw new DomainModelException("Capture un nuevo horario");
				}
			}
//		}
//		else
//		{
//			
//		}
	}
	//TODO	
	public void prepareImpoExpoAndDesistimiento(Solicitud solicitud, ArrayNode appointments) throws DomainModelException, Exception
	{
		int i=0;
		String recintos[] = new String[appointments.size()];

		String auxForRecinto=null;
		if(appointments.size()>1)
		{
			for (JsonNode each : appointments)
			{
				
					ObjectNode eachAppointmentNode = (ObjectNode) each;
					
					if(eachAppointmentNode.has("recintoDestino"))
					{
						Iterator<String> auxForType=eachAppointmentNode.get("recintoDestino").getFieldNames();
						if(auxForType.hasNext())
						{
							recintos[i]=eachAppointmentNode.get("recintoDestino").get("label").asText();
							auxForRecinto=eachAppointmentNode.get("recintoDestino").get("label").asText();
							i++;
						}
					}
					if(eachAppointmentNode.has("recintoOrigen"))
					{
						Iterator<String> auxForType=eachAppointmentNode.get("recintoOrigen").getFieldNames();
						if(auxForType.hasNext())
						{
							recintos[i]=eachAppointmentNode.get("recintoOrigen").get("label").asText();
							auxForRecinto=eachAppointmentNode.get("recintoOrigen").get("label").asText();
							i++;
						}
					}
					//TODO check Freight Kind	
					if (eachAppointmentNode.has("fk"))
					{
						if (eachAppointmentNode.get("fk").get("label").asText().equals("FCL"))
						{
							if (eachAppointmentNode.get("contenido") == null || eachAppointmentNode.get("contenido").asText().equals("null"))
							{
								throw new DomainModelException(getMessageFromResource("Booking_content_not_defined_please_verify_with_Naviera_before_continue"));
							}
						}
					}
				
			}
			
			//TODO check
		
//			if(auxForRecinto!=null)
//			{
			 
				int counter=0;
				int counter_null=0;
				if(recintos!=null)
				{
					 for (int j=0; j<recintos.length; j++)
					 {
						 for(int k=0; k<recintos.length - 1; k++)
						 {
							 if(recintos[k]!=null && recintos[k+1]!=null)
							 {
							   if (recintos[k].equals(recintos[k+1]))
							   {
								   counter++;   
							   }
							 }
							 if(recintos[j]==null||recintos[j]=="")
							 {
								 counter_null++;
							 }
						 }
					 }
				}
				
				if(counter==recintos.length||counter_null==recintos.length)
				{
					Solicitud auxForSolicitudApp=manager.getSolicitudWithFolio(solicitud.getFolio());
					if(auxForSolicitudApp.getRecinto()!=null)
					{
						if(auxForRecinto==null)
						{
							solicitud.setRecinto("ATP");
						}
						else
						{
							solicitud.setRecinto("TIT");
						}							
						manager.saveSolicitud(solicitud);
					}
					else
					{
						if(auxForRecinto==null)
						{
							solicitud.setRecinto("ATP");
							manager.saveSolicitud(solicitud);
						}
						else
						{
							solicitud.setRecinto("TIT");
							manager.saveSolicitud(solicitud);
							throw new DomainModelException("Capture un nuevo horario");
						}

					}
				}

				else
				{
					throw new DomainModelException("Los recintos deben coincidir");
				}
		}
		else
		{
			String auxForRecintoApp=null;
			for (JsonNode each : appointments)
			{
				ObjectNode eachAppointmentNode = (ObjectNode) each;	
				if(eachAppointmentNode.has("recintoDestino"))
				{
					Iterator<String> auxForType=eachAppointmentNode.get("recintoDestino").getFieldNames();
					if(auxForType.hasNext())
					{
						auxForRecintoApp=eachAppointmentNode.get("recintoDestino").get("label").asText();
					}
				}
				if(eachAppointmentNode.has("recintoOrigen"))
				{
					Iterator<String> auxForType=eachAppointmentNode.get("recintoOrigen").getFieldNames();
					if(auxForType.hasNext())
					{
						auxForRecintoApp=eachAppointmentNode.get("recintoOrigen").get("label").asText();
					}
				}
				if (eachAppointmentNode.has("fk"))
				{
					if (eachAppointmentNode.get("fk").get("label").asText().equals("FCL"))
					{
						if (eachAppointmentNode.get("contenido") == null || eachAppointmentNode.get("contenido").asText().equals("null"))
						{
							throw new DomainModelException(getMessageFromResource("Booking_content_not_defined_please_verify_with_Naviera_before_continue"));
						}
					}
				}
			}

			Solicitud auxForSolicitudApp=manager.getSolicitudWithFolio(solicitud.getFolio());
			if(auxForSolicitudApp.getRecinto()!=null)
			{
				if(auxForRecintoApp==null)
				{
					solicitud.setRecinto("ATP");
				}
				else
				{
					solicitud.setRecinto("TIT");
				}							
				manager.saveSolicitud(solicitud);
			}
			else
			{
				if(auxForRecintoApp==null)
				{
					solicitud.setRecinto("ATP");
					manager.saveSolicitud(solicitud);
				}
				else
				{
					solicitud.setRecinto("TIT");
					manager.saveSolicitud(solicitud);
					throw new DomainModelException("Capture un nuevo horario");
				}
				
			}
		}
	}
	
//	@RequestMapping(value="/accept-appointment-data.json", method = RequestMethod.POST)
//	@ResponseBody
//	public Object acceptAppointmentData(@RequestBody JsonNode node, HttpServletRequest request)
//	{
//		ServerResponse response = new ServerResponse();
//
//		try
//		{
//			ObjectNode updatedNode = (ObjectNode) node;
//
//			logger.info("Json Information : {} " + updatedNode);
//			
//			// get the current solicitud
//			Solicitud solicitud = (Solicitud) request.getSession().getAttribute(Solicitud.SLOT_NAME);
//			// add folio to the node
//			updatedNode.put("solicitudFolio", solicitud.getFolio());
//
//			// default gate
//			String gateId = getGateIdFromUserAndNode(solicitud.getUser(), node);
//			updatedNode.put("gateId", gateId);
//			logger.info("gateId = {}", gateId);
//
//			String tranType = getTranType();
//			updatedNode.put("tranType", tranType);
//			logger.info("tranType = {}", tranType);
//
//			// create the appointment
//			SolicitudAppointment appointment = null; //managerN4.processSaveAppointment(updatedNode);
//
//			// build the response
//			ObjectNode responseNode = JsonNodeFactory.instance.objectNode();
//
//			responseNode.put("appointmentNbr", appointment.getAppointmentNbr());
//			responseNode.put("appointmentId", appointment.getId());
//			responseNode.put("status", appointment.getStatus().getName());
//
//			response.setBody(responseNode);
//			response.setMessage(getMessageFromResource("Appointment_registered_please_verify_data_matches_what_is_requested"));
//		}
//		catch (DomainModelException ex)
//		{
//			String errorMsg = "Error accepting appointment - " + ex.getMessage();
//			response.setErrorMessage(errorMsg);
//		}
//		catch (Exception ex)
//		{
//			String errorMsg = "Error accepting appointment data";
//			response.setErrorMessage(errorMsg);
//			
//			logger.error(errorMsg, ex);
//		}
//
//		return response;
//	}

	//TODO
	@RequestMapping(value="/get-time-slots.json", method = RequestMethod.POST)
	@ResponseBody
	public Object getTimeSlots(@RequestBody JsonNode node, HttpServletRequest request) throws Exception
	{
		ServerResponse response = new ServerResponse();

		DateFormat formatter = (DateFormat) getBean("dateFormatter_yyyy-MM-dd");
		DateFormat timeSlotFormatter = (DateFormat) getBean("dateFormatter_hh_mm_ss");

		HttpSession session = request.getSession();
		
		Solicitud solicitud = (Solicitud) session.getAttribute(Solicitud.SLOT_NAME);
 		try
		{
			Date aDate = formatter.parse(node.get("date").asText());
			//TODO 
			List<Date> dates = managerN4.getTimeSlotsForDate(aDate, solicitud);
			
			List<String> timeSlots = new ArrayList<String>();

			for (Date eachDate : dates)
				timeSlots.add(timeSlotFormatter.format(eachDate));

			if (timeSlots.size() > 0)
				response.setBody(timeSlots);
			else
				response.setErrorMessage("No Time Slots Available");
		}
		catch (Exception ex)
		{
			String errorMsg = "error while getting timeslots";
			response.setErrorMessage(errorMsg);
			
			logger.error(errorMsg, ex);
		}

		return response;
	}
	
	// code to get the default Gate, depending of the company the user belongs
	// if ATP, then door is selected by other rules
	public String getDefaultGateForUser(User user)
	{
		String code = user.getEmpresa().getCodigo();
		
		if ("ATP".equals(code))
			return null;

		return code;
	}

	public String getGateIdFromUserAndNode(User user, JsonNode node)
	{
		return getDefaultGateForUser(user); 
	}

	public String getPageTitle()
	{
		return "";
	}

	public String getTranType()
	{
		return getOperationType().getTranType();
	}
	
	public String getViewName()
	{
		return getOperationType().getView();
	}

	public Integer getMaxContainers()
	{
		return getOperationType().getMaxContainers();
	}

	public SolicitudOperationTypeEnum getOperationType()
	{
		return SolicitudOperationTypeEnum.IMPO;
	}
}
