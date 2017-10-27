package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;
 


import com.atp.solicitudes.dao.BLDao;
import com.atp.solicitudes.model.BL;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class BLDaoMyBatis extends MyBatisDaoTemplate implements BLDao
{

	public BLDaoMyBatis(SqlSessionFactory sqlSessionFactory) 
	{
		super(sqlSessionFactory);
	}
	
	public BL getWithId(Integer aValue) throws Exception
	{
//		return (BL) selectOne("mybatis.BLMapper.selectById", aValue);
		return null;
	}
	
	public DaoResult<BL> query(DaoQuery query, DaoOrder order) throws Exception
	{
//		DaoResult<BL> result = new DaoResult<BL>();
//		result.setCursorPropertiesFrom(query);
//
//		Map<String,Object> map = new HashMap<String,Object>();
//
//		String[] likes = {"name"};
//		registerFullLikePaths(likes, query, map);
//
//		String[] equals = {"id"};
//		registerEqPaths(equals, query, map);
//
//		if (query.getRequestTotalRows())
//		{
//			Long totalRows = selectOne("mybatis.BLMapper.selectCount", map);
//			result.setTotalRows(new Long(totalRows));
//		}
//
//		registerOrder(order, map);
//
//		List<BL> col = this.<BL> selectList("mybatis.BLMapper.select", map, getRowBoundsFrom(query));
//		result.setCollection(col);
//
//		return result;
		return null;
	}
	
	public List<SimpleEntry> getColumnPropertyValues(String column, String match, int maxResults) throws Exception
	{
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("columnName", column);
		map.put("columnValue", match);

		RowBounds rowBounds = new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.BLMapper.selectColumnValue", map, rowBounds);

		return col;
	}

}
