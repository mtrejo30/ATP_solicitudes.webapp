package com.atp.solicitudes.model;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.objectwave.enumerator.BasicEnum;
import com.objectwave.enumerator.EnumSerializer;
import com.objectwave.utils.ObjectWithIdResolver;

@JsonSerialize(using = EnumSerializer.class)
public enum UserStatusEnum implements BasicEnum
{
	ACTIVE("Active"),
	DEACTIVATED("Inactive"),
	DELETED("Deleted");

	public static final UserStatusEnum[] validDisplayValues = { ACTIVE, DEACTIVATED};
	public static final UserStatusEnum[] allValues = { ACTIVE, DEACTIVATED, DELETED};
	
	public String name;

	UserStatusEnum (String s)
	{
		name = s;
	}

	public static UserStatusEnum withId(Integer id)
	{
		return values()[id];
	}

	public static List<UserStatusEnum> getAll()
	{
		List <UserStatusEnum> states = new ArrayList<UserStatusEnum>();
		
		for (UserStatusEnum state : allValues)
			states.add(state);

		return states;
	}
	
	public static List<UserStatusEnum> getValidDisplayValues()
	{
		List <UserStatusEnum> states = new ArrayList<UserStatusEnum>();
		
		for (UserStatusEnum state : validDisplayValues)
			states.add(state);

		return states;
	}

	public Integer getId()
	{
		return ordinal();
	}

	public String getName()
	{
		return name;
	}
	
	public static String getNameForId(Integer id)
	{
		return withId(id).getName();
	}
	
	public static class IdResolver implements ObjectWithIdResolver
	{
		public Object getWithId(Integer id)
		{
			return UserStatusEnum.withId(id);
		}
	}
}
