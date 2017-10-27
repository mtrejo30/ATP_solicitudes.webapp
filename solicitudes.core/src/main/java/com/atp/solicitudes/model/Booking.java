package com.atp.solicitudes.model;

public class Booking 
{ 
	private Integer id;

	private String nombre;
	private String linea;
	private String pod;
	private String podName;
	private String fpod;
	private String fpodName;
	private String fk;
	private String buqueViaje;
	private String buqueViajeNombre;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	} 
	
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof Booking))
			return false;

		Booking realObject = (Booking) anObject;

		return this.getId().equals(realObject.getId());
	}
	
	public int hashCode()
	{
		return getId();
	}

	public String getPod()
	{
		return pod;
	}

	public void setPod(String pod)
	{
		this.pod = pod;
	}

	public String getPodName()
	{
		return podName;
	}

	public void setPodName(String podName)
	{
		this.podName = podName;
	}

	public String getFpod()
	{
		return fpod;
	}

	public void setFpod(String fpod)
	{
		this.fpod = fpod;
	}

	public String getFpodName()
	{
		return fpodName;
	}

	public void setFpodName(String fpodName)
	{
		this.fpodName = fpodName;
	}

	public String getFk()
	{
		return fk;
	}

	public void setFk(String fk)
	{
		this.fk = fk;
	}

	public String getNombre()
	{
		return nombre;
	}

	public void setNombre(String nombre)
	{
		this.nombre = nombre;
	}

	public String getBuqueViaje()
	{
		return buqueViaje;
	}

	public void setBuqueViaje(String buqueViaje)
	{
		this.buqueViaje = buqueViaje;
	}

	public String getBuqueViajeNombre()
	{
		return buqueViajeNombre;
	}

	public void setBuqueViajeNombre(String buqueViajeNombre)
	{
		this.buqueViajeNombre = buqueViajeNombre;
	}

	public String getLinea()
	{
		return linea;
	}

	public void setLinea(String linea)
	{
		this.linea = linea;
	}	
}
