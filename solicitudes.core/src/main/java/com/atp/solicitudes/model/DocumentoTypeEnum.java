package com.atp.solicitudes.model;

import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;

@JsonSerialize(using = EnumSerializer.class)
public enum DocumentoTypeEnum implements BasicEnum
{
	BL("BL"),
	PEDIMENTO("Pedimento"),
	PARTEII("Parte II"),
	OFICIO("Oficio"),
	CARTA("Otros");
	
	public static final List<DocumentoTypeEnum> allValues;
	
	static
	{
		allValues = Arrays.asList(DocumentoTypeEnum.values());
	}						
	
	private String name;
	
	DocumentoTypeEnum(String name)
	{	
		this.name = name;
	}
	
	public Integer getId()
	{
		return this.ordinal();
	}		
	
	public String getName()
	{
		return this.name;
	}
	
	public static DocumentoTypeEnum withId(Integer id) 
	{
		return DocumentoTypeEnum.values()[id];
	}
	
}
