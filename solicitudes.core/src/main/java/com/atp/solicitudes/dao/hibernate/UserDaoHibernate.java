package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.UserDao;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserStatusEnum;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.HibernateDaoTemplate;

public class UserDaoHibernate extends HibernateDaoTemplate implements UserDao
{
	/*
	 * Proper criteria for object
	 */
	private Criteria getCriteria()
	{
		return getSession().createCriteria(User.class);
	}
	
	public User getWithId(Integer id)
	{
		Criteria criteria =  getCriteria();
		// restriction for not including logic deleted users 
		criteria.add(Restrictions.ne("status", UserStatusEnum.DELETED));

		// restriction to query by user name
		criteria.add(Restrictions.eq("id", id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<User> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}

	public User getWithUsername(String username)
	{
		Criteria criteria =  getCriteria();
		// restriction for not including logic deleted users 
		criteria.add(Restrictions.ne("status", UserStatusEnum.DELETED));
		
		// restriction to query by user name
		criteria.add(Restrictions.eq("username", username));

		// get the collection
		@SuppressWarnings("unchecked")
		List<User> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}
	
	public User getWithEmail(String email)
	{
		Criteria criteria =  getCriteria();
		// restriction for not including logic deleted users 
		criteria.add(Restrictions.ne("status", UserStatusEnum.DELETED));

		// restriction to query by user name
		criteria.add(Restrictions.eq("email", email));

		// get the collection
		@SuppressWarnings("unchecked")
		List<User> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}	
	
	public User getWithUserN4(Integer userN4_Id)
	{
		Criteria criteria =  getCriteria();
		// restriction for not including logic deleted users 
		criteria.add(Restrictions.ne("status", UserStatusEnum.DELETED));

		// restriction to query by user name
		criteria.add(Restrictions.eq("userN4_Id", userN4_Id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<User> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}	
	
	public void save(User user) throws Exception
	{
		getHibernateTemplate().saveOrUpdate(user);
	}
	
	// Soft delete, user status is changed to Deleted
	public void delete(User user)
	{
		user.setStatus(UserStatusEnum.DELETED);
		getHibernateTemplate().saveOrUpdate(user);
	}	
	
	public DaoResult<User> query(DaoQuery query, DaoOrder order)
	{
		Criteria criteria = getCriteria();

		criteria.add(Restrictions.ne("status", UserStatusEnum.DELETED));

		String[] eqs = {"id", "status", "profile"};
		registerEqPaths(eqs, query, criteria);

		String[] likes = {"username", "email"};
		registerLikePaths(likes, query, criteria);

		DaoResult<User> result = new DaoResult<User>();

		result.processWith(query, order, criteria);

		// return the result
		return result;
	}
	
	public List<String> getColumnPropertyValues(String column, String match, int maxResults) throws Exception
	{
		Query query = getSession().createQuery("select distinct p." + column + " from User p where p." + column + " like ? order by p." + column);
		query.setString(0, match);
		
		if(maxResults != 0)
			query.setMaxResults(maxResults);
		
		@SuppressWarnings("unchecked")
		List<String> queryResult = query.list();
		
		return queryResult;
	}	
}
