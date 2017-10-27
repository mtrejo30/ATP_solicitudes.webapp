package com.atp.solicitudes.webservice;

import java.util.Collections;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.Special;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping(value = "/Special")
public class SpecialWebService extends LocalBaseService
{
	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(SpecialWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") String id)
	{
		Special obj = null;

		try
		{
			obj = manager.getSpecialWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Special", ex);
		}

		return obj;
	}

	//http://localhost:8080/solicitudes/rest/Special/get-all
	@RequestMapping(value="/get-all", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getAll()
	{
		ServerResponse resp = new ServerResponse();

		try
		{
			List<Special> col = Collections.emptyList();
			col = manager.getAllSpecial();
			
			resp.setBody(col);
		}
		catch (Exception ex)
		{
			String message = "error while getting Special collection";
			logger.debug(message, ex);
			
			resp.setErrorMessage(message);
		}

		return resp;
	}

	@RequestMapping(value="/search", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object search(@RequestBody JsonNode node, HttpServletRequest request) throws Exception
	{
		ServerResponse resp = new ServerResponse();

		try
		{
			DaoQuery query = new DaoQuery();

			// query include all moves
			addStringParameterToQuery(query, node, "moveWithAll", "moveWithAll");
			
			if (node.has("companyLike"))
				query.filter("companyLike", "%" + node.get("companyLike").asText() + "%");

			DaoOrder order = DaoOrder.withSort("descripcion", DaoOrder.ASC);

			List<Special> col = Collections.emptyList();
			col = manager.querySpecial(query, order);
			
			resp.setBody(col);
		}
		catch (Exception ex)
		{
			String message = "error while getting Special collection";
			logger.debug(message, ex);
			
			resp.setErrorMessage(message);
		}

		return resp;
	}
}
