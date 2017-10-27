package com.atp.solicitudes.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.JsonNode;

@Entity
@Table(name = "holiday")
public class Holiday implements Serializable
{
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private Integer id;

	@Column(name = "name", nullable = false, length=50)
	String name;
	
	@Column(name = "date", nullable = false)
	Date date;
	
	public Holiday()
	{
		
	}
	
	@Override
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof Holiday))
			return false;

		Holiday realObject = (Holiday) anObject;

		return this.getId().equals(realObject.getId());
	}
	
	@Override
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

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public Date getDate()
	{
		return date;
	}

	public void setDate(Date date)
	{
		this.date = date;
	}
	
	public boolean isPersistent()
	{
		return getId() != null;
	}
	
//	public static class IdResolver implements ObjectWithIdResolver
//	{
//		public Object getWithId(Integer id)
//		{
//			Holiday holiday = new Holiday();
//			holiday.setId(id);
//			return holiday;
//		}
//	}
	
	public void fillFrom(JsonNode node, Map<String,Object> context) throws Exception
	{
		setName(node.get("name").asText());
		
		SimpleDateFormat formatter = (SimpleDateFormat) context.get("dateFormatter");
		setDate(formatter.parse(node.get("date").asText()));			
	}

}
