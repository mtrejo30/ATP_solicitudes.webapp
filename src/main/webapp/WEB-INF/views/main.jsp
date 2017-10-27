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
   <div class="container"> 
        <div class="logo1">
			<img src="images/atp_img.jpg" style="margin-top:10px;height:400px;margin-left:340px; display: inline;"/>
        </div>
       <div style ="margin-top:430px">
			 <b>MANUALES  </b> 
			  <br> <br>
        <sec:authorize access="hasAnyRole('TA','TI','LN','AA','CLI','RF','DEP','AC')">
				 <a  target=" _blank" href="images/Manual_de_avisos_del_Sistema.pdf">Manual de avisos del Sistema </a>
			  <br> <br>
			  <a  target=" _blank" href="images/Manual_para_el_usuario_Programador-Cliente.pdf">Manual para el usuario Programador - Cliente  </a> 
			   <br> <br>
			  </sec:authorize>			   
			   <sec:authorize access="hasAnyRole('TA','TI','TRA')">
			<a target=" _blank" href="images/Manual_para_el_usuario_Transporte-Cliente.pdf">Manual para el usuario Transporte - Cliente  </a>
			 <br> <br>
			  </sec:authorize>
			   <sec:authorize access="hasAnyRole('TA','TI','AC')">
			<a  target="_blank" href="images/Manual_para_el_usuario_Administrador-Cliente.pdf">Manual para el usuario Administrador - Cliente </a>
			 <br> <br>
		 </sec:authorize>
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