package com.atp.solicitudes.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.forms.SystemPropertyForm;
import com.atp.solicitudes.manager.DomainManager;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.model.SystemProperty;
import com.objectwave.utils.JSONUtils;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping ("system-property")
public class SystemPropertyController extends LocalBaseController
{
	static String SEARCH_INFO_PARAM = "search_info";

	static int MAX_AUTOCOMPLETE_RESULTS = 10; // 0 = all results

	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpSession session)
	{
		// assigns ModelSession to model object
		setModelSession(session, model);

		/// assign an empty SystemPropertyForm, to be used on the systemProperty.jsp
		model.put(SystemPropertyForm.MODEL_NAME, new SystemPropertyForm());

		// return view name to be used
		return "system-property";
	}

	@RequestMapping(value = "/system-property-table-info", method = RequestMethod.GET)
	@ResponseBody
	public Object systemPropertyTableInfoRequest(HttpServletRequest request, HttpSession session)
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

		// Get SystemProperties to be displayed on table
		DaoResult<SystemProperty> systemProperties = getSystemProperties(query, order);
		
		ObjectNode object = getTableMainNode(systemProperties);
		
		// Populate table
		ArrayNode rows = getSystemPropertyNodes(systemProperties.getCollection());

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

	private DaoResult<SystemProperty> getSystemProperties(DaoQuery query, DaoOrder order)
	{
		DaoResult<SystemProperty> systemProperties = null;
		DomainManager manager = getDomainManager();

		// perform query
		try
		{
			systemProperties = manager.getSystemPropertiesFrom(query, order);
		}
		catch (Exception e)
		{
			// If something fail at the domain manager level
			String msg = "Error_while_retrieving_users";
			// log the error
			logger.error(getMessageFromResource(msg), e);
		}

		return systemProperties;
	}

	private ArrayNode getSystemPropertyNodes(List<SystemProperty> systemProperties)
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		// loop through the resulting objects
		for (SystemProperty eachSystemProperty : systemProperties)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			eachObject.put("id", eachSystemProperty.getId());

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);
					
			// column info
			eachArray.add(eachSystemProperty.getId());
			eachArray.add(eachSystemProperty.getName());
			eachArray.add(eachSystemProperty.getValue());

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}

	@RequestMapping(value = "/system-properties-names", method = RequestMethod.GET)
	@ResponseBody
	public Object getSystemPropertiesNamesRequest(@RequestParam("term") String queryPattern) throws Exception
	{
		DomainManager manager = getDomainManager();
		
		List<String> names = Collections.emptyList();

		try
		{
			names = manager.getSystemPropertiesColumnPropertyValues("name", "%" + queryPattern.trim() + "%", MAX_AUTOCOMPLETE_RESULTS);
		}
		catch (Exception ex)
		{
			logger.error(getMessageFromResource("Error_when_getting_systemPropertyName"), ex);
		}

		return names;					
	}
	
	@RequestMapping(value = "/edit-system-property", method = RequestMethod.POST, produces="application/json")
	@ResponseBody
	public ServerResponse editSystemPropertyRequest(HttpServletRequest request)
	{
		ServerResponse response = new ServerResponse();

		Integer id = Integer.parseInt(request.getParameter("id"));  // SystemProperty Id - use this Id to search in DB for the SystemProperty.
		String value = request.getParameter("value"); //New value for the cell

		SystemProperty systemProperty = null;
		DomainManager manager = getDomainManager();

		try
		{
			systemProperty = manager.getSystemPropertyById(id);
		}
		catch (Exception e) 
		{
			String msg = getMessageFromResource("Error_when_getting_systemProperty");
			response.setError(true);
			response.setMessage(msg + " - " + e);
			return response;
		}

		//Set the value
		systemProperty.setValue(value);
		
		//Save SystemProperty
		try
		{
			manager.saveSystemProperty(systemProperty);
		}
		catch (Exception e)
		{
			// get the error message to be shown to the user
			String msg = getMessageFromResource(e.getMessage());
			response.setMessage(msg);
			response.setError(true);
			return response;
		}

		// SystemProperty successfully saved
		response.setMessage(systemProperty.getName() + " Saved");
		
		// return the response
		return response;
	}
}