package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;

public interface SolicitudDao
{
	Solicitud getWithFolio(Integer folio) throws Exception;
	void save(Solicitud solicitud) throws Exception;
	DaoResult<Solicitud> query(DaoQuery query, DaoOrder order) throws Exception;
	User getUserFrom(Solicitud solicitud) throws Exception;
	List<String> getColumnValues(String column, String match, int maxResults) throws Exception;
}
