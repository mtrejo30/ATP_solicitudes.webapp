package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.AgenciaAduanal;
import com.objectwave.utils.SimpleEntry;

public interface AgenciaAduanalDao
{
	AgenciaAduanal getWithId(Integer anId) throws Exception;
	List<SimpleEntry> getDistinct(Integer usern4Id, String match, Integer maxResults) throws Exception;
}
