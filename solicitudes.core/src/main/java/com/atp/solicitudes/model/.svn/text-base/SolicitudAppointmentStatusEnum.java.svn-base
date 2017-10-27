package com.atp.solicitudes.model;

import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;

@JsonSerialize(using = EnumSerializer.class)
public enum SolicitudAppointmentStatusEnum implements BasicEnum
{
	CREATED("Creado"),
	CANCELED("Cancelado"),
	CLOSED("Cerrado"),
	USED("Utilizado"),
	USEDLATE("Utilizado Tardío");
	
	public static final List<SolicitudAppointmentStatusEnum> allValues;
	
	static
	{
		allValues = Arrays.asList(SolicitudAppointmentStatusEnum.values());
	}
	
	private String name;
	
	SolicitudAppointmentStatusEnum(String name)
	{
		this.name = name;
	}
	
	public Integer getId() 
	{
		return ordinal();
	}
	
	public String getName()
	{
		return name;
	}
	
	public static SolicitudAppointmentStatusEnum withId(Integer id)
	{
		return values()[id];
	}
}
