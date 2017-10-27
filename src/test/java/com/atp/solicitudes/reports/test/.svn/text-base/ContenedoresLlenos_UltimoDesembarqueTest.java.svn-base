package com.atp.solicitudes.reports.test;

import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.ContenedoresLlenos_UltimoDesembarque;
import com.atp.solicitudes.test.BaseTest;
import com.objectwave.dao.utils.DaoResult;

public class ContenedoresLlenos_UltimoDesembarqueTest extends BaseTest
{
	@Resource
    private ReportsDomainManager manager;
	
	@Test
	public void testContenedoresLlenos_UltimoDesembarque() 
	{
		List<ContenedoresLlenos_UltimoDesembarque> col = null;
		
		try
		{
			DaoResult<ContenedoresLlenos_UltimoDesembarque> result = manager.getContenedoresLlenos_UltimoDesembarque(BaseTest.VERIFICADOR_DESEMBARQUE);
			col = result.getCollection();
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
				
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);
	}
	
}
