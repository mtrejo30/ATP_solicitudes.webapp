package com.atp.solicitudes.model;

import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;
import com.objectwave.utils.ObjectWithIdResolver;

@JsonSerialize(using = EnumSerializer.class)
public enum SolicitudOperationTypeEnum implements BasicEnum
{
	IMPO("Entrega de Importación", "DI", "impo", 2),
	EXPO("Recepción de Exportación", "RE", "expo", 2),
	ENTREGA_VACIO("Entrega de Vacío", "DM", "entrega-vacio", 4),
	RECEPCION_VACIO("Recepción de Vacío", "RM", "recepcion-vacio", 4),
	DESISTIMIENTO("Entrega de Exportación", "DE", "desistimiento", 2);

	public static final List<SolicitudOperationTypeEnum> allValues;
	static { allValues = Arrays.asList(SolicitudOperationTypeEnum.values()); }

	public static SolicitudOperationTypeEnum withId(Integer id)
	{
		return values()[id];
	}

	private String name;
	private String view;
	private String tranType; 
	private Integer maxContainers;

	SolicitudOperationTypeEnum(String name, String tranType, String view, Integer maxContainers)
	{
		this.name = name;
		this.tranType = tranType;
		this.view = view;
		this.maxContainers = maxContainers;
	}
	
	public Integer getId()
	{
		return this.ordinal();
	}

	public String getTranType()
	{
		return tranType;
	}

	public String getName()
	{
		return name;
	}
	
	public String getView()
	{
		return view;
	}

	public static class IdResolver implements ObjectWithIdResolver
	{
		public Object getWithId(Integer id)
		{
			return SolicitudOperationTypeEnum.withId(id);
		}
	}

	public Integer getMaxContainers()
	{
		return maxContainers;
	}
}
