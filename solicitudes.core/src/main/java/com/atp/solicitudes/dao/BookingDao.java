package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.Booking;
import com.objectwave.utils.SimpleEntry;

public interface BookingDao
{
	Booking getWithId(Integer aValue) throws Exception;
	Booking getWithNombre(String aValue) throws Exception;
    List<SimpleEntry> getDistinct(String match, int maxResults) throws Exception;
    List<Booking> getEqualsByName(String name, int maxResults) throws Exception;
}
