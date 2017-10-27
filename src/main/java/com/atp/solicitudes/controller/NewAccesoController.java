package com.atp.solicitudes.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.User;
import com.objectwave.exception.DomainModelException;

@Controller
@RequestMapping("newacceso")
public class NewAccesoController
{

	public static final String NEW_PASSWORD_PARAM = "new_password";
	public static final String CONFIRM_PASSWORD_PARAM = "confirm_password";
	
	protected static Logger logger = LoggerFactory.getLogger(NewPasswordController.class);
	
	@RequestMapping 
	public String show(Map<String, Object> model, HttpServletRequest request)
	{
		final String newPassword = request.getParameter(NEW_PASSWORD_PARAM);
		final String confirmPassword = request.getParameter(CONFIRM_PASSWORD_PARAM);
				
		// gets the current logged user
		//final SessionModel sessionModel = getSessionModel(request.getSession());
		//final User user = (User) sessionModel.getLoggedUser();
		
		String redirectPage = null;
		
		if (newPassword == null || confirmPassword == null)
			return "newacceso";				
			
		try
		{			
			redirectPage = "redirect:" + LoginController.LANDING_PAGE;
		}
		
		catch (Exception ex)
		{
			final String msg = "error in login process";
        	logger.error(msg, ex);

        	// if error, post it on the error page
        	model.put("errorMessage", msg);

        	redirectPage = "redirect:error";        	
		}
				
		// return view name to be used
		return redirectPage;
	}
}
