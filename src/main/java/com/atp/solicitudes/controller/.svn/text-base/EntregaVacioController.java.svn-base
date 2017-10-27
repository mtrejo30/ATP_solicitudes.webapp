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
@RequestMapping("entrega-vacio")
public class EntregaVacioController extends AppointmentController
{
	protected static Logger logger = LoggerFactory.getLogger(EntregaVacioController.class);

	public String getPageTitle()
	{
		return getMessageFromResource("EntregaVacioTitle");
	}

	public SolicitudOperationTypeEnum getOperationType()
	{
		return SolicitudOperationTypeEnum.ENTREGA_VACIO;
	}

	public String getGateIdFromUserAndNode(User user, JsonNode node)
	{
		// return a default gate based on user
		String defaultGate = getDefaultGateForUser(user);
		if (defaultGate != null)
			return defaultGate;

		String grade = node.get("clase").get("label").asText();
		
		if ("SC".equals(grade))
			return ATPRulesConstants.ATP_GATE;

		String tipoIso = node.get("tipo").get("label").asText();

		if (tipoIso.contains("R") || tipoIso.contains("T") || tipoIso.contains("P"))
			return ATPRulesConstants.ATP_GATE;

		return ATPRulesConstants.DEPOSITO_GATE;
	}
}