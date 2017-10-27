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
@RequestMapping("recepcion-vacio")
public class RecepcionVacioController extends AppointmentController
{
	protected static Logger logger = LoggerFactory.getLogger(RecepcionVacioController.class);

	public String getPageTitle()
	{
		return getMessageFromResource("RecepcionVacioTitle");
	}

	public SolicitudOperationTypeEnum getOperationType()
	{
		return SolicitudOperationTypeEnum.RECEPCION_VACIO;
	}

	public String getGateIdFromUserAndNode(User user, JsonNode node)
	{
		// return a default gate based on user
		String defaultGate = getDefaultGateForUser(user);
		if (defaultGate != null)
			return defaultGate;

		String tipo = node.get("tipo").get("label").asText();
		String linea = node.get("linea").get("label").asText();

		String special = "";
		JsonNode specialNode = node.get("special");
		if (specialNode != null && specialNode.isObject())
			special = specialNode.get("label").asText();

		if (tipo.contains("R") & (linea!=("MSC")||linea!=("HSD")) || tipo.contains("T") || tipo.contains("P"))
		{
			if (special.length() > 0)
				return ATPRulesConstants.ATP_GATE;
		}

		return ATPRulesConstants.DEPOSITO_GATE;
	}
}
