package com.atp.solicitudes.controller;

import java.text.MessageFormat;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.atp.solicitudes.model.CancellationMotiveEnum;
import com.atp.solicitudes.model.OperationValidationStateEnum;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.SolicitudOperationTypeEnum;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserTransportistas;
import com.objectwave.controller.BaseController;
import com.objectwave.utils.JSONUtils;

@Controller
@RequestMapping ("transportistas")
public class TransportistasController extends BaseController
{
	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpServletRequest request)
	{
			return "transportistas";
	}

}
