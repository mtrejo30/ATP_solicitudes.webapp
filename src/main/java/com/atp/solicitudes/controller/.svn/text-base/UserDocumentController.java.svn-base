package com.atp.solicitudes.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.atp.solicitudes.forms.UserDocumentForm;
import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.AgenciaAduanal;
import com.atp.solicitudes.model.Cliente;
import com.atp.solicitudes.model.DocumentoSolicitud;
import com.atp.solicitudes.model.DocumentoStatusEnum;
import com.atp.solicitudes.model.DocumentoTypeEnum;
import com.atp.solicitudes.model.OperationValidationStateEnum;
import com.atp.solicitudes.model.PaqueteComercial;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.model.GenericBlob;
import com.objectwave.utils.JSONUtils;
import com.objectwave.utils.StreamUtils;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping("user-document")
public class UserDocumentController extends LocalBaseController
{
	protected static Logger logger = LoggerFactory.getLogger(UserDocumentController.class);

	@Resource(name=DomainManager.BEAN_NAME)
	private DomainManager domainManager;
	
	@Resource(name=DomainManagerN4.BEAN_NAME)
	private DomainManagerN4 domainManagerN4;
	
	@RequestMapping(method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpServletRequest request)
	{
		try
		{
			// assigns ModelSession to model object
			setModelSession(request.getSession(), model);
			// assign an empty UserDocumentForm and UserDocumentSearchForm
			// two forms on one page, one for new Documents, other to search for them
			model.put(UserDocumentForm.MODEL_NAME, new UserDocumentForm());

			// retrieve the solicitud object that will be associated with the documents
			Solicitud solicitud = (Solicitud) request.getSession().getAttribute(Solicitud.SLOT_NAME);
			// refresh it from the database
			solicitud = domainManager.getSolicitudWithFolio(solicitud.getFolio());
			model.put(Solicitud.SLOT_NAME, solicitud);

			AgenciaAduanal aa = domainManagerN4.getAgenciaAduanalWithId(solicitud.getAgentId());
			Cliente cliente = domainManagerN4.getClienteWithId(solicitud.getClienteId());
			PaqueteComercial paquete =domainManagerN4.getPaqueteComercialWithId(solicitud.getCodigoId());
			
			model.put(AgenciaAduanal.SLOT_NAME, aa);
			model.put(Cliente.SLOT_NAME, cliente);
			model.put(PaqueteComercial.SLOT_NAME, paquete);
			
			// combo fields
			model.put("documenTypeList", JSONUtils.getJSONFromObject(DocumentoTypeEnum.allValues));
			model.put("documentStatusList", JSONUtils.getJSONFromObject(DocumentoStatusEnum.allValues));
			
			// return view name to be used
			return "user-document";			
		}
		catch (Exception ex)
		{
			String errorMsg = MessageFormat.format("error while rendering page", new Object[] {});
			logger.error(errorMsg, ex);

			model.put("errorMessage", errorMsg);
			return "error";
		}			
	}

