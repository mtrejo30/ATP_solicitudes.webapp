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
import com.atp.solicitudes.model.Bloqueos;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.utils.JSONUtils;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping("bloqueos")
public class bloqueosController extends LocalBaseController
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(bloqueosController.class);

	static String SEARCH_INFO_PARAM = "search_info";	
	
	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpSession session)
	{
		// assigns ModelSession to model object
		setModelSession(session, model);
			
		// return view name to be used
		return "bloqueos";
	}
	/*
	
	@RequestMapping(value = "/bloqueos-table-info", method = RequestMethod.GET)
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
		DaoResult<Bloqueos> holidays = getHolidays(query, order);
		
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
	
	private DaoResult<Bloqueos> getHolidays(DaoQuery query, DaoOrder order)
	{
		DaoResult<Bloqueos> holidays = null;
		DomainManager manager = getDomainManager();

		// perform query
		try
		{
			holidays = manager.queryBloqueos(query, order);
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
	
	private ArrayNode getHolidaysNodes(List<Bloqueos> holidays)
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		// loop through the resulting objects
		for (Bloqueos eachHoliday : holidays)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			eachObject.put("id", eachHoliday.getId_bloqueo());

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);
					
			
			// column info
			eachArray.add(eachHoliday.getId_bloqueo());
			eachArray.add(eachHoliday.getTipo_Movimiento());			
			eachArray.add(eachHoliday.getNombre_agencia_excluir());
			eachArray.add(eachHoliday.getNombre_cliente_excluir());

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}
	*/
	
}

