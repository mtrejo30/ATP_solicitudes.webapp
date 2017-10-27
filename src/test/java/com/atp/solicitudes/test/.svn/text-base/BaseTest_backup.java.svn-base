package com.atp.solicitudes.test;

import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.atp.solicitudes.reports.manager.ReportsDomainManager;

@RunWith(JUnit4.class)
public class BaseTest_backup 
{
	private static ApplicationContext applicationContext = null;
	private static ReportsDomainManager manager = null;
	
	@BeforeClass
	public static void onlyOnce()
	{
		applicationContext = new FileSystemXmlApplicationContext( 
				"file:src/main/webapp/WEB-INF/config/datasource-jdbc.xml",
				"file:src/main/webapp/WEB-INF/config/applicationContext.xml",
				"file:src/main/webapp/WEB-INF/config/applicationContext-custom.xml");
		
		manager = (ReportsDomainManager)applicationContext.getBean("domainManager_reports");
	}
	
	public static ApplicationContext getApplicationContext()
	{
		return applicationContext;
	}
	
	public static ReportsDomainManager getDomainManager()
	{
		return manager;
	}
}
