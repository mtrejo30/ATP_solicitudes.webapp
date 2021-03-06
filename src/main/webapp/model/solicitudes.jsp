<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

Solicitudes = { };

Solicitudes.Constants = { };

Solicitudes.Constants.AppointmentStatusCreated = 'Creado';
Solicitudes.Constants.AppointmentStatusCancelled = 'Cancelado';
Solicitudes.Constants.SolicitudStatusValidated = 'Validado';

function isContainerTipoR1(value)
{
	return value.indexOf('R') != -1;
}

function validateBookingForGate(bookingCode)
{
	if (bookingCode.charAt(0) == "S" && solicitudUserCompanyCode == "IST")
		throw new SolicitudError("<spring:message code='Invalid_booking_number_for_gate' />");
}

function isDataEmpty(data)
{
	return data == null || data == "";
}

function canRowBeEdited(rowData)
{
	return rowData.status == null || rowData.status == Solicitudes.Constants.AppointmentStatusCreated;
}

function isRowRegistered(rowData)
{
	return rowData.appointmentId != null;
}

function isRowCancelled(rowData)
{
	return rowData.status == Solicitudes.Constants.AppointmentStatusCancelled;
}

function validatesSolicitudInfoAgainstContainer(rowData)
{
	if (rowData.custIdGKey != null && rowData.custIdGKey != solicitudAgenciaAduanalId)
		throw new SolicitudError("<spring:message code='Customer_agent_does_not_match_between_solicitud_and_container' />");

	// validates shipper matches solicitud and container
	if (rowData.shipCustIdGKey != null && rowData.shipCustIdGKey != solicitudClienteId)
		throw new SolicitudError("<spring:message code='Shipper_does_not_match_between_solicitud_and_container' />");
		
	
}

function validatesBookingInfoAgainstContainer(container, myColumn)
{
	// no container history, all ok
	if (container == null)
		return;

	var typeFromContainer = container.type_Iso;
	var lineFromContainer = container.line_Op;

	var typeFromBooking = myColumn.getColumnValue('tipo');
	var lineFromBooking = myColumn.getColumnValue('linea');

	if (isDataEmpty(typeFromBooking))
	{
		throw new SolicitudError("<spring:message code='Booking_type_must_be_defined' />");
	}

	// if lineFromContainer exists and does not match line from booking
	if (lineFromContainer != null && lineFromContainer != lineFromBooking.label)
	{
		throw new SolicitudError("<spring:message code='Container_line_does_not_match_booking_line' />");
	}

	// if lineFromContainer exists and does not match line from booking
	if (typeFromContainer != null && typeFromContainer != typeFromBooking.label)
	{
		throw new SolicitudError("<spring:message code='Container_line_does_not_match_booking_type' />");
	}
}

/*
 * SolicitudError object
 */

function SolicitudError(message, code)
{
	this.message = message;
	this.code = code;
}

SolicitudError.prototype.getMessage = function()
{
	return this.message;
};