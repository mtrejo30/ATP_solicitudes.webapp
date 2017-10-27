package com.atp.solicitudes.reports.test;

import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.ContenedoresLlenos_UltimoEmbarque;
import com.atp.solicitudes.test.BaseTest;
import com.objectwave.dao.utils.DaoResult;

public class ContenedoresLlenos_UltimoEmbarqueTest extends BaseTest
{	
	@Resource
	private ReportsDomainManager manager;
	
	@Test
	public void testContenedoresLlenos_UltimoEmbarque()  
	{		
		List<ContenedoresLlenos_UltimoEmbarque> col = null;
		
		try
		{
			DaoResult<ContenedoresLlenos_UltimoEmbarque> daoResult = manager.getContenedoresLlenos_UltimoEmbarque(BaseTest.VERIFICADOR_EMBARQUE);
			col = daoResult.getCollection();
		}
		catch (Exception e)
		{
			Assert.fail(e.getMessage());
		}
		
		Assert.assertTrue("\n" + getClass().getName() + "\n***** Empty collection *****\n", col.size() != 0);		
	}

}
