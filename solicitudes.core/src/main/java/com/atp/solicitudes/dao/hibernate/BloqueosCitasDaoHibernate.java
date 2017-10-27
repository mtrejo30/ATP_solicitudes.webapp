package com.atp.solicitudes.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

import com.atp.solicitudes.dao.BloqueosCitasDao;
import com.atp.solicitudes.dao.UserTransportistasDao;
import com.atp.solicitudes.model.Bloqueos;
import com.atp.solicitudes.model.Contenedor;
import com.atp.solicitudes.model.Holiday;
import com.atp.solicitudes.model.SolicitudContenedor;
import com.atp.solicitudes.model.UserTransportistas;
import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.dao.utils.HibernateDaoTemplate;
import com.objectwave.utils.SimpleEntry;

public class BloqueosCitasDaoHibernate extends HibernateDaoTemplate implements BloqueosCitasDao{
	public Criteria getCriteria(){
		return getSession().createCriteria(Bloqueos.class);
	}
	


	
	/*
	public DaoResult<Bloqueos> query(DaoQuery query, DaoOrder order) throws Exception
	{
		Criteria criteria = getCriteria();

		String[] likes = {"id_bloqueo"};
		registerLikePaths(likes, query, criteria);

		String[] eqs = {"Tipo_Movimientos"};
		registerEqPaths(eqs, query, criteria);

		DaoResult<Bloqueos> result = new DaoResult<Bloqueos>();

		result.processWith(query, order, criteria);

		// return the result
		return result;
	}*/

	public List<Bloqueos> query()
	{
		Query query = getSession().createQuery("select model.id,model.Tipo_Movimiento,model.nombre_agencia_excluir,model.nombre_cliente_excluir,model.lineas,model.Tipo_contendor, model.mensaje,model.fecha_creacion,model.fecha_desactivacion from Bloqueos as model" );
		@SuppressWarnings("unchecked")
		List<Bloqueos> queryResult = (List<Bloqueos>)query.list();
		return queryResult;	
	}

	public ArrayList<Bloqueos> getBloqueosStatus(String strtipo) 
	{
		Query query = getSession().createQuery("select model.id,model.Tipo_Movimiento,model.id_agencia_excluir,model.id_cliente_excluir,model.lineas,model.Tipo_contendor, model.mensaje,model.fecha_creacion,model.fecha_desactivacion from Bloqueos as model where model.Tipo_Movimiento='"+strtipo+"'");
		@SuppressWarnings("unchecked")
		ArrayList<Bloqueos> queryResult = (ArrayList<Bloqueos>)query.list();
					return queryResult;	
	}

	public ArrayList<Bloqueos> getBloqueosStatushabilitar(String strtipo,String strtipo2,String s) 
	{
		Query query = getSession().createQuery("select model.id,model.Tipo_Movimiento,model.id_agencia_excluir,model.id_cliente_excluir,model.lineas,model.Tipo_contendor, model.mensaje,model.fecha_creacion,model.fecha_desactivacion from Bloqueos as model where model.Tipo_Movimiento='"+strtipo+"' and model.nombre_agencia_excluir='"+strtipo2+"' or model.nombre_cliente_excluir='"+s+"'");
		@SuppressWarnings("unchecked")
		ArrayList<Bloqueos> queryResult = (ArrayList<Bloqueos>)query.list();
					return queryResult;	
	}



	public void save(Bloqueos id) throws Exception {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(id);
	}




	public void update(Bloqueos id) throws Exception 
	{
		// TODO Auto-generated method stub
		getHibernateTemplate().update(id);
		
	}




	public void delete(Bloqueos id) throws Exception {
		getHibernateTemplate().delete(id);
		
	}




	public Bloqueos getWithId(Integer id) throws Exception {
		// TODO Auto-generated method stub
	
			Criteria criteria = getCriteria();

			// restriction to query
			criteria.add(Restrictions.eq("id", id));

			// get the collection
			@SuppressWarnings("unchecked")
			List<Bloqueos> col = criteria.list();

			// if no elements found, return null
			// otherwise, return the first object found
			if (col.size() == 0)
				return null;
			else
				return col.get(0);
		
	}
}