	/*
	 * This method receives a multipart file form POST containing the document information posted from the browser
	 */
	@RequestMapping(value = "/upload-document", method = RequestMethod.POST)
	public String acceptFile(UserDocumentForm userDocumentForm, Map<String, Object> model, HttpServletRequest request)
	{
		ServerResponse serverResponse = new ServerResponse();
		
		String callbackFunction = getCallbackFunctionNameFrom(request);

		// check validation info is OK
		String validationError = getValidationMessageFrom(userDocumentForm);

		// gets the current logged user
		User loggedUser = getLoggedUser(request);

		try
		{
			Solicitud solicitud = (Solicitud) request.getSession().getAttribute(Solicitud.SLOT_NAME);
			
			if (solicitud == null)
				throw new Exception();
			
			// retrieve the solicitud object from the database, so we contain the fresh object from the database
			solicitud = domainManager.getSolicitudWithFolio(solicitud.getFolio());
			// check if the solicitud is already canceled or validated
			domainManager.raiseSolicitudStatusException(solicitud);
									
			if (validationError != null)
			{
				// if there is an error, we assign info to the serverResponse
				serverResponse.setError(true);
				serverResponse.setMessage(validationError);
				populateModelForIFrame(callbackFunction, serverResponse, model);

				return "iframe-post";
			}
													
			// get the multipart file from the form object
			MultipartFile mp = userDocumentForm.getFile();

			// if file is empty or no file defined
			// report it to the result page
			if (mp.getSize() == 0)
			{
				String message = getMessageFromResource("Document_file_is_empty");

				serverResponse.setError(true);
				serverResponse.setMessage(message);
				populateModelForIFrame(callbackFunction, serverResponse, model);

				return "iframe-post";
			}

			// create the document object and assign the direct attributes
			DocumentoSolicitud documentoSolicitud = new DocumentoSolicitud();

			documentoSolicitud.setType(DocumentoTypeEnum.withId(userDocumentForm.getType()));
			documentoSolicitud.setClave(userDocumentForm.getClave());		
			documentoSolicitud.setFileName(mp.getOriginalFilename());
			documentoSolicitud.setStatus(DocumentoStatusEnum.CARGADO);
			documentoSolicitud.setDateUpload(new Date());					
			documentoSolicitud.setUser(loggedUser);
			documentoSolicitud.setContentType(mp.getContentType());
								
			documentoSolicitud.setSolicitud(solicitud);							

			// get the binary info
			InputStream fileStream = null;

			try
			{
				// get the input stream from the multipart file
				fileStream = mp.getInputStream();

				// create a GenericBlob with the binary stream
				GenericBlob genericBlob = new GenericBlob();
				genericBlob.setData(StreamUtils.getBytes(fileStream));
				genericBlob.setType("");

				// set the created GenericBlob to the document object
				documentoSolicitud.setBlob(genericBlob);
			}
			finally
			{
				// ensure cleaned close stream
				IOUtils.closeQuietly(fileStream);				
			}

			// save the document object, including its GenericBlob
			domainManager.addNewDocumentoSolicitud(documentoSolicitud);
			// update the solicitud object
			// when we add a new file to the solicitud, then we must change the solicitud status to CARGADO.
			domainManager.updateSolicitudStatus(solicitud, OperationValidationStateEnum.CARGADO, loggedUser.getProfile());

			serverResponse.setMessage(getMessageFromResource("document_saved"));

			// object to hold each information row
			ObjectNode responseNode = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			responseNode.put("id", documentoSolicitud.getId());

			serverResponse.setBody(responseNode);

			populateModelForIFrame(callbackFunction, serverResponse, model);
		}
		catch (DomainModelException e)
		{
			String msg = getMessageFromResource(e.getMessage());
			
			serverResponse.setError(true);
			serverResponse.setMessage(msg);
			
			try
			{
				populateModelForIFrame(callbackFunction, serverResponse, model);
			}
			catch (Exception ex)
			{
				logger.error("error while populating iframe model", ex);
			}

			return "iframe-post";
		}
		catch (Exception e)
		{
			String msg = getMessageFromResource("Error_while_saving_document");

			// if something went wrong on the whole process
			logger.error(msg, e);
			serverResponse.setError(true);
			serverResponse.setMessage(msg);
			
			try
			{
				populateModelForIFrame(callbackFunction, serverResponse, model);
			}
			catch (Exception ex)
			{
				logger.error("error while populating iframe model", ex);
			}

			return "iframe-post";
		}

		serverResponse.setMessage(getMessageFromResource("Document_saved"));

		return "iframe-post";
	}

