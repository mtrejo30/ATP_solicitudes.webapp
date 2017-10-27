package com.atp.solicitudes.model;

import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;

@JsonSerialize(using = EnumSerializer.class)
public enum ReportAccessLevelEnum implements BasicEnum
{
	BASICO(1, "Basico"),
	MEDIO(2, "Medio"),
	AVANZADO(3, "Avanzado");
	
	public static final List<ReportAccessLevelEnum> allValues;
	
	static
	{
		allValues = Arrays.asList(ReportAccessLevelEnum.values());
	}
	
	private int id;
	private String name;
	
	ReportAccessLevelEnum(Integer id, String name)
	{
		this.id = id;
		this.name = name;
	}
	
	public Integer getId() 
	{
		return id;
	}
	
	public String getName()
	{
		return name;
	}
	
	public ReportAccessLevelEnum withId(Integer id)
	{
		return values()[id];
	}
}
