package com.atp.solicitudes.model;

import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;
import com.objectwave.utils.ObjectWithIdResolver;

@JsonSerialize(using = EnumSerializer.class)
public enum OperationValidationStateEnum implements BasicEnum
{
	CARGADO("Cargado"),
	ERROR("Error"),
	VALIDADO("Validado"),
	CANCELADO("Cancelado");
	
	public static final List<OperationValidationStateEnum> allValues;
	static { allValues = Arrays.asList(OperationValidationStateEnum.values()); }
	
	public static OperationValidationStateEnum withId(Integer id)
	{
		return values()[id];
	}

	private String name;

	OperationValidationStateEnum(String name)
	{
		this.name = name;
	}
	
	public Integer getId()
	{
		return this.ordinal();
	}

	public String getName()
	{
		return name;
	}

	public static class IdResolver implements ObjectWithIdResolver
	{
		public Object getWithId(Integer id)
		{
			return OperationValidationStateEnum.withId(id);
		}
	}
}
