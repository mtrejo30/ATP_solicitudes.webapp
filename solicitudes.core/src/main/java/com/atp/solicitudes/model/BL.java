package com.atp.solicitudes.model;

public class BL 
{ 
	private Integer id;

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

		if (!(anObject instanceof BL))
			return false;

		BL realObject = (BL) anObject;

		return this.getId().equals(realObject.getId());
	}
	
	public int hashCode()
	{
		return getId();
	}	
}
