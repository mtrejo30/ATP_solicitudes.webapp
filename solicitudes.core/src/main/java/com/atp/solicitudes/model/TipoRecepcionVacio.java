package com.atp.solicitudes.model;

public class TipoRecepcionVacio
{
	private Integer id;
	private String nombre;

	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof TipoRecepcionVacio))
			return false;

		TipoRecepcionVacio realObject = (TipoRecepcionVacio) anObject;

		return this.getId().equals(realObject.getId());
	}

	public int hashCode()
	{
		return getId();
	}

	public String getNombre()
	{
		return nombre;
	}

	public void setNombre(String nombre)
	{
		this.nombre = nombre;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}
}
