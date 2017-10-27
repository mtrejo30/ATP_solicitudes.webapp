package com.atp.solicitudes.model;

import org.codehaus.jackson.annotate.JsonProperty;

public class BookingItem 
{ 
	private Integer id;
	private Integer bookingGKey;

	private String typeIso;
	private String cmdy;
	private Double tempRequired;
	private Integer isDim;
	private Integer hzrdGKey;
	private String grade;
	private String imos;
	private Integer marinePollutants;
	private String undgField;
 

	

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

		if (!(anObject instanceof BookingItem))
			return false;

		BookingItem realObject = (BookingItem) anObject;

		return this.getId().equals(realObject.getId());
	}
	
	public int hashCode()
	{
		return getId();
	}

	@JsonProperty
	public Boolean getRequireConnection()
	{
		return getTempRequired() != null;
	}

	@JsonProperty
	public Boolean getHasMarinePollutants()
	{
		return getMarinePollutants() != null && getMarinePollutants() > 0;
	}

	@JsonProperty
	public Boolean getHasHazard()
	{
		return getHzrdGKey() != null && !(Integer.valueOf(0)).equals(getHzrdGKey());
	}
	
	@JsonProperty
	public Boolean getHasDimensions()
	{
		return getIsDim() != null && Integer.valueOf(getIsDim()).equals(1);
	}

	public String getTypeIso()
	{
		return typeIso;
	}

	public void setTypeIso(String typeIso)
	{
		this.typeIso = typeIso;
	}

	public String getCmdy()
	{
		return cmdy;
	}

	public void setCmdy(String cmdy)
	{
		this.cmdy = cmdy;
	}

	public Double getTempRequired()
	{
		return tempRequired;
	}

	public void setTempRequired(Double tempRequired)
	{
		this.tempRequired = tempRequired;
	}

	public Integer getIsDim()
	{
		return isDim;
	}

	public void setIsDim(Integer isDim)
	{
		this.isDim = isDim;
	}

	public Integer getBookingGKey()
	{
		return bookingGKey;
	}

	public void setBookingGKey(Integer bookingGKey)
	{
		this.bookingGKey = bookingGKey;
	}

	public Integer getHzrdGKey()
	{
		return hzrdGKey;
	}

	public void setHzrdGKey(Integer hzrdGKey)
	{
		this.hzrdGKey = hzrdGKey;
	}

	public String getGrade()
	{
		return grade;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}

	public String getImos()
	{
		return imos;
	}

	public void setImos(String imos)
	{
		this.imos = imos;
	}

	public Integer getMarinePollutants()
	{
		return marinePollutants;
	}

	public void setMarinePollutants(Integer marinePolutants)
	{
		this.marinePollutants = marinePolutants;
	}
	
	public String getUndgField() {
		return undgField;
	}

	public void setUndgField(String undgField) {
		this.undgField = undgField;
	}
}
