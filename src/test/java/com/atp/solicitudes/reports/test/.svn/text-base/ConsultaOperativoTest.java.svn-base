package com.atp.solicitudes.reports.test;

import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.BuqueViaje;
import com.atp.solicitudes.reports.model.ConsultaOperativo;
import com.atp.solicitudes.test.BaseTest;
import com.objectwave.dao.utils.DaoResult;

public class ConsultaOperativoTest extends BaseTest
{	
	@Resource
	private ReportsDomainManager manager;
	
	@Test
	public void testConsultaOperativoImportacion() 
	{		
		List<ConsultaOperativo> col = null;
		
		try
		{
			DaoResult<ConsultaOperativo> daoResult = manager.getConsultaOperativoImportacion(BaseTest.VERIFICADOR_OPERATIVO_IMPORTACION);
			col = daoResult.getCollection();
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
		
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);		
	}
	
	@Test
	public void testConsultaOperativoExportacion() 
	{		
		List<ConsultaOperativo> col = null;
		
		try
		{
			DaoResult<ConsultaOperativo> daoResult = manager.getConsultaOperativoExportacion();
			col = daoResult.getCollection();
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
		
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);		
	}
	
	@Test
	public void testBuqueViajeForConsultaOperativa()
	{
		List<BuqueViaje> col = null;
		
		try
		{
			DaoResult<BuqueViaje> daoResult = manager.getBuqueViajeForConsultaOperativo();
			col = daoResult.getCollection();
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
		
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);
	}
}
