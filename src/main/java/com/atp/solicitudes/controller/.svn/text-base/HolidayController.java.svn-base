package com.atp.solicitudes.controller;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.Holiday;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.utils.JSONUtils;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping("holiday")
public class HolidayController extends LocalBaseController
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(HolidayController.class);

	static String SEARCH_INFO_PARAM = "search_info";	
	
	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpSession session)
	{
		// assigns ModelSession to model object
		setModelSession(session, model);
			
		// return view name to be used
		return "holiday";
	}
	
	@RequestMapping(value = "/holiday-table-info", method = RequestMethod.GET)
	@ResponseBody
	public Object holidaysTableInfoRequest(HttpServletRequest request, HttpSession session)
	{
		// map for query filters
		DaoQuery query = getTableQuery(request);

		// map for order properties
		DaoOrder order = getTableOrder(request);
		
		// request parameters that defines the page and number of rows to get
		Integer pageNumber = Integer.parseInt(request.getParameter(PAGE_PARAMETER));
		Integer numberOfRows = Integer.parseInt(request.getParameter(ROWS_PARAMETER));

		query.setPageNumber(pageNumber);
		query.setNumberOfRows(numberOfRows);
		query.setRequestTotalRows(true);

		// Get holidays to be displayed on table
		DaoResult<Holiday> holidays = getHolidays(query, order);
		
		ObjectNode object = getTableMainNode(holidays);
		
		// Populate table
		ArrayNode rows = getHolidaysNodes(holidays.getCollection());

		// set the rows property
		object.put("rows", rows);

		// return the object to the UI table
		return object;
	}
	
	private DaoQuery getTableQuery(HttpServletRequest request)
	{
		DaoQuery query = new DaoQuery();

		String searchInfoStr = request.getParameter(SEARCH_INFO_PARAM); 

		if (searchInfoStr == null)
			return query;

		try
		{
			JsonNode node = JSONUtils.getJSONFromString(searchInfoStr);
			addStringParameterToQuery(query, node, "name", "name");
		}
		catch (Exception ex)
		{
			logger.error("error while reading seach info", ex);
		}

		return query;
	}
	
	private DaoResult<Holiday> getHolidays(DaoQuery query, DaoOrder order)
	{
		DaoResult<Holiday> holidays = null;
		DomainManager manager = getDomainManager();

		// perform query
		try
		{
			holidays = manager.queryHoliday(query, order);
		}
		catch (Exception e)
		{
			// If something fail at the domain manager level
			String msg = "Error_while_retrieving_holidays";
			// log the error
			logger.error(getMessageFromResource(msg), e);
		}

		return holidays;
	}
	
	private ArrayNode getHolidaysNodes(List<Holiday> holidays)
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		// loop through the resulting objects
		for (Holiday eachHoliday : holidays)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			eachObject.put("id", eachHoliday.getId());

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);
					
			SimpleDateFormat dateFormatter = (SimpleDateFormat) getBean("dateFormatter_yyyy-MM-dd");				
			final String holidaydate = dateFormatter.format(eachHoliday.getDate());
			
			// column info
			eachArray.add(eachHoliday.getId());
			eachArray.add(eachHoliday.getName());			
			eachArray.add(holidaydate);

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}
	
	/*
	 * This method updates or creates a new day.
	 */
	@RequestMapping (value = "/save-holiday", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse saveHolidayRequest(@RequestBody JsonNode node)
	{
		ServerResponse response = new ServerResponse();

		DomainManager manager = getDomainManager();

		try
		{
			if (node.get("name").asText().isEmpty() || node.get("date").asText().isEmpty()) 
            {
               throw new DomainModelException("Error_while_saving_day");
            } 
			Holiday holiday = manager.processSaveUpdateHoliday(node);
			
			ObjectNode bodyNode = new ObjectNode(JsonNodeFactory.instance);
			bodyNode.put("id", holiday.getId());

			response.setBody(bodyNode);
			response.setMessage(getMessageFromResource("Holiday_saved"));
		}
		catch (DomainModelException dme)
		{
			String msg = getMessageFromResource(dme.getMessage());

			logger.info(msg, dme);
			response.setError(true);
			response.setMessage(msg);
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_saving_day");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg );
		}

		return response;
	}
	
	@RequestMapping(value = "/holiday-table-row", method = RequestMethod.POST)
	@ResponseBody
	public Object holidayTableRowRequest(@RequestBody JsonNode nodeQuery)
	{
		int nodeID = nodeQuery.get("id").asInt();
		
		DaoQuery query = DaoQuery.withFilter("id", nodeID);
		DaoOrder order = new DaoOrder();

		DaoResult<Holiday> col = getHolidays(query, order);
		
		// collection to hold all the rows
		ArrayNode rows = getHolidaysNodes(col.getCollection());
		
		ServerResponse response = new ServerResponse();
		response.setBody(rows.get(0));

		return response;
	}
	
	@RequestMapping(value = "/edit-holiday", method = RequestMethod.POST)
	public @ResponseBody Object editHolidayRequest(@RequestBody JsonNode obj)
	{			
		ServerResponse response = new ServerResponse();

		//get the id of the day to edit
		Integer id = obj.get("id").asInt();

		//get the day
		Holiday holiday = null;
		try
		{
			DomainManager manager = getDomainManager();
			holiday = manager.getHolidayWithId(id);
			
		}
		catch (Exception e)
		{
			String errorMsg = getMessageFromResource("Error_while_getting_holiday");
			logger.error(errorMsg, e);

			// Something was wrong while doing the search
			logger.error(errorMsg, e);
			response.setError(true);
			response.setMessage(errorMsg);
			return response;
		}
		
		response.setBody(holiday);
		response.setMessage(getMessageFromResource("Holiday_updated"));
		return response;
	}
	
	/*
	 * This method deletes the selected day
	 */
	@RequestMapping (value = "/delete-holiday", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse deleteHolidayRequest(@RequestBody ObjectNode obj, HttpSession session)
	{
		ServerResponse response = new ServerResponse();
		DomainManager dm = getDomainManager();

		//get the id of the day to delete
		Integer id = obj.get("id").asInt();

		Holiday holiday = null;

		try
		{
			holiday = dm.getHolidayWithId(id);
		}
		catch (Exception e) 
		{
			String errorMsg = getMessageFromResource("Error_while_getting_holiday");
			logger.error(errorMsg, e);

			response.setError(true);
			response.setMessage(errorMsg);

			return response;
		}

		try
		{
			dm.deleteHoliday(holiday);
		}
		catch (Exception e)
		{
			String errorMsg = getMessageFromResource("Error_while_deleting_holiday");
			logger.error(errorMsg, e);

			response.setError(true);
			response.setMessage(errorMsg);
			return response;
		}

		// return the id of the object that should be removed, so the ui knows which id will be removed
		ObjectNode body = new ObjectNode(JsonNodeFactory.instance);
		body.put("id", id);
		response.setBody(body);

		response.setMessage(getMessageFromResource("Holiday_deleted"));
		return response;
	}
		
}
