package com.atp.solicitudes.dao;

import com.atp.solicitudes.model.SolicitudContenedor;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;

/**
 * Interface for DAO operations on SolicitudContenedor object 
 */

public interface SolicitudContenedorDao {
	SolicitudContenedor getWithId(Integer id) throws Exception;
	DaoResult<SolicitudContenedor> query(DaoQuery query, DaoOrder order) throws Exception;
	void save(SolicitudContenedor comentario) throws Exception;
	void update(SolicitudContenedor comentario) throws Exception;
	void delete(SolicitudContenedor comentario) throws Exception;
	
}
