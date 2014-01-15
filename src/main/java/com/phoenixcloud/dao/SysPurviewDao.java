package com.phoenixcloud.dao;

import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.phoenixcloud.bean.SysPurview;

@Repository
public class SysPurviewDao extends AbstractDao<SysPurview> {
	public SysPurviewDao() {
		super(SysPurview.class);
	}
	
	@SuppressWarnings("unchecked")
	public List<SysPurview> getAll() {
		Query query = entityManager.createQuery("select pur from SysPurview pur where pur.deleteState = 0");
		return query.getResultList();
	}
	
	public SysPurview find(String id) {
		Query query = entityManager.createQuery("select pur from SysPurview pur where pur.deleteState = 0 and pur.purviewId = ?1");
		query.setParameter(1, id);
		return getSingleResultOrNull(query);
	}
}
