package com.atp.solicitudes.reports.controller;

import java.text.DateFormat;
import java.text.MessageFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.controller.LocalBaseController;
import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.ConsultaBooking;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.JSONUtils;


@Controller
@RequestMapping ("report_consultas_por_booking")
public class ConsultaBookingController extends LocalBaseController
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(ConsultaBookingController.class);
	
	static String SEARCH_INFO_PARAM = "search_info";

	@Resource(name=ReportsDomainManager.BEAN_NAME)
	private ReportsDomainManager domainManager;

	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpSession session)
	{
		try
		{
			// assigns ModelSession to model object
			setModelSession(session, model);
	
			// return view name to be used
			return "report_consultas_por_booking";
		}
		catch (Exception ex)
		{
			String errorMsg = MessageFormat.format("error while rendering page", new Object[] {});
			logger.error(errorMsg, ex);

			model.put("errorMessage", errorMsg);
			return "error";
		}
	}

	@RequestMapping(value = "/report-table-info", method = RequestMethod.GET)
	@ResponseBody
	public Object reportTableInfoRequest(HttpServletRequest request)
	{
		// Get users to be displayed on table
		DaoResult<ConsultaBooking> col = getObjects(request);

		ObjectNode object = getTableMainNode(col);
		
		// Populate table
		ArrayNode rows = getNodes(col.getCollection());

		// set the rows property
		object.put("rows", rows);

		// return the object to the UI table
		return object;
	}


	private DaoResult<ConsultaBooking> getObjects(HttpServletRequest request)
	{
		DaoResult<ConsultaBooking> col = new DaoResult<ConsultaBooking>();

		// perform query
		try
		{
			JsonNode node = JSONUtils.getJSONFromString(request.getParameter(SEARCH_INFO_PARAM));

			String digitoVerificador = node.get("contenedorDigitoVerificador").asText().trim();

			if (digitoVerificador.length() > 0)
				col = domainManager.getConsultaBooking(digitoVerificador);
		}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("Error_while_retrieving_objects", new Object[] {});
			logger.error(getMessageFromResource(errorMsg), e);
		}

		return col;
	}

	private ArrayNode getNodes(List<ConsultaBooking> col)
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		DateFormat formatter = (DateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss");

		Integer count = 0;

		// loop through the resulting objects
		for (ConsultaBooking eachObj : col)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			count++;

			// sets the object id, required by the UI table
			eachObject.put("id", count);

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);

			// column info
			eachArray.add(eachObj.getContenedor());
			eachArray.add(eachObj.getLhtCode());
			eachArray.add(eachObj.getSslCode());
			eachArray.add(formatter.format(eachObj.getRdDate()));
			eachArray.add(eachObj.getRdFlag()); 
			eachArray.add(eachObj.getMovimiento()); 

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}
}