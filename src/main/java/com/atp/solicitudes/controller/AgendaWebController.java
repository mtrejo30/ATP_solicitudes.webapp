package com.atp.solicitudes.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserStatusEnum;
import com.objectwave.exception.DomainModelException;
import com.objectwave.utils.JSONUtils;

@Controller
@RequestMapping("AgendaWeb")
public class AgendaWebController extends LocalBaseController
{
	public static final String NEW_PASSWORD_PARAM = "new_password";
	public static final String CONFIRM_PASSWORD_PARAM = "confirm_password";
	
	protected static Logger logger = LoggerFactory.getLogger(AgendaWebController.class);
	
	@RequestMapping 
	public String show(Map<String, Object> model, HttpServletRequest request)
	{
		final String newPassword = request.getParameter(NEW_PASSWORD_PARAM);
		final String confirmPassword = request.getParameter(CONFIRM_PASSWORD_PARAM);
				
		// gets the current logged user
		//final SessionModel sessionModel = getSessionModel(request.getSession());
		//final User user = (User) sessionModel.getLoggedUser();
		final User user = getLoggedUser(request);
		final DomainManager dm = getDomainManager();  
		
		model.put("urlwebclient", "http://148.223.29.18:5041/AgendaWebClient/Home?ID=" + user.getUsuarioN4_id().toString());
	
		
		String redirectPage = null;
		
		if (newPassword == null || confirmPassword == null)
			return "AgendaWeb";				
		
				
		// return view name to be used
		return redirectPage;
	}
}

