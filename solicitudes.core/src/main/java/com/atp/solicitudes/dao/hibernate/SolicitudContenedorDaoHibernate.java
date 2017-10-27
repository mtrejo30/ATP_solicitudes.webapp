package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.SolicitudContenedorDao;
import com.atp.solicitudes.model.Holiday;
import com.atp.solicitudes.model.SolicitudContenedor;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.HibernateDaoTemplate;

public class SolicitudContenedorDaoHibernate extends HibernateDaoTemplate implements SolicitudContenedorDao{

	public Criteria getCriteria(){
		return getSession().createCriteria(SolicitudContenedor.class);
	}
	
	public SolicitudContenedor getWithId(Integer id){
		Criteria criteria = getCriteria();

		// restriction to query
		criteria.add(Restrictions.eq("id", id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<SolicitudContenedor> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}
	
	public DaoResult<SolicitudContenedor> query(DaoQuery query, DaoOrder order){
		Criteria criteria = getCriteria();

		String[] eqs = {"id", "solicitud"};
		registerEqPaths(eqs, query, criteria);

		// apply order
		order.applyToCriteria(criteria, query);

		// create the result object
		DaoResult<SolicitudContenedor> result = new DaoResult<SolicitudContenedor>();
	
		// process it
		result.processWith(query, criteria);

		return result;	
	}
	
	public void save(SolicitudContenedor contenedor)
	{
		getHibernateTemplate().saveOrUpdate(contenedor);
	}
	
	public void delete(SolicitudContenedor contenedor)
	{
		getHibernateTemplate().delete(contenedor);
	}	
	
	public void update(SolicitudContenedor contenedor)
	{
		getHibernateTemplate().update(contenedor);
	}	
}
