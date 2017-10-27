package com.atp.solicitudes.dao;

import java.util.List;
  

import com.atp.solicitudes.model.Transportista;
import com.objectwave.utils.SimpleEntry;

public interface TransportistaDao
{
	Transportista getWithId(Integer aValue) throws Exception;
	public Transportista getWithNombre(String aValue) throws Exception;
    List<SimpleEntry> getTransportistaDistinct(String match, int maxResults) throws Exception;
}
