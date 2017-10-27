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

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.manager.DomainManagerN4;  
import com.atp.solicitudes.model.ContenedorStatus;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.Transportista;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserTransportistas;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.SimpleEntry;

@Controller
@RequestMapping(value = "/Transportista")
public class TransportistaWebService extends LocalBaseService
{
	
	@Resource(name="domainManager_n4")
	DomainManagerN4 manager;
	
	
	@Resource(name=DomainManager.BEAN_NAME)
	private DomainManager domainManager;
	
	protected static Logger logger = LoggerFactory.getLogger(TransportistaWebService.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getId(@PathVariable(value = "id") Integer id)
	{
		Transportista obj = null;
		try
		{
			obj = manager.getTransportistaWithId(id);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Transportista", ex);
		}
		return obj;
	}
	
	@RequestMapping(value = "/nombre/{nombre}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getNombre(@PathVariable(value = "nombre") String nombre)
	{
		System.out.println("-----2-----transportista-" + nombre);
		String rem = nombre ;
		rem =rem.replace(",",".");
		rem =rem.replace("diag","/");
		rem =rem.replace("coma",",");
		rem =rem.replace("sig","&");
		rem =rem.replace("bla"," ");
		
		String h ="A. GARCIA";
		Transportista obj = null;
		System.out.println("-----2-----transportista-" + rem);
		try
		{
			obj = manager.getTransportistaWithNombre(rem);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Transportista", ex);
		}

		return obj;
	}

	
	@RequestMapping(value = "/like", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getLikeTransportista(@RequestParam(value = "match") String match, HttpServletRequest request)
	{
		List<SimpleEntry> res = null;

		try
		{
			String maxResultsStr = request.getParameter("results");

			Integer maxResults = maxResultsStr != null ? Integer.parseInt(maxResultsStr) : null;

			res = manager.getTransportistaImpo("%" + match + "%", maxResults);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Transportista columns", ex);
		}

		return res;
	}
	
	@RequestMapping(value = "/likes/{nombre}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getTransportistas(@PathVariable(value = "nombre") String nombre)
	{
		//DaoResult<UserTransportistas> col = new DaoResult<UserTransportistas>();
		//List<String> listObj = domainManager.getSolicitudByN4(idUser);
		/*String[] listId = new String[listObj.size()];
		for (int i = 0; i < listObj.size()-1; i++)
		{
			listId[i] = listObj.get(i);
		}*/
		List<SimpleEntry> res = null;

		try
		{
			res = manager.getTransportistaImpo("%" + nombre + "%", 10);
			//List<SimpleEntry> listObj = manager.getTransportistaImpo("%" + nombre + "%", 10);
			//col = domainManager.getnombresByAdmin(listObj);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Transportista", ex);
		}
		System.out.println("------" + res.toArray());
		return res;
	}
	
	@RequestMapping(value = "/status/{unit_nbr}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getContenedorStatus(@PathVariable(value = "unit_nbr") String unitNbr)
	{
		List<String> res = null;

		try
		{
			res = domainManager.getContenedorStatus(unitNbr);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting Contenedor columns", ex);
		}

		return res;
	}
	

	
}