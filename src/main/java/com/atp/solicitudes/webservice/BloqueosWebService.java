package com.atp.solicitudes.webservice;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
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
import com.atp.solicitudes.model.ContenedorStatus;
import com.atp.solicitudes.model.SolicitudComentario;
import com.atp.solicitudes.model.Bloqueos;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserTransportistas;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping(value = "/bloqueos_")
public class BloqueosWebService extends LocalBaseService
{
	@Resource(name="domainManager")
	DomainManager manager;

	protected static Logger logger = LoggerFactory.getLogger(SolicitudComentarioWebService.class);
	

	
	@RequestMapping(value = "UserN4", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getUserTransportistasByUserN4()
	{
		
		List<Bloqueos> res = null;
		try
		{
			
			res = manager.queryBloqueos();
		}
		catch (Exception ex)
		{
			String msg = "error while getting UserTransportistas";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}
		return res;
	}
	

	@RequestMapping (value = "/save", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	
	public ServerResponse saveUserRequest(@RequestBody JsonNode node)
	{
		ServerResponse response = new ServerResponse();

		try
		{
		
			Bloqueos bloqueos = manager.processSaveUpdateBloqueos(node);
			
			ObjectNode bodyNode = new ObjectNode(JsonNodeFactory.instance);
			bodyNode.put("id", bloqueos.getId_bloqueo());

			response.setBody(bodyNode);
			response.setMessage(getMessageFromResource("User_saved"));
		}
		catch (DomainModelException dme)
		{
			String msg = getMessageFromResource(dme.getMessage());

			logger.error(msg, dme);
			response.setError(true);
			response.setMessage(msg);
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_saving_user");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg );
		}

		return response;
	}
	
	@RequestMapping(value = "/edit-user", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Object editUserRequest(@RequestBody JsonNode obj)
	{			
		ServerResponse response = new ServerResponse();

		//get the id of the user to edit
		Integer id = obj.get("id").asInt();
        System.out.print("idtrabajo"+id);
		//get the user
		Bloqueos user = null;
		try
		{
			user = manager.getBloqueosWithId(id);
			
		}
		catch (Exception e)
		{
			// Something was wrong while doing the search
			String msg = "Error while executing query";
			response.setError(true);
			response.setMessage(msg + " - " + e);
			return response;
		}
		
		response.setBody(user);
		
		return response;
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object delete(@PathVariable(value = "id") Integer Id)
	{
		Bloqueos obj;
		try
		{
			// force the current date when saving the comment
			obj = manager.getBloqueosWithId(Id);
			manager.deleteBloqueos(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while saving UserTransportistas";
			logger.debug(msg, ex);
			return createServerResponseWithError(msg);
		}
		
		return obj;

	}
	
	@RequestMapping(value = "/status/{tipo_nbr}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getContenedorStatus(@PathVariable(value = "tipo_nbr") String unitNbr)
	{
		ArrayList<Bloqueos> res = null;

		try
		{
			res = manager.getBloqueosStatus(unitNbr);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor columns", ex);
		}

		return res;
	}

	@RequestMapping(value = "/statushabilitar/{tipo_nbr}/{tipo_nbr_}/{tipo_nbr_s}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getContenedorStatus(@PathVariable(value = "tipo_nbr") String unitNbr,@PathVariable(value = "tipo_nbr_") String unitNbr_,@PathVariable(value = "tipo_nbr_s") String unitNbr_s)
	{
		ArrayList<Bloqueos> res = null;
		unitNbr_s=unitNbr_s.replace("%2D","-");
		System.out.print("prueba1"+unitNbr_s);
		try
		{
			res = manager.getBloqueosStatushabilitar(unitNbr,unitNbr_,unitNbr_s);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor columns", ex);
		}

		return res;
	}
}
