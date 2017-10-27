package com.atp.solicitudes.reports.test;

import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.ContenedoresLlenos_RecepcionPorPuerta;
import com.atp.solicitudes.test.BaseTest;
import com.objectwave.dao.utils.DaoResult;

public class ContenedoresLlenos_RecepcionPorPuertaTest extends BaseTest
{	
	@Resource
	private ReportsDomainManager manager;
	
	@Test
	public void testContenedoresLlenos_RecepcionPorPuerta()  
	{		
		List<ContenedoresLlenos_RecepcionPorPuerta> col = null;
		
		try
		{
			DaoResult<ContenedoresLlenos_RecepcionPorPuerta> daoResult = manager.getContenedoresLlenos_RecepcionPorPuerta(BaseTest.VERIFICADOR_RECEPCION_POR_PUERTA);
			col = daoResult.getCollection();
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
		
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);		
	}
}
