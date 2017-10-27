package com.atp.solicitudes.manager;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonNode;

import com.atp.solicitudes.model.CancellationMotiveEnum;
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
import com.atp.solicitudes.model.User;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.logger.ActivityEvent;
import com.objectwave.model.ActivityLogEntry;
import com.objectwave.model.GenericBlob;
import com.objectwave.model.SystemProperty;
import com.objectwave.session.SessionModelUser;

public interface DomainManager
{
	String BEAN_NAME = "domainManager";
	
	// Generic
	void validateAppVersion(String appVersion) throws Exception, DomainModelException;
	void publishEvent(ActivityEvent event);

	// Profiles
	Profile getProfileWithId(Integer id) throws Exception;
	List<Profile> getAllProfiles() throws Exception;
	
	// Users
	User getUserWithId(Integer id) throws Exception;
	User getUserWithUsername(String username) throws Exception;
	User getUserWithEmail(String username) throws Exception;
	User getUserWithUserN4 (Integer usern4) throws Exception;
	void validateUserPersistence(User user) throws Exception, DomainModelException;
	User processSaveUpdateUser(JsonNode node) throws DomainModelException, Exception;
	void processUpdateUserPassword(User user, String newPassword, String confirmPassword) throws DomainModelException, Exception;
	void saveUser(User obj) throws Exception;
	void deleteUser(User obj) throws Exception;
	DaoResult<User> queryUser(DaoQuery query, DaoOrder order) throws Exception;
	List<String> getUsersColumnPropertyValues(String match, String column, int maxResults) throws Exception;	
	DaoQuery getQueryWithUserFilter(User user) throws Exception;
	Boolean validateUserAccessAllowed(User user) throws DomainModelException, Exception;
	
	// Empresa
	Empresa getEmpresaWithId(Integer id) throws Exception;
	List<Empresa> getAllEmpresa() throws Exception;

	// Login
	void registerLogin(User user) throws Exception;
	void invalidLoginAttempt(String username) throws Exception;
	void userSuccesfullyLoggedMobile(User aUser) throws Exception;
	Boolean shouldNewPasswordBeDefinedFor(User user) throws Exception;
	
	// Holidays
	Holiday processSaveUpdateHoliday(JsonNode node) throws DomainModelException, Exception;
	Holiday getHolidayWithId(Integer id) throws Exception;
	void deleteHoliday(Holiday holiday) throws Exception;
	DaoResult<Holiday> queryHoliday(DaoQuery query, DaoOrder order) throws Exception;
	
	// Solicitud
	Solicitud getSolicitudWithFolio(Integer id) throws Exception;
	void saveSolicitud(Solicitud solicitud) throws Exception;
	void raiseSolicitudStatusException(Solicitud solicitud) throws DomainModelException;
	DaoResult<Solicitud> querySolicitud(DaoQuery query, DaoOrder order) throws Exception;
	User getUserFromSolicitud(Solicitud solicitud) throws Exception;
    List<String> getSolicitudColumnValues(String column, String match, int maxResults) throws Exception;    
    void validateSolicitudCanBeModified(Solicitud solicitud, Date newScheduleDate) throws Exception, DomainModelException;
    void setSolicitudStatus(Solicitud solicitud, OperationValidationStateEnum status) throws Exception;
    
	// SolicitudAppointment
	SolicitudAppointment getSolicitudAppointmentWithId(Integer id) throws Exception;
	List<SolicitudAppointment> getSolicitudAppointmentWithSolicitud(Solicitud solicitud) throws Exception;
	SolicitudAppointment getSolicitudAppointmentWithAppNbr(String app_nbr) throws Exception;
	void saveSolicitudAppointment(SolicitudAppointment solicitudAppointment) throws Exception;
	void updateSolicitudAppointmentStatus(SolicitudAppointment solicitudAppointment, SolicitudAppointmentStatusEnum status) throws Exception;
	Boolean validateCancelAppointmentHasPenalty(Date dateScheduled) throws Exception, DomainModelException;
	List<SolicitudAppointment> getSolicitudAppointmentFromSolicitud(Solicitud solicitud) throws Exception;
	List<SolicitudAppointment> getActiveSolicitudAppointments() throws Exception;
	void setAppointmentCancellationMotive(SolicitudAppointment appointment, CancellationMotiveEnum cancellation) throws Exception;
	
	// SolicitudComentario
	SolicitudComentario getSolicitudComentarioWithId(Integer id) throws Exception;
	void saveSolicitudComentario(SolicitudComentario obj) throws Exception;
	void saveSolicitudComentarioAndNotify(SolicitudComentario obj) throws Exception;
	SolicitudComentario processSaveSolicitudComentario(JsonNode node) throws Exception, DomainModelException;
	DaoResult<SolicitudComentario> getSolicitudComentariosForSolicitud(Solicitud solicitud) throws Exception;
	
	// DocumentoSolicitud
	DocumentoSolicitud getDocumentoSolicitudById(Integer id) throws Exception;
	DocumentoSolicitud getDocumentoSolicitudByUserId(User user) throws Exception;
	DocumentoSolicitud getDocumentoSolicitudBySolicitudId(Solicitud solicitud) throws Exception;
	void saveDocumentoSolicitud(DocumentoSolicitud userDocument) throws Exception;
	void addNewDocumentoSolicitud(DocumentoSolicitud documentoSolicitud) throws Exception;
	void processUpdateDocumentoSolicitudStatus(JsonNode node, SessionModelUser user) throws DomainModelException, Exception;
	void updateSolicitudStatus(Solicitud solicitud, OperationValidationStateEnum newStatus, Profile profile) throws DomainModelException, Exception;
	DaoResult<DocumentoSolicitud> queryDocumentoSolicitud(DaoQuery query, DaoOrder order) throws Exception;
	GenericBlob getDocumentoSolicitudBlob(DocumentoSolicitud doc) throws Exception;
	List<DocumentoSolicitud> getDocumentoSolicitudWithStatus(Solicitud solicitud, DocumentoStatusEnum status) throws Exception;
	boolean hasDocumentoSolicitudWithStatus(Solicitud solicitud, DocumentoStatusEnum status) throws Exception;
	
	// ActivityLogEntry
	void registerActivityLogEntry(ActivityLogEntry entry) throws Exception;
	DaoResult<ActivityLogEntry> queryActivityLogEntry(DaoQuery query, DaoOrder order) throws Exception;
	List<String> getActivityLogColumnPropertyValues(String match, String column, int maxResults) throws Exception;	
	
	// System Properties
	SystemProperty getSystemPropertyNamed(String name) throws Exception;
	void saveSystemProperty(SystemProperty sysProp) throws Exception;
	void deleteSystemProperty(SystemProperty sysProp) throws Exception;
	SystemProperty getSystemPropertyById(Integer id) throws Exception;
	List<SystemProperty> getSystemProperties(String[] names) throws Exception;
	List<SystemProperty> getSystemPropertiesWithPatternName(String patterName) throws Exception;
	DaoResult<SystemProperty> getSystemPropertiesFrom(DaoQuery query, DaoOrder order) throws Exception;
	List<String> getSystemPropertiesColumnPropertyValues(String column, String match, int maxResults) throws Exception;
	Map<String,SystemProperty> getSystemPropertiesMap() throws Exception;
	Map<String,SystemProperty> getSystemPropertiesMapWithNames(String[] names) throws Exception;
}
