package com.atp.solicitudes.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.atp.solicitudes.model.User;
import com.objectwave.session.SessionModel;

@Controller
@RequestMapping("main")
public class MainController extends LocalBaseController
{
	@RequestMapping(method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpSession session)
	{
		// assigns ModelSession to model object
		setModelSession(session, model);
		final SessionModel sessionModel = getSessionModel(session);
		if (sessionModel.isLoggedIn())
		{
			User user = (User)sessionModel.getLoggedUser();
			session.setAttribute("loggedUser", user);
		}
		// return view name to be used
		return "main";
	}
}	
