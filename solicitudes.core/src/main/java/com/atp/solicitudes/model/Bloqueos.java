package com.atp.solicitudes.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.objectwave.exception.DomainModelException;

@Entity
@Table(name="Bloqueos_Citas")
public class Bloqueos implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@JsonProperty(value="id_bloqueo")
	@Id
	@GeneratedValue(strategy= GenerationType.AUTO)
	@Column(name="id_bloqueo",updatable = false, nullable = false)
	private Integer id;
	
	@JsonProperty(value="Tipo_Movimiento")
	@Column(name = "Tipo_Movimiento", nullable = false)
	private String Tipo_Movimiento;
	
	@JsonProperty(value="id_agencia_excluir")
	@Column(name = "id_agencia_excluir",  nullable = false)
	private Integer id_agencia_excluir;
	
	@JsonProperty(value="nombre_agencia_excluir")
	@Column(name = "nombre_agencia_excluir", nullable = false)
	private String nombre_agencia_excluir;
	
	
	@JsonProperty(value="id_cliente_excluir")
	@Column(name = "id_cliente_excluir", nullable = false)
	private Integer id_cliente_excluir;
	
	@JsonProperty(value="nombre_cliente_excluir")
	@Column(name = "nombre_cliente_excluir", nullable = false)
	private String nombre_cliente_excluir;
	
	@JsonProperty(value="lineas")
	@Column(name = "lineas", nullable = false)
	private String lineas;
	
	@JsonProperty(value="Tipo_contendor")
	@Column(name = "Tipo_contendor", nullable = false)
	private String Tipo_contendor;
	
	@JsonProperty(value="mensaje")
	@Column(name = "mensaje", nullable = false)
	private String mensaje;
	
	@JsonProperty(value="fecha_creacion")
	@Column(name = "fecha_creacion",  nullable = false)
	private String fecha_creacion;
	
	@JsonProperty(value="fecha_actualizacion")
	@Column(name = "fecha_actualizacion", nullable = false)
	private String fecha_actualizacion;
	
	@JsonProperty(value="fecha_desactivacion")
	@Column(name = "fecha_desactivacion", nullable = false)
	private String fecha_desactivacion;

	
	public Integer getId_bloqueo() {
		return id;
	}
	public void setId_bloqueo(Integer id_bloqueo) {
		this.id = id_bloqueo;
	}
	public String getTipo_Movimiento() {
		return Tipo_Movimiento;
	}
	public void setTipo_Movimiento(String tipo_Movimiento) {
		Tipo_Movimiento = tipo_Movimiento;
	}
	public Integer getId_agencia_excluir() {
		return id_agencia_excluir;
	}
	public void setId_agencia_excluir(Integer id_agencia_excluir) {
		this.id_agencia_excluir = id_agencia_excluir;
	}
	public String getNombre_agencia_excluir() {
		return nombre_agencia_excluir;
	}
	public void setNombre_agencia_excluir(String nombre_agencia_excluir) {
		this.nombre_agencia_excluir = nombre_agencia_excluir;
	}
	public Integer getId_cliente_excluir() {
		return id_cliente_excluir;
	}
	public void setId_cliente_excluir(Integer id_cliente_excluir) {
		this.id_cliente_excluir = id_cliente_excluir;
	}
	public String getNombre_cliente_excluir() {
		return nombre_cliente_excluir;
	}
	public void setNombre_cliente_excluir(String nombre_cliente_excluir) {
		this.nombre_cliente_excluir = nombre_cliente_excluir;
	}
	public String getLineas() {
		return lineas;
	}
	public void setLineas(String lineas) {
		this.lineas = lineas;
	}
	public String getTipo_contenedor() {
		return Tipo_contendor;
	}
	public void setTipo_contenedor(String tipo_contenedor) {
		this.Tipo_contendor = tipo_contenedor;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public String getFecha_creacion() {
		return fecha_creacion;
	}
	public void setFecha_creacion(String fecha_creacion) {
		this.fecha_creacion = fecha_creacion;
	}
	public String getFecha_actualizacion() {
		return fecha_actualizacion;
	}
	public void setFecha_actualizacion(String fecha_actualizacion) {
		this.fecha_actualizacion = fecha_actualizacion;
	}
	public String getFecha_desactivacion() {
		return fecha_desactivacion;
	}
	public void setFecha_desactivacion(String fecha_desactivacion) {
		this.fecha_desactivacion = fecha_desactivacion;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public void fillFrom(JsonNode node, Map<String,Object> context) throws DomainModelException, Exception
	{	
		if (node.get("mensaje").asText().equals(("")))
			throw new DomainModelException ("Ingresar Mensaje");
		
		if (node.get("Tipo_contendor").asText().equals(("")))
			throw new DomainModelException ("Ingresar Tipos a bloquear");

		if(node.get("nombre_agencia_excluir").asText().equals(("")))
		{setId_agencia_excluir(0);}
		else{setId_agencia_excluir(node.get("id_agencia_excluir").asInt());}
		
		if(node.get("nombre_cliente_excluir").asText().equals(("")))
		{setId_cliente_excluir(0);}
		else{setId_cliente_excluir(node.get("id_cliente_excluir").asInt());}
		
		
		setTipo_Movimiento(node.get("tipo_Movimiento").asText());
		setNombre_agencia_excluir(node.get("nombre_agencia_excluir").asText());
		setNombre_cliente_excluir(node.get("nombre_cliente_excluir").asText());
		setLineas(node.get("lineas").asText());
		setTipo_contenedor(node.get("Tipo_contendor").asText());
		setMensaje(node.get("mensaje").asText());
		setFecha_creacion((node.get("fecha_creacion").asText()));
		setFecha_actualizacion((node.get("fecha_actualizacion").asText()));
		setFecha_desactivacion((node.get("fecha_desactivacion").asText()));
	}

	
	@Override
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof Holiday))
			return false;

		Bloqueos realObject = (Bloqueos) anObject;

		return this.getId_bloqueo().equals(realObject.getId_bloqueo());
	}
	@Override
	public int hashCode()
	{
		return getId_bloqueo();
	}

}
