package com.atp.solicitudes.forms;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.atp.solicitudes.model.DocumentoSolicitud;

public class UserDocumentForm
{
	public static final String MODEL_NAME = "userDocumentForm";

	@NotEmpty
	@Size(min = DocumentoSolicitud.NAME_MIN_LENGTH, max = DocumentoSolicitud.NAME_MAX_LENGTH) 
	private String clave;
	
	@NotNull
	private Integer type;
	
	private MultipartFile file;
	
	public String getClave()
	{
		return clave;
	}

	public void setClave(String clave)
	{
		this.clave = clave;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public MultipartFile getFile()
	{
		return file;
	}

	public void setFile(MultipartFile file)
	{
		this.file = file;
	}
}
