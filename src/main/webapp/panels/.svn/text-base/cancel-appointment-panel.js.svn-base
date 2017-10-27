function Cancel_Appointment_Panel()
{
	this.cancelSolicitudUrl = null;

	Panel.call(this);
}

Panel.registerSubclass(Cancel_Appointment_Panel);
Cancel_Appointment_Panel.uiFile = "cancel-appointment-panel.jsp";

//UI properties
Cancel_Appointment_Panel.prototype.form = "#cancel_appointment_form";
Cancel_Appointment_Panel.prototype.width = 510;

//events
Cancel_Appointment_Panel.Events = {};
Cancel_Appointment_Panel.Events.SOLICITUD_CANCELED = 0;

Cancel_Appointment_Panel.prototype.fillCancellation = function(col)
{
	var select = this.find("#cancelSolicitudId");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

Cancel_Appointment_Panel.prototype.init = function()
{	
	var myself = this;
	
	this.find("#cancelSolicitudAppointmentsButton").click(
		function() {
		
		myself.cancelAppointment(); 
		});
	this.find("#cancelSolicitudButton").click(function() { myself.close(); });

	this.getForm().attr("action", this.cancelSolicitudUrl);
};


Cancel_Appointment_Panel.prototype.cancelAppointment = function()
{
	var obj = this.getObject();

	
	var myself = this;

	blockPage();
	jQuery.postJSON("appointment/cancel-appointment.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
			getTable().jqGrid('setCell', getSelectedRowData().id, "status", "Cancelado");
			myself.close();
		}
		else
		{
			myself.close();
			showMessage("Solicitud Cancelada");
			getTable().jqGrid('setCell', getSelectedRowData().id, "status", "Cancelado");
			myself.performHandler(Cancel_Appointment_Panel.Events.SOLICITUD_CANCELED, data.body);
		}
	});
};

