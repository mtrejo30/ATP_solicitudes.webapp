package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.TransportistaDao;
import com.atp.solicitudes.model.Transportista;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class TransportistaDaoMyBatis extends MyBatisDaoTemplate implements TransportistaDao
{
	public TransportistaDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public Transportista getWithId(Integer aValue) throws Exception
	{
		return (Transportista) selectOne("mybatis.TransportistaMapper.selectById", aValue);

	}

	public Transportista getWithNombre(String aValue) throws Exception
	{
		return (Transportista) selectOne("mybatis.TransportistaMapper.selectByNombre", aValue);
	}

	public List<SimpleEntry> getTransportistaDistinct(String match, int maxResults) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("columnName", "ID");
		map.put("columnValue", match);

		RowBounds rowBounds = new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.TransportistaMapper.selectTransportista_distinct", map, rowBounds);

		return col;
	}

}
