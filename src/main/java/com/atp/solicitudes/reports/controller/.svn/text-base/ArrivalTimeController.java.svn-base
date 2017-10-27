package com.atp.solicitudes.reports.controller;

import java.text.DateFormat;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.atp.solicitudes.reports.model.ArrivalTime;
import com.atp.solicitudes.reports.model.ArrivalTimeContenedor;
import com.atp.solicitudes.reports.model.ArrivalTimeHoraEntradaTerminal;
import com.atp.solicitudes.reports.model.ArrivalTimeLlegadaAlCentroRegulador;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.JSONUtils;


@Controller
@RequestMapping ("report_arrival_time")
public class ArrivalTimeController extends LocalBaseController
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(ArrivalTimeController.class);
	
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
			return "report_arrival_time";
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
		DaoResult<ArrivalTime> col = getObjects(request);

		ObjectNode object = getTableMainNode(col);
		
		// Populate table
		ArrayNode rows = getNodes(col.getCollection());

		// set the rows property
		object.put("rows", rows);

		// return the object to the UI table
		return object;
	}


	private DaoResult<ArrivalTime> getObjects(HttpServletRequest request)
	{
		List<ArrivalTime> arrivalTimeList = new ArrayList<ArrivalTime>();
		
		// perform query
		try
		{
			JsonNode node = JSONUtils.getJSONFromString(request.getParameter(SEARCH_INFO_PARAM));

			String paseDeEntrada = node.get("inputPaseDeEntrada").asText().trim();

			if (paseDeEntrada.length() > 0)
			{				
				List<ArrivalTimeContenedor> contenedorList = 
						domainManager.getArrivalTimeContenedor(paseDeEntrada).getCollection();
												
				List<ArrivalTimeLlegadaAlCentroRegulador> centroReguladorList = 
						domainManager.getArrivalTimeLlegadaAlCentroRegulador(paseDeEntrada).getCollection();

				List<ArrivalTimeHoraEntradaTerminal> terminalList = 
						domainManager.getArrivalTimeHoraEntradaTerminal(paseDeEntrada).getCollection();
				
				for (int index = 0; index < contenedorList.size(); index++)
				{
					ArrivalTime newArrivalTime = 
							getNewArrivalTime(index, contenedorList, centroReguladorList, terminalList);					
					newArrivalTime.setPaseDeEntrada(paseDeEntrada);
					
					arrivalTimeList.add(newArrivalTime);
				}
			}				
		}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("Error_while_retrieving_objects", new Object[] {});
			logger.error(getMessageFromResource(errorMsg), e);
		}
		
		DaoResult<ArrivalTime> daoResult = new DaoResult<ArrivalTime>();
		daoResult.setCollection(arrivalTimeList);

		return daoResult;
	}
	
	private ArrivalTime getNewArrivalTime(int index, List<?>... params)
	{
		ArrivalTime arrivalTime = new ArrivalTime();		
		
		ArrivalTimeContenedor contenedor = (ArrivalTimeContenedor)params[0].get(index);
		if (contenedor != null)
			arrivalTime.setContenedor(contenedor.getContenedor());
		
		ArrivalTimeLlegadaAlCentroRegulador llegadaAlCentroRegulador = (ArrivalTimeLlegadaAlCentroRegulador)params[1].get(index);
		if (llegadaAlCentroRegulador != null)
			arrivalTime.setLlegadaAlCentroRegulador(llegadaAlCentroRegulador.getLlamadoDate());
		
		ArrivalTimeHoraEntradaTerminal horaEntradaTerminal = (ArrivalTimeHoraEntradaTerminal)params[2].get(index);
		if (horaEntradaTerminal != null)
			arrivalTime.setHoraEntradaTerminal(horaEntradaTerminal.getInLaneDate());
							
		return arrivalTime;
	}
	
	private ArrayNode getNodes(List<ArrivalTime> col)
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		DateFormat formatter = (DateFormat) getBean("dateFormatter_yyyy-MM-dd_hh_mm_ss");

		Integer count = 0;

		// loop through the resulting objects
		for (ArrivalTime eachObj : col)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			count++;

			// sets the object id, required by the UI table
			eachObject.put("id", count);

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);

			// column info
			eachArray.add(eachObj.getPaseDeEntrada());
			eachArray.add(eachObj.getContenedor());			
			eachArray.add(formatter.format(eachObj.getLlegadaAlCentroRegulador()));
			eachArray.add(formatter.format(eachObj.getHoraEntradaTerminal()));
			
			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}
}