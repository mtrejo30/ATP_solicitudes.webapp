package com.atp.solicitudes.manager.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.atp.solicitudes.constants.ActivityLogEntryConstants;
import com.atp.solicitudes.dao.DocumentoSolicitudDao;
import com.atp.solicitudes.dao.EmpresaDao;
import com.atp.solicitudes.dao.HolidayDao;
import com.atp.solicitudes.dao.ProfileDao;
import com.atp.solicitudes.dao.SolicitudAppointmentDao;
import com.atp.solicitudes.dao.SolicitudComentarioDao;
import com.atp.solicitudes.dao.SolicitudDao;
import com.atp.solicitudes.dao.UserDao;
import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.manager.DomainManagerN4;
import com.atp.solicitudes.model.AgenciaAduanal;
import com.atp.solicitudes.model.CancellationMotiveEnum;
import com.atp.solicitudes.model.Cliente;
import com.atp.solicitudes.model.DocumentoSolicitud;
import com.atp.solicitudes.model.DocumentoStatusEnum;
import com.atp.solicitudes.model.Empresa;
import com.atp.solicitudes.model.Holiday;
import com.atp.solicitudes.model.OperationValidationStateEnum;
import com.atp.solicitudes.model.Profile;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.SolicitudAppointment;
import com.atp.solicitudes.model.SolicitudAppointmentStatusEnum;
import com.atp.solicitudes.model.SolicitudComentario;
import com.atp.solicitudes.model.SolicitudOperationTypeEnum;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserN4;
import com.objectwave.dao.ActivityLogEntryDao;
import com.objectwave.dao.GenericBlobDao;
import com.objectwave.dao.GenericBlobDaoRetriever;
import com.objectwave.dao.SystemPropertyDao;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.logger.ActivityEvent;
import com.objectwave.logger.ActivityLogEntryRegister;
import com.objectwave.mail.MailDeliverer;
import com.objectwave.model.ActivityLogEntry;
import com.objectwave.model.GenericBlob;
import com.objectwave.model.SystemProperty;
import com.objectwave.session.SessionModelUser;
import com.objectwave.utils.AppContextProvider;
import com.objectwave.utils.DateUtils;

@Service
@Transactional(readOnly = true)
@PropertySource("classpath:solicitudes.properties")
public class DomainManagerImpl extends AppContextProvider implements DomainManager, ActivityLogEntryRegister
{
	protected static Logger logger = LoggerFactory.getLogger(DomainManagerImpl.class);

	public static final String SYSTEM_PROPERTY_APPLICATION_VERSION = "APP_VERSION";

	@Resource(name="profileDao")
	private ProfileDao profileDao;
	
	@Resource(name="userDao")
	private UserDao userDao;

	@Resource(name="empresaDao")
	private EmpresaDao empresaDao;

	@Resource(name="activityLogEntryDao")
	private ActivityLogEntryDao activityLogEntryDao;
	
	@Resource(name="systemPropertyDao")
	private SystemPropertyDao systemPropertyDao;
	
	@Resource(name="holidayDao")
	private HolidayDao holidayDao;
	
	@Resource(name="genericBlobDao")
	private GenericBlobDao genericBlobDao;
	
	@Resource(name="solicitudDao")
	private SolicitudDao solicitudDao;
	
	@Resource(name="solicitudComentarioDao")
	private SolicitudComentarioDao solicitudComentarioDao;
	
	@Resource(name="documentoSolicitudDao")
	private DocumentoSolicitudDao documentoSolicitudDao;

	@Resource(name="solicitudAppointmentDao")
	private SolicitudAppointmentDao solicitudAppointmentDao;

	@Resource(name="MailDeliverer")
	private MailDeliverer mailDeliverer;
	
	@Resource(name=DomainManagerN4.BEAN_NAME)
	DomainManagerN4 managerN4;
	
	@Autowired
	private Environment environment;
	
	// General
	public void validateAppVersion(String appVersion) throws Exception, DomainModelException
	{
		SystemProperty prop = getSystemPropertyNamed("APP_VERSION");

		// if property not found, ignore the validation
		if (prop == null)
			return;

		if (appVersion.compareTo(prop.getStringValue()) < 0)
			throw new DomainModelException("Invalid_application_version");
	}

	// Profiles
	public Profile getProfileWithId(Integer id) throws Exception
	{
		return profileDao.getWithId(id);
	}

	public List<Profile> getAllProfiles() throws Exception
	{
		return profileDao.getAllProfiles();
	}

	// Users
	public User getUserWithId(Integer id) throws Exception
	{
		return userDao.getWithId(id);
	}

	public User getUserWithUsername(String username) throws Exception
	{
		return userDao.getWithUsername(username);
	}

	public User getUserWithEmail(String email) throws Exception
	{
		return userDao.getWithEmail(email);
	}

	public User getUserWithUserN4(Integer usern4) throws Exception
	{
		return userDao.getWithUserN4(usern4);
	}
	
	@Transactional(readOnly = false)
	public void registerLogin(User user) throws Exception
	{
		user.setLastLogin(new Date());
		userDao.save(user);

		publishEvent(new ActivityEvent(ActivityLogEntry.createForActionAndData("User_Logged",
				user.getId() + "," + user.getUsername())));
	}

