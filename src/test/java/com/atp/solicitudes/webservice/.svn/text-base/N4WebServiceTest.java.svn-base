package com.atp.solicitudes.webservice;

import javax.annotation.Resource;
import javax.xml.datatype.DatatypeConstants;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.atp.solicitudes.test.BaseTest;
import com.atp.solicitudes.webservice.client.N4WebServiceTemplate;

import com.navis.argo.AppointmentListRequestType;
import com.navis.argo.AppointmentRequestBaseType;
import com.navis.argo.ContainerType;
import com.navis.argo.DriverBaseRequestType;
import com.navis.argo.GateWebserviceRequestType;
import com.navis.argo.TruckBaseRequestType;
import com.navis.argo.webservice.types.v1.GenericInvokeResponseWsType;
import com.navis.argo.webservice.types.v1.MessageType;
import com.navis.argo.webservice.types.v1.QueryResultType;
import com.navis.argo.webservice.types.v1.ResponseType;
import com.navis.argo.webservice.types.v1.ScopeCoordinateIdsWsType;
import com.navis.services.argoservice.GenericInvoke;
import com.navis.services.argoservice.GenericInvokeResponse;

public class N4WebServiceTest extends BaseTest
{
	protected static Logger logger = LoggerFactory.getLogger(N4WebServiceTest.class);

	@Resource(name="n4_webserviceTemplate")
	N4WebServiceTemplate template;
	
	@Test
	public void createAppointmentTest()  throws Exception
	{		
		ScopeCoordinateIdsWsType scope = template.getDefaultScopeCoordinateIdsWsType();

		GenericInvoke invoke = new GenericInvoke();
		invoke.setScopeCoordinateIdsWsType(scope);
		
		String xmlSource = "";

		GateWebserviceRequestType request = new GateWebserviceRequestType();

		GateWebserviceRequestType.CreateAppointment appointment = new GateWebserviceRequestType.CreateAppointment();
		
		DatatypeFactory dtf = DatatypeFactory.newInstance();

		XMLGregorianCalendar xgcal = dtf.newXMLGregorianCalendarDate(2014,1,22, DatatypeConstants.FIELD_UNDEFINED );
		appointment.setAppointmentDate(xgcal);

		xgcal = dtf.newXMLGregorianCalendarTime(14,0,0, DatatypeConstants.FIELD_UNDEFINED );
		appointment.setAppointmentTime(xgcal);

		appointment.setGateId("ATP");
		appointment.setTranType("DI");

		DriverBaseRequestType driver = new DriverBaseRequestType();
		driver.setCardId("123456");
		appointment.setDriver(driver);

		TruckBaseRequestType truck = new TruckBaseRequestType();
		truck.setLicenseNbr("123");
		truck.setTruckingCoId("3G");
		appointment.setTruck(truck);

		ContainerType container = new ContainerType();
		container.setEqid("MEDU8701376");
		appointment.setContainer(container);
		
		request.setCreateAppointment(appointment);

		xmlSource = template.marshallObject(request);
		logger.info("Contained XML {}", xmlSource);

		invoke.setXmlDoc(xmlSource);
		
		GenericInvokeResponse resp = (GenericInvokeResponse) template.marshalSendAndReceive(invoke);

		GenericInvokeResponseWsType genericInvokeResponse = resp.getGenericInvokeResponse();

		ResponseType respType = genericInvokeResponse.getCommonResponse();

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
		logger.info("Response Payload - {}", responsePayload);
	}

	@Test
	public void cancelAppointmentTest()  throws Exception
	{		
		ScopeCoordinateIdsWsType scope = template.getDefaultScopeCoordinateIdsWsType();

		GenericInvoke invoke = new GenericInvoke();
		invoke.setScopeCoordinateIdsWsType(scope);
		
		String xmlSource = "";
		
		GateWebserviceRequestType request = new GateWebserviceRequestType();

		GateWebserviceRequestType.CancelAppointment cancelAppointment = new GateWebserviceRequestType.CancelAppointment();

		AppointmentListRequestType appointments = new AppointmentListRequestType();

		AppointmentRequestBaseType entry = new AppointmentRequestBaseType();
		entry.setAppointmentNbr(512l);
		appointments.getAppointment().add(entry);

		cancelAppointment.setAppointments(appointments);
		
		request.setCancelAppointment(cancelAppointment);
		
		xmlSource = template.marshallObject(request);
		logger.info("Contained XML {}", xmlSource);

		invoke.setXmlDoc(xmlSource);
		
		GenericInvokeResponse resp = (GenericInvokeResponse) template.marshalSendAndReceive(invoke);

		GenericInvokeResponseWsType genericInvokeResponse = resp.getGenericInvokeResponse();

		ResponseType respType = genericInvokeResponse.getCommonResponse();

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
			logger.info("QueryResultType Object - {}", obj);		}

		String responsePayload = genericInvokeResponse.getResponsePayLoad();
		logger.info("Response Payload - {}", responsePayload);
	}

	@Test
	public void createAppointmentHoursTest()  throws Exception
	{		
		ScopeCoordinateIdsWsType scope = template.getDefaultScopeCoordinateIdsWsType();

		GenericInvoke invoke = new GenericInvoke();
		invoke.setScopeCoordinateIdsWsType(scope);
		
		String xmlSource = "";

		GateWebserviceRequestType request = new GateWebserviceRequestType();

		GateWebserviceRequestType.CreateAppointment appointment = new GateWebserviceRequestType.CreateAppointment();
		
		DatatypeFactory dtf = DatatypeFactory.newInstance();

		XMLGregorianCalendar xgcal = dtf.newXMLGregorianCalendarDate(2014,1,28, DatatypeConstants.FIELD_UNDEFINED );
		appointment.setAppointmentDate(xgcal);

		xgcal = dtf.newXMLGregorianCalendarTime(0,0,0, DatatypeConstants.FIELD_UNDEFINED );
		appointment.setAppointmentTime(xgcal);

		appointment.setGateId("ATP");
		appointment.setTranType("PUM");
		appointment.setExternalRefNbr("TEST");

		DriverBaseRequestType driver = new DriverBaseRequestType();
		driver.setCardId("123456");
		appointment.setDriver(driver);

		TruckBaseRequestType truck = new TruckBaseRequestType();
		truck.setLicenseNbr("123");
		truck.setTruckingCoId("3G");
		appointment.setTruck(truck);

		ContainerType container = new ContainerType();
		container.setEqid("TEST1234567");
		appointment.setContainer(container);
	
		request.setCreateAppointment(appointment);

		xmlSource = template.marshallObject(request);
		logger.info("Contained XML {}", xmlSource);

		invoke.setXmlDoc(xmlSource);
		
		GenericInvokeResponse resp = (GenericInvokeResponse) template.marshalSendAndReceive(invoke);

		GenericInvokeResponseWsType genericInvokeResponse = resp.getGenericInvokeResponse();

		ResponseType respType = genericInvokeResponse.getCommonResponse();

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
		logger.info("Response Payload - {}", responsePayload);
	}
}
