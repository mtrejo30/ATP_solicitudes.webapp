package com.atp.solicitudes.model;

import java.io.Serializable;

public class Transportista implements Serializable
{
	public static final String SLOT_NAME = "transportista";

	private static final long serialVersionUID = 1L;

	private Integer id;
	private String nombre;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getNombre()
	{
		return nombre;
	}

	public void setNombre(String nombre)
	{
		this.nombre = nombre;
	}

	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof Transportista))
			return false;

		Transportista realObject = (Transportista) anObject;

		return this.getId().equals(realObject.getId());
	}

	public int hashCode()
	{
		return getId();
	}

}
