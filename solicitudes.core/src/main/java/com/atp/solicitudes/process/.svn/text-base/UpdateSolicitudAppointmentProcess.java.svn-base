package com.atp.solicitudes.process;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.SolicitudAppointment;
import com.atp.solicitudes.model.SolicitudAppointmentStatusEnum;

public class UpdateSolicitudAppointmentProcess
{
	protected static Logger logger = LoggerFactory.getLogger(UpdateSolicitudAppointmentProcess.class);

	@Resource(name = DomainManager.BEAN_NAME)
	DomainManager domainManager;
	
	NamedParameterJdbcTemplate jdbcTemplate;
	
	private String webServiceUsername;
	private String webServiceExternalUserId;

	public void execute()
	{
		logger.info("Update appointments process started at {}", new Date());

		Map<String,Object> params = new HashMap<String,Object>();
		
		List<SolicitudAppointment> activeAppointments = Collections.emptyList();
		
		// get the existing active appointments
		try
		{
			activeAppointments = domainManager.getActiveSolicitudAppointments();
		}
		catch (Exception ex)
		{
			logger.error("error while getting active appointments", ex);
		}

		// if active appointments founds
		if (activeAppointments.size() > 0)
		{
			// set the appointment nbrs as a query parameter
			params.put("nbrs", getActiveAppointmentNbrs(activeAppointments));
			// set the creator of the appointment to the user and external user combination
			params.put("creator", getWebServiceExternalUserId() + "/" + getWebServiceUsername());
	
			try
			{
				// execute the query and set the record set handler with the
				// appointments mapped to their nbr
				//TODO consider set a minimum date creation to reduce rowset size
				jdbcTemplate.query(
					"select APP_NBR, STATE from GATE_APPOINTMENT_VIEW where CREATOR = :creator and STATE in ('USED', 'USEDLATE', 'CANCEL', 'CLOSED') and APP_NBR in (:nbrs) order by START_DATE asc",
					params,
					new RetrieveSolicitudAppointmentsHandler(getActiveAppointmentsMap(activeAppointments)));
			}
			catch (Exception ex)
			{
				logger.error("error while executing appointment status update query", ex);
			}
		}
		
		logger.info("Update appointments process finished at {}", new Date());
	}
	
	private class RetrieveSolicitudAppointmentsHandler implements RowCallbackHandler
	{
		Map<Integer, SolicitudAppointment> appointmentsMap;

		RetrieveSolicitudAppointmentsHandler(Map<Integer, SolicitudAppointment> map)
		{
			appointmentsMap = map;
		}

		public void processRow(ResultSet rs) throws SQLException
		{
			Integer nbr = rs.getInt("APP_NBR");
			
			// find an appointment with the matching nbr on the created map
			SolicitudAppointment appointment = appointmentsMap.get(nbr);
			
			// if found
			if (appointment != null)
			{
				try
				{
					// get the status column value
					String statusCol = rs.getString("STATE");

					// get the appropriate status enum value from the column value
					SolicitudAppointmentStatusEnum newStatus = getStatusFromColumn(statusCol);

					// update the appointment status
					domainManager.updateSolicitudAppointmentStatus(appointment, newStatus);

					Object[] params = {appointment.getAppointmentNbr(), newStatus.getName()};
					logger.info("appointment with nbr {} updated to status {}", params);
				}
				catch (Exception ex)
				{
					logger.error("error while updating status of appointment" ,ex);
				}
			}
		}
	}

	private SolicitudAppointmentStatusEnum getStatusFromColumn(String str)
	{
		SolicitudAppointmentStatusEnum result = SolicitudAppointmentStatusEnum.CREATED;
		
		if ("CREATED".equals(str))
			result = SolicitudAppointmentStatusEnum.CREATED;
		
		if ("USED".equals(str))
			result = SolicitudAppointmentStatusEnum.USED;

		if ("USEDLATE".equals(str))
			result = SolicitudAppointmentStatusEnum.USEDLATE;

		if ("CANCEL".equals(str))
			result = SolicitudAppointmentStatusEnum.CANCELED;

		if ("CLOSED".equals(str))
			result = SolicitudAppointmentStatusEnum.CLOSED;
		
		return result;
	}

	private Map<Integer,SolicitudAppointment> getActiveAppointmentsMap(List<SolicitudAppointment> appointments)
	{
		Map<Integer,SolicitudAppointment> map = new HashMap<Integer,SolicitudAppointment>();

		for (SolicitudAppointment eachSolicitudAppointment : appointments)
		{
			map.put(Integer.parseInt(eachSolicitudAppointment.getAppointmentNbr()), eachSolicitudAppointment);
		}

		return map;
	}

	private List<Integer> getActiveAppointmentNbrs(List<SolicitudAppointment> appointments)
	{
		List<Integer> col = new ArrayList<Integer>();

		for (SolicitudAppointment eachSolicitudAppointment : appointments)
		{
			col.add(Integer.parseInt(eachSolicitudAppointment.getAppointmentNbr()));
		}

		return col;
	}

	public NamedParameterJdbcTemplate getJdbcTemplate()
	{
		return jdbcTemplate;
	}

	public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate)
	{
		this.jdbcTemplate = jdbcTemplate;
	}

	public DomainManager getDomainManager()
	{
		return domainManager;
	}

	public void setDomainManager(DomainManager domainManager)
	{
		this.domainManager = domainManager;
	}

	public String getWebServiceExternalUserId()
	{
		return webServiceExternalUserId;
	}

	public void setWebServiceExternalUserId(String webServiceExternalUserId)
	{
		this.webServiceExternalUserId = webServiceExternalUserId;
	}

	public String getWebServiceUsername()
	{
		return webServiceUsername;
	}

	public void setWebServiceUsername(String webServiceUsername)
	{
		this.webServiceUsername = webServiceUsername;
	}
}
