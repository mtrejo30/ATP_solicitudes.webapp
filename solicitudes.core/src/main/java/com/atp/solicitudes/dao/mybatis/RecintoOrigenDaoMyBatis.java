package com.atp.solicitudes.dao.mybatis;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;

import com.atp.solicitudes.dao.RecintoOrigenDao;
import com.atp.solicitudes.model.RecintoOrigen;
import com.objectwave.dao.utils.MyBatisDaoTemplate;

public class RecintoOrigenDaoMyBatis extends MyBatisDaoTemplate implements RecintoOrigenDao
{
	static final String MYBATIS_NAMESPACE = "mybatis.RecintoOrigenMapper";

	public RecintoOrigenDaoMyBatis(SqlSessionFactory sqlSessionFactory)
	{
		super(sqlSessionFactory);
	}

	public RecintoOrigen getWithId(String aValue) throws Exception
	{
		return (RecintoOrigen) selectOne(MYBATIS_NAMESPACE + ".selectById", aValue);
	}

	public List<RecintoOrigen> getAll() throws Exception
	{
		RowBounds rowBounds = new RowBounds();

		List<RecintoOrigen> col = selectList(MYBATIS_NAMESPACE + ".selectAll", rowBounds);

		return col;
	}
}