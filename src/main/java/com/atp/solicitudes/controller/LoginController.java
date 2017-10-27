package com.atp.solicitudes.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
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
import com.atp.solicitudes.webservice.N4WebServiceTest;
import com.atp.solicitudes.webservice.client.N4WebServiceTemplate;
import com.navis.argo.ObjectFactory;
import com.navis.argo.webservice.types.v1.GenericInvokeResponseWsType;
import com.navis.argo.webservice.types.v1.MessageType;
import com.navis.argo.webservice.types.v1.QueryResultType;
import com.navis.argo.webservice.types.v1.ResponseType;
import com.navis.services.argoservice.GenericInvoke;
import com.navis.services.argoservice.GenericInvokeResponse;
import com.objectwave.exception.DomainModelException;
import com.objectwave.session.SessionModel;
import com.navis.argo.webservice.*;

/**
 * LoginController is a class to handle the application credentials login request.
 * It handles the redirect to the appropriate landing page.
 */
@Controller
@RequestMapping("login")
public class LoginController extends LocalBaseController
{
	@Resource(name="n4_webserviceTemplate")
	N4WebServiceTemplate template;
	
	public static final String NAME_PARAM = "username";
	public static final String PASSWORD_PARAM = "password";
	public static final String LANDING_PAGE = "main.page";
	public static final String NEW_PASSWORD_PAGE = "new-password.page";
	public static final String NEW_ACCESO_PAGE = "newacceso.page";
	
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
		//borrar
		
		
		//borrar fin
		String fecha_sys;
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
        	sessionModel.setUserN4(user.getUsuarioN4_id().toString());
        	sessionModel.setIpAddress(request.getLocalAddr());
        	sessionModel.setLoggedUser(user);

        	// store it on the session
        	session = request.getSession();
        	//ten mins by default
        	session.setMaxInactiveInterval(Integer.parseInt(environment.getProperty("sessionTimeOut", "900")));
        	session.setAttribute(SessionModel.SLOT_NAME, sessionModel);

        	domainManager.registerLogin(user);
        	String fecha_vigencia = user.validity_date();
        	Date fechaActual = new Date();
             
            //Formateando la fecha:
            //DateFormat formatoHora = new SimpleDateFormat("HH:mm:ss");
             DateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
             fecha_sys =formatoFecha.format(fechaActual);
            int a =user.getpantallaId();
            
            System.out.println("-pantalla-" + a);
            if(user.validity_date() ==formatoFecha.format(fechaActual))
            {
            	String msg = getMessageFromResource("Login_failed");
            	logger.error(msg);
        		// redirect to change new password page
            }
            
            System.out.println("--" + user.validity_date());
            System.out.println("--" + formatoFecha.format(fechaActual));
            
        	// check if user is required to change his password
        	if (!domainManager.shouldNewPasswordBeDefinedFor(user))
        	{
        		final String msg = "logged user must change his password";
        		logger.info(msg);
        		//return "redirect:" + NEW_PASSWORD_PAGE;
        		return "redirect:" + NEW_ACCESO_PAGE;
        	}
        		
        	if (domainManager.shouldNewPasswordBeDefinedFor1(user))
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
        			
        			//String obj = new N4WebServiceTest().pruebacosa(); 
        			//GenericInvoke invoke = new GenericInvoke();
        			//invoke.setXmlDoc("<![CDATA[<argo:snx xmlns:argo=\"http://www.navis.com/argo\" xmlns:ns2=\"http://www.navis.com/services/argoservice\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.navis.com/argo snx.xsd\"><icu> <units> <unit-identity id=\"MSCU4763394\" /> </units> <properties> <property tag=\"UnitFlexString04\" value=\"OCX\" /> <property tag=\"UnitRemark\" value=\"1_ooooooo desde el Portal Web algo\" /> </properties> </icu><hpu><entities><units><unit id=\"MSCU4763394\"></unit></units></entities><flags><flag hold-perm-id=\"PREVIO EXPRESS\" action=\"ADD_HOLD\"/></flags></hpu></argo:snx>]]>");
        			//invoke.setXmlDoc("<ns4:gate xmlns:ns2=\"http://www.navis.com/services/argoservice\" xmlns:ns3=\"http://types.webservice.argo.navis.com/v1.0\" xmlns:ns4=\"http://www.navis.com/argo\"><create-appointment><appointment-date>2016-08-22</appointment-date><appointment-time>00:00:00</appointment-time><gate-id>DEPOSITO</gate-id><driver card-id=\"123456\"/><truck license-nbr=\"123\" trucking-co-id=\"3G\"/><tran-type>DM</tran-type><container ufv-flex-date-2=\"2016-08-21T20:05:22\" eqid=\"TEST1234567\"/><external-ref-nbr>TEST</external-ref-nbr></create-appointment></ns4:gate>");
        			/*logger.info("Response  - {}",invoke.getXmlDoc());
        			GenericInvokeResponse resp = (GenericInvokeResponse) template.marshalSendAndReceive(invoke);
        			GenericInvokeResponseWsType genericInvokeResponse = resp.getGenericInvokeResponse();
        			ResponseType respType = genericInvokeResponse.getCommonResponse();
        			logger.info("Response  - {}",invoke.getXmlDoc());
        			logger.info("Resp - {}",resp);
        			logger.info("Resp - {}",genericInvokeResponse);
        			logger.info("Response Status - {}", respType.getStatus());
        			logger.info("Response Description - {}", respType.getStatusDescription());
                    
        			
        			for (MessageType eachMsg : respType.getMessageCollector().getMessages())
        			{
        				logger.info("MessageType SEV LEV: {} - {}", eachMsg.getSeverityLevel(), eachMsg.getMessage());
        			}

        			for (QueryResultType eachQuery : respType.getQueryResults())
        			{
        				String queryResult = eachQuery.getResult();
        				logger.info("QueryResultType String Result - {}", queryResult);
        				
        				
        				Object obj = template.unmarshallObject(queryResult);
        				logger.info("QueryResultType Object - {}", obj);
        			}

        			String responsePayload = genericInvokeResponse.getResponsePayLoad();
        			 System.out.printf("Response Payload - {}", responsePayload);
        			 System.out.printf("Response Description - {}", respType.getStatusDescription());
        			logger.info("Response Payload - {}", responsePayload);
        			logger.info("Response Description - {}", respType.getStatusDescription());*/
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
