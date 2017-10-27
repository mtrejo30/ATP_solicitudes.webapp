package com.atp.solicitudes.dao;

import java.util.List;
 

import com.atp.solicitudes.model.OperadorTransportista;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.SimpleEntry;

public interface OperadorTransportistaDao
{
	OperadorTransportista getWithGkey(Integer aValue) throws Exception;
	OperadorTransportista getWithCardId(String aValue) throws Exception;
    List<SimpleEntry> getOperadorTransportistaDistinct(String match, int maxResults) throws Exception; 
	DaoResult<OperadorTransportista> query(DaoQuery query, DaoOrder order) throws Exception;
}
