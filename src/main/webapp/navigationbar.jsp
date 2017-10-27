<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- if modelSession exists and is logged, show session information -->
<c:if test='${_SessionModel != null && _SessionModel.loggedIn }'>

<div id="navigationBarDiv">
	<ul class="navigationBar">
		<li><a id="mainMenu" href="<c:url value='/main.page' />">
		<spring:message code="Main" />
		</a></li>
	
		<sec:authorize access="hasAnyRole('TA')">
			<li><a id="userMenu" href="<c:url value='/user-admin.page' />">
			<spring:message code="User_Admin" />
			</a></li>
		</sec:authorize>
			
		<sec:authorize access="hasAnyRole('TA','TI')">
			<li><a id="activityMenu" href="<c:url value='/activity-log.page' />">
			<spring:message code="Activity_Log" />
			</a></li>			
		</sec:authorize>
		
		<sec:authorize access="hasRole('TA')">
			<li><a id="holidaysMenu" href="<c:url value='/holiday.page' />">
			<spring:message code="holiday" />
			</a></li>
		</sec:authorize>
		
		<sec:authorize access="hasRole('TA')">
			<li><a id="propertyMenu" href="<c:url value='/system-property.page' />">
			<spring:message code="System_Property" />
			</a></li>
		</sec:authorize>
		<sec:authorize access="hasAnyRole('AC')">
			<li><a id="transportistasMenu" href="<c:url value='/transportistas.page' />">
			<spring:message code="Transporters" />
			</a></li>
		</sec:authorize>
		<li><a class="solicitudMenu" id="solicitudMenu" href="<c:url value='/solicitud.page' />">
		<spring:message code="Solicitudes" />
		</a></li>
		<sec:authorize access="hasAnyRole('TRA','AC')">
			<li><a id="bitacoraUserMenu" href="<c:url value='/bitacora.page' />">
			<spring:message code="Bitacora_Menu" />
			</a></li>
		</sec:authorize>
		<sec:authorize access="hasRole('TA')">
			<li><a id="bloqueosMenu" href="<c:url value='/bloqueos.page' />">
			<spring:message code="bloqueos_" />
			</a></li>
		</sec:authorize>
		<sec:authorize access="hasAnyRole('REPORT_ACCESS_LEVEL_ADVANCED', 'REPORT_ACCESS_LEVEL_MEDIUM', 'REPORT_ACCESS_LEVEL_BASIC')">
			<li>
				<a id="reportMenu" href="<c:url value='/report_contenedores_llenos_ultimo_desembarque.page' />">
				<spring:message code="Reports" />
				</a>
			
				<ul>
					<c:import url="/navigationbar_reports.jsp"></c:import>
				</ul>

			</li>
		</sec:authorize>
	</ul>
</div>
</c:if>

<script>

function highlightNavigationBarItem(barName)
{
	jQuery("#navigationBarDiv").find("#" + barName).addClass("menuHighlight");
	
    jQuery('.navigationBar li').hover(
  	      function () { showSubmenu(this); },
  	      function () { jQuery('ul', this).fadeOut(); }
  	      );
}

function showSubmenu(aComponent)
{
	var menuElement = jQuery('ul', aComponent);
	menuElement.fadeIn();
}
</script>