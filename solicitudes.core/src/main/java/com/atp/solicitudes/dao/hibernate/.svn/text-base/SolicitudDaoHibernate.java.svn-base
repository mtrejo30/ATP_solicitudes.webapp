package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.SolicitudDao;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.HibernateDaoTemplate;

public class SolicitudDaoHibernate extends HibernateDaoTemplate implements SolicitudDao
{
	private Criteria getCriteria()
	{
		return getSession().createCriteria(Solicitud.class);
	}
	
	public Solicitud getWithFolio(Integer folio) throws Exception
	{
		Criteria criteria = getCriteria();

		criteria.add(Restrictions.eq("folio", folio));

		// get the collection
		@SuppressWarnings("unchecked")
		List<Solicitud> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}
	
	public void save(Solicitud object) throws Exception
	{
		getHibernateTemplate().saveOrUpdate(object);
	}

	public DaoResult<Solicitud> query(DaoQuery query, DaoOrder order)
	{
		Criteria criteria = getCriteria();

//		String test= query.getFieldAliasFromPath("nbrField", getCriteria());
		query.applyFetchingToCriteria(criteria);
		 
		String[] eqs = {"folio", "status", "operationType", "user"};
		registerEqPaths(eqs, query, criteria);

		String[] likes = {"reference", "user.username"};
		registerFullLikePaths(likes, query, criteria);

		DaoResult<Solicitud> result = new DaoResult<Solicitud>();

		result.processWith(query, order, criteria);

		// return the result
		return result;
	}

	
	public User getUserFrom(Solicitud solicitud) throws Exception
	{
		// do a none lock on the object that contains the User
		getSession().buildLockRequest(LockOptions.NONE).lock(solicitud);
	
		// retrieve the User from the solicitud
		User obj = solicitud.getUser();
		
		// touch the proxy object so it gets the full contents of the User
		obj.getId();
		
		return obj;
	}
	
 
	public List<String> getColumnValues(String column, String match, int maxResults) throws Exception
	{
		Query query = getSession().createQuery("select distinct " + column + " from Solicitud where " + column + " like ? order by " + column + " asc");
		query.setString(0, match);
		
		if(maxResults != 0)
			query.setMaxResults(maxResults);
		
		@SuppressWarnings("unchecked")
		List<String> queryResult = query.list();
		
		return queryResult;
	}
	 

}
