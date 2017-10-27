package com.atp.solicitudes.authentication;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.objectwave.authentication.AuthorityListResolver;

/**
 * Implements the UserDetailsService which provides valid user and role information
 * used by the Spring Security Framework.
 * Subclasses JdbcDaoSupport for easy manipulation of
 * database connectivity
 * @see org.springframework.security.core.userdetails.UserDetailsService
 * @see org.springframework.jdbc.core.support.JdbcDaoSupport
 *  
 */
public class ApplicationAuthenticationProvider extends JdbcDaoSupport implements UserDetailsService
{
	/**
	 * Field APPLICATION_ROLE.
	 * (value is ""APPLICATION_ROLE"")
	 * Contains the default application role value used
	 */
	public static final Integer STATUS_ACTIVE = 0;
	public static final Integer STATUS_INACTIVE = 1;
	public static final Integer STATUS_DELETED = 2;

	/**
	 * Field APPLICATION_QUERY.
	 * Contains the SQL database query to retrieve the valid users
	 */
	public static final String APPLICATION_QUERY = "select username, password, status, b.code as role, c.code as report_access_level from user_table a left outer join profile b on a.profile_id = b.id left outer join report_access_level c on a.report_access_level_id = c.id where a.username = ?";

	AuthorityListResolver authorityListResolver;

	/**
	 * Method loadUserByUsername.
	 * 
	 * Returns a UserDetails object containing the user (application) and role information based on the application id
	 * 
	 * @param applicationId String
	 * @return UserDetails
	 * @throws UsernameNotFoundException
	 * @see org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(String)
	 */
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
	{
		List<UserDetails> users = loadUsersByUsername(username);

		if (users.size() == 0)
		{
			logger.debug("Query returned no results for user " + username);

			throw new UsernameNotFoundException("username not found");
		}

		return users.get(0);
	}

	/**
	 * Method loadUsersByUsername.
	 * 
	 * Returns a List of UserDetails which matches the application id
	 * 
	 * @param storeFrontId String
	 * @return List<UserDetails>
	 */
	protected List<UserDetails> loadUsersByUsername(String username)
	{
		return getJdbcTemplate().query(APPLICATION_QUERY, new String[] { username }, new RowMapper<UserDetails>()
		{
			public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException
			{
				String db_username = rs.getString("username");
				String password = rs.getString("password");
				Integer status = rs.getInt("status");

				boolean enabled = STATUS_ACTIVE.equals(status);
				boolean accountNonExpired = true;

				return new User(db_username, password, enabled, accountNonExpired, true, true, getAuthorityListResolver().getAuthorityListFrom(rs));
			}
		});
	}
	
	public AuthorityListResolver getAuthorityListResolver()
	{
		return authorityListResolver;
	}

	public void setAuthorityListResolver(AuthorityListResolver authorityListResolver)
	{
		this.authorityListResolver = authorityListResolver;
	}
}
