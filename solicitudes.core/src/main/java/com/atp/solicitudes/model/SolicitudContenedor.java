package com.atp.solicitudes.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import java.text.SimpleDateFormat;



import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
//import org.codehaus.jackson.annotate.JsonIgnore;
//import org.codehaus.jackson.annotate.JsonProperty;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name="solicitud_contenedor")
public class SolicitudContenedor implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@JsonProperty(value="idsolicont")
	@Id
	@GeneratedValue(strategy= GenerationType.AUTO)
	@Column(name="id",updatable = false, nullable = false)
	private Integer id;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.JOIN)
	@JoinColumn(name = "solicitud_id", nullable = false)
	private Solicitud solicitud;
	
	@JsonProperty(value="unit_nbr")
	@Column(name = "unit_nbr", updatable = true, nullable = false)
	private String unit_nbr;
	
	@JsonIgnore
	@Column(name = "fecha", updatable = true , nullable = false)
	private Date fecha;
	
	//JsonProperty's
	
	@JsonProperty(value="solicitud")
	public Integer getsolicitudid(){
		return getSolicitud().getFolio();
	}
	@JsonProperty(value="solicitud")
	public void setSolicitudId(Integer id)
	{
		Solicitud fake = new Solicitud(); fake.setFolio(id);
		setSolicitud_id(fake);
	}
	
	@JsonProperty(value="fecha")
	public String getFechaString(){
		return new SimpleDateFormat("yyyy-MM-dd").format(getFecha());
	}
	
	//Getter and Setter
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Solicitud getSolicitud() {
		return solicitud;
	}
	public void setSolicitud_id(Solicitud solicitud) {
		this.solicitud = solicitud;
	}
	public String getUnit_nbr() {
		return unit_nbr;
	}
	public void setUnit_nbr(String unit_nbr) {
		this.unit_nbr = unit_nbr;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}