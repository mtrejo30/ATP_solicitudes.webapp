package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.LineaNavieraDao;  
import com.atp.solicitudes.model.LineaNaviera;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class LineaNavieraDaoMyBatis extends MyBatisDaoTemplate implements LineaNavieraDao
{

	public LineaNavieraDaoMyBatis(SqlSessionFactory sqlSessionFactory) 
	{
		super(sqlSessionFactory);
	}
	
	public LineaNaviera getWithId(Integer aValue) throws Exception
	{
     	return (LineaNaviera) selectOne("mybatis.LineaNavieraMapper.selectById", aValue);
	}
	
	public LineaNaviera getWithNombre(String aValue) throws Exception
	{
		return (LineaNaviera) selectOne("mybatis.LineaNavieraMapper.selectByNombre", aValue);
	}
	
	public DaoResult<LineaNaviera> query(DaoQuery query, DaoOrder order) throws Exception
	{
		DaoResult<LineaNaviera> result = new DaoResult<LineaNaviera>();
		result.setCursorPropertiesFrom(query);

		Map<String,Object> map = new HashMap<String,Object>();

		String[] likes = {"nombre"};
		registerFullLikePaths(likes, query, map);

		String[] equals = {"id"};
		registerEqPaths(equals, query, map);

		if (query.getRequestTotalRows())
		{
			Long totalRows = selectOne("mybatis.LineaNavieraMapper.selectCount", map);
			result.setTotalRows(new Long(totalRows));
		}

		registerOrder(order, map);

		List<LineaNaviera> col = this.<LineaNaviera> selectList("mybatis.LineaNavieraMapper.select", map, getRowBoundsFrom(query));
		result.setCollection(col);

		return result;
	 
	}
	
	public List<SimpleEntry> getDistinct(String match, Integer maxResults) throws Exception
	{
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("columnName", "ID");
		map.put("columnValue", match);

		RowBounds rowBounds = maxResults == null ? new RowBounds() : new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.LineaNavieraMapper.selectDistinct", map, rowBounds);

		return col;
	}
	
}
