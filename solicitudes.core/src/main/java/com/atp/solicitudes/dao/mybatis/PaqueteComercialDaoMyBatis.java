package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.PaqueteComercialDao;
import com.atp.solicitudes.model.PaqueteComercial;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class PaqueteComercialDaoMyBatis extends MyBatisDaoTemplate implements PaqueteComercialDao
{

	public PaqueteComercialDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public PaqueteComercial getWithId(Integer idPaquete) throws Exception
	{
		return (PaqueteComercial) selectOne("mybatis.PaqueteComercialMapper.selectById",idPaquete);
	}

	public List<SimpleEntry> getPaqueteComercial(String custid, String match, Integer maxResults) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("CLAVE_PAQUETE", match);
		map.put("ID_CLIENTE", custid);

		RowBounds rowBounds = new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.PaqueteComercialMapper.selectPaqueteComercial", map, rowBounds);

		return col;
	}
}
