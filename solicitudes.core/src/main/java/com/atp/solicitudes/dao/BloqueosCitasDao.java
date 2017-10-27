package com.atp.solicitudes.dao;

import java.util.ArrayList;
import java.util.List;

import com.atp.solicitudes.model.Bloqueos;
import com.atp.solicitudes.model.Holiday;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserTransportistas;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.utils.SimpleEntry;

public interface BloqueosCitasDao {
	Bloqueos getWithId(Integer id) throws Exception;
	List<Bloqueos> query() throws Exception;
	void save(Bloqueos id) throws Exception;
	void update(Bloqueos id) throws Exception;
	void delete(Bloqueos id) throws Exception;
	ArrayList<Bloqueos> getBloqueosStatus(String strtipos) throws Exception;
	ArrayList<Bloqueos> getBloqueosStatushabilitar(String strtipos,String s,String w) throws Exception;
}
