package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.UserN4Dao;
import com.atp.solicitudes.model.UserN4;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class UserN4DaoMyBatis extends MyBatisDaoTemplate implements UserN4Dao
{
	public UserN4DaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public UserN4 getWithGkey(Integer aValue) throws Exception
	{
		return (UserN4) selectOne("mybatis.UserN4Mapper.selectByGkey", aValue);
	}

	public UserN4 getWithId(String aValue) throws Exception
	{
		return (UserN4) selectOne("mybatis.UserN4Mapper.selectById", aValue);
	}
	
	public UserN4 getWithName(String aValue) throws Exception
	{
		return (UserN4) selectOne("mybatis.UserN4Mapper.selectByName", aValue);
	}
	
	public UserN4 getWithCustId(String aValue) throws Exception
	{
		return (UserN4) selectOne("mybatis.UserN4Mapper.selectByCustId", aValue);
	}
	
	public DaoResult<UserN4> query(DaoQuery query, DaoOrder order) throws Exception
	{
		DaoResult<UserN4> result = new DaoResult<UserN4>();
		result.setCursorPropertiesFrom(query);

		Map<String, Object> map = new HashMap<String, Object>();

		String[] likes = { "id" };
		registerFullLikePaths(likes, query, map);

		String[] equals = { "gkey" };
		registerEqPaths(equals, query, map);

		if (query.getRequestTotalRows())
		{
			Long totalRows = selectOne("mybatis.UserN4Mapper.selectCount", map);
			result.setTotalRows(new Long(totalRows));
		}

		registerMultipleOrder(order, map);

		List<UserN4> col = this.<UserN4> selectList("mybatis.UserN4Mapper.select", map, getRowBoundsFrom(query));
		result.setCollection(col);

		return result;
	}

	public List<SimpleEntry> getUserN4Distinct(String match, int maxResults) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("columnName", "ID");
		map.put("columnValue", match);

		RowBounds rowBounds = new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.UserN4Mapper.selectUserN4_distinct", map, rowBounds);

		return col;
	}
	
}
