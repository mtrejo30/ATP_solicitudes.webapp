package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.HolidayDao;
import com.atp.solicitudes.model.Holiday;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.HibernateDaoTemplate;

public class HolidayDaoHibernate extends HibernateDaoTemplate implements HolidayDao
{

	private Criteria getCriteria()
	{
		return getSession().createCriteria(Holiday.class);
	}
	
	public Holiday getWithId(Integer id) throws Exception
	{
		Criteria criteria =  getCriteria();		
		// restriction to query by holiday id
		criteria.add(Restrictions.eq("id", id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<Holiday> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);		
	}

	public Holiday getWithName(String name) throws Exception
	{
		Criteria criteria =  getCriteria();		
		// restriction to query by holiday name
		criteria.add(Restrictions.eq("name", name));

		// get the collection
		@SuppressWarnings("unchecked")
		List<Holiday> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}

	@SuppressWarnings("unchecked")
	public List<Holiday> getAll() throws Exception
	{		
		return getCriteria().list();				
	}
	
	public DaoResult<Holiday> query(DaoQuery query, DaoOrder order) throws Exception
	{
		Criteria criteria = getCriteria();

		String[] likes = {"name"};
		registerLikePaths(likes, query, criteria);

		String[] eqs = {"id"};
		registerEqPaths(eqs, query, criteria);

		DaoResult<Holiday> result = new DaoResult<Holiday>();

		result.processWith(query, order, criteria);

		// return the result
		return result;
	}
	
	public void save(Holiday holiday) throws Exception
	{
		getHibernateTemplate().saveOrUpdate(holiday);
	}
	
	public void delete(Holiday holiday)
	{
		getHibernateTemplate().delete(holiday);
	}	
}
