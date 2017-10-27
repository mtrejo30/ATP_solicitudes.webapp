package com.atp.solicitudes.reports.test;

import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.ArrivalTimeLlegadaAlCentroRegulador;
import com.atp.solicitudes.test.BaseTest;
import com.objectwave.dao.utils.DaoResult;

public class ArrivalTimeLlegadaAlCentroReguladorTest extends BaseTest
{
	@Resource
	private ReportsDomainManager manager;
		
	@Test
	public void testConsultaBL()  
	{		
		List<ArrivalTimeLlegadaAlCentroRegulador> col = null;
		
		try
		{
			DaoResult<ArrivalTimeLlegadaAlCentroRegulador> daoResult = manager.getArrivalTimeLlegadaAlCentroRegulador(BaseTest.PASE_DE_VISITA);
			col = daoResult.getCollection();								
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
		
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);		
	}
}
