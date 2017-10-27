package com.atp.solicitudes.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.User;
import com.objectwave.controller.BaseController;
import com.objectwave.session.SessionModel;

public class LocalBaseController extends BaseController implements HandlerExceptionResolver
{
	public DomainManager getDomainManager()
	{
		return (DomainManager) getBean (DomainManager.BEAN_NAME);
	}

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception)
	{
		logger.error("error while responding request", exception);

		ModelAndView model = new ModelAndView("error");
		model.addObject("errorMessage", "Error while responding request, check log files");
		return model;
	}

	protected User getLoggedUser(HttpServletRequest request)
	{
		// gets the current logged user
		SessionModel sessionModel = getSessionModel(request.getSession());
		return (User) sessionModel.getLoggedUser();
	}
}
