<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div align=center>

	<!-- if modelSession exists and is logged, show session information -->
	<c:if test='${_SessionModel != null && _SessionModel.loggedIn }'>

	<table class=toolbarTable>
		<tr>
			<td nowrap>
				<spring:message code="Welcome" /> <c:out value='${_SessionModel.loggedUser.username}'/>
			
				<c:if test='${param.title != null}'>
					-&nbsp;<c:out value='${param.title}' />
				</c:if>
			
				| <a class=linkNoDecoration href="#" onclick=doExit()><spring:message code="Logoff" /></a>				
			</td>
		</tr>
	</table>

	</c:if>

</div>
