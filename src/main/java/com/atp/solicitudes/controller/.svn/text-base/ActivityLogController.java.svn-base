package com.atp.solicitudes.controller;

import java.text.SimpleDateFormat;
import java.util.Collections;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.model.ActivityLogEntry;
import com.objectwave.model.json.ActivityLogFormJSON;
import com.objectwave.utils.JSONUtils;

@Controller
@RequestMapping ("activity-log")
public class ActivityLogController extends LocalBaseController
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(ActivityLogController.class);
	
	static String SEARCH_INFO_PARAM = "search_info";

	static int MAX_AUTOCOMPLETE_RESULTS = 10; // 0 = all results

	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpSession session)
	{
		// assigns ModelSession to model object
		setModelSession(session, model);

		// return view name to be used
		return "activity-log";
	}
	
	@RequestMapping(value = "/activity-log-table-info", method = RequestMethod.POST)
	@ResponseBody
	public Object activityLogTableInfoRequest(HttpServletRequest request, HttpSession session)
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

		DaoResult<ActivityLogEntry> col = getActivityLogs(query, order);
		
		// Get table main node
		ObjectNode object = getTableMainNode(col);

		// collection to hold all the rows
		ArrayNode rows = getActivityLogNodes(col.getCollection());
		
		// set the rows property
		object.put("rows", rows);

		// return the object to the UI table
		return object;
	}

	private DaoQuery getTableQuery(HttpServletRequest request)
	{
		// map for query filters
		DaoQuery query = new DaoQuery();

		// get the activityLogForm object from the session
		// previously assigned on the submitSearch request
		String searchInfoStr = request.getParameter(SEARCH_INFO_PARAM); 

		// if there is no activityLogForm from the session, return the empty object
		if (searchInfoStr == null)
			return query;

		ActivityLogFormJSON searchInfo = null;
		JsonNode node = null;

		try
		{
			node = JSONUtils.getJSONFromString(searchInfoStr);
			searchInfo = (ActivityLogFormJSON) JSONUtils.getObjectFromJSONString(searchInfoStr, ActivityLogFormJSON.class);
		}
		catch (Exception ex)
		{
			logger.error("error while reading seach info", ex);
		}

		// if there is no activityLogForm from the session, return the empty queryMap
		if (searchInfo == null)
			return query;

		// formatter to read dates from the activityLogForm
		SimpleDateFormat dateFormatter = (SimpleDateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss");

		try
		{
			// if initial date set
			if (searchInfo.getInitialDate().length() > 0)
				query.filter("timestamp_initial", dateFormatter.parseObject(searchInfo.getInitialDate() + " 00:00:00"));

			// if final date set
			if (searchInfo.getFinalDate().length() > 0)
				query.filter("timestamp_final", dateFormatter.parseObject(searchInfo.getFinalDate() + " 23:59:59"));

			addStringParameterToQuery(query, node, "data", "data");
			addStringParameterToQuery(query, node, "action", "action");
		}
		catch (Exception e)
		{
			// if there is an error while parsing the dates
			String msg = "error al parsear fechas";
			logger.error(getMessageFromResource(msg), e);	
		}

		return query;
	}

	private DaoResult<ActivityLogEntry> getActivityLogs(DaoQuery query, DaoOrder order)
	{
		DaoResult<ActivityLogEntry> logs = null;
		DomainManager manager = getDomainManager();

		// perform query
		try
		{
			logs = manager.queryActivityLogEntry(query, order);
		}
		catch (Exception e)
		{		
			// If something fail at the domain manager level
			String msg = "Error_while_retrieving_logs";
			// log the error
			logger.error(getMessageFromResource(msg), e);	
		}
		
		return logs;
	}

	private ArrayNode getActivityLogNodes(List<ActivityLogEntry> logs)
	{
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		// formatter for date to be show on the UI table
		SimpleDateFormat tableFormatter = (SimpleDateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss"); 

		// loop through the resulting objects
		for (ActivityLogEntry eachLog : logs)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			eachObject.put("id", eachLog.getId());

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);

			// column info
			eachArray.add(eachLog.getAction());
			eachArray.add(eachLog.getAccessed_from());
			eachArray.add(eachLog.getData());
			eachArray.add(tableFormatter.format(eachLog.getTimestamp()));
			eachArray.add(eachLog.getUsername() == null ? "" : eachLog.getUsername());

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}


	/*
	 * This method will respond a json object with the Activitylog Action
	 * that matches the queryPattern. This request will be done by an autocomplete widget
	 */	
	@RequestMapping(value = "/activity-log-search-action", method = RequestMethod.GET)
	@ResponseBody
	public Object getActivityLogSearchActionRequest(@RequestParam("term") String queryPattern) throws Exception
	{
		return getActivityLogColumnPropertyValues("action", queryPattern);
	}
	
	/*
	 * This method will respond a json object with the Activitylog Information
	 * that matches the queryPattern. This request will be done by an autocomplete widget
	 */	
	@RequestMapping(value = "/activity-log-search-data", method = RequestMethod.GET)
	@ResponseBody
	public Object getActivityLogSearchDataRequest(@RequestParam("term") String queryPattern) throws Exception
	{
		return getActivityLogColumnPropertyValues("data", queryPattern);
	}
	
	private List<String> getActivityLogColumnPropertyValues(String property, String queryPattern) throws Exception
	{
		DomainManager manager = getDomainManager();

		List<String> values = Collections.emptyList();

		try
		{
			values = manager.getActivityLogColumnPropertyValues(property, "%" + queryPattern.trim() + "%", MAX_AUTOCOMPLETE_RESULTS);
		}
		catch (Exception ex)
		{
			logger.error("error while getting ActivityLogEntry property " + property, ex);
		}

		return values;					
	}
}
