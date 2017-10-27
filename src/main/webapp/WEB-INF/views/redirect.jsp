<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:import url="/doctype.jsp" />
<spring:message var='title' code="Main" />

<html>
<head>
	<title><c:out value='${title}'/></title>
	<c:import url="/libraries.jsp" />
</head>

<body>
	<c:import url="/header.jsp" />
	<br/>

	<div align=center>

		<c:if test='${errorMessage != null}'>
			<span class="errorContainer"><c:out value='${errorMessage}'/></span>
			<br/>
		</c:if>

		<c:if test='${message != null}'>
			<span><c:out value='${message}'/></span>
			<br/>
		</c:if>

		<br/>

		<c:if test='${goToLogin}'>
			<a href="<c:url value='login.html' />"><spring:message code='Redirecting_To_Login' /></a>
			<script>
				setTimeout(function() { redirectURL("<c:url value='login.html' />"); }, 4000);
			</script>
		</c:if>

		<c:if test='${goHistoryBack}'>
			<a href="javascript:history.go(-1)"><spring:message code='Sending_Back' /></a>
			<script>
				setTimeout(function() { history.go(-1); }, 4000);
			</script>
		</c:if>

		<c:if test='${redirectTo != null}'>
			<a href="<c:out value='${redirectTo}' />"><spring:message code='Redirecting' /></a>
			<script>
				setTimeout(function() { redirectURL("<c:out value='${redirectTo}' />"); }, 4000);
			</script>
		</c:if>
	</div>

	<c:import url="/footer.jsp" />

</body>
</html>
