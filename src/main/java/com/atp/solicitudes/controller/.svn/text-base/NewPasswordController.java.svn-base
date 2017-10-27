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
@RequestMapping("new-password")
public class NewPasswordController extends LocalBaseController
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
		final User user = getLoggedUser(request);
		final DomainManager dm = getDomainManager();  
		
		String redirectPage = null;
		
		if (newPassword == null || confirmPassword == null)
			return "new-password";				
			
		try
		{			
			dm.processUpdateUserPassword(user, newPassword, confirmPassword);
        	redirectPage = "redirect:" + LoginController.LANDING_PAGE;
		}
		catch (DomainModelException ex)
		{
        	// if error, post it on the error page
        	model.put("errorMessage", getMessageFromResource(ex.getMessage()));

        	redirectPage = "new-password";        	
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

