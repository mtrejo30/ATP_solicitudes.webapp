package com.atp.solicitudes.webservice;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeFactory;

import org.apache.commons.io.IOUtils;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.SolicitudAppointment;
import com.atp.solicitudes.reports.manager.ReportsDomainManager;
import com.atp.solicitudes.reports.model.PaseDeEntradaReport;
import com.atp.solicitudes.utils.jasper.JasperDataSource;
import com.objectwave.utils.StreamUtils;

@Controller
@RequestMapping(value = "/PaseDeEntradaReport")
public class PaseDeEntradaReportWebService extends LocalBaseService
{
	@Resource(name = "domainManager_reports")
	ReportsDomainManager manager;
	@Resource(name=DomainManager.BEAN_NAME)
	DomainManager domainManager;
	private ResourceLoader resourceLoader = new DefaultResourceLoader();
	@RequestMapping(value = "/app_nbr/{gav_appNbr}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Object getPaseDeEntrada(@PathVariable(value = "gav_appNbr") Integer paseDeEntrada)
	{
		PaseDeEntradaReport obj = null;
		try
		{
			obj = manager.getPaseDeEntradaReport(paseDeEntrada);
		}
		catch (Exception ex)
		{
			logger.debug("error while getting PaseDeEntradaReport", ex);
		}

		return obj;
	}
	@RequestMapping(value="/pdf/{APP_NBR}", method = RequestMethod.GET)
	public void pdf(@PathVariable(value = "APP_NBR") Integer nbr, HttpServletResponse response, HttpServletRequest request)
	{
		OutputStream output = null;
		InputStream input = null;
		File pdfFile = null;
		PaseDeEntradaReport obj = null;
		SolicitudAppointment appointment=null;	
		try
		{

			input = resourceLoader.getResource("reports/report_appointment.jasper").getInputStream();
			JasperReport jasReport = (JasperReport) JRLoader.loadObject(input);
			
			input.close();
			appointment=domainManager.getSolicitudAppointmentWithAppNbr(nbr.toString(),null);
			obj = manager.getPaseDeEntradaReport(nbr);
			PaseDeEntradaReport pase = new PaseDeEntradaReport();
			
			pase.setGav_appNbr(obj.getGav_appNbr()); 
			pase.setGav_transTypeName(obj.getGav_transTypeName());
			pase.setGav_state(obj.getGav_state());
			pase.setGav_creator(obj.getGav_creator());
			pase.setGav_startDate(obj.getGav_startDate());
			pase.setGav_endDate(obj.getGav_endDate());
			pase.setGav_lineOp(obj.getGav_lineOp());
			pase.setGav_gateId(obj.getGav_gateId());
			pase.setGav_gateDescription(obj.getGav_gateDescription());
			pase.setGav_truckLicence(obj.getGav_truckLicence());
			pase.setGav_truckingCompany(obj.getGav_truckingCompany());
			pase.setGav_driverName(obj.getGav_driverName());
			pase.setGav_driverLicenseNbr(obj.getGav_driverLicenseNbr());
			pase.setGav_unitNbr(obj.getGav_unitNbr());
			pase.setGav_custidName(obj.getGav_custidName());
			pase.setGav_booking(obj.getGav_booking());
			pase.setGav_bookingTypeIso(obj.getGav_bookingTypeIso());
			pase.setGav_bookingTypeDescription(obj.getGav_bookingTypeDescription());
			pase.setGav_notes(obj.getGav_notes());
			pase.setGav_shipcustid(obj.getGav_shipcustid());
			
			pase.setUv_typeIso(obj.getUv_typeIso());
			pase.setUv_weight(obj.getUv_weight());
			pase.setUv_temporal(obj.getUv_temporal());
			pase.setUv_previoExpress(obj.getUv_previoExpress());
			pase.setUv_special(obj.getUv_special());
			pase.setUv_recintoTit(obj.getUv_recintoTit());
			pase.setUv_typeIsoName(obj.getUv_typeIsoName());
			pase.setUv_hzrdGkey(obj.getUv_hzrdGkey());
			pase.setUv_tempRequired(obj.getUv_tempRequired());
			pase.setUv_ventRequiredPct(obj.getUv_ventRequiredPct());
			pase.setUv_ventUnit(obj.getUv_ventUnit());
			pase.setUv_isDim(obj.getUv_isDim());
			pase.setUv_oogLeft(obj.getUv_oogLeft());
			pase.setUv_oogRight(obj.getUv_oogRight());
			pase.setUv_oogTop(obj.getUv_oogTop());
			pase.setUv_oogBack(obj.getUv_oogBack());
			pase.setUv_oogFront(obj.getUv_oogFront());
			pase.setUv_o2Pct(obj.getUv_o2Pct());
			pase.setUv_co2Pct(obj.getUv_co2Pct());
			pase.setUv_complexPosition(obj.getUv_complexPosition());
			pase.setUv_consigneeId(obj.getUv_consigneeId());
			pase.setUv_category(obj.getUv_category());
			pase.setUv_etiquetaUndg(obj.getUv_etiquetaUndg());
			
			pase.setBv_notes(obj.getBv_notes());
				
			pase.setBiv_remarks(obj.getBiv_remarks());
			pase.setBiv_grade(obj.getBiv_grade());
			
			pase.setRbsv_name(obj.getRbsv_name());
			pase.setRbsv_notes(obj.getRbsv_notes());
			pase.setRbsv_ctName(obj.getRbsv_ctName());			
			pase.setRbsv_addressLine1(obj.getRbsv_addressLine1());
			pase.setRbsv_city(obj.getRbsv_city());
	
			pase.setVvv_vesselVoyage(obj.getVvv_vesselVoyage());
			pase.setVvv_vesselName(obj.getVvv_vesselName());
			pase.setVvv_voyageIn(obj.getVvv_voyageIn());
			pase.setVvv_voyageOut(obj.getVvv_voyageOut());
			
			pase.setUhv_marinePollutants(obj.getUhv_marinePollutants());
			pase.setUhv_hzrdGkey(obj.getUhv_hzrdGkey());
			pase.setUhv_imdgClass(obj.getUhv_imdgClass());
			pase.setUhv_hzrdDescription(obj.getUhv_hzrdDescription());
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("PaseDeEntradaReport", pase);
			
			// Barcode used on the report
			String barsCode=null;
			Barcode barCode = BarcodeFactory.createCodabar(pase.getGav_appNbr().toString());
			barsCode=barCode.toString();
			map.put("BarCode", barsCode);

			// Status used on the report
			String statusAppointment, status=null;
			statusAppointment=appointment.getStatus().toString();
			if(statusAppointment.equalsIgnoreCase("CANCELED")||statusAppointment.equalsIgnoreCase("CLOSED"))
				status="C A N C E L A D O";
			else
				status="NO  DE  PROPINAS";
			
			map.put("Status", status);
			
			String mensaje="Por su seguridad respete los límites de velocidad dentro de la Terminal y en la Ruta Fiscal.";
			map.put("Mensaje", mensaje);
			
			String rsc= null;
			Date date= new Date();
			DateFormat formatter = (DateFormat) getBean("dateFormatter_dd-MM-yyyy");
			
			if(pase.getGav_gateId().equalsIgnoreCase("ATP")||pase.getGav_gateId().equalsIgnoreCase("DEPOSITO")||pase.getGav_gateId().equalsIgnoreCase("TIT"))
			    {
				rsc= "RSC - 029 - 11 - 10/11/14 - PSC -009 - 1 de 1";
			    }
			else
				if(pase.getGav_gateId().equalsIgnoreCase("IST"))
				{
					rsc="RDI - 001 - 00 - 10/11/14 - PDI -001 - 1 de 1";					
				}
				else
					{
					rsc="";
					}

			map.put("Rsc", rsc);
			
			DateFormat formatterReport = (DateFormat) getBean("dateFormatter_dd-MMM-yyyy_hh_mmm");
			DateFormat formatterReportDate = (DateFormat) getBean("dateFormatter_dd-MMM-yyyy");
			
			String dateAppointment=null;
			
			DateFormat df= new SimpleDateFormat("MM/dd/yyyy HH:mm:ss a");
			String startDate= df.format(pase.getGav_startDate());
			String endDate= df.format(pase.getGav_startDate());
			int posStartDate=11;
			int posEndDate=20;

			if((pase.getGav_shipcustid().equals("S000067")||pase.getGav_shipcustid().equals("H001636")||
					pase.getGav_shipcustid().equals("S000085")||pase.getGav_shipcustid().equals("S000080")||
					pase.getGav_shipcustid().equals("H004281")||pase.getGav_shipcustid().equals("H080313")||
					pase.getGav_shipcustid().equals("H080314")||pase.getGav_shipcustid().equals("H010189")||
					pase.getGav_shipcustid().equals("H005890")||pase.getGav_shipcustid().equals("H080108")||
					pase.getGav_shipcustid().equals("S000102")||pase.getGav_shipcustid().equals("H077277")||
					pase.getGav_shipcustid().equals("S000113")||pase.getGav_shipcustid().equals("S000114"))
					&& (startDate.substring(posStartDate,13).equals("22")&&startDate.substring(posEndDate, 22).equalsIgnoreCase("PM"))
					)
			{
				dateAppointment=formatterReportDate.format(pase.getGav_startDate());
				map.put("DateAppointment", dateAppointment);
			}
			else
			{
				dateAppointment=formatterReport.format(pase.getGav_startDate()).toString()+ " - "+pase.getGav_endDate().getHours()+":"+pase.getGav_endDate().getMinutes();
				map.put("DateAppointment", dateAppointment);
			}
			map.put("DateAppointment", dateAppointment);
			
			String dateActual=null;
			dateActual=formatterReport.format(new Date()).toString();
			map.put("DateActual", dateActual);
			
			String loc=null;
			if (pase.getUv_category() != null)
			{

				if ((pase.getUv_consigneeId() == null || pase.getUv_consigneeId().equals(null) || pase.getUv_consigneeId().equals("")) && (pase.getUv_category().equals("IMPRT")))
				{

					loc = pase.getUv_complexPosition().substring(6, 7);
				}
				else
				{
					loc = "";
				}
			}
			else
			{
				loc = "";
			}
			map.put("Loc", loc);
			
			String hazard="";
			
			if(pase.getUv_hzrdGkey()!=null)
				
			{
				List<PaseDeEntradaReport> hazardC=new ArrayList<PaseDeEntradaReport>();
				hazardC=manager.getPaseDeEntradaReportHazard(pase.getUv_hzrdGkey());
				for(int i=0;i<hazardC.size();i++)
				{
					if(hazardC.get(i).getUhv_marinePollutants()==1)
					{
						hazard+="CONTAMINANTE MARINO";
					}
					hazard+="\n "+hazardC.get(i).getUhv_imdgClass().toString()+ " - " +hazardC.get(i).getUhv_hzrdDescription() + "\n ";		
				}
				map.put("Hazard", hazard);
			}
			else
			{
				hazard="";
				map.put("Hazard", hazard);
			}
	
			List<PaseDeEntradaReport> result = new ArrayList<PaseDeEntradaReport>();
			result.add(pase);

			JasperDataSource source = new JasperDataSource(PaseDeEntradaReport.class, result);

			JasperPrint jasper_print = JasperFillManager.fillReport(jasReport, map, source);

			pdfFile = File.createTempFile("report1", ".pdf");

			output = new FileOutputStream(pdfFile);
			JasperExportManager.exportReportToPdfStream(jasper_print, output);
			IOUtils.closeQuietly(output);

			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename=\"Pase de Entrada - " + nbr + ".pdf\";");
			response.setContentLength((int) pdfFile.length());

			input = new FileInputStream(pdfFile);
			output = response.getOutputStream();

			StreamUtils.copyStream(input, output, StreamUtils.BUFFER_SIZE);

			pdfFile.delete();
		}
		catch (Exception ex)
		{
			logger.error("error while printing pase de entrada", ex);
		}
		finally
		{
			if (pdfFile != null)
				pdfFile.delete();

			IOUtils.closeQuietly(input);
			IOUtils.closeQuietly(output);
		}
	}
}
