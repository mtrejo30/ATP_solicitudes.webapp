<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

<div id="Bloqueos_admin_container" class="panel_container user_admin_container">
	<form id="Bloqueos_form">
		<fieldset>
		<!-- 		this.setId_bloqueo(node.get("id_bloqueos").asInt());
		this.setTipo_Movimiento(node.get("tipo_Movimiento").asText());
		this.setId_agencia_excluir(node.get("id_agencia_excluir").asInt());
		this.setNombre_agencia_excluir(node.get("nombre_agencia_excluir").asText());
		this.setId_cliente_excluir(node.get("id_cliente_excluir").asInt());
		this.setNombre_cliente_excluir(node.get("nombre_cliente_excluir").asText());
		this.setLineas(node.get("lineas").asText());
		this.setTipo_contenedor(node.get("tipo").asText());
		this.setMensaje(node.get("mensaje").asText());
		this.setFecha_creacion(fecha_creacion);
		this.setFecha_actualizacion(fecha_actualizacion);
		this.setFecha_desactivacion(node.get("fecha_desactivacion").asText()); -->
			<legend>Info</legend>
			
			
			<label>Tipo de Movimientos:</label>
			<select  style="width: 320px!important;" id="tipo_Movimiento" name="tipo_Movimiento" > 
				<option value="Entrega de Vacío">Entrega de Vacío</option> 
				<option value="Entrega de Importación">Entrega de Importación</option> 
				<option value="Recepción de Vacío">Recepción de Vacío</option> 
				<option value="Recepción de Exportación">Recepción de Exportación</option> 
			</select>
			<input style="display:none" class="" id="id_agencia_excluir" name="id_agencia_excluir" type="text">
			<input style="display:none" class="" id="id_cliente_excluir" name="id_cliente_excluir" type="text">
			<br/>
			<label>Lineas:</label>
			<input style="width: 320px!important;" class="" id="lineas" name="lineas" type="text">
			<br/>
			<label>Tipos:</label>
			<textarea class="" id="Tipo_contendor" name="Tipo_contendor" type="text" cols="40" rows="5"></textarea>
			<br/>
			<label>Mensaje:</label>
			<textarea   class="" id="mensaje" name="mensaje" type="text" cols="40" rows="5"></textarea>
			<br/>
			<label>Agencia:</label>
			<input style="width: 320px!important;" class="" id="nombre_agencia_excluir" name="nombre_agencia_excluir" type="text">
			<br/>
			<label>Cliente:</label>
			<input style="width: 320px!important;" id="nombre_cliente_excluir" name="nombre_cliente_excluir" type="text">
			<br/>
			<label Style="display:none">Fecha Desactivacion:</label>
			<input style="width: 320px!important;display:none" id="fecha_desactivacion" type="text" name="fecha_desactivacion" />
			<input style="display:none" id="fecha_creacion" type="text" name="fecha_creacion" />
			<input style="display:none" id="fecha_actualizacion" type="text" name="fecha_actualizacion" />
			<br/>
		</fieldset>
		<br/>		
		<div align="center" id="errorContainer" class="errorContainer"></div>
	</form>
	
	<div align=center>
		<input id=saveButton type=submit value="<spring:message code='Accept' />">
		<input id=closeButton type=button value="<spring:message code='Cancel' />">
	</div>
</div>

<script type="text/javascript">
//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded()
{
	
	var fec =new Date().toJSON().slice(0,10);
	jQuery("#fecha_creacion").val(fec);
	jQuery("#fecha_actualizacion").val(fec);
	jQuery("#fecha_desactivacion").datepicker({dateFormat: 'yy-mm-dd'});
}



</script>