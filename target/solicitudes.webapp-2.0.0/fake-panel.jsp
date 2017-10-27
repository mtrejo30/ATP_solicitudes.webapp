<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<div id="fake_container" class="panel_container fake_container">
	<form id="fake_form">
		<fieldset>
			<legend>Info</legend>

			<label>ID (for invalid test 10)</label> <input type="text" id="id" name="id" value="1" />
			<br/>

			<label>Label</label> <input type="text" id="label" name="label" value="ferito" />

			<br/>

		</fieldset>
	</form>
	
	<div align=center>
		<input id=saveButton type=button value="<spring:message code='Save' />">
		<input id=cancelButton type=button value="<spring:message code='Cancel' />">
	</div>
</div>