function Solicitud_Panel()
{
	this.saveSolicitudUrl = null;

	Panel.call(this);
}

Panel.registerSubclass(Solicitud_Panel);
Solicitud_Panel.uiFile = "solicitud-panel.jsp";

//UI properties
Solicitud_Panel.prototype.form = "#solicitud_form";
Solicitud_Panel.prototype.width = 510;

//events
Solicitud_Panel.Events = {};
Solicitud_Panel.Events.SOLICITUD_SAVED = 0;

Solicitud_Panel.prototype.init = function()
{	
	var myself = this;
	
	this.find("#saveSolicitudButton").click(function() { myself.saveSolicitud(); });
	this.find("#cancelSolicitudButton").click(function() { myself.close(); });
	this.prepareAgent();
	this.prepareClient();
	this.prepareCode();
	this.getForm().attr("action", this.saveSolicitudUrl);
	

};

Solicitud_Panel.prototype.fillType = function(col)
{
	var select = this.find("#operationTypeId");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

Solicitud_Panel.prototype.saveSolicitud = function()
{
	var obj = this.getObject();

	var myself = this;

	blockPage();
	jQuery.postJSON("solicitud/save-solicitud.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			myself.close();
			myself.performHandler(Solicitud_Panel.Events.SOLICITUD_SAVED, data.body);
			var info = data;
			showAcceptCancel("Solicitud guardada ¿Desea capturar citas?", function (data){  acceptClicked(info);});
			
		}
		
	});
	
	
};

function acceptClicked(data)
{
	blockPage();
	jQuery.postJSON("solicitud/citas-solicitud.json", data.body, function(data)
			{
				unblockPage();

				if (data.error)
				{
					showMessage(data.message, {title: 'Error'});
 				}
				else
				{
					redirectURL(data.body + ".page");
 				}
				
			});

}



Solicitud_Panel.prototype.prepareAgent = function()
{
	var myself = this;

	this.find("#agenciaAduanalName").autocomplete(
	{ 
		source: function(req, resp)
		{
			blockPage();
			jQuery.getJSON("rest/AgenciaAduanal/search.json?userN4Id=" + n4 + "&results=10&match="+ encodeURIComponent(req.term.toUpperCase()), { }, resp);
		},
		minLength: 3,

		open: function(event, ui)
		{
			unblockPage();
		},

		response: function(event, ui)
		{
			unblockPage();
		},

		select: function(event, ui)
		{
			myself.find("#agenciaAduanalId").val(ui.item.key);
		}
    });
}; 


Solicitud_Panel.prototype.prepareClient = function()
{
	var myself = this;

	this.find("#clienteName").autocomplete(
	{ 
		source: function(req, resp)
		{
			blockPage();
			jQuery.getJSON("rest/Cliente/search.json?userN4Id=" + n4 + "&results=10&match="+ encodeURIComponent(req.term.toUpperCase()), { }, resp);
		},
		minLength: 3,

		open: function(event, ui)
		{
			unblockPage();
		},

		response: function(event, ui)
		{
			unblockPage();
		},

		select: function(event, ui)
		{
			myself.find("#clienteId").val(ui.item.key);
		}
    });
}; 

Solicitud_Panel.prototype.prepareCode = function()
{
	var myself = this;
	
	this.find("#codigoName").autocomplete(
	{ 
		source: function(req, resp)
		{
			blockPage();
			jQuery.getJSON("rest/PaqueteComercial/search.json?cliente_id="+ jQuery("#clienteId").val() + "&results=10&match="+ encodeURIComponent(req.term.toUpperCase()), { }, resp);
		},
		minLength: 3,

		open: function(event, ui)
		{
			unblockPage();
		},

		response: function(event, ui)
		{
			unblockPage();
		},

		select: function(event, ui)
		{
			myself.find("#codigoId").val(ui.item.key);
		}
    });
};

Solicitud_Panel.prototype.fillObjectInfo = function(property, obj)
{
	var id = "", name = "";

	if (obj != null)
	{
		id = obj.id;
		name = obj.nombre;
	}
	
	this.find("#" + property + "Id").val(id);
	this.find("#" + property + "Name").val(name);
};

Solicitud_Panel.prototype.fillFrom = function(obj)
{
	this._super.fillFrom.call(this, obj);
	var myself = this;

	// agente
	if (obj.agentId != null)
	{
		blockPage();
		jQuery.getJSON("rest/AgenciaAduanal/" + obj.agentId, {}, function (data)
		{ 
			unblockPage();
			myself.fillObjectInfo("agenciaAduanal", data);
		},
		function(data)
		{
			unblockPage();
			myself.fillObjectInfo("agenciaAduanal", null);
		});
	}
	else
		myself.fillObjectInfo("agenciaAduanal", null);

	// cliente
	if (obj.clienteId != null)
	{
		blockPage();
		jQuery.getJSON("rest/Cliente/" + obj.clienteId, {}, function (data)
		{
			unblockPage();
			myself.fillObjectInfo("cliente", data);
		},
		function(data)
		{
			unblockPage();
			myself.fillObjectInfo("cliente", null);
		});
	}
	else
		myself.fillObjectInfo("cliente", null);
	
	// codigo
	if (obj.codigoId != null)
	{
		blockPage();
		jQuery.getJSON("rest/PaqueteComercial/" + obj.codigoId, {}, function (data)
		{
			unblockPage();
			myself.fillObjectInfo("codigo", data);
		},
		function(data)
		{
			unblockPage();
			myself.fillObjectInfo("codigo", null);
		});
	}
	else
		myself.fillObjectInfo("codigo", null);
};
