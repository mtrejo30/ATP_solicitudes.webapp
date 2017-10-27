package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.ContenedorDao;
import com.atp.solicitudes.model.Contenedor;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class ContenedorDaoMyBatis extends MyBatisDaoTemplate implements ContenedorDao
{
	static final String MYBATIS_NAMESPACE = "mybatis.ContenedorMapper";
	
	public static final String CONSIGNE_IGNORE = "ATP";

	public ContenedorDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public Contenedor getWithId(Integer aValue) throws Exception
	{
		return (Contenedor) selectOne(MYBATIS_NAMESPACE + ".selectById", aValue);
	}
	
	public Integer getCountUnitNbr(String aValue) throws Exception
	{
		return (Integer) selectOne(MYBATIS_NAMESPACE + ".selectCountUnitNbr", aValue);
	}

	public List<SimpleEntry> getImpoDistinct(String match, String consigne, Integer maxResults) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("columnName", "UNIT_NBR");
		if (!CONSIGNE_IGNORE.equals(consigne))
			map.put("consigne", consigne);
		map.put("columnValue", match);

		RowBounds rowBounds = maxResults == null ? new RowBounds() : new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList(MYBATIS_NAMESPACE + ".selectImpo_distinct", map, rowBounds);

		return col;
	}

	public List<SimpleEntry> getDesistimientoDistinct(String match, String consigne, Integer maxResults) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("columnName", "UNIT_NBR");
		if (!CONSIGNE_IGNORE.equals(consigne))
			map.put("consigne", consigne);
		map.put("columnValue", match);

		RowBounds rowBounds = maxResults == null ? new RowBounds() : new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList(MYBATIS_NAMESPACE + ".selectDesistimiento_distinct", map, rowBounds);

		return col;
	}
	
	public List<SimpleEntry> getHistorialDistinct(String match, Integer maxResults) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("UNIT_NBR", match);

		RowBounds rowBounds = maxResults == null ? new RowBounds() : new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList(MYBATIS_NAMESPACE + ".selectHistorial_distinct", map, rowBounds);

		return col;
	}

	public Contenedor getRecentWithUnitNbr(String unitNbr) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("UNIT_NBR", unitNbr);

		RowBounds rowBounds = new RowBounds(0, 1);

		List<Contenedor> col = selectList(MYBATIS_NAMESPACE + ".select_recentFromUnitNbr", map, rowBounds);

		if (col.size() > 0)
			return col.get(0);
		else
			return null;
	}
	
	public DaoResult<Contenedor> query(DaoQuery query, DaoOrder order) throws Exception
	{
		DaoResult<Contenedor> result = new DaoResult<Contenedor>();
		result.setCursorPropertiesFrom(query);

		Map<String, Object> map = new HashMap<String, Object>();

		String[] likes = { "unit_nbr" };
		registerFullLikePaths(likes, query, map);

		String[] equals = { "unit_gkey" };
		registerEqPaths(equals, query, map);

		if (query.getRequestTotalRows())
		{
			Long totalRows = selectOne(MYBATIS_NAMESPACE + ".selectCount", map);
			result.setTotalRows(new Long(totalRows));
		}

		registerOrder(order, map);

		List<Contenedor> col = this.<Contenedor> selectList(MYBATIS_NAMESPACE + ".select", map, getRowBoundsFrom(query));
		result.setCollection(col);

		return result;
	}
	
	
}
