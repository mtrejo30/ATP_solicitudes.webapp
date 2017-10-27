function User_Bloqueos()
{
	Panel.call(this);
}
Panel.registerSubclass(User_Bloqueos);

User_Bloqueos.uiFile = "user-bloqueos.jsp";
 
// events
User_Bloqueos.Events = {};
User_Bloqueos.Events.SAVE_USER = 0;

// UI properties
User_Bloqueos.prototype.form = "#Bloqueos_form";
User_Bloqueos.prototype.width = 550;

User_Bloqueos.prototype.init = function()
{
	var myself = this;
	this.find("#saveButton").click(function() { myself.saveUser(); return false; });
	this.find("#closeButton").click(function() { myself.close(); });
	
	this.prepareUserN4();
	this.prepareUserN4Cliente();
};
User_Bloqueos.prototype.prepareUserN4 = function()
{
	var myself = this;

	this.find("#nombre_agencia_excluir").autocomplete(
		{ 
			source: function(req, resp)
			{
				blockPage();
				var prevUrl = "";
				if($("#profileId option:selected").text() === "Transportista")
					prevUrl = 'rest/Transportista/likes/';
				else
					prevUrl = 'rest/UserN4/like.json?results=10&match=';
				jQuery.getJSON(prevUrl + encodeURIComponent(req.term.toUpperCase()), { }, resp);
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
				myself.find("#id_agencia_excluir").val(ui.item.key);
			}
	    });

	 $("nombre_agencia_excluir").keypress(function(){
		 if(jQuery("#nombre_agencia_excluir").val()=="")
			{
				jQuery("#id_agencia_excluir").val("")
			}
	    });
	 $("nombre_cliente_excluir").keypress(function(){
		 if(jQuery("#nombre_cliente_excluir").val()=="")
			{
				jQuery("#id_c_excluir").val("")
			}
	    });
}; 

User_Bloqueos.prototype.prepareUserN4Cliente = function()
{
	var myself = this;

	this.find("#nombre_cliente_excluir").autocomplete(
		{ 
			source: function(req, resp)
			{
				blockPage();
				var prevUrl = "";
				if($("#profileId option:selected").text() === "Transportista")
					prevUrl = 'rest/Transportista/likes/';
				else
					prevUrl = 'rest/UserN4/like.json?results=10&match=';
				jQuery.getJSON(prevUrl + encodeURIComponent(req.term.toUpperCase()), { }, resp);
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
				myself.find("#id_cliente_excluir").val(ui.item.key);
			}
	    });
}; 
 

User_Bloqueos.prototype.saveUser = function()
{
	var obj = this.getObject();
	obj.id = this.id;

	var myself = this;

	blockPage();
	jQuery.postJSON("rest/bloqueos_/save", obj, function(data)
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
			
			myself.performHandler(User_Bloqueos.Events.SAVE_USER, data.body);
		}
	});
};