package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.UserTransportistas;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;

public interface UserTransportistasDao {
	UserTransportistas getWithId(Integer id) throws Exception;
	UserTransportistas getUserTransportistasWithIdN4Transport(Integer id,Integer userN4,Integer idTrans) throws Exception;
	DaoResult<UserTransportistas> query(DaoQuery query, DaoOrder order) throws Exception;
	void save(UserTransportistas userTransportistas) throws Exception;
	void update(UserTransportistas userTransportistas) throws Exception;
	void delete(UserTransportistas userTransportistas) throws Exception;
	List<UserTransportistas> getUserTransportistasbyUserN4(Integer UserN4) throws Exception;
}
