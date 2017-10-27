package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.EmpresaDao;
import com.atp.solicitudes.model.Empresa;
import com.objectwave.dao.utils.HibernateDaoTemplate;

public class EmpresaDaoHibernate extends HibernateDaoTemplate implements EmpresaDao
{
	private Criteria getCriteria()
	{
		return getSession().createCriteria(Empresa.class);
	}

	public Empresa getWithId(Integer id) throws Exception
	{
		Criteria criteria =  getCriteria();
		criteria.add(Restrictions.eq("id", id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<Empresa> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);		
	}
	
	public List<Empresa> getAll() throws Exception
	{
		Criteria criteria =  getCriteria();
		
		criteria.addOrder(Order.asc("nombre"));

		// get the collection
		@SuppressWarnings("unchecked")
		List<Empresa> col = criteria.list();

		return col;
	}
}
