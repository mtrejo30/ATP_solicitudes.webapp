<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

<div id="solicitud_container" class="solicitud_container">
	<form
		id="solicitud_form"
		method="post"
		target="postDocument">		
		<fieldset>
			<legend>Info</legend>

				<br/>
				<input id="folio" name="folio" type="hidden">

				<label id="SolicitudReferenceLabel"><spring:message code='Solicitud_reference' />:</label>
				<input id="reference" name="reference" type="text"  maxlength="15"/>
								
				<label><spring:message code='Solicitud_type' />:</label>
				<select id="operationTypeId" name="operationTypeId" ></select>

				<label id="agentLabel"><spring:message code='Agent_name' />:</label>
				<input id="agenciaAduanalName" name="agenciaAduanalName" type="text"/>
				<input id="agenciaAduanalId" name="agenciaAduanalId" type="hidden">
				
				<label id="clientLabel"><spring:message code='Client_name' />:</label>
				<input id="clienteName" name="clienteName" type="text" />
				<input id="clienteId" name="clienteId" type="hidden">
				
				<label id="codeLabel"><spring:message code='Package' />:</label>
				<input id="codigoName" name="codigoName" type="text" />
				<input id="codigoId" name="codigoId" type="hidden">
				
				<br/><br/>
		</fieldset>

	</form>

		<br/>		
		<div align="center" id="errorContainer" class="errorContainer"></div>

	<div align=center>
		<input id=saveSolicitudButton type=button value="<spring:message code='Accept' />">
		<input id=cancelSolicitudButton type=button value="<spring:message code='Cancel' />">
	</div>
</div>
