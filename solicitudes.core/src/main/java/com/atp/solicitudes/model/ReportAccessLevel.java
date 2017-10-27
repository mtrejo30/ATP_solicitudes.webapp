package com.atp.solicitudes.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.objectwave.utils.ObjectWithIdResolver;

@Entity
@Table(name = "report_access_level")
public class ReportAccessLevel implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	public static final String BASIC    = "BASIC";		
	public static final String MEDIUM   = "MEDIUM";		
	public static final String ADVANCED = "ADVANCED";		
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private Integer id;

	@Column(name = "name", nullable = false, length=50)
	String name;
	
	@Column(name = "code", nullable = false, length=10)
	String code;

	public ReportAccessLevel()
	{
		
	}
	
	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}
	
	public String getName()
	{
		return name;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public String getCode() 
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}
	
	@Override
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof ReportAccessLevel))
			return false;

		ReportAccessLevel realObject = (ReportAccessLevel) anObject;

		return this.getId().equals(realObject.getId());
	}

	@Override
	public int hashCode()
	{
		return getId();
	}
	
	public static class IdResolver implements ObjectWithIdResolver
	{
		public Object getWithId(Integer id)
		{
			ReportAccessLevel reportAccessLevel = new ReportAccessLevel();
			reportAccessLevel.setId(id);
			return reportAccessLevel;
		}
	}
	
}
