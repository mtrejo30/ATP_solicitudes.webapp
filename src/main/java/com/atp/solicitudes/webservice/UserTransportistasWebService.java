package com.atp.solicitudes.webservice;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

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
import com.atp.solicitudes.model.SolicitudComentario;
import com.atp.solicitudes.model.UserTransportistas;

@Controller
@RequestMapping(value = "/UserTransportistas")
public class UserTransportistasWebService extends LocalBaseService
{
	@Resource(name="domainManager")
	DomainManager manager;

	protected static Logger logger = LoggerFactory.getLogger(SolicitudComentarioWebService.class);
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") Integer id)
	{
		UserTransportistas obj = null;

		try
		{
			obj = manager.getUserTransportistasWithId(id);
		}
		catch (Exception ex)
		{
			String msg = "error while getting UserTransportistas";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}
	
	@RequestMapping(value = "UserN4/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getUserTransportistasByUserN4(@PathVariable(value = "id") Integer id)
	{
		List<UserTransportistas> res = null;
		try
		{
			
			res = manager.getUserTransportistasbyUserN4(id);
		}
		catch (Exception ex)
		{
			String msg = "error while getting UserTransportistas";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}
		return res;
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object delete(@PathVariable(value = "id") Integer Id)
	{
		UserTransportistas obj;
		try
		{
			// force the current date when saving the comment
			obj = manager.getUserTransportistasWithId(Id);
			manager.deleteUserTransportistas(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while saving UserTransportistas";
			logger.debug(msg, ex);
			return createServerResponseWithError(msg);
		}
		
		return obj;

	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object update(@RequestParam(value = "trans_id") Integer trans_id, @RequestParam(value = "nivel") String nivel, @RequestParam(value = "id") Integer id, @RequestParam(value = "username") String username)
	{
		UserTransportistas obj =  new UserTransportistas();;
		try
		{
			String rem = username ;
			rem =rem.replace(",",".");
			rem =rem.replace("diag","/");
			rem =rem.replace("coma",",");
			rem =rem.replace("sig","&");
			rem =rem.replace("bla"," ");
			System.out.println("-----3-----transportista-" + username );
			// force the current date when saving the comment
			obj = manager.getUserTransportistasWithId(id);
			obj.setDate_updated(new Date());
			obj.setNivelString(nivel);
			obj.setTransportista_id(trans_id);
			obj.setUsername(rem);

			manager.updateUserTransportistas(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while saving UserTransportistas";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object save(@RequestParam(value = "usern4") Integer usern4, @RequestParam(value = "nivel") String nivel, @RequestParam(value = "trans_id") Integer trans_id, @RequestParam(value = "username") String username, @RequestParam(value = "idUser") Integer idUser)
	{
		UserTransportistas obj;
		try
		{
			System.out.println("-----3-----transportista-" + username );
			String rem = username ;
			rem =rem.replace(",",".");
			rem =rem.replace("diag","/");
			rem =rem.replace("coma",",");
			rem =rem.replace("sig","&");
			rem =rem.replace("bla"," ");
			System.out.println("-----3-----transportista-" + rem );

			obj = new UserTransportistas();
			// force the current date when saving the comment
			obj.setUser(manager.getUserWithId(idUser));
			obj.setDate_updated(new Date());
			obj.setFecha_alta(new Date());
			obj.setNivelString(nivel);
			obj.setTransportista_id(trans_id);
			obj.setUsername(rem);
			obj.setUser_n4_id(usern4);

			manager.saveUserTransportistas(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while saving UserTransportistas";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return null;
	}

}
