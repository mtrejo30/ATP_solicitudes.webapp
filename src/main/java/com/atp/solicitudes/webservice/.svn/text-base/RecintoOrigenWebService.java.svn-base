package com.atp.solicitudes.webservice;

import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.RecintoOrigen;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping(value = "/RecintoOrigen")
public class RecintoOrigenWebService extends LocalBaseService
{
	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(RecintoOrigenWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") String id)
	{
		RecintoOrigen obj = null;

		try
		{
			obj = manager.getRecintoOrigenWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting RecintoOrigen", ex);
		}

		return obj;
	}

	@RequestMapping(value="/get-all", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getAll()
	{
		ServerResponse resp = new ServerResponse();

		try
		{
			List<RecintoOrigen> col = Collections.emptyList();
			col = manager.getAllRecintoOrigen();
			resp.setBody(col);
		}
		catch (Exception ex)
		{
			String message = "error while getting RecintoOrigen collection";
			logger.debug(message, ex);
			
			resp.setErrorMessage(message);
		}

		return resp;
	}
}
