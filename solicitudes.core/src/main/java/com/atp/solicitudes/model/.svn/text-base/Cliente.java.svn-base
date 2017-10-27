package com.atp.solicitudes.model;

import java.io.Serializable;

public class Cliente implements Serializable
{
	public static final String SLOT_NAME = "cliente";

	private static final long serialVersionUID = 1L;

	private Integer id;
	private String nombre;
	private String custid;

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

	public String getCustid()
	{
		return custid;
	}

	public void setCustid(String custid)
	{
		this.custid = custid;
	}

	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof Cliente))
			return false;

		Cliente realObject = (Cliente) anObject;

		return this.getId().equals(realObject.getId());
	}

	public int hashCode()
	{
		return getId();
	}

}
