package com.atp.solicitudes.dao.hibernate;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.LockOptions;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.DocumentoSolicitudDao;
import com.atp.solicitudes.model.DocumentoSolicitud;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.HibernateDaoTemplate;
import com.objectwave.model.GenericBlob;

public class DocumentoSolicitudDaoHibernate extends HibernateDaoTemplate implements DocumentoSolicitudDao
{
	private Criteria getCriteria()
	{
		return getSession().createCriteria(DocumentoSolicitud.class);
	}
	
	public DocumentoSolicitud getWithId(Integer id) throws Exception
	{
		Criteria criteria = getCriteria();

		criteria.add(Restrictions.eq("id", id));

		// get the collection
		@SuppressWarnings("unchecked")
		List<DocumentoSolicitud> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}
	
	public void save(DocumentoSolicitud object) throws Exception
	{
		getHibernateTemplate().saveOrUpdate(object);
	}
	
	public DaoResult<DocumentoSolicitud> query(DaoQuery query, DaoOrder order) throws Exception
	{
		Criteria criteria = getCriteria();
		
		String[] eqs = {"id", "solicitud", "user"};
		registerEqPaths(eqs, query, criteria);
		String[] likes = {"nameOnly"};
		registerFullLikePaths(likes, query, criteria);

		// create the result object
		DaoResult<DocumentoSolicitud> result = new DaoResult<DocumentoSolicitud>();
	
		// process it
		result.processWith(query, order, criteria);
		
		return result;
	}
	
	public GenericBlob getBlob(DocumentoSolicitud doc) throws Exception
	{
		getSession().buildLockRequest(LockOptions.NONE).lock(doc);

		GenericBlob blob = doc.getBlob();
		
		blob.getId();
		
		return blob;
	}
	
	public DocumentoSolicitud getWithUserId(User user) throws Exception
	{
		Criteria criteria = getCriteria();

		criteria.add(Restrictions.eq("user", user));

		// get the collection
		@SuppressWarnings("unchecked")
		List<DocumentoSolicitud> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}
	
	public DocumentoSolicitud getWithSolicitudId(Solicitud solicitud) throws Exception
	{
		Criteria criteria = getCriteria();

		criteria.add(Restrictions.eq("solicitud", solicitud));

		// get the collection
		@SuppressWarnings("unchecked")
		List<DocumentoSolicitud> col = criteria.list();

		// if no elements found, return null
		// otherwise, return the first object found
		if (col.size() == 0)
			return null;
		else
			return col.get(0);
	}
}
