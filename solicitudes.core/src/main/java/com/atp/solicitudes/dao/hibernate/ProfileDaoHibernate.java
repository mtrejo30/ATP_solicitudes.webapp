package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.atp.solicitudes.dao.ProfileDao;
import com.atp.solicitudes.model.Profile;

public class ProfileDaoHibernate extends HibernateDaoSupport implements ProfileDao 
{

	private Criteria getCriteria()
	{
		return getSession().createCriteria(Profile.class);
	}

	public Profile getWithId(Integer id)
	{
		Criteria criteria =  getCriteria();
		// restriction for not including logic deleted users 
		//criteria.add(Restrictions.ne("status", UserStatusEnum.DELETED));

		// restriction to query by profile id
		criteria.add(Restrictions.eq("id", id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<Profile> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}

	@SuppressWarnings("unchecked")
	public List<Profile> getAllProfiles() throws Exception
	{
		Criteria criteria = getCriteria();
		//criteria.add(Restrictions.ne("status", Project.DELETED));
		return criteria.list();		
	}
	
}
