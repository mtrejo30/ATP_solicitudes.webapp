package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.DocumentoSolicitud;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.model.GenericBlob;
import com.objectwave.utils.SimpleEntry;

public interface DocumentoSolicitudDao
{
	DocumentoSolicitud getWithId(Integer aValue) throws Exception;
	
	List<String> getDocumentsWithId(Integer aValue) throws Exception;
	
	void save(DocumentoSolicitud object) throws Exception;
	DaoResult<DocumentoSolicitud> query(DaoQuery query, DaoOrder order) throws Exception;

	GenericBlob getBlob(DocumentoSolicitud doc) throws Exception;
	
	DocumentoSolicitud getWithUserId(User user) throws Exception;
	DocumentoSolicitud getWithSolicitudId(Solicitud solicitud) throws Exception;
}
