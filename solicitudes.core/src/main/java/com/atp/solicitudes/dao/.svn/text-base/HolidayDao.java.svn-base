package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.Holiday;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;

public interface HolidayDao
{
	void save(Holiday holiday) throws Exception;
	void delete(Holiday holiday) throws Exception;
	
	Holiday getWithId(Integer id) throws Exception;
	Holiday getWithName(String name) throws Exception;
	
	List<Holiday> getAll() throws Exception;
	DaoResult<Holiday> query(DaoQuery query, DaoOrder order) throws Exception;
	
}
