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
import com.atp.solicitudes.model.OperadorTransportista;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value="/OperadorTransportista")
public class OperadorTransportistaWebService extends LocalBaseService
{
	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(OperadorTransportistaWebService.class);

	@RequestMapping(value = "/{gKey}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "gKey") Integer gKey)
	{
		OperadorTransportista obj = null;

		try
		{
			obj = manager.getOperadorTransportistaWithGkey(gKey);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting OperadorTransportista", ex);
		}

		return obj;
	}

	@RequestMapping(value = "/cardId/{cardId}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getCardId(@PathVariable(value = "cardId") String name)
	{
		OperadorTransportista obj = null;

		try
		{
			obj = manager.getOperadorTransportistaWithCardId(name);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting OperadorTransportista", ex);
		}

		return obj;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getAll(HttpServletRequest request)
	{
		List<OperadorTransportista> obj = null;

		try
		{
			DaoResult<OperadorTransportista> res = null;

			DaoQuery query = new DaoQuery();
			DaoOrder order = new DaoOrder();
			
			injectSortOrders(order, request);

			String[] filters = {"name", "gKey"};
			injectFilterQueries(filters, query, request);

			injectPaginationParameters(query, request);

			res = manager.queryOperadorTransportista(query, order);
			
			obj = res.getCollection();
		}
		catch (Exception ex)
		{
			logger.debug("error while getting OperadorTransportista", ex);
		}

		return obj;
	}

	@RequestMapping(value = "/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLikeOperador(@RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getOperadorTransportistaImpo("%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting OperadorTransportista columns", ex);
		}

		return res;
	}
	
}
