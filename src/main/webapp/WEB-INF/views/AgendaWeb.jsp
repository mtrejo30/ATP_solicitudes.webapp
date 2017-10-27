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
		
	</div>
 

 <div  align=center>  
 
            	<c:import url="/navigationbar.jsp" />
			
			<br>
			<br>

</div>


  
	<iframe  width=100%  frameborder="0" height=100% id="iframeId" 
	src = <c:out value='${urlwebclient}' escapeXml="false" />>
	
    </iframe>
 




	<c:import url="/footer.jsp" />
	<script >
	jQuery(document).ready(loaded);
	
	function loaded(){
		
		
	}
	function doMain(){
		redirectURL("<c:url value='main.page' />");
	}
	</script>
</body>
</html>