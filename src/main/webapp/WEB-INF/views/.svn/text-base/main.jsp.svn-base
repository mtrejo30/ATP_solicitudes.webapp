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
	<c:import url="/libraries_plugins.jsp" />
</head>

<body>
	<c:import url="/header.jsp">
		<c:param name='title' value='${title}' />
	</c:import>
	
	<div align=center>
	
	<c:import url="/navigationbar.jsp" />
	
	<c:if test='${error == ""}'>
		<div align=center>
			<h1></h1>
			<p></p>
		</div>
	</c:if>
			
	</div>

	<c:import url="/footer.jsp" />
			
	<div id="modalMessage"> 
		<p></p>
	</div>
</body>

<script type="text/javascript">
//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded()
{	
	//currentMenu
	highlightNavigationBarItem("mainMenu");
}	
</script>
</html>