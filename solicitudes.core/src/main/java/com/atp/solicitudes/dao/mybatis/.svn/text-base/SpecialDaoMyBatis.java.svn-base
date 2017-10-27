package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.SpecialDao;
import com.atp.solicitudes.model.Special;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.MyBatisDaoTemplate;

public class SpecialDaoMyBatis extends MyBatisDaoTemplate implements SpecialDao
{
	static final String MYBATIS_NAMESPACE = "mybatis.SpecialMapper";

	public SpecialDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public Special getWithId(String aValue) throws Exception
	{
		return (Special) selectOne(MYBATIS_NAMESPACE + ".selectById", aValue);
	}

	public List<Special> query(DaoQuery query, DaoOrder order) throws Exception
	{
		RowBounds rowBounds = new RowBounds();

		Map<String, Object> map = new HashMap<String, Object>();

		String[] equals = {"companyLike", "moveWithAll"};
		registerEqPaths(equals, query, map);

		registerOrder(order, map);

		List<Special> col = selectList(MYBATIS_NAMESPACE + ".selectQuery", map, rowBounds);

		return col;
	}

	public List<Special> getAll() throws Exception
	{
		RowBounds rowBounds = new RowBounds();

		List<Special> col = selectList(MYBATIS_NAMESPACE + ".selectAll", rowBounds);

		return col;
	}
}