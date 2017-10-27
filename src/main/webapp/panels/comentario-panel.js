function Comentario_Panel()
{
	Panel.call(this);
	
	this.uiMessages = {};
	this.restUrls = {};
	this.mergeObject = null;
	this.ownerId = null;
}

Comentario_Panel.Events = {};
Comentario_Panel.Events.COMENTARIO_SAVED = 0;

Panel.registerSubclass(Comentario_Panel);

Comentario_Panel.prototype.form = "#comentario_form";
Comentario_Panel.prototype.width = 550;

Comentario_Panel.prototype.init = function()
{
	var myself = this;

	this.parent.find("#saveButton").click(function() { myself.saveComment(); } );
};

Comentario_Panel.prototype.update = function()
{
	var myself = this;
	
	var obj = { };

	blockPage();
	jQuery.getJSON(this.restUrls.list + this.ownerId, obj, function(data)
	{
		if (data.error)
		{
			showMessage(data.message);
		}
		else
		{
			myself.fillFrom(data);
		}
	});
};	

Comentario_Panel.prototype.fillFrom = function(objectCol)
{
	var comentariosDiv = this.getComentariosDiv();
	comentariosDiv.html("");

	var myself = this;

	jQuery.each(objectCol, function(eachComentarioIndex, eachComentario)
	{
		myself.addComentario(eachComentario, comentariosDiv);
	});
	
	comentariosDiv.scrollTop(comentariosDiv[0].scrollHeight);
	
	unblockPage();
};

Comentario_Panel.prototype.getComentariosDiv = function()
{
	return this.parent.find("#comentarios_div");
};

Comentario_Panel.prototype.addComentario = function(comentario, comentariosDiv)
{
	var commentDiv = jQuery("<div>");
	commentDiv.addClass("comentario_record");
	
	var bodyDiv = jQuery("<div>");
	bodyDiv.addClass("comentario_body");
	
	var convertEnters = comentario.comentario.replace(/\n/g, '<br/>');

	bodyDiv.html(convertEnters);

	commentDiv.append(bodyDiv);

	var jsDate = new Date(comentario.fecha);
	var momentDate = moment(jsDate);

	var footerDiv = jQuery("<div>");
	footerDiv.addClass("comentario_footer");
	footerDiv.html("escrito por " + comentario.usuarioNombre + " - " + momentDate.format("DD/MMMM/YYYY hh:mm:ss A"));

	commentDiv.append(footerDiv);
	
	comentariosDiv.append(commentDiv);
};

Comentario_Panel.prototype.setOwnerId = function(id)
{
	this.ownerId = id;
};

Comentario_Panel.prototype.saveComment = function()
{
	var obj = jQuery.extend(this.mergeObject, this.getObject());

	var myself = this;

	blockPage();
	jQuery.postJSON(this.restUrls.save, obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message);
		}
		else
		{
			if (myself.uiMessages.saveMessage != null)
				showMessage(myself.uiMessages.saveMessage);

			myself.clean();
			
			jQuery.getJSON(myself.restUrls.get + data.id, {}, function(innerData)
			{
				var div = myself.getComentariosDiv();
				myself.addComentario(innerData, div);
				div.scrollTop(div[0].scrollHeight);
			});

			myself.performHandler(Comentario_Panel.Events.COMENTARIO_SAVED, data);
		}
	});
};