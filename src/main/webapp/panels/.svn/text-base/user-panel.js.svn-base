function User_Panel()
{
	Panel.call(this);
}
Panel.registerSubclass(User_Panel);

User_Panel.uiFile = "user-panel.jsp";
 
// events
User_Panel.Events = {};
User_Panel.Events.SAVE_USER = 0;

// UI properties
User_Panel.prototype.form = "#user_form";
User_Panel.prototype.width = 550;

User_Panel.prototype.init = function()
{
	var myself = this;
	this.find("#saveButton").click(function() { myself.saveUser(); return false; });
	this.find("#closeButton").click(function() { myself.close(); });
	this.prepareUserN4();
};

User_Panel.prototype.fillStatus = function(col)
{
	var select = this.find("#statusId");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

User_Panel.prototype.fillProfile = function(col)
{
	var select = this.find("#profileId");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

User_Panel.prototype.fillEmpresa = function(col)
{
	var select = this.find("#empresaId");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.nombre}; });
};

User_Panel.prototype.fillReportAccessLevel = function(col)
{
	var select = this.find("#reportLevelId");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

User_Panel.prototype.prepareUserN4 = function()
{
	var myself = this;

	this.find("#userN4Name").autocomplete(
		{ 
			source: function(req, resp)
			{
				blockPage();
				jQuery.getJSON("rest/UserN4/like.json?results=10&match="+ encodeURIComponent(req.term.toUpperCase()), { }, resp);
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
				myself.find("#userN4Id").val(ui.item.key);
			}
	    });
}; 
 
User_Panel.prototype.fillFrom = function(obj)
{
	this._super.fillFrom.call(this, obj);

	var myself = this;

	if (obj.usuarioN4_id != null)
	{
		blockPage();

		jQuery.getJSON("rest/UserN4/gkey/" + obj.usuarioN4_id, {}, function (data)
		{ 
			unblockPage();
			myself.find("#userN4Name").val(data.id);
		})
		.error(function(data) 
		{ 
			unblockPage();
			myself.find("#userN4Name").val("");
		});
	}
	else
	{
		myself.find("#userN4Name").val("");
	}
}; 

User_Panel.prototype.saveUser = function()
{
	var obj = this.getObject();
	obj.id = this.id;

	var myself = this;

	blockPage();
	jQuery.postJSON("user-admin/save-user.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			myself.close();
			showMessage("Usuario Guardado");
			
			myself.performHandler(User_Panel.Events.SAVE_USER, data.body);
		}
	});
};