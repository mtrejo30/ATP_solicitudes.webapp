<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:import url="/doctype.jsp" />
<spring:message var='title' code="Login" />

<html>
<head>
	<title><c:out value='${title}'/></title>
	<c:import url="/metas.jsp" />
	<c:import url="/libraries.jsp" />
</head>

<body>
	<c:import url="/header.jsp" />
	<br/>

	<div class="login_container wideFields" align=center>
		<h2><spring:message code="Sign_In" /></h2>

		<form method="post">
			<label><spring:message code="Username" /></label>
			<input id="username" name="username" type="text">
			<br/>

			<label><spring:message code="Password" /></label>
			<input id="password" name="password" type="password">
			<br/><br/>

			<input id="loginButton" type=submit value="<spring:message code="Login" />" />
			<br/><br/>

			<div class="errorMessage">
				<c:out value='${errorMessage}' />&nbsp;
			</div>
		</form>

		<br/>

		<div align="center" id="errorContainer" class="errorContainer">
		</div>
	</div>

	<c:import url="/footer.jsp" />
	
	<div id="sessionTimeoutWarning" style="display: none;">
	</div>

	<div id="modalMessage">
		<p></p>
	</div>
	
</body>

	
<script type="text/javascript">
jQuery(document).ready(loaded);

function loaded()
{
	jQuery("#loginButton").click(function() { blockPage(); });
}
</script>
</html>