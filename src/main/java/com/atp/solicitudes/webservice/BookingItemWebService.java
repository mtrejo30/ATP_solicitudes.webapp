package com.atp.solicitudes.webservice;

import java.util.List;

import javax.annotation.Resource;

import org.codehaus.jackson.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.BookingItem;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping(value = "/BookingItem")
public class BookingItemWebService extends LocalBaseService
{
	@Resource(name = "domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(BookingItemWebService.class);

	@RequestMapping(value = "/{unit_gkey}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "unit_gkey") Integer unit_gkey)
	{
		BookingItem obj = null;

		try
		{
			obj = manager.getBookingItemWithId(unit_gkey);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting BookingItem", ex);
		}

		return obj;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getSearch(@RequestBody JsonNode node)
	{
		ServerResponse resp = new ServerResponse();

		try
		{
			List<BookingItem> col = null;

			Integer bookingId = node.get("bookingId").asInt();

			DaoQuery query = DaoQuery.withFilter("bookingGKey", bookingId);

			if (node.has("bookingItemId"))
			{
				query.filter("id", node.get("bookingItemId").asInt());
			}

			DaoOrder order = DaoOrder.withSort("TYPE_ISO", DaoOrder.ASC);
			order.sort("GRADE", DaoOrder.ASC);

			DaoResult<BookingItem> result = manager.queryBookingItem(query, order);
			
			col = result.getCollection();
			
			resp.setBody(col);
		}
		catch (Exception ex)
		{
			String msg = "error while getting BookingItem columns";
			logger.debug(msg, ex);
			
			resp.setErrorMessage(msg);
		}

		return resp;
	}
	
	@RequestMapping(value = "/searchType", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getSearchType(@RequestBody JsonNode node)
	{
		ServerResponse resp = new ServerResponse();

		try
		{
			List<BookingItem> col = null;

			Integer bookingId = node.get("bookingId").asInt();

			DaoQuery query = DaoQuery.withFilter("bookingGKey", bookingId);

			if (node.has("bookingItemId"))
			{
				query.filter("id", node.get("bookingItemId").asInt());
			}

			DaoOrder order = DaoOrder.withSort("TYPE_ISO", DaoOrder.ASC);
			order.sort("GRADE", DaoOrder.ASC);

			DaoResult<BookingItem> result = manager.getBookingItemWithIdForType(query, order);
			
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
			String msg = "error while getting BookingItem columns";
			logger.debug(msg, ex);
			
			resp.setError(Boolean.TRUE);
			resp.setErrorMessage(msg);
		}

		return resp;
	}
}
