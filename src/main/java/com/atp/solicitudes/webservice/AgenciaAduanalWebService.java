package com.atp.solicitudes.webservice;

import java.util.Collections;
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
import com.atp.solicitudes.model.AgenciaAduanal;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value = "/AgenciaAduanal")
public class AgenciaAduanalWebService extends LocalBaseService
{
	@Resource(name = "domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(AgenciaAduanalWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object get(@PathVariable(value = "id") Integer id, HttpServletRequest request) throws Exception
	{
		AgenciaAduanal obj = null;

		try
		{
			obj = manager.getAgenciaAduanalWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting AgenciaAduanal", ex);
		}

		return obj;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object search(@RequestParam(value = "userN4Id") Integer userN4Id, @RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = Collections.emptyList();

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;
            
			res = manager.getAgenciaAduanalDistinct(userN4Id, "%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting AgenciaAduanal columns", ex);
		}

		return res;
	}
}
