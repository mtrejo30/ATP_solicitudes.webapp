package com.atp.solicitudes.webservice;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.Cliente;
import com.atp.solicitudes.model.PaqueteComercial;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value = "/PaqueteComercial")
public class PaqueteComercialWebService extends LocalBaseService
{

	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;

	@RequestMapping(value = "/{paqueteId}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "paqueteId") Integer idPaquete,  HttpServletRequest request)
	{
		PaqueteComercial obj = null;

		try
		{
			obj = manager.getPaqueteComercialWithId(idPaquete);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting PaqueteComercial", ex);
		}

		return obj;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLike(@RequestParam(value = "cliente_id") Integer cliente_id, @RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;
		Cliente cliente= null;
		String custid=null;
		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			cliente = manager.getClienteWithId(cliente_id);
			custid = cliente.getCustid();

			res = manager.getPaqueteComercial(custid, "%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting PaqueteComercial columns", ex);
		}

		return res;
	}
}
