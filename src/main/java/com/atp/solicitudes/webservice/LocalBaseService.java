package com.atp.solicitudes.webservice;

import com.atp.solicitudes.manager.DomainManager;
import com.objectwave.webservice.BaseService;

public class LocalBaseService extends BaseService
{
	public DomainManager getDomainManager()
	{
		return (DomainManager) getBean(DomainManager.BEAN_NAME);
	}
}
