package com.atp.solicitudes.dao;

import java.util.List;

import com.atp.solicitudes.model.Profile;

public interface ProfileDao 
{
	Profile getWithId(Integer id) throws Exception;
	List<Profile> getAllProfiles() throws Exception;
}
