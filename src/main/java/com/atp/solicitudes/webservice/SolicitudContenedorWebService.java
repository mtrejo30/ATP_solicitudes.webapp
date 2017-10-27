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
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.SolicitudComentario;
import com.atp.solicitudes.model.SolicitudContenedor;
import com.objectwave.dao.utils.DaoResult;

@Controller
@RequestMapping(value = "/SolicitudContenedor")
public class SolicitudContenedorWebService extends LocalBaseService
{
	@Resource(name="domainManager")
	DomainManager manager;

	protected static Logger logger = LoggerFactory.getLogger(SolicitudComentarioWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") Integer id)
	{
		SolicitudComentario obj = null;

		try
		{
			obj = manager.getSolicitudComentarioWithId(id);
		}
		catch (Exception ex)
		{
			String msg = "error while getting SolicitudComentario";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}

	@RequestMapping(value = "/", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object save(@RequestBody SolicitudContenedor obj)
	{
		try
		{
			// force the current date when saving the comment
			obj.setFecha(new Date());

			manager.saveSolicitudContenedor(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while saving SolicitudCOntenedor";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}

	@RequestMapping(value = "/saveNotify", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object saveAndNotify(@RequestBody SolicitudComentario obj)
	{
		try
		{
			// force the current date when saving the comment
			obj.setFecha(new Date());

			manager.saveSolicitudComentarioAndNotify(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while saving SolicitudComentario";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}

	@RequestMapping(value = "/fromSolicitud/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getAll(@PathVariable(value = "id") Integer id)
	{
		List<SolicitudContenedor> obj = null;

		try
		{
			DaoResult<SolicitudContenedor> res = null;

			Solicitud fake = new Solicitud(); fake.setFolio(id);

			res = manager.getSolicitudContenedoresForSolicitud(fake);
			
			obj = res.getCollection();
		}
		catch (Exception ex)
		{
			String msg = "error while getting SolicitudComentario";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object update(@RequestBody SolicitudContenedor obj)
	{
		try
		{
			// force the current date when saving the comment
			obj.setFecha(new Date());

			manager.updateSolicitudContenedor(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while updating SolicitudCOntenedor";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object delete(@RequestBody SolicitudContenedor obj)
	{
		try
		{
			manager.deleteSolicitudContenedor(obj);
		}
		catch (Exception ex)
		{
			String msg = "error while delete SolicitudContenedor";
			logger.debug(msg, ex);
			
			return createServerResponseWithError(msg);
		}

		return obj;
	}
}