	@RequestMapping(value = "/documentTableInfoRequest", method = RequestMethod.POST)
	@ResponseBody
	public Object documentTableInfoRequest(HttpServletRequest request/*, HttpSession session*/)
	{
		DaoQuery queryMap = getQueryMap(request);
		DaoOrder order = getTableOrder(request);

		// request parameters that defines the page and number of rows to get
		Integer pageNumber = Integer.parseInt(request.getParameter(PAGE_PARAMETER));
		Integer numberOfRows = Integer.parseInt(request.getParameter(ROWS_PARAMETER));

		queryMap.setPageNumber(pageNumber);
		queryMap.setNumberOfRows(numberOfRows);

		DaoResult<DocumentoSolicitud> docs = getUserDocument(queryMap, order);

		ObjectNode object = getTableMainNode(docs);

		// collection to hold all the rows
		ArrayNode rows = getTableNodes(docs.getCollection());

		// set the rows property
		object.put("rows", rows);

		// return the object to the UI table
		return object;
	}

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception)
	{
		Map<String, Object> model = new HashMap<String, Object>();

		ServerResponse serverResponse = new ServerResponse();

		if (exception instanceof MaxUploadSizeExceededException)
		{
			String errorMessage = getMessageFromResource("Document_file_too_big");

			serverResponse.setError(true);
			serverResponse.setMessage(errorMessage);
			try
			{
				populateModelForIFrame("uploadDocumentCallback", serverResponse, model);
			}
			catch (Exception ex)
			{

			}
		}

		return new ModelAndView("iframe-post", model);
	}
	
	private DaoQuery getQueryMap(HttpServletRequest request)
	{
		DaoQuery queryMap = new DaoQuery();
		
		// current solicitud
		queryMap.filter("solicitud", request.getSession().getAttribute(Solicitud.SLOT_NAME));
		
		return queryMap;	
	}

	private DaoResult<DocumentoSolicitud> getUserDocument(DaoQuery query, DaoOrder order)
	{
		DaoResult<DocumentoSolicitud> docs = null;
		
		// perform query
		try
		{
			docs = domainManager.queryDocumentoSolicitud(query, order);
		}
		catch (Exception e)
		{
			// If something fail at the domain manager level
			String msg = "Error_while_retrieving_documents";
			// log the error
			logger.error(getMessageFromResource(msg), e);
		}

		return docs;
	}

	private ArrayNode getTableNodes(List<DocumentoSolicitud> docs)
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		// loop through the resulting objects
		for (DocumentoSolicitud eachDocument : docs)
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			eachObject.put("id", eachDocument.getId());

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);

			SimpleDateFormat dateFormatter = (SimpleDateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss");
			String dateUpload = dateFormatter.format(eachDocument.getDateUpload());

			// column info
			eachArray.add(eachDocument.getType().getName());
			eachArray.add(eachDocument.getClave());
			eachArray.add(eachDocument.getFileName());
			eachArray.add(eachDocument.getStatus().getName());
			eachArray.add(dateUpload);

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}
		return rows;
	}

	@RequestMapping(value = "/document-table-row", method = RequestMethod.POST)
	@ResponseBody
	public Object documentTableRowRequest(@RequestBody JsonNode nodeQuery, HttpServletRequest request)
	{
		//DaoQuery query = DaoQuery.withFilter("id", nodeQuery.get("id").asInt());
		DaoQuery query = getQueryMap(request);
		DaoOrder order = new DaoOrder();
		
		query.filter("id", nodeQuery.get("id").asInt());

		DaoResult<DocumentoSolicitud> col = getUserDocument(query, order);

		ArrayNode rows = getTableNodes(col.getCollection());

		ServerResponse response = new ServerResponse();

		response.setBody(rows.get(0));

		return response;
	}

	@RequestMapping (value = "/update-document-status", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse updateDocumentStatusRequest(@RequestBody ObjectNode node, HttpSession session, HttpServletRequest request)
	{
		ServerResponse response = new ServerResponse();		
				
		try
		{			
			User loggedUser = getLoggedUser(request);
			
			domainManager.processUpdateDocumentoSolicitudStatus(node, loggedUser);
			
			DocumentoStatusEnum newStatus = DocumentoStatusEnum.withId(node.get("status").asInt());	
																
			// object to hold each information row
			ObjectNode responseNode = new ObjectNode(JsonNodeFactory.instance);
			
			responseNode.put("status", newStatus.getName());
						
			response.setBody(responseNode);		
			
			if (newStatus == DocumentoStatusEnum.CANCELADO)
				response.setMessage(getMessageFromResource("document_canceled"));
			else if (newStatus == DocumentoStatusEnum.ERROR)
				response.setMessage(getMessageFromResource("document_error"));
			else if (newStatus == DocumentoStatusEnum.VALIDADO)
				response.setMessage(getMessageFromResource("document_validated"));
			else if(newStatus == DocumentoStatusEnum.INVALIDO)
				response.setMessage(getMessageFromResource("document_invalidated"));
		}
		catch (DomainModelException dme)
		{
			String msg = getMessageFromResource(dme.getMessage());

			response.setError(true);
			response.setMessage(msg);			
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_updating_document_state");
			
			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg);	
		}		
		return response;
	}
	
	@RequestMapping(value = "/get-document", method = RequestMethod.GET)
	public void getDocument(@RequestParam("id") Integer id, HttpServletResponse response)
	{
		InputStream inputStream = null;
		OutputStream outputStream = null;

		try
		{
			DocumentoSolicitud doc = domainManager.getDocumentoSolicitudById(id);
			GenericBlob blob = domainManager.getDocumentoSolicitudBlob(doc);

			response.setContentType(doc.getContentType());
			response.setHeader("Content-Disposition", "attachment; filename=\"" + doc.getFileName() + "\";");

			inputStream = blob.getInputStream();
			outputStream = response.getOutputStream();

			StreamUtils.copyStream(inputStream, outputStream, StreamUtils.BUFFER_SIZE);
		}
		catch (Exception ex)
		{
			logger.error("error while getting document", ex);
		}
		finally
		{
			IOUtils.closeQuietly(inputStream);
			IOUtils.closeQuietly(outputStream);
		}
	}
	
	@RequestMapping(value = "/can-add-or-change-document-status", method = RequestMethod.POST)
	@ResponseBody
	public Object canAddOrChangeDocumentStatus(HttpServletRequest request)
	{
		ServerResponse serverResponse = new ServerResponse();
		try
		{
			Solicitud solicitud = (Solicitud) request.getSession().getAttribute(Solicitud.SLOT_NAME);
						
			if (solicitud.isCanceledOrValidated())
			{
				serverResponse.setError(true);
				serverResponse.setMessage("solicitud_already_canceled_or_validated");
			}
		}
		catch (Exception ex)
		{
			logger.error("error while getting document", ex);
			
			serverResponse.setError(true);
		}
		
		return serverResponse;
	}
}
