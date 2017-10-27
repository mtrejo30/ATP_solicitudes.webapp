package com.atp.solicitudes.controller;

import org.codehaus.jackson.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atp.solicitudes.constants.ATPRulesConstants;
import com.atp.solicitudes.model.SolicitudOperationTypeEnum;
import com.atp.solicitudes.model.User;

@Controller
@RequestMapping("impo")
public class ImpoController extends AppointmentController
{
	protected static Logger logger = LoggerFactory.getLogger(ImpoController.class);

	public String getPageTitle()
	{
		return getMessageFromResource("ImpoTitle");
	}

	public SolicitudOperationTypeEnum getOperationType()
	{
		return SolicitudOperationTypeEnum.IMPO;
	}
	
	public String getGateIdFromUserAndNode(User user, JsonNode node)
	{
		// return a default gate based on user
		String defaultGate = getDefaultGateForUser(user);
		if (defaultGate != null)
			return defaultGate;

		// if recinto destino has data, return TIT
		JsonNode recintoNode = node.get("recintoDestino");
		if (recintoNode != null && recintoNode.isObject() && recintoNode.get("label").asText().length() > 0)
			return ATPRulesConstants.TIT_GATE;

		return ATPRulesConstants.ATP_GATE;
	}
}
