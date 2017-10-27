package com.atp.solicitudes.webservice;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.test.BaseTest;
import com.objectwave.exception.DomainModelException;

public class DomainManagerN4Test extends BaseTest
{
	protected static Logger logger = LoggerFactory.getLogger(DomainManagerN4Test.class);

	@Resource(name=DomainManagerN4.BEAN_NAME)
	DomainManagerN4 manager;

	@Test
	public void getHoursForDatesTest()
	{
		try
		{
			Calendar calendar = Calendar.getInstance();
			
			calendar.add(Calendar.DAY_OF_YEAR, 1);

			List<Date> dates = manager.getTimeSlotsForDate(calendar.getTime());
			
			for (Date eachDate : dates)
				logger.info("Date {}", eachDate);
		}
		catch (Exception ex)
		{
			logger.error("error while running test", ex);
		}
	}
	
	@Test
	public void cancelAppointmentTest()
	{
		try
		{
			String appointmentNbr = "478744";
			manager.cancelAppointmentWithNumber(appointmentNbr);
			logger.info("appointment cancelled {}", appointmentNbr);
		}
		catch (DomainModelException dme)
		{
			String msg = "expected appointment not able to be cancelled - " + dme.getMessage();
			logger.info(msg);
			assertTrue(msg, true);
		}
		catch (Exception ex)
		{
			String msg = "error while running test";
			logger.error(msg, ex);
			fail(msg);
		}
	}

	@Test
	public void createAppointmentTest()
	{
		try
		{
			Map<String,Object> map = new HashMap<String,Object>();

			Calendar calendar = Calendar.getInstance();
			
			calendar.add(Calendar.DAY_OF_YEAR, 1);

			List<Date> dates = manager.getTimeSlotsForDate(calendar.getTime());

			Date selDate = dates.get(dates.size() - 1);

			map.put("date", selDate);
			
			map.put("gateId", "ATP");
			map.put("tranType", "DI");
			map.put("driver_cardId", "123456");
			map.put("truck_licenseNbr", "123");
			map.put("truck_coId", "3G");

			map.put("container_eqid", "DFSU2244761");
			
//			GateAppointmentResponseType resp = manager.createAppointment(map);
//			
//			String appointmentNbr = resp.getAppointmentNbr();
//			
//			manager.cancelAppointmentWithNumber(appointmentNbr);
//		}
//		catch (DomainModelException dme)
//		{
//			logger.error("expected appointment not able to be cancelled", dme);
		}
		catch (Exception ex)
		{
			logger.error("error while running test", ex);
		}
	}
}
