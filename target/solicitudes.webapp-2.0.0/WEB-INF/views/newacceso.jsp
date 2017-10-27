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
		<h1><spring:message code="password_must_change1" /></h1>
	</div>

	<div class="new_password_container" align=left>
		<br>
		<form method="post">
		<label>Se ha caducado la cuenta Favor de comunicarse con atención a clientes</label>
		</form>

		<br/>

 		<div align="center" id="errorContainer" class="errorContainer">
 		</div>
	</div>
	
	<c:import url="/footer.jsp" />
	
</body>
</html>