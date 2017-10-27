package com.atp.solicitudes.dao;

import com.atp.solicitudes.model.BookingItem;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;

public interface BookingItemDao
{
	BookingItem getWithId(Integer aValue) throws Exception;
	public BookingItem getWithBookingGkey(Integer aValue, String type) throws Exception;
	public DaoResult<BookingItem> getWithIdForType(DaoQuery query, DaoOrder order) throws Exception;
	public BookingItem getWithNombre(String aValue) throws Exception;
	DaoResult<BookingItem> queryBookingItem(DaoQuery query, DaoOrder order) throws Exception;
}
