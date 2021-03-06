package com.atp.solicitudes.webservice;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonNode;
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

import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.Booking;
import com.atp.solicitudes.model.BookingItem;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.SimpleEntry;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping(value = "/Booking")
public class BookingWebService extends LocalBaseService
{
	@Resource(name = "domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(BookingWebService.class);

	@RequestMapping(value = "/{unit_gkey}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "unit_gkey") Integer unit_gkey)
	{
		Booking obj = null;

		try
		{
			obj = manager.getBookingWithId(unit_gkey);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Booking", ex);
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

			res = manager.getBookingByPattern("%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Booking columns", ex);
		}

		return res;
	}
	
	@RequestMapping(value = "/name", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getBookingByName(@RequestParam(value = "name") String name, HttpServletRequest request)
	{
		List<Booking> collection = null;
		
		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			collection = manager.getBookingByName(name, maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Booking columns", ex);
		}
		
		return collection;
	}
	
	@RequestMapping(value = "/searchType", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getSearchType(@RequestBody JsonNode node)
	{
		ServerResponse resp = new ServerResponse();

		try
		{
			List<Booking> col = null;

			Integer bookingId = node.get("bookingId").asInt();

			DaoQuery query = DaoQuery.withFilter("bookingGKey", bookingId);

			if (node.has("bookingId"))
			{
				query.filter("id", node.get("bookingId").asInt());
			}

			DaoOrder order = DaoOrder.withSort("POD_NAME", DaoOrder.ASC);
			order.sort("GRADE", DaoOrder.ASC);

			DaoResult<Booking> result = manager.getBookingItemWithId(query, order);
			
			col = result.getCollection();
			if (col.isEmpty())
			{
				resp.setError(Boolean.TRUE);
				resp.setErrorMessage(getMessageFromResource("Check_availability"));
			}
			resp.setBody(col);
		}
		catch (Exception ex)
		{
			String msg = "No contiene datos";
			logger.debug(msg, ex);
			
			resp.setError(Boolean.TRUE);
			resp.setErrorMessage(msg);
		}

		return resp;
	}
	
}
