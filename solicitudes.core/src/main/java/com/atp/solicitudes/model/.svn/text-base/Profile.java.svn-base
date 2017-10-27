package com.atp.solicitudes.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.objectwave.utils.ObjectWithIdResolver;

@Entity
@Table(name = "profile")
public class Profile implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	/** Terminal Administrador **/
	public static final String TA  =  "TA";		
	/** Terminal Interno **/
	public static final String TI  =  "TI";		
	/** Linea Naviera **/
	public static final String LN  =  "LN";		
	/** Agencia Aduanal **/
	public static final String AA  =  "AA";		
	/** Recintos Fiscalizados ***/
	public static final String RF  =  "RF";		
	/** Cliente **/
	public static final String CLI = "CLI";		
	/** Transportista **/
	public static final String TRA = "TRA";		
	/** Depositos **/
	public static final String DEP = "DEP";		
	/** Consultas **/
	public static final String CON = "CON";		
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private Integer id;

	@Column(name = "name", nullable = false, length=50)
	String name;
	
	@Column(name = "code", nullable = false, length=10)
	String code;
	
	public Profile()
	{
		
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
	
	public String getCode() 
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}
	
	public boolean isTerminalAdministrador()
	{
		return code.equals(Profile.TA);
	}
	
	public boolean isTerminalInterno()
	{
		return code.equals(Profile.TI);
	}
	
	public boolean isLineaNaviera()
	{
		return code.equals(Profile.LN);
	}
	
	public boolean isAgenciaAduanal()
	{
		return code.equals(Profile.AA);
	}
		
	public boolean isCliente()
	{
		return code.equals(Profile.CLI);
	}
	
	public boolean isTransportista()
	{
		return code.equals(Profile.TRA);
	}
	
	public boolean isRecintosFiscalizados()
	{
		return code.equals(Profile.RF);
	}
	
	public boolean isDepositos()
	{
		return code.equals(Profile.DEP);		
	}
	
	public boolean isConsultas()
	{
		return code.equals(Profile.CON);
	}
	
	@Override
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof Profile))
			return false;

		Profile realObject = (Profile) anObject;

		return this.getId().equals(realObject.getId());
	}

	@Override
	public int hashCode()
	{
		return getId();
	}
	
	public static class IdResolver implements ObjectWithIdResolver
	{
		public Object getWithId(Integer id)
		{
			Profile newProfile = new Profile();
			newProfile.setId(id);
			return newProfile;
		}
	}
}
