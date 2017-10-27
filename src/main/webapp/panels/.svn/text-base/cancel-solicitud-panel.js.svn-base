function Cancel_Solicitud_Panel()
{
	this.cancelSolicitudUrl = null;

	Panel.call(this);
}

Panel.registerSubclass(Cancel_Solicitud_Panel);
Cancel_Solicitud_Panel.uiFile = "cancel-solicitud-panel.jsp";

//UI properties
Cancel_Solicitud_Panel.prototype.form = "#cancel_solicitud_form";
Cancel_Solicitud_Panel.prototype.width = 510;

//events
Cancel_Solicitud_Panel.Events = {};
Cancel_Solicitud_Panel.Events.SOLICITUD_CANCELED = 0;

Cancel_Solicitud_Panel.prototype.fillCancellation = function(col)
{
	var select = this.find("#cancelSolicitudId");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

Cancel_Solicitud_Panel.prototype.init = function()
{	
	var myself = this;
	
	this.find("#cancelSolicitudAppointmentsButton").click(
		function() {
		
		myself.cancelAppointment(); 
		});
	this.find("#cancelSolicitudButton").click(function() { myself.close(); });

	this.getForm().attr("action", this.cancelSolicitudUrl);
};


Cancel_Solicitud_Panel.prototype.cancelAppointment = function()
{
	var obj = this.getObject();

	
	var myself = this;

	blockPage();
	jQuery.postJSON("appointment/cancel-solicitud.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			myself.close();
			showMessage("Solicitud Cancelada");

			myself.performHandler(Cancel_Solicitud_Panel.Events.SOLICITUD_CANCELED, data.body);
		}
	});
};

