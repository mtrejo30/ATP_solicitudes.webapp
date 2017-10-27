package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.AgenciaAduanalDao;
import com.atp.solicitudes.model.AgenciaAduanal;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class AgenciaAduanalDaoMyBatis extends MyBatisDaoTemplate implements AgenciaAduanalDao
{

	public AgenciaAduanalDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public AgenciaAduanal getWithId(Integer aValue) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("GKEY", aValue);
		
		List<AgenciaAduanal> list = selectList("mybatis.AgenciaAduanalMapper.selectById", map);
		
		if (list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	public List<SimpleEntry> getDistinct(Integer usern4Id, String match, Integer maxResults) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("columnValue", match);
		map.put("userN4Id", usern4Id);

		RowBounds rowBounds = maxResults == null ? new RowBounds() : new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.AgenciaAduanalMapper.selectDistinct", map, rowBounds);

		return col;
	}
}
