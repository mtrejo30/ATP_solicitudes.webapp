package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.BL;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.SimpleEntry;

public interface BLDao
{
	BL getWithId(Integer aValue) throws Exception;
	DaoResult<BL> query(DaoQuery query, DaoOrder order) throws Exception;
	List<SimpleEntry> getColumnPropertyValues(String column, String match, int maxResults) throws Exception;
}
