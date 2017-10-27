package com.atp.solicitudes.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.objectwave.logger.ActivityLogAppender;
import com.objectwave.model.GenericBlob;

@Entity
@Table(name = "documento_solicitud")
public class DocumentoSolicitud implements Serializable, ActivityLogAppender
{ 	
	private static final long serialVersionUID 		=  1L;

	public static final int NAME_MIN_LENGTH 		=   3;
	public static final int NAME_MAX_LENGTH 		= 255;
	public static final int DESCRIPTION_MIN_LENGTH	= 	3;
	public static final int DESCRIPTION_MAX_LENGTH	= 255;	
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private Integer id;
	
	@Column(name = "document_type", nullable = false)
	private DocumentoTypeEnum type;

	@Column(name = "clave", nullable = false, length = NAME_MAX_LENGTH)
	private String clave;
	
	@Column(name = "file_name", nullable = false, length = NAME_MAX_LENGTH)
	private String fileName;
	
	@Column(name = "document_status", nullable = false)
	private DocumentoStatusEnum status;

	@Column(name = "date", nullable = false)
	private Date dateUpload;
		
	@Column(name = "content_type", nullable = true, length = NAME_MAX_LENGTH)
	private String contentType;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@Fetch(value = FetchMode.SELECT)
	@JoinColumn(name = "blob_id", nullable = false)
	private GenericBlob blob;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@Fetch(value = FetchMode.SELECT)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@Fetch(value = FetchMode.SELECT)
	@JoinColumn(name = "solicitud_id", nullable = false)
	private Solicitud solicitud;		
	
	public DocumentoSolicitud()
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
	
	public DocumentoTypeEnum getType()
	{
		return type;
	}

	public void setType(DocumentoTypeEnum documentType)
	{
		this.type = documentType;
	}

	public String getClave()
	{
		return clave;
	}

	public void setClave(String clave)
	{
		this.clave = clave;
	}

	public String getFileName()
	{
		return fileName;
	}

	public void setFileName(String fileName)
	{
		this.fileName = fileName;
	}

	public DocumentoStatusEnum getStatus()
	{
		return status;
	}

	public void setStatus(DocumentoStatusEnum documentStatus)
	{
		this.status = documentStatus;
	}
	
	public Date getDateUpload()
	{
		return dateUpload;
	}

	public void setDateUpload(Date dateUpload)
	{
		this.dateUpload = dateUpload;
	}

	public String getContentType()
	{
		return contentType;
	}

	public void setContentType(String contentType)
	{
		this.contentType = contentType;
	}

	public GenericBlob getBlob()
	{
		return blob;
	}

	public void setBlob(GenericBlob blob)
	{
		this.blob = blob;
	}

	public User getUser()
	{
		return user;
	}

	public void setUser(User user)
	{
		this.user = user;
	}

	public Solicitud getSolicitud()
	{
		return solicitud;
	}

	public void setSolicitud(Solicitud solicitud)
	{
		this.solicitud = solicitud;
	}

	@Override
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof DocumentoSolicitud))
			return false;

		DocumentoSolicitud realObject = (DocumentoSolicitud) anObject;

		return this.getId().equals(realObject.getId());
	}
	
	@Override
	public int hashCode()
	{
		return getId();
	}	
	
	public void appendToActivityLog(StringBuilder builder)
	{						
		builder.append("id=");
		builder.append(getId());
		builder.append(",sol=");
		builder.append(getSolicitud().getFolio());
		builder.append(",type=");
		builder.append(getType());
		builder.append(",clave=");
		builder.append(getClave());
		builder.append(",name=");
		builder.append(getFileName());
		builder.append(",status=");
		builder.append(getStatus());
	}
}
