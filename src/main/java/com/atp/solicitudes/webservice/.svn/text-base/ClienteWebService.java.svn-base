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
import com.atp.solicitudes.model.Cliente;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value = "/Cliente")
public class ClienteWebService extends LocalBaseService
{
	@Resource(name = "domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(ClienteWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object get(@PathVariable(value = "id") Integer id, HttpServletRequest request) throws Exception
	{
		Cliente obj = null;

		try
		{
			obj = manager.getClienteWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Cliente", ex);
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
            
			res = manager.getClienteDistinct(userN4Id, "%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Cliente columns", ex);
		}

		return res;
	}
}
