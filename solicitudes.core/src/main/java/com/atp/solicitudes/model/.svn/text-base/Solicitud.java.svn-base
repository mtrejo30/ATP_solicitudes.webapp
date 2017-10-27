package com.atp.solicitudes.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.objectwave.exception.DomainModelException;
import com.objectwave.logger.ActivityLogAppender;

@Entity
@Table(name="solicitud")
public class Solicitud implements Serializable, ActivityLogAppender
{
	private static final long serialVersionUID	=  1L;
	
	public static final String SLOT_NAME = "solicitud";

	public static final int REFERENCE_LENGTH 	= 100;
	public static final int AGENCIA_ADUANAL_ID_LENGTH 	= 10;
	public static final int CLIENTE_ID_LENGTH  	= 10;
	public static final int CODIGO_ID_LENGTH  	= 10;
	public static final int PLACAS_LENGTH  	= 10;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private Integer folio;
	
	@Column(name = "reference", nullable = false, length = REFERENCE_LENGTH)
	private String reference;
	
	@JsonIgnore
	@Column(name = "operation_type", nullable = false)
	private SolicitudOperationTypeEnum operationType;
	
	@Column(name = "status", nullable = false)
	private OperationValidationStateEnum status; 

	@Column(name = "date_created", nullable = false)
	private Date dateCreated; 

	@Column(name = "date_updated", nullable = false)
	private Date dateUpdated; 
	
	@Column(name = "agencia_aduanal_id", nullable = true)
	private Integer  agenciaAduanalId;
	
	@Column(name = "cliente_id", nullable = true)
	private Integer clienteId;

	@Column(name= "paquete_id", nullable = true, length = CODIGO_ID_LENGTH)
	private Integer codigoId;

	
	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.SELECT)
	@JoinColumn(name = "user_id", nullable = false)
	@JsonIgnore
	private User user;
	
	@Column(name= "recinto", nullable = true)
	private String recinto;
	
	public Solicitud()
	{
		
	}
			
	public Integer getFolio()
	{
		return folio;
	}
	
	public void setFolio(Integer folio)
	{
		this.folio = folio;
	}
	
	public String getReference()
	{
		return reference;
	}
	
	public void setReference(String reference)
	{
		this.reference = reference;
	}
	
	public SolicitudOperationTypeEnum getOperationType()
	{
		return operationType;
	}

	public void setOperationType(SolicitudOperationTypeEnum operationType)
	{
		this.operationType = operationType;
	}

	public OperationValidationStateEnum getStatus()
	{
		return status;
	}

	public void setStatus(OperationValidationStateEnum status)
	{
		this.status = status;
	}

	public Date getDateCreated()
	{
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated)
	{
		this.dateCreated = dateCreated;
	}

	public Date getDateUpdated()
	{
		return dateUpdated;
	}

	public void setDateUpdated(Date dateUpdated)
	{
		this.dateUpdated = dateUpdated;
	}

	public Integer getAgentId()
	{
		return agenciaAduanalId;
	}

	public void setAgentId(Integer agenciaAduanalId)
	{
		this.agenciaAduanalId = agenciaAduanalId;
	}

	public Integer getClienteId()
	{
		return clienteId;
	}

	public void setClienteId(Integer clienteId)
	{
		this.clienteId = clienteId;
	}

	public User getUser()
	{
		return user;
	}

	public void setUser(User user)
	{
		this.user = user;
	}
	
	public Integer getCodigoId()
	{
		return codigoId;
	}

	public void setCodigoId(Integer codigoId)
	{
		this.codigoId = codigoId;
	}

	public boolean canBeEditedByStatus()
	{
		return OperationValidationStateEnum.VALIDADO.equals(status);
	}

	public boolean isCanceledOrValidated()
	{
		return status == OperationValidationStateEnum.VALIDADO ||
					status == OperationValidationStateEnum.CANCELADO;
	}
	
	@Override
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof Solicitud))
			return false;

		Solicitud realObject = (Solicitud) anObject;

		return this.getFolio().equals(realObject.getFolio());
	}

	@Override
	public int hashCode()
	{
		return getFolio();
	}
	
	public void fillFrom(JsonNode node, Map<String,Object> context) throws DomainModelException, Exception
	{
		String info = node.get("reference").asText();
		if (info.length() == 0)
			throw new DomainModelException("Solicitud_must_have_a_reference");
		setReference(info);

		setOperationType(SolicitudOperationTypeEnum.withId(node.get("operationTypeId").asInt()));

		info = node.get("agenciaAduanalName").asText();
		if (info.length() == 0)
			throw new DomainModelException("Solicitud_must_have_a_custom_agency");
		setAgentId(node.get("agenciaAduanalId").asInt());

		info = node.get("clienteName").asText();
		if (info.length() == 0)
			throw new DomainModelException("Solicitud_must_have_a_custom_client");
		setClienteId(node.get("clienteId").asInt());
		
		// allow null codigo if not captured
		info = node.get("codigoName").asText();
		if (info.length() == 0)
			setCodigoId(null);
		else
			setCodigoId(node.get("codigoId").asInt());
	}


	
	public void appendToActivityLog(StringBuilder builder)
	{
		builder.append("folio=");
		builder.append(getFolio());
		builder.append(",operation=");
		builder.append(getOperationType());
		builder.append(",status=");
		builder.append(getStatus());
		builder.append(",ref=");
		builder.append(getReference());				
	}

	@JsonProperty
	public Integer getOperationTypeId()
	{
		return getOperationType().getId();
	}

	public Integer getAgenciaAduanalId()
	{
		return agenciaAduanalId;
	}

	public void setAgenciaAduanalId(Integer agenciaAduanalId)
	{
		this.agenciaAduanalId = agenciaAduanalId;
	}

	public String getRecinto()
	{
		return recinto;
	}

	public void setRecinto(String recinto)
	{
		this.recinto = recinto;
	}
}
