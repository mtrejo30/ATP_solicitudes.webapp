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
import com.atp.solicitudes.model.LineaNaviera;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value = "/LineaNaviera")
public class LineaNavieraWebService extends LocalBaseService
{
	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(LineaNavieraWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") Integer id)
	{
		LineaNaviera obj = null;

		try
		{
			obj = manager.getLineaNavieraWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting LineaNaviera", ex);
		}

		return obj;
	}
	
	@RequestMapping(value = "/nombre/{nombre}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getNombre(@PathVariable(value = "nombre") String nombre)
	{
		LineaNaviera obj = null;

		try
		{
			obj = manager.getLineaNavieraWithNombre(nombre);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting LineaNaviera", ex);
		}

		return obj;
	}
	
	@RequestMapping(value = "/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLike(@RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getLineaNavieraByPattern("%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting LineaNaviera columns", ex);
		}

		return res;
	}
	
}