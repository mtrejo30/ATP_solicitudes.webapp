package com.atp.solicitudes.manager;

import java.util.Date;
import java.util.List;

import org.codehaus.jackson.JsonNode;

import com.atp.solicitudes.model.AgenciaAduanal;
import com.atp.solicitudes.model.Booking;
import com.atp.solicitudes.model.BookingItem;
import com.atp.solicitudes.model.Cliente;
import com.atp.solicitudes.model.Contenedor;
import com.atp.solicitudes.model.LineaNaviera;
import com.atp.solicitudes.model.OperadorTransportista;
import com.atp.solicitudes.model.PaqueteComercial;
import com.atp.solicitudes.model.RecintoOrigen;
import com.atp.solicitudes.model.Solicitud;
import com.atp.solicitudes.model.SolicitudAppointment;
import com.atp.solicitudes.model.Special;
import com.atp.solicitudes.model.TipoRecepcionVacio;
import com.atp.solicitudes.model.Transportista;
import com.atp.solicitudes.model.UserN4;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.utils.SimpleEntry;

public interface DomainManagerN4
{
	String BEAN_NAME = "domainManager_n4";

	// AgenciaAduanal
	AgenciaAduanal getAgenciaAduanalWithId(Integer aValue) throws Exception;
	List<SimpleEntry> getAgenciaAduanalDistinct(Integer usern4Id, String match, Integer maxResults) throws Exception;
	
	// LineaNaviera
	LineaNaviera getLineaNavieraWithId(Integer aValue) throws Exception;
	LineaNaviera getLineaNavieraWithNombre(String nombre)  throws Exception;
	List<SimpleEntry> getLineaNavieraByPattern(String match, Integer maxResults) throws Exception;
	
	// Cliente
	Cliente getClienteWithId(Integer aValue) throws Exception;
	List<SimpleEntry> getClienteDistinct(Integer usern4Id, String match, Integer maxResults) throws Exception;

	// Transportista
	Transportista getTransportistaWithId(Integer aValue) throws Exception;
	Transportista getTransportistaWithNombre(String aValue) throws Exception;
	List<SimpleEntry> getTransportistaImpo(String match, Integer maxResults) throws Exception;
	
	// OperadorTransportista
	OperadorTransportista getOperadorTransportistaWithGkey(Integer aValue) throws Exception;
	OperadorTransportista getOperadorTransportistaWithCardId(String aValue) throws Exception;
	DaoResult<OperadorTransportista> queryOperadorTransportista(DaoQuery query, DaoOrder order) throws Exception;
	List<SimpleEntry> getOperadorTransportistaImpo(String match, Integer maxResults) throws Exception;
	
	// Contenedor
	Contenedor getContenedorWithId(Integer aValue) throws Exception;
	List<SimpleEntry> getClaveContenedorImpo(String aValue, String consigne, Integer maxResults) throws Exception;
	List<SimpleEntry> getClaveContenedorDesistimiento(String aValue, String consigne, Integer maxResults) throws Exception;
	List<SimpleEntry> getClaveContenedorHistorial(String aValue, Integer maxResults) throws Exception;
	Contenedor getContenedorRecentWithUnitNbr(String aValue) throws Exception;
 
	// UserN4
	UserN4 getUserWithGkey(Integer aValue) throws Exception;
	UserN4 getWithId(String aValue) throws Exception;
	UserN4 getWithName(String aValue) throws Exception;
	UserN4 getWithCustId(String aValue) throws Exception;
	DaoResult<UserN4> queryUserN4(DaoQuery query, DaoOrder order) throws Exception;
	List<SimpleEntry> getUserN4(String match, Integer maxResults) throws Exception;

	// Special
	Special getSpecialWithId(String id) throws Exception;
	List<Special> querySpecial(DaoQuery query, DaoOrder order) throws Exception;
	List<Special> getAllSpecial() throws Exception;

	// RecintoOrigen
	RecintoOrigen getRecintoOrigenWithId(String id) throws Exception;
	List<RecintoOrigen> getAllRecintoOrigen() throws Exception;

	// Booking
	Booking getBookingWithId(Integer id) throws Exception;
	List<SimpleEntry> getBookingByPattern(String match, Integer maxResults) throws Exception;
	List<Booking> getBookingByName(String name, Integer maxResults) throws Exception;

	// BookingItem
	BookingItem getBookingItemWithId(Integer id) throws Exception;
	public BookingItem getBookingItemWithGkey(Integer id, String type) throws Exception;
	public DaoResult<BookingItem> getBookingItemWithIdForType(DaoQuery query, DaoOrder order) throws Exception;
	DaoResult<BookingItem> queryBookingItem(DaoQuery query, DaoOrder order) throws Exception;
	
	// TipoRecepcionVacio
	TipoRecepcionVacio getTipoRecepcionVacioWithId(Integer id) throws Exception;
	TipoRecepcionVacio getTipoRecepcionVacioWithNombre(String aValue) throws Exception;
	List<SimpleEntry> getTipoRecepcionVacioByPattern(String match, Integer maxResults) throws Exception;

	// Appointments
	SolicitudAppointment processSaveAppointment(JsonNode node, Solicitud solicitud) throws DomainModelException, Exception;
	List<Date> getTimeSlotsForDate(Date aDate, Solicitud solicitud) throws Exception;
	List<Date> getTimeSlotsForDate(Date aDate) throws Exception;
	void cancelAppointment(SolicitudAppointment appointment) throws DomainModelException, Exception;
	void cancelAppointmentWithNumber(String numberStr) throws DomainModelException, Exception;
	
	// Paquete Comercial
	PaqueteComercial getPaqueteComercialWithId(Integer aValue) throws Exception;
	List<SimpleEntry> getPaqueteComercial(String clienteId, String match, Integer maxResults) throws Exception;
	
	// Solicitud
    void cancelSolicitud(Solicitud solicitud) throws DomainModelException, Exception;
    
    // Store Procedures
    void callStoredProcedureCancellationAppointments(String v_cita, String v_note) throws Exception;
    void callAsignAgentClientReferenceAppointment(String app_nbr, Integer agent, Integer client, String reference) throws Exception;
    void callAsignAgentClientRefAppointment(String app_nbr, Integer agent, Integer client) throws Exception;
    void callAsignBookingItemGkey(Integer booking_item_gkey, String app_nbr) throws Exception;
}
