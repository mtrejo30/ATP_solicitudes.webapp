<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="container" id="heade">
    <div class="row">
        <div class="logo">
			<c:if test="${loggedUser.empresa.nombre eq 'ATP'}">
				<img src="images/atp-logo.jpg" style="margin-top:10px; display: inline;"/>
			</c:if>
        </div>
        <div class="titulo" >
            <h1><spring:message code="application.title" /></h1>
            <c:if test="${loggedUser.empresa.nombre ne 'ATP'}">
				<h3 style="margin-left:-120px">${loggedUser.empresa.nombre}</h3>
			</c:if>
        </div>
        <div  class="login">
            <c:if test='${_SessionModel != null && _SessionModel.loggedIn }'>
            	<ul class="nav navigationBar">						
					<li class="main-menu">
						<a href="#"><c:out value='${_SessionModel.loggedUser.username}'/></a>
						<ul id="menu"  class="sub-menu">
					    	<li><a href="#" onclick=doNewPassword()><spring:message code="Change_password" /></a></li>
					    	<sec:authorize access="hasAnyRole('AC')">
					    	<li><a href="#" onclick=doAgendaWeb()><spring:message code="AgendaWeb" /></a></li>
					    	</sec:authorize>
					    	 <%-- 
					    	<sec:authorize access="hasAnyRole('AC')">
					    	<!-- <li><a href="http://atptfs01:8080/AgendaWebClient/Home?ID=${_SessionModel.userN4}" target="_blank">Agenda</a> </li> -->
					    	<li><a href="#" onclick=doOpenDialog("http://atptfs01:8080/AgendaWebClient/Home?ID=${_SessionModel.userN4}")>Agenda</a> </li>
					    	</sec:authorize>
					    	--%>
					    	<li><a href="#" onclick=doExit()><spring:message code="Logoff" /></a></li>
					    
					  	</ul>
					</li>
				</ul>
			</c:if>
        </div>
    </div>
</div>
<input type="hidden" id="Id_userN4_Id" value="${_SessionModel.userN4}" />
<input type="hidden" id="Idpantalla" value="${_SessionModel.loggedUser.pantalla}" />
<input type="hidden" id="userN4_Profile" value="${loggedUser.profile.code}" />
<input type="hidden" id="Id_user_bitacora" value="${_SessionModel.loggedUser.id}" />

<script>
$(document).ready(function() {
    $('.nav > li').bind('mouseover', openSubMenu);
    $('.nav > li').bind('mouseout',  closeSubMenu);
    function openSubMenu() {
        $(this).find('ul').css('visibility', 'visible'); 
        $(this).find('ul').css('display', 'block'); 
    }
    function closeSubMenu() {
        $(this).find('ul').css('visibility', 'hidden');
    }
    
   //execute loaded function when page loaded
    jQuery(document).ready(loaded);

    function loaded() 
    {
    	var pantalla= jQuery("#Idpantalla").val();
    	var a = "DEACTIVATED"
    	   if(pantalla == a)
    		{jQuery("#transportistasMenu").hide();}
    	else
    		{jQuery("#transportistasMenu").show();}
    }

});
</script>
