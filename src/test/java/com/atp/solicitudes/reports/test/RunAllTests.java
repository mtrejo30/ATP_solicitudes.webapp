package com.atp.solicitudes.reports.test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import com.atp.solicitudes.test.BaseTest;

@RunWith(Suite.class)
@SuiteClasses({
	ConsultaBLTest.class,
	ConsultaBookingTest.class,
	ConsultaOperativoTest.class,
	ContenedoresLlenos_EntregaPorPuertaTest.class,
	ContenedoresLlenos_RecepcionPorPuertaTest.class,
	ContenedoresLlenos_UltimoDesembarqueTest.class,
	ContenedoresLlenos_UltimoEmbarqueTest.class
			  })
public class RunAllTests extends BaseTest 
{
	
}
