package com.atp.solicitudes.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.User;
import com.objectwave.exception.DomainModelException;
import com.objectwave.session.SessionModel;

/**
 * LoginController is a class to handle the application credentials login request.
 * It handles the redirect to the appropriate landing page.
 */
@Controller
@RequestMapping("login")
public class LoginController extends LocalBaseController
{
	public static final String NAME_PARAM = "username";
	public static final String PASSWORD_PARAM = "password";
	public static final String LANDING_PAGE = "main.page";
	public static final String NEW_PASSWORD_PAGE = "new-password.page";
	
	protected static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private Environment environment;

	/**
	 * Method show.
	 * 
	 * Takes the session info to decide if there is a valid session.
	 * 
	 * @param model Map<String,Object>
	 * @param request HttpServletRequest
	 * @return String
	 * @throws DomainModelException 
	 */
	@RequestMapping
	public String show(Map<String, Object> model, HttpServletRequest request) 
	{
		// clear any session data before asking for login credentials
		HttpSession session = request.getSession(false);
		if (session != null)
			session.invalidate();
		
		// get parameters
		String username = request.getParameter(NAME_PARAM);
		String password = request.getParameter(PASSWORD_PARAM);

		// if no username or password, return empty page
		if (username == null || password == null)
			return "login";

		// create a UsernamePasswordAuthenticationToken with the posted data
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);

		// get the spring security context
		SecurityContext context = SecurityContextHolder.getContext();

		// get the spring authentication manager
		AuthenticationManager authManager = (AuthenticationManager) getBean("authenticationManager");

        // assign the session from the request to the auth token
        token.setDetails(new WebAuthenticationDetails(request));

        try
        {
        	// authenticate
        	Authentication result = authManager.authenticate(token);
        	context.setAuthentication(result);

        	DomainManager domainManager = getDomainManager();        	
        	User user = domainManager.getUserWithUsername(username);
        	
        	// if for some reason the user is null, raise an error
        	if (user == null)
        		throw new Exception("user not found");

        	// get the session model from the Spring bean container
        	// as it is used on the ActivityLogger logger bean as a session bean
        	SessionModel sessionModel = (SessionModel) getBean("SessionModel");
        	// fill the session model with the appropriate session information
        	sessionModel.setIpAddress(request.getLocalAddr());
        	sessionModel.setLoggedUser(user);

        	// store it on the session
        	session = request.getSession();
        	//ten mins by default
        	session.setMaxInactiveInterval(Integer.parseInt(environment.getProperty("sessionTimeOut", "600")));
        	session.setAttribute(SessionModel.SLOT_NAME, sessionModel);

        	domainManager.registerLogin(user);
        	
        	// check if user is required to change his password
        	if (domainManager.shouldNewPasswordBeDefinedFor(user))
        	{
        		final String msg = "logged user must change his password";
        		logger.info(msg);

        		// redirect to change new password page
        		return "redirect:" + NEW_PASSWORD_PAGE;
        	} 
        	
        	//TODO check and test
        	try
        	{
        		if(!domainManager.validateUserAccessAllowed(user))
        		{ 
        			 return "redirect:" + LANDING_PAGE;
        		}
        	}
        	catch (DomainModelException dme)
        	{
            	String msg = getMessageFromResource("Login_failed");
            	logger.error(msg, dme);

            	// if error, post it on the error page
            	model.put("errorMessage", msg + " : " + dme.getMessage());
            	
            	session.invalidate();
         		return "login";
        	}        	        	
        	
			return "redirect:" + LANDING_PAGE;
        }
        catch (AuthenticationException authEx)
        {
        	String msg = getMessageFromResource("Login_failed");
        	logger.error(msg, authEx);

        	// if error, post it on the error page
        	model.put("errorMessage", msg + " : " + authEx.getMessage());

        	return "login";
        }
        catch (Exception ex)
        {
        	String msg = getMessageFromResource("Error_in_login_process");
        	logger.error(msg, ex);

        	// if error, post it on the error page
        	model.put("errorMessage", msg);

        	return "error";
        }
	}
}
