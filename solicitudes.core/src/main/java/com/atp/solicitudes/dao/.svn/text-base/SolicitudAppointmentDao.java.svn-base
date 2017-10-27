package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.SolicitudAppointment;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;

public interface SolicitudAppointmentDao
{
	SolicitudAppointment getWithId(Integer id) throws Exception;
	SolicitudAppointment getWithAppNbr(String app_nbr) throws Exception;
	List<SolicitudAppointment> getWithSolicitud (Solicitud solicitud) throws Exception;
	void save(SolicitudAppointment solicitud) throws Exception;
	DaoResult<SolicitudAppointment> query(DaoQuery query, DaoOrder order) throws Exception;
	List<String> getColumnValues(String column, String match, int maxResults) throws Exception;
	SolicitudAppointment getSolicitudIdd(String column, String match) throws Exception;
	Integer getSolicitudId(String app_nbr) throws Exception;
}
