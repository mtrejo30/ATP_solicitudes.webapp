package com.atp.solicitudes.authentication;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.objectwave.authentication.AuthorityListResolver;

public class AuthorityListResolverByUserRole implements AuthorityListResolver
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(AuthorityListResolverByUserRole.class);

	public List<GrantedAuthority> getAuthorityListFrom(Object authInfo)
	{
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>(1);

		// authInfo is the profile code, we will use the profile code for the granted authorities

		try
		{
			ResultSet rs = (ResultSet) authInfo;

			String profileCode = rs.getString("role");
			String reportAccessLevel = rs.getString("report_access_level");


			if (profileCode != null)
				authorities.add(new SimpleGrantedAuthority(profileCode));			

			if (reportAccessLevel != null)
				authorities.add(new SimpleGrantedAuthority("REPORT_ACCESS_LEVEL_" + reportAccessLevel));	
		}
		catch (SQLException e)
		{
			logger.error("error while retrieving user authority list roles", e);
		}
		
		return authorities;
    }
}