	@Transactional(readOnly = false)
	public void publishEvent(ActivityEvent event)
	{
		try
		{
			getApplicationContext().publishEvent(event);
		}
		catch (Exception ex)
		{
			logger.error("error while publishing event", ex);
		}
	}

	public DaoResult<User> queryUser(DaoQuery query, DaoOrder order) throws Exception
	{
		return userDao.query(query, order);
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveUser(User user) throws Exception
	{
		userDao.save(user);
	}

	@Transactional(rollbackForClassName = { "Exception" })
	public void deleteUser(User user) throws Exception
	{
		userDao.delete(user);

		publishEvent(new ActivityEvent(ActivityLogEntry.createForActionAndAppender(ActivityLogEntryConstants.USER_DELETED, user)));
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void invalidLoginAttempt(String username) throws Exception
	{
		publishEvent(new ActivityEvent(ActivityLogEntry.createForActionAndData(ActivityLogEntry.INVALID_LOGIN_TRY, username)));
	}

	public List<String> getUsersColumnPropertyValues(String column, String match, int maxResults) throws Exception
	{
		return userDao.getColumnPropertyValues(column, match, maxResults);
	}
	
	public DaoQuery getQueryWithUserFilter(User user) throws Exception
	{
		String profileCode = user.getProfile().getCode();
		
		if (profileCode.equals(Profile.TA) || profileCode.equals(Profile.TI))
		{
			return new DaoQuery();
		}
		else
		{
			return DaoQuery.withFilter("user", user);
		}
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public User processSaveUpdateUser(JsonNode node) throws DomainModelException, Exception
	{
		User user = null;
		String oldPassword = null;
		boolean isNew = false;
		
		// if passwords do not match, raise an error
		if (!node.get("password").asText().equals(node.get("confPassword").asText()))
			throw new DomainModelException("User_passwords_does_not_match");

		if (node.get("id").isNull())
		{
			// if no id, is a new user
			isNew = true;
			user = new User();
		}
		else
		{
			// retrieve user
			user = getUserWithId(node.get("id").asInt());
			// keep original saved password (already encoded)
			oldPassword = user.getPassword();
		}

		// fill user with node info
		user.fillFrom(node, null);

		// validate persistance
		validateUserPersistence(user);

		String newPassword = node.get("password").asText();

		if (newPassword.length() == 0)
		{
			// if no password

			if (user.isPersistent())
			{
				// if already persistent, use the retrieved password
				user.setPassword(oldPassword);
			}
			else
			{
				// else, password not defined for a new user
				throw new DomainModelException("User_password_must_be_defined");
			}
		}
		else
		{
			// if password set, always encode it
			user.setPassword(getEncodedPassword(newPassword));
			// reset last date of password change
			user.setLastPasswordChange(new Date());
		}

		//TODO check and test
		//validateUserAccessAllowed(user);
		
		saveUser(user);
		
		publishEvent(new ActivityEvent(
				ActivityLogEntry.createForActionAndAppender(
						isNew ? ActivityLogEntryConstants.USER_CREATED : ActivityLogEntryConstants.USER_UPDATED, user)));		

		return user;
	}

	private String getEncodedPassword(String unencodedPassword)
	{
		ShaPasswordEncoder encoder = (ShaPasswordEncoder) getBean("ShaPasswordEncoder");
		return encoder.encodePassword(unencodedPassword, null);
	}

	private void validateUserPassword(String password, String confirmPassword) throws DomainModelException
	{
		if (!password.equals(confirmPassword))
			throw new DomainModelException("User_passwords_does_not_match");
		
		if (password.length() == 0)
			throw new DomainModelException("User_password_must_be_defined");
		
		if (password.length() < 8)
			throw new DomainModelException("User_password_must_be_greather_than_eight_characters");
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void processUpdateUserPassword(User user, String newPassword, String confirmPassword) throws DomainModelException,
			Exception
	{
		// validate new user password
		validateUserPassword(newPassword, confirmPassword);

		// if password set, always encode it
		user.setPassword(getEncodedPassword(newPassword));
		// reset last date of password change
		user.setLastPasswordChange(new Date());

		// save user
		saveUser(user);

		// raise event
		publishEvent(new ActivityEvent(ActivityLogEntry.createForActionAndData(ActivityLogEntryConstants.USER_PASSWORD_CHANGED,
				user.getUsername())));
	}
	
	public Boolean shouldNewPasswordBeDefinedFor(User user) throws Exception
	{
		// if no password already set, define one
		if (user.getLastPasswordChange() == null)
			return true;

		int totalDays = DateUtils.getDaysBetweenDates(user.getLastPasswordChange(), new Date());

		return (totalDays > getNumberOfDaysPasswordExpire());
	}

	public Boolean validateUserAccessAllowed(User user)throws DomainModelException, Exception
	{
		//TODO check check and test
		UserN4 usern4= managerN4.getUserWithGkey(user.getUsuarioN4_id());
		String credit=usern4.getCredit_status();
		if(usern4.getLife_cycle_state().equalsIgnoreCase("OBS"))
			throw new DomainModelException("UserN4_is_not_on_the_system");
		if(credit==null)
			{
			throw new DomainModelException("UserN4_has_credit_issues");
			}
		if(!credit.equalsIgnoreCase("OAC"))
			{
			throw new DomainModelException("UserN4_has_credit_issues");
			}
		else
			return false;

	}	
	
	
	
			
	public void validateUserPersistence(User user) throws DomainModelException, Exception
	{
		// if user does not exists, check if a user exists with same user name
		if (!user.isPersistent())
		{
			User existingUser = getUserWithUsername(user.getUsername());

			if (existingUser != null)
				throw new DomainModelException("User_with_username_already_exists");

			existingUser = getUserWithEmail(user.getEmail());

//			if (existingUser != null)
//				throw new DomainModelException("User_with_email_already_exists");
			
//			existingUser = getUserWithUserN4(user.getUsuarioN4_id());

//			if (existingUser != null)
//				throw new DomainModelException("UserN4_already_exists");
			
		}
		else
		{
//			User existingUser = getUserWithEmail(user.getEmail());

			// if existing user is same as the parameter user, is OK
//			if (!user.equals(existingUser))
//				throw new DomainModelException("User_with_email_already_exists");
		}
	}
	
	// Empresa
	
	public Empresa getEmpresaWithId(Integer id) throws Exception
	{
		return empresaDao.getWithId(id);
	}

	public List<Empresa> getAllEmpresa() throws Exception
	{
		return empresaDao.getAll();
	}

	// Holidays
	
	public Holiday getHolidayWithName(String name) throws Exception
	{
		return holidayDao.getWithName(name);
	}
	
	public Holiday getHolidayWithId(Integer id) throws Exception
	{
		return holidayDao.getWithId(id);
	}
	
	@Transactional(rollbackForClassName = { "Exception" })
	public void deleteHoliday(Holiday holiday) throws Exception
	{
		holidayDao.delete(holiday);

		publishEvent(new ActivityEvent(ActivityLogEntry.createForActionAndData(ActivityLogEntryConstants.HOLIDAY_DELETED, holiday.getId()
				+ "," + holiday.getName())));
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveHoliday(Holiday holiday) throws Exception
	{
		holidayDao.save(holiday);

		String action = holiday.isPersistent() ? ActivityLogEntryConstants.HOLIDAY_UPDATED : ActivityLogEntryConstants.HOLIDAY_CREATED;
		publishEvent(new ActivityEvent(ActivityLogEntry.createForActionAndData(action, holiday.getId() + "," + holiday.getName())));
	}	
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public Holiday processSaveUpdateHoliday(JsonNode node) throws DomainModelException, Exception
	{
		Holiday holiday = null;

		if (node.get("id").isNull())
		{
			// if no id, is a new holiday
			holiday = new Holiday();
		}
		else
		{
			// retrieve holiday
			holiday = getHolidayWithId(node.get("id").asInt());
		}
		
		SimpleDateFormat simpleDateFormat = (SimpleDateFormat) getBean("dateFormatter_yyyy-MM-dd");

		Map<String,Object> context = new HashMap<String,Object>();
		context.put("dateFormatter", simpleDateFormat);

		// fill holiday with node info		
		holiday.fillFrom(node, context);

		saveHoliday(holiday);

		return holiday;
	}


	public DaoResult<Holiday> queryHoliday(DaoQuery query, DaoOrder order) throws Exception
	{
		return holidayDao.query(query, order);
	}

	// Solicitud
	
	public Solicitud getSolicitudWithFolio(Integer id) throws Exception
	{
		return solicitudDao.getWithFolio(id);
	}

	public void raiseSolicitudStatusException(Solicitud solicitud) throws DomainModelException
	{
		if (solicitud.isCanceledOrValidated())
			throw new DomainModelException("solicitud_already_" + solicitud.getStatus().getName());
	}
	
	public DaoResult<Solicitud> querySolicitud(DaoQuery query, DaoOrder order) throws Exception
	{
		return solicitudDao.query(query, order);
	}
	
	public User getUserFromSolicitud(Solicitud solicitud) throws Exception
	{
		return solicitudDao.getUserFrom(solicitud);
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveSolicitud(Solicitud solicitud) throws Exception
	{
		solicitudDao.save(solicitud);
				
		publishEvent(new ActivityEvent(
					ActivityLogEntry.createForActionAndAppender(ActivityLogEntryConstants.SOLICITUD_CREATED, solicitud)));
	}
	
	public void validateSolicitudCanBeModified(Solicitud solicitud, Date newScheduleDate) throws Exception, DomainModelException
	{
//		if (!solicitud.canBeEditedByStatus())
//			throw new DomainModelException("Solicitud_status_revokes_edition");
		
		//TODO include valid dates for editing a solicitud
		 
		int minutesToNewScheduleDate = DateUtils.getMinutesBetweenDates(new Date(),newScheduleDate);
		/* Comentado para arreglarse cuando se termine la nueva rutina
		if(solicitud.getDateScheduled()!=null)
		{
			int minutesToCurrentScheduleDate = DateUtils.getMinutesBetweenDates(new Date(),solicitud.getDateScheduled());
			 
			if (minutesToCurrentScheduleDate < 240 || minutesToCurrentScheduleDate < 0)
				throw new DomainModelException("Solicitud_appointment_datetime_revokes_edition");
		}
		*/
		if  (minutesToNewScheduleDate < 0)
			throw new DomainModelException("Solicitud_appointment_datetime_revokes_edition");
		 
	
		//Datos generales pueden modificarse mientras TODAS las citas de la solicitud tengan status CREATED
		//Datos de fecha pueden cambiarse siempre y cuando estemos a 4 horas antes de la fecha actual de calendarizacion de la solicitud
	}

	// SolicitudAppointment

	public SolicitudAppointment getSolicitudAppointmentWithId(Integer id) throws Exception
	{
		return getSolicitudAppointmentDao().getWithId(id);
	}
	
	public List<SolicitudAppointment> getSolicitudAppointmentWithSolicitud(Solicitud solicitud) throws Exception
	{
		return getSolicitudAppointmentDao().getWithSolicitud(solicitud);
	}
	
	public SolicitudAppointment getSolicitudAppointmentWithAppNbr(String app_nbr) throws Exception
	{
		return getSolicitudAppointmentDao().getWithAppNbr(app_nbr);
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveSolicitudAppointment(SolicitudAppointment solicitudAppointment) throws Exception
	{
		getSolicitudAppointmentDao().save(solicitudAppointment);
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void updateSolicitudAppointmentStatus(SolicitudAppointment solicitudAppointment, SolicitudAppointmentStatusEnum status) throws Exception
	{
		// set the status
		solicitudAppointment.setStatus(status);

		// update definition
		solicitudAppointment.updateDefinition();

		// save appointment
		saveSolicitudAppointment(solicitudAppointment);

		publishEvent(new ActivityEvent(
			ActivityLogEntry.createForActionAndAppender(ActivityLogEntryConstants.SOLICITUD_APPOINTMENT_STATUS_UPDATED, solicitudAppointment)
		));
	}
	
	public Boolean validateCancelAppointmentHasPenalty(Date dateScheduled) throws Exception, DomainModelException
	{		
		int minutes = DateUtils.getMinutesBetweenDates(new Date(), dateScheduled);
		
		if(minutes<240 || minutes<0) 
			return true;
		else 
			return false;
	}

	public List<SolicitudAppointment> getSolicitudAppointmentFromSolicitud(Solicitud solicitud) throws Exception
	{
		DaoQuery query = DaoQuery.withFilter("solicitud", solicitud);
		DaoOrder order = DaoOrder.withSort("dateUpdated", DaoOrder.ASC);

		DaoResult<SolicitudAppointment> result = getSolicitudAppointmentDao().query(query, order);

		return result.getCollection();
	}
	
	public 	List<SolicitudAppointment> getActiveSolicitudAppointments() throws Exception
	{
		// Active SolicitudAppointments have only the following status (transitory)
		Object[] status = new Object[]
		{
			SolicitudAppointmentStatusEnum.CREATED,
			SolicitudAppointmentStatusEnum.USED,
			SolicitudAppointmentStatusEnum.USEDLATE
		};

		DaoQuery query = DaoQuery.withFilter("status_in", status);
		DaoOrder order = DaoOrder.withSort("dateUpdated", DaoOrder.ASC);
		
		DaoResult<SolicitudAppointment> result = getSolicitudAppointmentDao().query(query, order);

		return result.getCollection();
	}

	// SolicitudComentario

	public SolicitudComentario getSolicitudComentarioWithId(Integer id) throws Exception
	{
		return solicitudComentarioDao.getWithId(id);
	}

	public SolicitudComentario processSaveSolicitudComentario(JsonNode node) throws Exception, DomainModelException
	{
		SolicitudComentario obj = new SolicitudComentario();
		
		obj.setComentario(node.get("comentario").asText());
		obj.setFecha(new Date());

		// fake relations
		Solicitud fakeSol = new Solicitud();
		fakeSol.setFolio(node.get("solicitudId").asInt());
		obj.setSolicitud(fakeSol);

		User fakeUser = new User();
		fakeUser.setId(node.get("userId").asInt());
		obj.setUsuario(fakeUser);

		// save comentario to database
		saveSolicitudComentario(obj);

		return obj;
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveSolicitudComentario(SolicitudComentario obj) throws Exception
	{
		solicitudComentarioDao.save(obj);
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveSolicitudComentarioAndNotify(SolicitudComentario obj) throws Exception
	{
		saveSolicitudComentario(obj);
		//TODO
		Map<String,String> mailParams = new HashMap<String,String>();
		mailParams.put("from", getMailSender());

		// resolve mail target
		String mailTarget = null;
		
		// get updated objects, original objects are fakes
		Solicitud solicitud = getSolicitudWithFolio(obj.getSolicitud().getFolio());
		User commentUser = getUserWithId(obj.getUsuario().getId());
		Integer clientId=solicitud.getClienteId();
		Cliente cliente=managerN4.getClienteWithId(clientId);
        Empresa empresa;
		empresa=commentUser.getEmpresa();
		 
 
			if (solicitud.getUser().equals(commentUser))
			{
				if (solicitud.getOperationType().equals(SolicitudOperationTypeEnum.IMPO))
					mailTarget = getMailTargetIMPO(empresa.getCodigo());
				else
				if (solicitud.getOperationType().equals(SolicitudOperationTypeEnum.EXPO))
					mailTarget = getMailTargetEXPO(empresa.getCodigo());
				else
				if (solicitud.getOperationType().equals(SolicitudOperationTypeEnum.ENTREGA_VACIO))
					mailTarget = getMailTargetENTREGAVACIO(empresa.getCodigo());
				else
				if (solicitud.getOperationType().equals(SolicitudOperationTypeEnum.RECEPCION_VACIO))
					mailTarget = getMailTargetRECEPCIONVACIO(empresa.getCodigo());
				else
				if (solicitud.getOperationType().equals(SolicitudOperationTypeEnum.DESISTIMIENTO))
					mailTarget = getMailTargetDESISTIMIENTO(empresa.getCodigo());
			}
			else
			{
				mailTarget = solicitud.getUser().getEmail();
			}
  
		mailParams.put("to", mailTarget);
		mailParams.put("subject", getMailNotificationSubjectHeader());
		
		Map<String,Object> modelParams = new HashMap<String,Object>();
		modelParams.put("usuario", commentUser);
		modelParams.put("solicitud", solicitud);
		modelParams.put("fecha", obj.getFecha());
		modelParams.put("comentario", obj.getComentario());
		modelParams.put("website", getWebsiteURL());
		modelParams.put("cliente", cliente.getNombre());
		modelParams.put("folio", solicitud.getFolio());

		MimeMessageHelper msgHelper = getMailDeliverer().prepareMailWithParameters(mailParams, modelParams, "solicitud_comentario_notification.vm", false);
		getMailDeliverer().sendMailMessage(msgHelper.getMimeMessage());
	}

	public DaoResult<SolicitudComentario> getSolicitudComentariosForSolicitud(Solicitud solicitud) throws Exception
	{
		DaoQuery query = DaoQuery.withFilter("solicitud", solicitud);
		DaoOrder order = DaoOrder.withSort("fecha", DaoOrder.ASC);
		
		return solicitudComentarioDao.query(query, order);
	}
	
	// DocumentoSolicitud

	public DocumentoSolicitud getDocumentoSolicitudById(Integer id) throws Exception
	{
		return documentoSolicitudDao.getWithId(id);
	}
	
	public DocumentoSolicitud getDocumentoSolicitudByUserId(User user) throws Exception
	{
		return documentoSolicitudDao.getWithUserId(user);
	}
	
	public DocumentoSolicitud getDocumentoSolicitudBySolicitudId(Solicitud solicitud) throws Exception
	{
		return documentoSolicitudDao.getWithSolicitudId(solicitud);
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveDocumentoSolicitud(DocumentoSolicitud userDocument) throws Exception
	{
		// ensure we save first the associated Blob object
		GenericBlob blob = userDocument.getBlob();
		genericBlobDao.save(blob);
		
		documentoSolicitudDao.save(userDocument);
	}		
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void processUpdateDocumentoSolicitudStatus(JsonNode node, SessionModelUser loggedUser) throws DomainModelException, Exception
	{
		// get the document
		DocumentoSolicitud document = getDocumentoSolicitudById(node.get("id").asInt());		
		
		if (document == null)
			throw new Exception();
		
		// get the solicitud associated with the document
		Solicitud solicitud = document.getSolicitud();
		// current document status	
		DocumentoStatusEnum currentDocumentStatus = document.getStatus();
		// status that wee wish for the document
		DocumentoStatusEnum newDocumentStatus = DocumentoStatusEnum.withId(node.get("status").asInt());	
		
		Profile profile = ((User)loggedUser).getProfile();
			
		// TI or TA can change any status
		if (profile.isTerminalAdministrador() || profile.isTerminalInterno())
		{
			switch (newDocumentStatus)
			{
				case CANCELADO:				
					setDocumentStatus(document, DocumentoStatusEnum.CANCELADO);
					// if all documents its in CANCELADO status
					if (canChangeSolicitudStatus(solicitud, OperationValidationStateEnum.CANCELADO))
						// changed the status of the solicitud to CANCELADO
						setSolicitudStatus(solicitud, OperationValidationStateEnum.CANCELADO);
					else
						// change only the Date Updated
						solicitud.setDateUpdated(new Date());
				break;
				case ERROR:
					setDocumentStatus(document, DocumentoStatusEnum.ERROR);
					setSolicitudStatus(solicitud, OperationValidationStateEnum.ERROR);
				break;
				case VALIDADO:															
					setDocumentStatus(document, DocumentoStatusEnum.VALIDADO);
					
					if (canChangeSolicitudStatus(solicitud, OperationValidationStateEnum.VALIDADO))
						setSolicitudStatus(solicitud, OperationValidationStateEnum.VALIDADO);
					else
						solicitud.setDateUpdated(new Date());
					break;
				case INVALIDO:															
					setDocumentStatus(document, DocumentoStatusEnum.INVALIDO);
				    solicitud.setDateUpdated(new Date());
				break;
				// TI or TA can't upload files
				case CARGADO:
				break;
			}			
		}
		else
		{
			switch (newDocumentStatus)
			{
				case CANCELADO:
					OperationValidationStateEnum solicitudStatus = solicitud.getStatus();
					
					if (solicitudStatus == OperationValidationStateEnum.VALIDADO || 
							solicitudStatus == OperationValidationStateEnum.CANCELADO)
						throw new DomainModelException("user_cant_change_this_document_status");					
					
					if (currentDocumentStatus == DocumentoStatusEnum.CARGADO ||
							currentDocumentStatus == DocumentoStatusEnum.ERROR)
					{
						setDocumentStatus(document, DocumentoStatusEnum.CANCELADO);
						if (canChangeSolicitudStatus(solicitud, OperationValidationStateEnum.CANCELADO))
							setSolicitudStatus(solicitud, OperationValidationStateEnum.CANCELADO);
						else
							solicitud.setDateUpdated(new Date());
					}
					else
					{
						throw new DomainModelException("user_cant_change_this_document_status");
					}
				break;									
				default:
			}
		}						
	}
		
	// this method is called from Controllers
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void updateSolicitudStatus(Solicitud solicitud, OperationValidationStateEnum newStatus, Profile profile)	throws DomainModelException, Exception
	{		
		OperationValidationStateEnum currentStatus = solicitud.getStatus();
		
		if (profile.isTerminalAdministrador() || profile.isTerminalInterno())
		{
			switch (newStatus)
			{
				case CANCELADO:
				case ERROR:
				case VALIDADO:
					setSolicitudStatus(solicitud, newStatus);
				break;
				default:
			}
		}
		else
		{
			switch (newStatus)
			{
				case CANCELADO:					
					if (currentStatus == OperationValidationStateEnum.ERROR ||
							currentStatus == OperationValidationStateEnum.CARGADO)
						setSolicitudStatus(solicitud, OperationValidationStateEnum.CANCELADO);
					else if (currentStatus == OperationValidationStateEnum.VALIDADO ||
								currentStatus == OperationValidationStateEnum.CANCELADO)
						throw new DomainModelException("Cant_change_this_solicitud_status_contact_with_admin");				
				break;
				case CARGADO:
					if (currentStatus == OperationValidationStateEnum.ERROR ||
							currentStatus == OperationValidationStateEnum.CARGADO)
						setSolicitudStatus(solicitud, OperationValidationStateEnum.CARGADO);
					else
						throw new DomainModelException("Cant_change_this_solicitud_status_contact_with_admin");
				break;
				default:
			}
		}						
	}	
	
	private boolean canChangeSolicitudStatus(Solicitud solicitud, OperationValidationStateEnum newStatus) throws Exception
	{
		DaoOrder order = new DaoOrder();
		DaoQuery query = DaoQuery.withFilter("solicitud", solicitud);

		// get all documents from the solicitud
		List<DocumentoSolicitud> docs = documentoSolicitudDao.query(query, order).getCollection();
		DocumentoStatusEnum docStatus = DocumentoStatusEnum.withId(newStatus.getId());
		// check if some DocumentoSolicitud isn't docStatus
		for (DocumentoSolicitud currentDoc : docs)
		{				
			if (currentDoc.getStatus() != docStatus)
				return false;
		}		
		
		return true;
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void setSolicitudStatus(Solicitud solicitud, OperationValidationStateEnum status) throws Exception
	{
		// change status solicitud 
		solicitud.setStatus(status);
		// update modification time
		solicitud.setDateUpdated(new Date());
		// save the solicitud

		solicitudDao.save(solicitud);
							
		publishEvent(new ActivityEvent(
			ActivityLogEntry.createForActionAndAppender(ActivityLogEntryConstants.SOLICITUD_STATUS_UPDATED, solicitud)));
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void setAppointmentCancellationMotive(SolicitudAppointment appointment, CancellationMotiveEnum cancellation) throws Exception
	{
		// change status solicitud 
		appointment.setCancellationMotive(cancellation);
		// update modification time
		appointment.setDateUpdated(new Date());
		// save the appointment

		saveSolicitudAppointment(appointment);
	}
	
	public Integer getSolicitudId(String app_nbr) throws Exception
	{
		return solicitudAppointmentDao.getSolicitudId(app_nbr);
	}
	
	private void setDocumentStatus(DocumentoSolicitud documentoSolicitud, DocumentoStatusEnum status) throws Exception
	{
		// change document status
		documentoSolicitud.setStatus(status);
		// save the document
		saveDocumentoSolicitud(documentoSolicitud);
									
		publishEvent(new ActivityEvent(
						ActivityLogEntry.createForActionAndAppender(ActivityLogEntryConstants.DOCUMENT_STATUS_UPDATED, documentoSolicitud)));
	}
	
	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void addNewDocumentoSolicitud(DocumentoSolicitud documentoSolicitud) throws Exception
	{
		saveDocumentoSolicitud(documentoSolicitud);	
				
		publishEvent(new ActivityEvent(
						ActivityLogEntry.createForActionAndAppender(ActivityLogEntryConstants.DOCUMENT_CREATED, documentoSolicitud)));		
	}
	
	public DaoResult<DocumentoSolicitud> queryDocumentoSolicitud(DaoQuery query, DaoOrder order) throws Exception
	{
		return documentoSolicitudDao.query(query, order);
	}
	
	public GenericBlob getDocumentoSolicitudBlob(final DocumentoSolicitud doc) throws Exception
	{
		
		class DocumentoSolicitudGenericBlobDaoRetriever implements GenericBlobDaoRetriever
		{
			public Object getOwner() { return doc; };
			public GenericBlob getGenericBlob() { return doc.getBlob(); }
		}

		return genericBlobDao.getFromDaoRetriever(new DocumentoSolicitudGenericBlobDaoRetriever());
	}
	
	public List<DocumentoSolicitud> getDocumentoSolicitudWithStatus(Solicitud solicitud, DocumentoStatusEnum status) throws Exception
	{
		DaoQuery query = new DaoQuery();
		DaoOrder order = new DaoOrder();
		
		query.filter("solicitud", solicitud);
		query.filter("status", status);
		
		return documentoSolicitudDao.query(query, order).getCollection();		
	}
	
	public boolean hasDocumentoSolicitudWithStatus(Solicitud solicitud, DocumentoStatusEnum status) throws Exception
	{
		return getDocumentoSolicitudWithStatus(solicitud, status).size() != 0 ? true : false;
	}
	
	// ActivityLogEntry

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void registerActivityLogEntry(ActivityLogEntry entry) throws Exception
	{
		activityLogEntryDao.insert(entry);
	}

	public DaoResult<ActivityLogEntry> queryActivityLogEntry(DaoQuery query, DaoOrder order) throws Exception
	{
		return activityLogEntryDao.query(query, order);
	}

	public List<String> getActivityLogColumnPropertyValues(String column, String match, int maxResults) throws Exception
	{
		return activityLogEntryDao.getColumnPropertyValues(column, match, maxResults);
	}

	// SystemProperty

	public SystemProperty getSystemPropertyNamed(String name) throws Exception
	{
		return getSystemPropertyDao().getWithName(name);
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void saveSystemProperty(SystemProperty sysProp) throws Exception
	{
		getSystemPropertyDao().save(sysProp);
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void deleteSystemProperty(SystemProperty sysProp) throws Exception
	{
		getSystemPropertyDao().delete(sysProp);
	}

	public SystemProperty getSystemPropertyById(Integer id) throws Exception
	{
		return systemPropertyDao.getWithId(id);
	}

	public List<SystemProperty> getSystemProperties(String[] names) throws Exception
	{
		return getSystemPropertyDao().getWithNames(names);
	}

	public List<SystemProperty> getSystemPropertiesWithPatternName(String patternName) throws Exception
	{
		return getSystemPropertyDao().getWithNamePattern(patternName);
	}

	public DaoResult<SystemProperty> getSystemPropertiesFrom(DaoQuery query, DaoOrder order) throws Exception
	{
		return systemPropertyDao.query(query, order);
	}
	
	public List<String> getSystemPropertiesColumnPropertyValues(String column, String match, int maxResults) throws Exception
	{
		return systemPropertyDao.getColumnPropertyValues(column, match, maxResults);
	}

	public Map<String, SystemProperty> getSystemPropertiesMapWithNames(String[] names) throws Exception
	{
		return systemPropertyDao.getMapWithNames(names);
	}

	public Map<String, SystemProperty> getSystemPropertiesMap() throws Exception
	{
		return systemPropertyDao.getMap();
	}

	//
	// properties files access
	//

	private String getMailSender()
	{
		return getEnvironment().getProperty("sol.email.notification.sender");
	}

	private String getMailTargetAll(String empresa)
	{
		if(empresa.equals("ATP"))
		{
			return getEnvironment().getProperty("sol.email.notification.target.atp.all");
		}
		else
			if(empresa.equals("IST"))
			{
				return getEnvironment().getProperty("sol.email.notification.target.istasa.all");
			}
			else
			{
				return getEnvironment().getProperty("sol.email.notification.target.rfi.all");
			}
	}

	private String getMailTargetIMPO(String empresa)
	{
		if(empresa.equals("ATP"))
		{
			return getEnvironment().getProperty("sol.email.notification.target.atp.impo");
		}
		else
			if(empresa.equals("IST"))
			{
				return getEnvironment().getProperty("sol.email.notification.target.istasa.impo");
			}
			else
			 {
				return getEnvironment().getProperty("sol.email.notification.target.rfi.impo");
			 }
		
	}
	
	private String getMailTargetEXPO(String empresa)
	{
		if(empresa.equals("ATP"))
		{
			return getEnvironment().getProperty("sol.email.notification.target.atp.expo");
		}
		else
			if(empresa.equals("IST"))
			{
				return getEnvironment().getProperty("sol.email.notification.target.istasa.expo");
			}
			else
			{
				return getEnvironment().getProperty("sol.email.notification.target.rfi.expo");
			}
		
	}
	
	private String getMailTargetENTREGAVACIO(String empresa)
	{
		if(empresa.equals("ATP"))
		{
			return getEnvironment().getProperty("sol.email.notification.target.atp.entregavacio");
		}
		else
			if(empresa.equals("IST"))
			{
				return getEnvironment().getProperty("sol.email.notification.target.istasa.entregavacio");
			}
			else
			{
				return getEnvironment().getProperty("sol.email.notification.target.rfi.entregavacio");
			}
		
	}
	
	private String getMailTargetRECEPCIONVACIO(String empresa)
	{
		if(empresa.equals("ATP"))
		{
			return getEnvironment().getProperty("sol.email.notification.target.atp.recepcionvacio");
		}
		else
			if(empresa.equals("IST"))
			{
				return getEnvironment().getProperty("sol.email.notification.target.istasa.recepcionvacio");
			}
			else
			{
				return getEnvironment().getProperty("sol.email.notification.target.rfi.recepcionvacio");
			}
		
	}
	
	private String getMailTargetDESISTIMIENTO(String empresa)
	{
		if(empresa.equals("ATP"))
		{
			return getEnvironment().getProperty("sol.email.notification.target.atp.desistimiento");
		}
		else
			if(empresa.equals("IST"))
			{
				return getEnvironment().getProperty("sol.email.notification.target.istasa.desistimiento");
			}
			else
			{
				return getEnvironment().getProperty("sol.email.notification.target.rfi.desistimiento");
			}
		
	}
     
	private Integer getNumberOfDaysPasswordExpire()
	{
		return Integer.parseInt(getEnvironment().getProperty("sol.password_expires.numberOfDays"));
	}
	
	private String getMailNotificationSubjectHeader()
	{
		return getEnvironment().getProperty("sol.email.notification.subject.header");
	}

	private String getWebsiteURL()
	{
		return getEnvironment().getProperty("sol.website.url");
	}

	//
	// getters and setters
	//
	public ProfileDao getProfileDao()
	{
		return profileDao;
	}

	public void setProfileDao(ProfileDao dao)
	{
		this.profileDao = dao;
	}

	public UserDao getUserDao()
	{
		return userDao;
	}

	public void setUserDao(UserDao dao)
	{
		this.userDao = dao;
	}

	public ActivityLogEntryDao getActivityLogEntryDao()
	{
		return activityLogEntryDao;
	}

	public void setActivityLogEntryDao(ActivityLogEntryDao dao)
	{
		this.activityLogEntryDao = dao;
	}

	public GenericBlobDao getGenericBlobDao()
	{
		return genericBlobDao;
	}

	public void setGenericBlobDao(GenericBlobDao genericBlobDao)
	{
		this.genericBlobDao = genericBlobDao;
	}

	public SystemPropertyDao getSystemPropertyDao()
	{
		return systemPropertyDao;
	}

	public void setSystemPropertyDao(SystemPropertyDao systemPropertyDao)
	{
		this.systemPropertyDao = systemPropertyDao;
	}

	public HolidayDao getHolidayDao()
	{
		return holidayDao;
	}

	public void setHolidayDao(HolidayDao holidayDao)
	{
		this.holidayDao = holidayDao;
	}

	@Transactional(readOnly = false, rollbackForClassName = { "Exception" })
	public void userSuccesfullyLoggedMobile(User aUser) throws Exception
	{
		aUser.setLastLogin(new Date());
		userDao.save(aUser);

		publishEvent(new ActivityEvent(ActivityLogEntry.createForActionAndData(ActivityLogEntry.USER_LOGGED_IN,
				aUser.getUsername())));
	}
	
	public List<String> getSolicitudColumnValues(String column, String match, int maxResults) throws Exception
	{
		return solicitudDao.getColumnValues(column, match, maxResults);
	}
	
	public SolicitudDao getSolicitudDao()
	{
		return solicitudDao;
	}

	public void setSolicitudDao(SolicitudDao solicitudDao)
	{
		this.solicitudDao = solicitudDao;
	}

	public DocumentoSolicitudDao getDocumentoSolicitudDao()
	{
		return documentoSolicitudDao;
	}

	public void setDocumentoSolicitudDao(DocumentoSolicitudDao documentoSolicitudDao)
	{
		this.documentoSolicitudDao = documentoSolicitudDao;
	}

	public SolicitudComentarioDao getSolicitudComentarioDao()
	{
		return solicitudComentarioDao;
	}

	public void setSolicitudComentarioDao(SolicitudComentarioDao solicitudComentarioDao)
	{
		this.solicitudComentarioDao = solicitudComentarioDao;
	}

	public MailDeliverer getMailDeliverer()
	{
		return mailDeliverer;
	}

	public void setMailDeliverer(MailDeliverer mailDeliverer)
	{
		this.mailDeliverer = mailDeliverer;
	}

	public Environment getEnvironment()
	{
		return environment;
	}

	public void setEnvironment(Environment environment)
	{
		this.environment = environment;
	}

	public SolicitudAppointmentDao getSolicitudAppointmentDao()
	{
		return solicitudAppointmentDao;
	}

	public void setSolicitudAppointmentDao(SolicitudAppointmentDao solicitudAppointmentDao)
	{
		this.solicitudAppointmentDao = solicitudAppointmentDao;
	}

	public EmpresaDao getEmpresaDao()
	{
		return empresaDao;
	}

	public void setEmpresaDao(EmpresaDao empresaDao)
	{
		this.empresaDao = empresaDao;
	}
}
