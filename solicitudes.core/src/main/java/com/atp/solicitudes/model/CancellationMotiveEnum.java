package com.atp.solicitudes.model;

import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;

@JsonSerialize(using = EnumSerializer.class)
public enum CancellationMotiveEnum implements BasicEnum
{
        CAMBIODATOS("Cambio de datos relevantes"),
		REPROGRAMACION("Reprogramaci�n"),
		CANCELACIONSERVICIO("Cancelaci�n de Servicio");

        public static final List<CancellationMotiveEnum> allValues;
    	
    	static
    	{
    		allValues = Arrays.asList(CancellationMotiveEnum.values());
    	}
    	
    	private String name;
    	
    	CancellationMotiveEnum(String name)
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
    	
    	public static CancellationMotiveEnum withId(Integer id)
    	{
    		return values()[id];
    	}

}
