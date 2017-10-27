package com.atp.solicitudes.model;

import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;

@JsonSerialize(using = EnumSerializer.class)
public enum DocumentoStatusEnum implements BasicEnum
{
	CARGADO("Cargado"),
	ERROR("Error"),
	VALIDADO("Validado"),
	CANCELADO("Cancelado"),
	INVALIDO("Invalido");
	
	public static final List<DocumentoStatusEnum> allValues;
	
	static
	{
		allValues = Arrays.asList(DocumentoStatusEnum.values());
	}
	
	private String name;
	
	DocumentoStatusEnum(String name)
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
	
	public static DocumentoStatusEnum withId(Integer id)
	{
		return values()[id];
	}
}
