<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="container">
    <div class="row">
        <div class="logo">
			<c:if test="${loggedUser.empresa.nombre eq 'ATP'}">
				<img src="images/atp-logo.jpg" style="margin-top:10px; display: inline;"/>
			</c:if>
        </div>
        <div class="titulo">
            <h1><spring:message code="application.title" /></h1>
            <c:if test="${loggedUser.empresa.nombre ne 'ATP'}">
				<h3>${loggedUser.empresa.nombre}</h3>
			</c:if>
        </div>
        <div class="login">
            <c:if test='${_SessionModel != null && _SessionModel.loggedIn }'>
            	<ul class="nav navigationBar">						
					<li class="main-menu">
						<a href="#"><c:out value='${_SessionModel.loggedUser.username}'/></a>
						<ul class="sub-menu">
					    	<li><a href="#" onclick=doNewPassword()><spring:message code="Change_password" /></a></li>
					    	<li><a href="#" onclick=doExit()><spring:message code="Logoff" /></a></li>
					  	</ul>
					</li>
				</ul>
			</c:if>
        </div>
    </div>
</div>
	
<script>
$(document).ready(function() {
    $('.nav > li').bind('mouseover', openSubMenu);
    $('.nav > li').bind('mouseout',  closeSubMenu);
    function openSubMenu() {
        $(this).find('ul').css('visibility', 'visible'); 
    }
    function closeSubMenu() {
        $(this).find('ul').css('visibility', 'hidden');
    }
});
</script>
