package com.atp.solicitudes.test;

import junit.framework.TestCase;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/*
 * Base class for all UnitTestings
 * some good tutorials and references
 * http://www.vogella.com/tutorials/JUnit/article.html
 * http://www.springbyexample.org/examples/intro-to-ioc-unit-test-beans-from-application-context.html
 * 
 */
/*
 * This is the base test class used for all unit testings
 * This defines the Spring configuration files to be used, matching the
 * beans defined on the development environment
 */
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/config/datasource-jdbc.xml",
	"file:src/main/webapp/WEB-INF/config/applicationContext.xml",
	"file:src/main/webapp/WEB-INF/config/applicationContext-custom.xml",
		})

@RunWith(SpringJUnit4ClassRunner.class)
public abstract class BaseTest extends TestCase
{	
	public static final String VERIFICADOR_DESEMBARQUE  		 = "TCNU8916778";		// TCNU8916778 o TCNU7945452)
	public static final String VERIFICADOR_EMBARQUE     		 = "SUDU8899782";
	public static final String VERIFICADOR_RECEPCION_POR_PUERTA  = "TRIU1234567"; 		// TRIU1234567 o CRSU1268761
	public static final String VERIFICADOR_ENTREGA_POR_PUERTA 	 = "TCNU8916778";		// TCNU8916778 o TCNU7945452
	public static final String VERIFICADOR_OPERATIVO_IMPORTACION = "MST1234";   		//  MST1234 (MSC Socotra viaje 1234)
	public static final String VERIFICADOR_OPERATIVO_EXPORTACION = "SUDU7824623";
	public static final String VERIFICADOR_CONSULTA_BOOKING      = "192ORI1236M88359";	
	
	public static final String PASE_DE_VISITA = "470710";
	public static final String BL = "SUDU720013764021";
	
	@Autowired
	protected ApplicationContext applicationContext;

	protected Object getBean(String beanName)
	{
		return getApplicationContext().getBean(beanName);
	}

	/*
	 * getters and setters
	 */
	public ApplicationContext getApplicationContext()
	{
		return applicationContext;
	}

	public void setApplicationContext(ApplicationContext applicationContext)
	{
		this.applicationContext = applicationContext;
	}
}