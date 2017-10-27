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
import com.atp.solicitudes.model.UserN4;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value = "/UserN4")
public class UserN4WebService extends LocalBaseService
{
	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;
	
	protected static Logger logger = LoggerFactory.getLogger(UserN4WebService.class);
    
	@RequestMapping(value = "/gkey/{gkey}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getGkey(@PathVariable(value = "gkey") Integer gkey)
	{ 
		UserN4 obj = null; 
		try
		{
			obj = manager.getUserWithGkey(gkey);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting UserN4", ex);
		} 
		return obj;
	}
	

	@RequestMapping(value = "/id/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") String id)
	{
		UserN4 obj = null;

		try
		{
			obj = manager.getWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting UserN4", ex);
		}

		return obj;
	}

	@RequestMapping(value = "/name/{name}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getName(@PathVariable(value = "name") String id)
	{
		UserN4 obj = null;

		try
		{
			obj = manager.getWithName(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting UserN4", ex);
		}

		return obj;
	}
	
	@RequestMapping(value = "/custid/{custid}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getCustId(@PathVariable(value = "custid") String id)
	{
		UserN4 obj = null;

		try
		{
			obj = manager.getWithCustId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting UserN4", ex);
		}

		return obj;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getAll(HttpServletRequest request)
	{
		List<UserN4> obj = null;

		try
		{
			DaoResult<UserN4> res = null;

			DaoQuery query = new DaoQuery();
			DaoOrder order = new DaoOrder();
			
			injectSortOrders(order, request);

			String[] filters = {"nombre", "id"};
			injectFilterQueries(filters, query, request);

			injectPaginationParameters(query, request);

			res = manager.queryUserN4(query, order);
			
			obj = res.getCollection();
		}
		catch (Exception ex)
		{
			logger.debug("error while getting UserN4", ex);
		}

		return obj;
	}

	
	@RequestMapping(value = "/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLikeUserN4(@RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getUserN4("%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting UserN4 columns", ex);
		}

		return res;
	}
	
	
	
}
