package com.atp.solicitudes.dao.mybatis;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.StoredProceduresDao;
import com.objectwave.dao.utils.MyBatisDaoTemplate;

public class StoredProceduresDaoMyBatis  extends MyBatisDaoTemplate implements StoredProceduresDao
{

	public StoredProceduresDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public void getCancellation(String v_cita, String v_note) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("V_CITA", v_cita);
		map.put("V_NOTE", v_note);

		update("mybatis.StoredProceduresMapper.cancelProcedure",  map);

	}
	
	public void setInfoAgentClientReference(String appNbr, Integer agent, Integer shipper, String reference) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("APP_NBR", appNbr);
		map.put("AGENT_GKEY", agent);
		map.put("SHIPPER_GKEY", shipper);
		map.put("REFERENCE", reference);
		
		update("mybatis.StoredProceduresMapper.setAgentClientReference",  map);
	}
	
	public void setInfoAgentClientRef(String appNbr, Integer agent, Integer shipper) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("APP_NBR", appNbr);
		map.put("AGENT_GKEY", agent);
		map.put("SHIPPER_GKEY", shipper);
		
		update("mybatis.StoredProceduresMapper.setAgentClientRef",  map);
	}
	
	public void setBookingItemGkey(Integer bookingItemGkey, String appNbr) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("BOOKING_ITEM_GKEY", bookingItemGkey);
		map.put("APP_NBR", appNbr);
		
		update("mybatis.StoredProceduresMapper.setBookingItemGkey",  map);
	}
	
}
