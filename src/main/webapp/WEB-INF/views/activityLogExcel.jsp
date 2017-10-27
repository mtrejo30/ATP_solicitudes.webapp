<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%
    response.setContentType("application/vnd.ms-excel");
    response.addHeader("Content-Disposition", "attachment;filename=\"" + request.getAttribute("reportName") + ".xls\"");
%>

<html>
<head>

<title><c:out value='${report.name}'/></title>

<style>
<c:import url="/css/excelStyle.css" />
</style>

</head>

<body xmlns="http://www.w3.org/1999/xhtml">

<h2><c:out value='${report.title}' /></h2>

<h4><c:out value='${report.name}' /> - <c:out value='${report.timestamp}' /> - <c:out value='${report.username}' /></h4>

<table class=reportTable>
	<tr class=headerTable>
		<td>
			<spring:message code='Initial_Date' />
		</td>
		<td>
			<c:set var="headValue" value="${report.attributes.initialDate}" />
			<c:choose>
				<c:when test='${headValue eq "" or headValue eq null}'>
					<spring:message code='All' />
				</c:when>
				<c:otherwise>
					<c:out value='${headValue}' />
				</c:otherwise>	
			</c:choose>
		</td>
		<td>
			<spring:message code='Final_Date' />
		</td>
		<td>
			<c:set var="headValue" value="${report.attributes.finalDate}" />
			<c:choose>
				<c:when test='${headValue eq "" or headValue eq null}'>
					<spring:message code='All' />
				</c:when>
				<c:otherwise>
					<c:out value='${headValue}' />
				</c:otherwise>	
			</c:choose>
		</td>
	</tr>

	<tr class=headerTable>
		<td>
			<spring:message code='Action' />
		</td>
		<td>
			<c:set var="headValue" value="${report.attributes.action}" />
			<c:choose>
				<c:when test='${headValue eq "" or headValue eq null}'>
					<spring:message code='All' />
				</c:when>
				<c:otherwise>
					<c:out value='${headValue}' />
				</c:otherwise>	
			</c:choose>
		</td>
		<td>
			<spring:message code='Information' />
		</td>
		<td>
			<c:set var="headValue" value="${report.attributes.data}" />
			<c:choose>
				<c:when test='${headValue eq "" or headValue eq null}'>
					<spring:message code='All' />
				</c:when>
				<c:otherwise>
					<c:out value='${headValue}' />
				</c:otherwise>	
			</c:choose>
		</td>
	</tr>
</table>

<br>

<table class=reportTable>
	<tr class=headerTable>
		<td nowrap align=right>#</td>
		<td nowrap ><spring:message code='Action' /></td>
		<td nowrap ><spring:message code='Information' /></td>
		<td nowrap ><spring:message code='Date' /></td>
		<td nowrap ><spring:message code='User' /></td>
	</tr>

	<c:forEach var='log' varStatus='status' items='${report.attributes.logs}'>
		<tr>
			<td align=right><c:out value='${status.count}' /></td>
			<td nowrap><c:out value='${log.action}' />&nbsp;</td>
			<td nowrap><c:out value='${log.data}' />&nbsp;</td>
			<td nowrap><fmt:formatDate value ='${log.timestamp}' pattern='dd-MMM-yy hh:mm:ss' />&nbsp;</td>
			<td nowrap><c:out value='${log.username}' />&nbsp;</td>
		</tr>
	</c:forEach>

</table>

</body>
</html>