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
import com.atp.solicitudes.model.Contenedor;
import com.objectwave.exception.DomainModelException;
import com.objectwave.utils.SimpleEntry;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping(value = "/Contenedor")
public class ContenedorWebService extends LocalBaseService
{
	@Resource(name = "domainManager_n4")
	DomainManagerN4 manager;

	protected static Logger logger = LoggerFactory.getLogger(ContenedorWebService.class);

	//http://localhost:8080/solicitudes/rest/Contenedor/164741681
	@RequestMapping(value = "/{unit_gkey}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "unit_gkey") Integer unit_gkey)
	{
		Contenedor obj = null;

		try
		{
			obj = manager.getContenedorWithId(unit_gkey);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor", ex);
		}

		return obj;
	}

	//http://localhost:8080/solicitudes/rest/Contenedor/impo/like?match=MSCU4942888&results=10
	@RequestMapping(value = "/impo/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLikeImpo(@RequestParam(value = "match") String match, @RequestParam(value = "consigne") String consigne, HttpServletRequest request) throws DomainModelException
	{
		ServerResponse serverResponse = new ServerResponse();
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getClaveContenedorImpo("%" + match + "%", consigne, maxResults);
		}
		
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor columns", ex);
		}
//		try{
//			if (res.size() != 0)
//			{
//				return res;
//			}
//			else
//			{
//				throw new DomainModelException("Container_invalid");
//			}
//		}
//		catch (DomainModelException ex)
//		{
//		String msg = getMessageFromResource("Container_invalid");
//		serverResponse.setMessage(msg);
//		return serverResponse;
//		}
		
		return res;
	}

	//http://localhost:8080/solicitudes/rest/Contenedor/historial/unit_nbr/like?match=GLDU356&results=10
	@RequestMapping(value = "/historial/unit_nbr/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getHistorialLike(@RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getClaveContenedorHistorial("%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor columns", ex);
		}

		return res;
	}

	//http://localhost:8080/solicitudes/rest/Contenedor/recent/unit_nbr/GLDU3564480
	@RequestMapping(value = "/recent/unit_nbr/{unit_nbr}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getRecentUnitNbr(@PathVariable(value = "unit_nbr") String unitNbr)
	{
		Contenedor res = null;

		try
		{
			res = manager.getContenedorRecentWithUnitNbr(unitNbr);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor columns", ex);
		}

		return res;
	}

	//http://localhost:8080/solicitudes/rest/Contenedor/desistimiento/like?match=CRLU7223748&results=10
	@RequestMapping(value = "/desistimiento/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLikeDesistimiento(@RequestParam(value = "match") String match, @RequestParam(value = "consigne") String consigne, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getClaveContenedorDesistimiento("%" + match + "%", consigne, maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor columns", ex);
		}

		return res;
	}
}
