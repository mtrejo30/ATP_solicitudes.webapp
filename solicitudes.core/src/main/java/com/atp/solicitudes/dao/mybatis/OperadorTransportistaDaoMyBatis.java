package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.OperadorTransportistaDao;
import com.atp.solicitudes.model.OperadorTransportista;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.MyBatisDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class OperadorTransportistaDaoMyBatis extends MyBatisDaoTemplate implements OperadorTransportistaDao
{
	public OperadorTransportistaDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public OperadorTransportista getWithGkey(Integer aValue) throws Exception
	{
		return (OperadorTransportista) selectOne("mybatis.OperadorTransportistaMapper.selectById", aValue);
	}

	public OperadorTransportista getWithCardId(String aValue) throws Exception
	{
		return (OperadorTransportista) selectOne("mybatis.OperadorTransportistaMapper.selectByCardId", aValue);
	}

	public DaoResult<OperadorTransportista> query(DaoQuery query, DaoOrder order) throws Exception
	{
		DaoResult<OperadorTransportista> result = new DaoResult<OperadorTransportista>();
		result.setCursorPropertiesFrom(query);

		Map<String, Object> map = new HashMap<String, Object>();

		String[] likes = { "cardId" };
		registerFullLikePaths(likes, query, map);

		String[] equals = { "gKey" };
		registerEqPaths(equals, query, map);

		if (query.getRequestTotalRows())
		{
			Long totalRows = selectOne("mybatis.OperadorTransportistaMapper.selectCount", map);
			result.setTotalRows(new Long(totalRows));
		}

		registerOrder(order, map);

		List<OperadorTransportista> col = this.<OperadorTransportista> selectList("mybatis.OperadorTransportistaMapper.select",
				map, getRowBoundsFrom(query));
		result.setCollection(col);

		return result;
	}

	public List<SimpleEntry> getOperadorTransportistaDistinct(String match, int maxResults) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();

		map.put("columnName", "NAME");
		map.put("columnValue", match);

		RowBounds rowBounds = new RowBounds(0, maxResults);

		List<SimpleEntry> col = selectList("mybatis.OperadorTransportistaMapper.selectOperadorTransportista_distinct", map,
				rowBounds);

		return col;
	}

}
