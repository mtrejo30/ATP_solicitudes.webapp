package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.ClienteDao;
import com.atp.solicitudes.model.Cliente;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class ClienteDaoMyBatis extends MyBatisDaoTemplate implements ClienteDao
{

	public ClienteDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public Cliente getWithId(Integer aValue) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("GKEY", aValue);

		List<Cliente> list = selectList("mybatis.ClienteMapper.selectById", map);
		
		if (list.size() == 0)
			return null;
		else
			return list.get(0);
	}
 
	public List<SimpleEntry> getClienteDistinct(Integer usern4Id, String match, Integer maxResults) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("columnValue", match);
		map.put("userN4Id", usern4Id);
		
		RowBounds rowBounds = maxResults == null ? new RowBounds() : new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.ClienteMapper.selectDistinct", map, rowBounds);

		return col;
	}
}
