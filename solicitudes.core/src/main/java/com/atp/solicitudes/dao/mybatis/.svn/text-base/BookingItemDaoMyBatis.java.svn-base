package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.BookingItemDao;
import com.atp.solicitudes.model.BookingItem;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.MyBatisDaoTemplate;

public class BookingItemDaoMyBatis extends MyBatisDaoTemplate implements BookingItemDao
{
	static final String MYBATIS_NAMESPACE = "mybatis.BookingItemMapper";

	public BookingItemDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public BookingItem getWithId(Integer aValue) throws Exception
	{
		return (BookingItem) selectOne(MYBATIS_NAMESPACE + ".selectById", aValue);
	}
	
	public BookingItem getWithBookingGkey(Integer aValue, String type) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("BOOKING_GKEY", aValue);
		map.put("TYPE_ISO", type);
		
		return (BookingItem) selectOne(MYBATIS_NAMESPACE + ".selectByBookingGkey", map);
	}
	
	public BookingItem getWithNombre(String aValue) throws Exception
	{
		return (BookingItem) selectOne(MYBATIS_NAMESPACE + ".selectByNombre", aValue);
	}

	public DaoResult<BookingItem> queryBookingItem(DaoQuery query, DaoOrder order) throws Exception
	{
		DaoResult<BookingItem> result = new DaoResult<BookingItem>();
		result.setCursorPropertiesFrom(query);

		Map<String, Object> map = new HashMap<String, Object>();

		String[] equals = { "bookingGKey", "id" };
		registerEqPaths(equals, query, map);

		if (query.getRequestTotalRows())
		{
			Long totalRows = selectOne(MYBATIS_NAMESPACE + ".selectCount", map);
			result.setTotalRows(new Long(totalRows));
		}

		registerMultipleOrder(order, map);

		List<BookingItem> col = this.<BookingItem> selectList(MYBATIS_NAMESPACE + ".select", map, getRowBoundsFrom(query));
		result.setCollection(col);

		return result;
	}
	
	public DaoResult<BookingItem> getWithIdForType(DaoQuery query, DaoOrder order) throws Exception
	{
		DaoResult<BookingItem> result = new DaoResult<BookingItem>();
		result.setCursorPropertiesFrom(query);

		Map<String, Object> map = new HashMap<String, Object>();

		String[] equals = { "bookingGKey", "id" };
		registerEqPaths(equals, query, map);

		if (query.getRequestTotalRows())
		{
			Long totalRows = selectOne(MYBATIS_NAMESPACE + ".selectCount", map);
			result.setTotalRows(new Long(totalRows));
		}

		registerMultipleOrder(order, map);

		List<BookingItem> col = this.<BookingItem> selectList(MYBATIS_NAMESPACE + ".selectType", map, getRowBoundsFrom(query));
		result.setCollection(col);

		return result;
	}
}
