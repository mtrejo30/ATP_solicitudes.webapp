package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.SolicitudComentarioDao;
import com.atp.solicitudes.model.SolicitudComentario;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.HibernateDaoTemplate;

public class SolicitudComentarioDaoHibernate extends HibernateDaoTemplate implements SolicitudComentarioDao
{
	/**
     * Method getCriteria.
     * 
     * Returns a Criteria object for the SolicitudComentario class.
     * 
     * @return Criteria
     */
	private Criteria getCriteria()
	{
		return getSession().createCriteria(SolicitudComentario.class);
	}

	public SolicitudComentario getWithId(Integer id) throws Exception
	{
		Criteria criteria = getCriteria();

		// restriction to query
		criteria.add(Restrictions.eq("id", id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<SolicitudComentario> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}

	public DaoResult<SolicitudComentario> query(DaoQuery query, DaoOrder order) throws Exception
	{
		Criteria criteria = getCriteria();

		String[] eqs = {"id", "solicitud"};
		registerEqPaths(eqs, query, criteria);

		// apply order
		order.applyToCriteria(criteria, query);

		// create the result object
		DaoResult<SolicitudComentario> result = new DaoResult<SolicitudComentario>();
	
		// process it
		result.processWith(query, criteria);

		return result;	
	}

	public void save(SolicitudComentario comentario)
	{
		getHibernateTemplate().saveOrUpdate(comentario);
	}
}
