package com.atp.solicitudes.manager;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonNode;

import com.atp.solicitudes.model.Bloqueos;
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
import com.atp.solicitudes.model.UserTransportistas;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.logger.ActivityEvent;
import com.objectwave.model.ActivityLogEntry;
import com.objectwave.model.GenericBlob;
import com.objectwave.model.SystemProperty;
import com.objectwave.session.SessionModelUser;
import com.objectwave.utils.SimpleEntry;
import com.atp.solicitudes.model.SolicitudContenedor;

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
	List<String> getUsersColumnPropertyValues_(String nivel,String id_N4_user) throws Exception;	
	
	// Empresa
	Empresa getEmpresaWithId(Integer id) throws Exception;
	List<Empresa> getAllEmpresa() throws Exception;

	// Login
	void registerLogin(User user) throws Exception;
	void invalidLoginAttempt(String username) throws Exception;
	void userSuccesfullyLoggedMobile(User aUser) throws Exception;
	Boolean shouldNewPasswordBeDefinedFor(User user) throws Exception;
	Boolean shouldNewPasswordBeDefinedFor1(User user) throws Exception;
	
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
	DaoResult<Solicitud> getSolicitudesByAdmin(DaoQuery query, DaoOrder order, List<String> UserN4) throws Exception;
	User getUserFromSolicitud(Solicitud solicitud) throws Exception;
    List<String> getSolicitudColumnValues(String column, String match, int maxResults) throws Exception;    
    void validateSolicitudCanBeModified(Solicitud solicitud, Date newScheduleDate) throws Exception, DomainModelException;
    void setSolicitudStatus(Solicitud solicitud, OperationValidationStateEnum status) throws Exception;
    List<String> getSolicitudByN4(String userN4, String idUser) throws Exception;
    List<String> getSolicitudByN4(String idUser) throws Exception;
    //prueba
    
    List<String> prueba(String idUser) throws Exception;
    List<String> getSolicitudByN4_(String idUser) throws Exception;
	List<String> getSolicitudAppointmentWithcontenedor(String user, String contenedor) throws Exception;
	List<String> getSolicitudAppointmentWithcontenedorAA(String user, String contenedor) throws Exception;
	List<String> getSolicitudAppointmentWithcontenedorcon(String user, String contenedor) throws Exception;
	List<String> getSolicitudAppointmentWithcontenedortra(String user, String contenedor) throws Exception;
	// SolicitudAppointment
	SolicitudAppointment getSolicitudAppointmentWithId(Integer id) throws Exception;
	List<SolicitudAppointment> getSolicitudAppointmentWithSolicitud(Solicitud solicitud) throws Exception; 
	SolicitudAppointment getSolicitudAppointmentWithAppNbr(String app_nbr, List<String> listid) throws Exception;
	void saveSolicitudAppointment(SolicitudAppointment solicitudAppointment) throws Exception;
	void updateSolicitudAppointmentStatus(SolicitudAppointment solicitudAppointment, SolicitudAppointmentStatusEnum status) throws Exception;
	Boolean validateCancelAppointmentHasPenalty(Date dateScheduled) throws Exception, DomainModelException;
	List<SolicitudAppointment> getSolicitudAppointmentFromSolicitud(Solicitud solicitud) throws Exception;
	List<SolicitudAppointment> getSolicitudAppointmentFromSolicitudByTransporter(Solicitud solicitud, Integer idTransporter) throws Exception;
	List<SolicitudAppointment> getActiveSolicitudAppointments() throws Exception;
	void setAppointmentCancellationMotive(SolicitudAppointment appointment, CancellationMotiveEnum cancellation) throws Exception;
	List<String> getSolicitudesByUserN4(Integer userN4) throws Exception;
	
	// SolicitudComentario
	SolicitudComentario getSolicitudComentarioWithId(Integer id) throws Exception;
	void saveSolicitudComentario(SolicitudComentario obj) throws Exception;
	void saveSolicitudComentarioAndNotify(SolicitudComentario obj) throws Exception;
	SolicitudComentario processSaveSolicitudComentario(JsonNode node) throws Exception, DomainModelException;
	DaoResult<SolicitudComentario> getSolicitudComentariosForSolicitud(Solicitud solicitud) throws Exception;
	
	// DocumentoSolicitud
	DocumentoSolicitud getDocumentoSolicitudById(Integer id) throws Exception;
	List<String> getDocumentoSolicitudbyId1(Integer id) throws Exception;
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
	DaoResult<ActivityLogEntry> queryActivityLogEntryByUser(DaoQuery query, DaoOrder order,String user) throws Exception;
	DaoResult<ActivityLogEntry> queryActivityLogEntryByUsers(DaoQuery query, DaoOrder order, List<String> users) throws Exception;
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
	
	// SolicitudContenedor
	SolicitudContenedor getSolicitudContenedorWithId(Integer id) throws Exception;
	void saveSolicitudContenedor(SolicitudContenedor obj) throws Exception;
	DaoResult<SolicitudContenedor> getSolicitudContenedoresForSolicitud(Solicitud solicitud) throws Exception;
	void deleteSolicitudContenedor(SolicitudContenedor solicitudContenedor) throws Exception;
	void updateSolicitudContenedor(SolicitudContenedor solicitudContenedor) throws Exception;
	
	//UserTransportistas
	UserTransportistas getUserTransportistasWithId(Integer id) throws Exception;
	void saveUserTransportistas(UserTransportistas obj) throws Exception;
	DaoResult<UserTransportistas> getUserTransportistasForUser(User user) throws Exception;
	void deleteUserTransportistas(UserTransportistas userTransportistas) throws Exception;
	void updateUserTransportistas(UserTransportistas userTransportistas) throws Exception;
	List<UserTransportistas> getUserTransportistasbyUserN4(Integer UserN4) throws Exception;
	UserTransportistas getUserTransportistasWithIdN4Transport(Integer id, Integer id2, Integer id3) throws Exception;
	List<UserTransportistas> getnombresByAdmin( List<SimpleEntry> listObj) throws Exception;
	
	List<String>getContenedorStatus(String id) throws Exception;
	
	ArrayList<Bloqueos> getBloqueosStatus(String strtipo) throws Exception;
	ArrayList<Bloqueos> getBloqueosStatushabilitar(String strtipo,String strtipo1,String str2) throws Exception;
	List<Bloqueos> queryBloqueos() throws Exception;
	Bloqueos getBloqueosWithId(Integer id) throws Exception;
	void deleteBloqueos(Bloqueos userBloqueos) throws Exception;
	void updateBloqueos(Bloqueos userBloqueos) throws Exception;
	void saveBloqueos(Bloqueos obj) throws Exception;
	Bloqueos processSaveUpdateBloqueos(JsonNode node) throws DomainModelException, Exception;
	
	
		
}
