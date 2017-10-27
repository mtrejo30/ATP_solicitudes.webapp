package com.atp.solicitudes.webservice;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.User;
import com.objectwave.webservice.model.ServerResponse;

@Controller
@RequestMapping("services/user")
public class UserService extends LocalBaseService
{
	@RequestMapping(value = "/get", method = RequestMethod.GET, headers="Accept=application/xml")
	@ResponseBody
	public Object getUser(@RequestParam(value="username") String username, HttpSession session)
	{
		// create the server response object
		ServerResponse response = new ServerResponse();

		DomainManager manager = getDomainManager();

		User user = null;

		try
		{
			// get the user from the domain manager by user name
			user = manager.getUserWithUsername(username);

			// create the XML representation of the user object
			// objects that are used to be responded as XML should be included on the
			// xmlObject bean list on the configuration file

			// sets the object as the body response
			response.setBody(user);
		}
		catch (Exception e)
		{
			// if a domain error occurred, notify it
			String msg = "Error_while_getting_user";
			logger.error(msg, e);	

			response.setError(true);
			response.setMessage(htmlEscape(getMessageFromResource(msg)));
		}

		// return the xml response
		return xmlResponse(response);
	}
}
