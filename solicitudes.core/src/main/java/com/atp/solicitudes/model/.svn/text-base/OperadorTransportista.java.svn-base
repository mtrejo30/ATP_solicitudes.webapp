package com.atp.solicitudes.model;

import java.io.Serializable;

public class OperadorTransportista implements Serializable
{
	public static final String SLOT_NAME = "operadorTransportista";

	private static final long serialVersionUID = 1L;

	private Integer gKey;
	private String name;
	private String cardId;

	public Integer getgKey()
	{
		return gKey;
	}

	public void setgKey(Integer gKey)
	{
		this.gKey = gKey;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getCardId()
	{
		return cardId;
	}

	public void setCardId(String cardId)
	{
		this.cardId = cardId;
	}

	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof OperadorTransportista))
			return false;

		OperadorTransportista realObject = (OperadorTransportista) anObject;

		return this.getgKey().equals(realObject.getgKey());
	}

	public int hashCode()
	{
		return getgKey();
	}

}
