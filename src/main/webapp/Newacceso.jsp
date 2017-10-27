<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link type="text/css" rel="Stylesheet" href="css/default.css" />

<c:import url="/doctype.jsp" />

<html>
<head>
	<c:import url="/metas.jsp" />
</head>
<body>
	<c:import url="/header.jsp" />
	<br/>
	<div align=center>
<!-- 		<img src="images/ow-logo.png" style="margin-top:10px;"/> -->
		<h1><spring:message code="password_must_change" /></h1>
	</div>

	<div class="new_password_container" align=center>
		<h2><spring:message code="new_password_page" /></h2>
		<form method="post">
		
			<div class="form-item">
				<label><spring:message code="Password" /></label>
				<input id="new_password" name="new_password" type="password">
			</div>

			<div class="form-item">
				<label><spring:message code="Confirm_Password" /></label>
				<input id="confirm_password" name="confirm_password" type="password">
			</div>

			<div class="form-item">
				<input id="actionButton" type=submit value="<spring:message code="change_password" />" />
			</div>

			<div class="errorMessage">
				<c:out value='${errorMessage}' />&nbsp;
			</div>
		</form>

		<br/>

 		<div align="center" id="errorContainer" class="errorContainer">
 		</div>
	</div>
	
	<c:import url="/footer.jsp" />
	
</body>
</html>