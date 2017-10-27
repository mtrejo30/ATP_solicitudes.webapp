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
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name="user_transportistas")
public class UserTransportistas implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@JsonProperty(value="id_user_trans")
	@Id
	@GeneratedValue(strategy= GenerationType.AUTO)
	@Column(name="id",updatable = false, nullable = false)
	private Integer id;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.JOIN)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;
	
	@JsonIgnore
	@Column(name = "fecha_alta", updatable = true , nullable = false)
	private Date fecha_alta;
	
	@JsonIgnore
	@Column(name = "date_updated", updatable = true , nullable = false)
	private Date date_updated;
	
	@JsonProperty(value="user_n4_id")
	@Column(name = "user_n4_id", updatable = true, nullable = false)
	private Integer user_n4_id;
	
	@JsonProperty(value="transportista_id")
	@Column(name = "transportista_id", updatable = true, nullable = false)
	private Integer transportista_id;
	
	@JsonProperty(value="username")
	@Column(name = "username", updatable = true, nullable = false)
	private String username;
	
	@JsonIgnore
	@Column(name = "nivel", updatable = true, nullable = false)
	private Integer nivel;
	
	//Json properties
	
	@JsonProperty(value="nivel")
	public String getNivelString(){
		if(getNivel() == 1)
			return "Basico";
		else if(getNivel() == 2)
			return "Intermedio";
		else if(getNivel() == 3)
			return "Avanzado";
		else
			return "Ninguno";
	}
	
	@JsonProperty(value="nivel")
	public void setNivelString(String nivel){
		if("Basico".equals(nivel))
			setNivel(1);
		else if("Intermedio".equals(nivel))
			setNivel(2);
		else if("Avanzado".equals(nivel))
			setNivel(3);
		else
			setNivel(4);
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getFecha_alta() {
		return fecha_alta;
	}

	public void setFecha_alta(Date fecha_alta) {
		this.fecha_alta = fecha_alta;
	}

	public Date getDate_updated() {
		return date_updated;
	}

	public void setDate_updated(Date date_updated) {
		this.date_updated = date_updated;
	}

	public Integer getUser_n4_id() {
		return user_n4_id;
	}

	public void setUser_n4_id(Integer user_n4_id) {
		this.user_n4_id = user_n4_id;
	}

	public Integer getNivel() {
		return nivel;
	}

	public void setNivel(Integer nivel) {
		this.nivel = nivel;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getTransportista_id() {
		return transportista_id;
	}

	public void setTransportista_id(Integer transportista_id) {
		this.transportista_id = transportista_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	

}
