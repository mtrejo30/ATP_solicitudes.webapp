package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.TipoRecepcionVacioDao;
import com.atp.solicitudes.model.TipoRecepcionVacio;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class TipoRecepcionVacioDaoMyBatis extends MyBatisDaoTemplate implements TipoRecepcionVacioDao
{
	static final String MYBATIS_NAMESPACE = "mybatis.TipoRecepcionVacioMapper";

	public TipoRecepcionVacioDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public TipoRecepcionVacio getWithId(Integer aValue) throws Exception
	{
		return (TipoRecepcionVacio) selectOne(MYBATIS_NAMESPACE + ".selectById", aValue);
	}
	
	public TipoRecepcionVacio getWithNombre(String aValue) throws Exception
	{
		return (TipoRecepcionVacio) selectOne(MYBATIS_NAMESPACE + ".selectByNombre", aValue);
	}

	public List<SimpleEntry> getDistinct(String match, Integer maxResults) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("columnName", "TYPE_ISO");
		map.put("columnValue", match);

		RowBounds rowBounds = maxResults == null ? new RowBounds() : new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList(MYBATIS_NAMESPACE + ".selectDistinct", map, rowBounds);

		return col;
	}
}
