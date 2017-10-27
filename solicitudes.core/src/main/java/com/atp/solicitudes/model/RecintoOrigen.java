package com.atp.solicitudes.model;

public class RecintoOrigen 
{ 
	private String recinto;
	private String descripcion;

	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof RecintoOrigen))
			return false;

		RecintoOrigen realObject = (RecintoOrigen) anObject;

		return this.getRecinto().equals(realObject.getRecinto());
	}
	
	public int hashCode()
	{
		return getRecinto().hashCode();
	}

	public String getRecinto()
	{
		return recinto;
	}

	public void setRecinto(String recinto)
	{
		this.recinto = recinto;
	}

	public String getDescripcion()
	{
		return descripcion;
	}

	public void setDescripcion(String descripcion)
	{
		this.descripcion = descripcion;
	}
}
