package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;

public interface UserDao
{
	User getWithId(Integer id) throws Exception;
	User getWithUsername(String username) throws Exception;
	User getWithEmail(String email) throws Exception;
	User getWithUserN4(Integer usern4) throws Exception;
	
	public void save(User object) throws Exception;
	public void delete(User object) throws Exception;
	public List<String> getColumnPropertyValues(String column, String match, int maxResults) throws Exception;
	
	public DaoResult<User> query(DaoQuery query, DaoOrder order) throws Exception;
}
