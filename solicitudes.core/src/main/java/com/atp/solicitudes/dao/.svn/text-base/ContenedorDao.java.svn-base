package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.Contenedor;
import com.objectwave.utils.SimpleEntry;

public interface ContenedorDao
{
	Contenedor getWithId(Integer aValue) throws Exception;

    List<SimpleEntry> getImpoDistinct(String match, String consigne, Integer maxResults) throws Exception;
    List<SimpleEntry> getDesistimientoDistinct(String match, String consigne, Integer maxResults) throws Exception;

    List<SimpleEntry> getHistorialDistinct(String match, Integer maxResults) throws Exception;
	Contenedor getRecentWithUnitNbr(String aValue) throws Exception;
	Integer getCountUnitNbr(String aValue) throws Exception;
}
