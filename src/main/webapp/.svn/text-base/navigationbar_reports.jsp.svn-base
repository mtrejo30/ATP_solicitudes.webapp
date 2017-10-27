<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="hasAnyRole('REPORT_ACCESS_LEVEL_ADVANCED','REPORT_ACCESS_LEVEL_MEDIUM')">

	<li><a id="contenedoresLlenos_UltimoDesembarque" href="<c:url value='/report_contenedores_llenos_ultimo_desembarque.page' />">
	<spring:message code="Report_contenedores_llenos_ultimo_desembarque" />
	</a></li>

	<li><a id="contenedoresLlenos_UltimoEmbarque" href="<c:url value='/report_contenedores_llenos_ultimo_embarque.page' />">
	<spring:message code="Report_contenedores_llenos_ultimo_embarque" />
	</a></li>

	<li><a id="contenedoresLlenos_RecepcionPorPuerta" href="<c:url value='/report_contenedores_llenos_recepcion_por_puerta.page' />">
	<spring:message code="Report_contenedores_llenos_recepcion_puerta" />
	</a></li>

	<li><a id="contenedoresLlenos_EntregaPorPuerta" href="<c:url value='/report_contenedores_llenos_entrega_por_puerta.page' />">
	<spring:message code="Report_contenedores_llenos_entrega_puerta" />
	</a></li>

	<li><a id="consultasPorBooking" href="<c:url value='/report_consultas_por_booking.page' />">
	<spring:message code="Report_consulta_booking" />
	</a></li>
		
</sec:authorize>
	
<sec:authorize access="hasRole('REPORT_ACCESS_LEVEL_ADVANCED')">
	<li><a id="consultasPorBL" href="<c:url value='/report_consultas_por_bl.page' />">
	<spring:message code="Report_consulta_bl" />
	</a></li>
</sec:authorize>	
	
<sec:authorize access="hasAnyRole('REPORT_ACCESS_LEVEL_ADVANCED','REPORT_ACCESS_LEVEL_MEDIUM')">
	<li><a id="arrivalTime" href="<c:url value='/report_arrival_time.page' />">
	<spring:message code="Report_arrived_time" />
	</a></li>
</sec:authorize>
	
	<li><a id="etasYcierresDeBuques" href="<c:url value='/report_etas_y_cierres_de_buques.page' />">
	<spring:message code="Report_etas_cierres_buques" />
	</a></li>
	

<sec:authorize access="hasRole('REPORT_ACCESS_LEVEL_ADVANCED')">
	<li><a id="operativosImpoExpo" href="<c:url value='/report_consulta_operativo.page' />">
	<spring:message code="Report_consulta_operativo" />
	</a></li>
</sec:authorize>

<sec:authorize access="hasRole('REPORT_ACCESS_LEVEL_BASIC')">
	<li><a id="reporteEtasYCierresDeBuque" href="<c:url value='/report_etas_y_cierres_de_buques.page' />">
	<spring:message code="Report_etas_cierres_buques" />
	</a></li>
</sec:authorize>	

<script>
function highlightNavigationBarReportsItem(barName)
{
	highlightNavigationBarItem("reportMenu");

	jQuery("#navigationBarDiv").find("#" + barName).addClass("menuHighlight");
}
</script>