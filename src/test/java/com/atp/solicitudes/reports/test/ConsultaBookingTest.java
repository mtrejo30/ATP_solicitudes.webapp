package com.atp.solicitudes.reports.test;

import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.ConsultaBooking;
import com.atp.solicitudes.test.BaseTest;
import com.objectwave.dao.utils.DaoResult;

public class ConsultaBookingTest extends BaseTest
{	
	@Resource
	private ReportsDomainManager manager;
	
	@Test
	public void testConsultaBooking()  
	{		
		List<ConsultaBooking> col = null;
		
		try
		{
			DaoResult<ConsultaBooking> daoResult = manager.getConsultaBooking(BaseTest.VERIFICADOR_CONSULTA_BOOKING);
			col = daoResult.getCollection();
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
		
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);		
	}
	
}
