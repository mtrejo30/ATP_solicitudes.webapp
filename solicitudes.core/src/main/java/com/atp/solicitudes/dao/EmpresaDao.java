package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.Empresa;

public interface EmpresaDao
{
	Empresa getWithId(Integer id) throws Exception;
	List<Empresa> getAll() throws Exception;
}
