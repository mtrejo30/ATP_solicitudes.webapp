<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- if modelSession exists and is logged, show session information -->
<c:if test='${_SessionModel != null && _SessionModel.loggedIn }'>

<div id="navigationBar_reports" class="menuh">
	
	<sec:authorize access="hasAnyRole('REPORT_ACCESS_LEVEL_ADVANCED','REPORT_ACCESS_LEVEL_MEDIUM')">
		<ul>
			<li><a id="contenedoresLlenos_UltimoDesembarque" href="<c:url value='/report_contenedores_llenos_ultimo_desembarque.page' />">
			<spring:message code="Report_contenedores_llenos_ultimo_desembarque" />
			</a></li>
		</ul>
		
		<ul>
			<li><a id="contenedoresLlenos_UltimoEmbarque" href="<c:url value='/report_contenedores_llenos_ultimo_embarque.page' />">
			<spring:message code="Report_contenedores_llenos_ultimo_embarque" />
			</a></li>
		</ul>
		
		<ul>
			<li><a id="contenedoresLlenos_RecepcionPorPuerta" href="<c:url value='/report_contenedores_llenos_recepcion_por_puerta.page' />">
			<spring:message code="Report_contenedores_llenos_recepcion_puerta" />
			</a></li>
		</ul>
		
		<ul>
			<li><a id="contenedoresLlenos_EntregaPorPuerta" href="<c:url value='/report_contenedores_llenos_entrega_por_puerta.page' />">
			<spring:message code="Report_contenedores_llenos_entrega_puerta" />
			</a></li>
		</ul>
		
		<ul>
			<li><a id="consultasPorBooking" href="<c:url value='/report_consultas_por_booking.page' />">
			<spring:message code="Report_consulta_booking" />
			</a></li>
		</ul>	
		
	</sec:authorize>
	
	<sec:authorize access="hasRole('REPORT_ACCESS_LEVEL_ADVANCED')">
		<ul>
			<li><a id="consultasPorBL" href="<c:url value='/report_consultas_por_bl.page' />">
			<spring:message code="Report_consulta_bl" />
			</a></li>
		</ul>
	</sec:authorize>	
	
	<sec:authorize access="hasAnyRole('REPORT_ACCESS_LEVEL_ADVANCED','REPORT_ACCESS_LEVEL_MEDIUM')">
		<ul>
			<li><a id="arrivalTime" href="<c:url value='/report_arrival_time.page' />">
			<spring:message code="Report_arrived_time" />
			</a></li>
		</ul>
	</sec:authorize>
	
	<ul>
		<li><a id="etasYcierresDeBuques" href="<c:url value='/report_etas_y_cierres_de_buques.page' />">
		<spring:message code="Report_etas_cierres_buques" />
		</a></li>
	</ul>
	
	
	<sec:authorize access="hasRole('REPORT_ACCESS_LEVEL_ADVANCED')">
		<ul>
			<li><a id="operativosImpoExpo" href="<c:url value='/report_consulta_operativo.page' />">
			<spring:message code="Report_consulta_operativo" />
			</a></li>
		</ul>
	</sec:authorize>
		
</div>

</c:if>

<script>
function highlightNavigationBarReportsItem(barName)
{
	highlightNavigationBarItem("reportMenu");

	jQuery("#navigationBar_reports").find("#" + barName).addClass("menuHighlight");
}
</script>