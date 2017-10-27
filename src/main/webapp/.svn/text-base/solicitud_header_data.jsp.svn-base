<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<div class="solicitudHeaderContainer" align=center>
	<table class=noPaddingTable>
	<tr>
		<td>
			<label><spring:message code='Folio' />:</label>
			<input readonly type=text value="${solicitud.folio}" />
		</td>
		<td>
			<label><spring:message code='Reference' />:</label>
			<input readonly type=text value="${solicitud.reference}" />
		</td>
	</tr>
	<tr>
		<td>
			<label><spring:message code='Custom_Agency' />:</label>
			<input readonly type=text value="${agenciaAduanal.nombre}" />
		</td>
		<td>
			<label><spring:message code='Customer' />:</label>
			<input readonly type=text value="${cliente.nombre}" />
		</td>
	</tr>
	<tr>
		<td>
			<label><spring:message code='Package' />:</label>
			<input readonly type=text value="${paqueteComercial.nombre}" />
		</td>
		<td>
			&nbsp;
		</td>
	</tr>
	<tr>
		<td>
			<label><spring:message code='Created' />:</label>
			<input readonly type=text value="${solicitud.dateCreated}" />
		</td>
		<td>
			<label><spring:message code='Modified' />:</label>
			<input readonly type=text value="${solicitud.dateUpdated}" />
		</td>
	</tr>
</table>
</div>