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

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "solicitud_comentario")
public class SolicitudComentario implements Serializable
{
	private static final long serialVersionUID = 1L;

	@JsonProperty(value="id")
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private Integer id;

	@JsonIgnore
	@Column(name = "fecha", nullable = false)
	private Date fecha;

	@JsonProperty(value="comentario")
	@Column(name = "comentario", nullable = true, columnDefinition = "text")
	private String comentario;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.JOIN)
	@JoinColumn(name = "solicitud_id", nullable = false)
	Solicitud solicitud;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.JOIN)
	@JoinColumn(name = "user_id", nullable = false)
	User usuario;

	@JsonProperty(value="usuarioNombre")
	public String getUsuarioName()
	{
		return getUsuario().getUsername();
	}

	@JsonProperty(value="usuarioId")
	public Integer getUsuarioId()
	{
		return getUsuario().getId();
	}

	@JsonProperty(value="usuarioId")
	public void setUsuarioId(Integer id)
	{
		User fake = new User(); fake.setId(id);
		setUsuario(fake);
	}

	@JsonProperty(value="solicitudId")
	public Integer getSolicitudId()
	{
		return getSolicitud().getFolio();
	}

	@JsonProperty(value="solicitudId")
	public void setSolicitudId(Integer id)
	{
		Solicitud fake = new Solicitud(); fake.setFolio(id);
		setSolicitud(fake);
	}

	@JsonProperty(value="fecha")
	public long getFechaLong()
	{
		return getFecha().getTime();
	}
	
	@JsonProperty(value="fecha")
	public void setFechaLong(long value)
	{
		Date newDate = new Date(value);
		setFecha(newDate);
	}

	/**
	 * Method equals.
	 * @param anObject Object
	 * @return boolean
	 */
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (anObject instanceof SolicitudComentario)
			return false;

		SolicitudComentario realObject = (SolicitudComentario) anObject;

		return this.getId().equals(realObject.getId());
	}

	/**
	 * Method hashCode.
	 * @return int
	 */
	public int hashCode()
	{
		return getId();
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Date getFecha()
	{
		return fecha;
	}

	public void setFecha(Date fecha)
	{
		this.fecha = fecha;
	}

	public String getComentario()
	{
		return comentario;
	}

	public void setComentario(String comentario)
	{
		this.comentario = comentario;
	}

	public User getUsuario()
	{
		return usuario;
	}

	public void setUsuario(User usuario)
	{
		this.usuario = usuario;
	}

	public Solicitud getSolicitud()
	{
		return solicitud;
	}

	public void setSolicitud(Solicitud solicitud)
	{
		this.solicitud = solicitud;
	}
}
