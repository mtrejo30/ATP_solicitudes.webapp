package com.atp.solicitudes.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.objectwave.exception.DomainModelException;
import com.objectwave.logger.ActivityLogAppender;
import com.objectwave.session.SessionModelUser;

@Entity
@Table(name = "user_table")
public class User extends Object implements Serializable, SessionModelUser, ActivityLogAppender
{
	private static final long serialVersionUID = 1L;

	public static final int USERNAME_LENGTH  =  50;
	public static final int FIRSTNAME_LENGTH =  50;
	public static final int LASTNAME_LENGTH  =  50;

	public static final int PASSWORD_LENGTH  = 100;
	public static final int EMAIL_LENGTH 	 = 100;
	public static final int USUARION4_LENGTH =  10;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private Integer id;

	@Column(name = "username", nullable = false, length = USERNAME_LENGTH)
	String username;

	@Column(name = "first_name", nullable = true, length = FIRSTNAME_LENGTH)
	String firstName;

	@Column(name = "last_name", nullable = true, length = LASTNAME_LENGTH)
	String lastName;

	@Column(name = "password", nullable = false, length = PASSWORD_LENGTH)
	@JsonIgnore(value=true)
	String password;

	@Column(name = "email", nullable = false, length = EMAIL_LENGTH)
	String email = "";
	
	@Column(name="user_n4_id", nullable=true, length= USUARION4_LENGTH)
	Integer userN4_Id;

	@Column(name = "status", nullable = true)
	@JsonIgnore(value = true)
	UserStatusEnum status = UserStatusEnum.ACTIVE;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.JOIN)
	@JoinColumn(name = "profile_id", nullable = false)
	@JsonIgnore(value = true)
	Profile profile;

	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.JOIN)
	@JoinColumn(name = "report_access_level_id", nullable = false)
	@JsonIgnore(value = true)
	ReportAccessLevel reportAccessLevel;

	@Column(name = "last_login", nullable = true)
	@JsonIgnore(value = true)
	Date lastLogin;
	
	@Column(name = "last_password_change", nullable = false)
	@JsonIgnore(value = true)
	Date lastPasswordChange;

	@ManyToOne(fetch = FetchType.EAGER)
	@Fetch(value = FetchMode.JOIN)
	@JoinColumn(name = "empresa_id", nullable = false)
	@JsonIgnore(value = true)
	Empresa empresa;

	public User()
	{
		
	}
	
	public void clearPassword()
	{
		setPassword("");
	}

	public void fillFrom(JsonNode node, Map<String,Object> context) throws DomainModelException, Exception
	{
		setUsername(node.get("username").asText());
		setFirstName(node.get("firstName").asText());
		setLastName(node.get("lastName").asText());
		setPassword(node.get("password").asText());
		setEmail(node.get("email").asText());
		
		if (!node.has("userN4Id"))
			throw new DomainModelException("User_must_have_a_N4_user_defined");

		setUsuarioN4_id(node.get("userN4Id").asInt());

		if (!node.has("statusId"))
			throw new DomainModelException("User_must_have_a_status_defined");

		setStatus(UserStatusEnum.withId(node.get("statusId").asInt()));
		
		// dummy profile, no need to get profile object from database
		// hibernate checks for the object id property to identify it

		if (!node.has("profileId"))
			throw new DomainModelException("User_must_have_a_profile_defined");

		Profile fakeProfile = new Profile();
		fakeProfile.setId(node.get("profileId").asInt());
		setProfile(fakeProfile);

		if (!node.has("empresaId"))
			throw new DomainModelException("User_must_have_a_company_defined");

		Empresa fakeEmpresa = new Empresa();
		fakeEmpresa.setId(node.get("empresaId").asInt());
		setEmpresa(fakeEmpresa);

		if (!node.has("reportLevelId"))
			throw new DomainModelException("User_must_have_a_report_access_level_defined");

		ReportAccessLevel fakeAccessLevel = new ReportAccessLevel();
		fakeAccessLevel.setId(node.get("reportLevelId").asInt());
		setReportAccessLevel(fakeAccessLevel);
	}

	@JsonProperty(value="statusId")
	public Integer getStatusId()
	{
		return getStatus().getId();
	}

	@JsonProperty(value="profileId")
	public Integer getProfileId()
	{
		return getProfile().getId();
	}
	
	@JsonProperty(value="reportLevelId")
	public Integer getReportAccessLevelId()
	{
		return reportAccessLevel.getId();
	}	

	@JsonProperty(value="empresaId")
	public Integer getEmpresaId()
	{
		return getEmpresa().getId();
	}

	public boolean isPersistent()
	{
		return getId() != null;
	}

	public boolean isDeactivated()
	{
		return UserStatusEnum.DEACTIVATED.equals(getStatus());
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getFullName()
	{
		return getFirstName() + " " + getLastName();
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getFirstName()
	{
		return firstName;
	}

	public void setFirstName(String firstName)
	{
		this.firstName = firstName;
	}

	public String getLastName()
	{
		return lastName;
	}

	public void setLastName(String lastName)
	{
		this.lastName = lastName;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String user_email)
	{
		this.email = user_email;
	}

	public Boolean isActive()
	{
		return UserStatusEnum.ACTIVE.equals(getStatus());
	}

	public void setLastLogin(Date lastLogin)
	{
		this.lastLogin = lastLogin;
	}

	public Date getLastLogin()
	{
		return lastLogin;
	}

	public Date getLastPasswordChange() 
	{
		return lastPasswordChange;
	}

	public void setLastPasswordChange(Date lastDate) 
	{
		this.lastPasswordChange = lastDate;
	}

	public UserStatusEnum getStatus()
	{
		return status;
	}

	public void setStatus(UserStatusEnum status)
	{
		this.status = status;
	}

	public Profile getProfile() 
	{
		return profile;
	}

	public void setProfile(Profile profile) 
	{
		this.profile = profile;
	}

	public Integer getUsuarioN4_id()
	{
		return userN4_Id;
	}

	public void setUsuarioN4_id(Integer userN4_Id)
	{
		this.userN4_Id = userN4_Id;
	}

	public ReportAccessLevel getReportAccessLevel()
	{
		return reportAccessLevel;
	}

	public void setReportAccessLevel(ReportAccessLevel reportAccessLevel)
	{
		this.reportAccessLevel = reportAccessLevel;
	}
	
	@Override
	public boolean equals(Object anObject)
	{
		if (anObject == null)
			return false;

		if (this == anObject)
			return true;

		if (!(anObject instanceof User))
			return false;

		User realObject = (User) anObject;

		return this.getId().equals(realObject.getId());
	}

	@Override
	public int hashCode()
	{
		return getId();
	}
	
	public void appendToActivityLog(StringBuilder builder)
	{	
		builder.append("id=");
		builder.append(getId());
		builder.append(",username=");
		builder.append(getUsername());
		builder.append(",N4=");
		builder.append(getUsuarioN4_id());
		builder.append(",email=");
		builder.append(getEmail());
		builder.append(",status=");
		builder.append(getStatus());
		builder.append(",profileId=");			
		builder.append(getProfileId());
	}

	public Empresa getEmpresa()
	{
		return empresa;
	}

	public void setEmpresa(Empresa empresa)
	{
		this.empresa = empresa;
	}
}