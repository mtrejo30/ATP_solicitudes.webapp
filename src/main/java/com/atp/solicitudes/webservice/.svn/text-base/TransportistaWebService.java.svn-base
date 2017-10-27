package com.atp.solicitudes.webservice;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManagerN4;  
import com.atp.solicitudes.model.Transportista;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value = "/Transportista")
public class TransportistaWebService extends LocalBaseService
{
	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;
	
	protected static Logger logger = LoggerFactory.getLogger(TransportistaWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") Integer id)
	{
		Transportista obj = null;

		try
		{
			obj = manager.getTransportistaWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Transportista", ex);
		}

		return obj;
	}
	
	@RequestMapping(value = "/nombre/{nombre}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getNombre(@PathVariable(value = "nombre") String nombre)
	{
		Transportista obj = null;

		try
		{
			obj = manager.getTransportistaWithNombre(nombre);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Transportista", ex);
		}

		return obj;
	}

	
	@RequestMapping(value = "/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLikeTransportista(@RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getTransportistaImpo("%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Transportista columns", ex);
		}

		return res;
	}

	
}