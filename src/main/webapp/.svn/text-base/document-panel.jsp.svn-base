<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<div id="document_container" class="document_container">
	<form
		id="document_form"
		enctype="multipart/form-data"
		method="post"
		target="postDocument">
		<fieldset>
			<legend>Info</legend>

				<br/>
				<label id="nameFileLabel"><spring:message code='document_clave' />:</label>
				<input id="clave" name="clave" type="text" value="${clave}"/>
				
				<br/>
				<label><spring:message code='document_short_name' />:</label>
				<input id="file" name="file" type="file" value="${file}" />
				
				<label><spring:message code='document_type' />:</label>
				<select id="typeSelect" name="type" ></select>

				<input type="hidden" id="_callbackFunctionName" name="_callbackFunctionName" />
				<br/><br/>
		</fieldset>

	</form>

		<br/>		
		<div align="center" id="errorContainer" class="errorContainer"></div>

	<div align=center>
		<input id=saveDocumentButton type=button value="<spring:message code='Accept' />">
		<input id=cancelDocumentButton type=button value="<spring:message code='Cancel' />">
	</div>
</div>

<iframe id="postDocument" name="postDocument" src="" style="display: none;"></iframe>
