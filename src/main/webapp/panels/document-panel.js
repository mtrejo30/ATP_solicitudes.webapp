function Document_Panel()
{
	this.saveDocumentUrl = null;

	Panel.call(this);
}

Panel.registerSubclass(Document_Panel);
Document_Panel.uiFile = "document-panel.jsp";

//UI properties
Document_Panel.prototype.form = "#document_form";
Document_Panel.prototype.width = 510;

//events
Document_Panel.Events = {};
Document_Panel.Events.DOCUMENT_SAVED = 0;

Document_Panel.prototype.init = function()
{	
	var myself = this;
	validacion();
	this.find("#saveDocumentButton").click(function() { myself.saveDocument(); });
	this.find("#cancelDocumentButton").click(function() {validacion(); myself.close(); });
	
	this.getForm().attr("action", this.saveDocumentUrl);
	this.documento();
};

Document_Panel.prototype.fillType = function(col)
{
	var select = this.find("#typeSelect");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

Document_Panel.prototype.saveDocument = function()
{
	if($("#linea").val()=="")
		{$("#linea").val("No Aplica")}
	
	if($("#ferrocaril").val()=="")
		{$("#ferrocaril").val("No Aplica")}
	
	if($("#bltxt").val()=="")
	{$("#bltxt").val("No Aplica")}
	
	if($("#pedimentotxt").val()=="")
	{$("#pedimentotxt").val("No Aplica")}
	
	blockPage();

	// always set the function call back here as it may be cleared by the clear panel method
	
	this.getForm().find("#_callbackFunctionName").val("Document_Panel_saveDocumentCallback");
	this.getForm().submit();
	Document_Panel.current = this;
	
};
Document_Panel.prototype.documento =function()
{
	jQuery("#typeSelect").change(function ()
			{ 
				var tipo =jQuery("#typeSelect").val();
			    if(tipo ==0)
			    	{
			    		jQuery("#blfieldlabel").show();
			    		jQuery("#bltxt").show();
			    		jQuery("#linealabel").show();
			    		jQuery("#linea_").show();
			    		jQuery("#ferrocarrillabel").show();
			    		jQuery("#ferrocarril_").show();
			    		jQuery("#pedimentoFileLabel").hide();
			    		jQuery("#pedimentotxt").hide();
			    		if($("#linea").val()=="")
			    		{$("#linea").val("Inactivo")}
			    	
			    	if($("#ferrocaril").val()=="")
			    		{$("#ferrocaril").val("Inactivo")}
			    	}
			    if(tipo ==1)
			    	{
				    	jQuery("#blfieldlabel").hide();
			    		jQuery("#bltxt").hide();
			    		jQuery("#pedimentoFileLabel").show();
			    		jQuery("#pedimentotxt").show();
			    		jQuery("#linealabel").hide();
			    		jQuery("#linea_").hide();
			    		jQuery("#ferrocarrillabel").hide();
			    		jQuery("#ferrocarril_").hide();
			    	}
			    if(tipo >1)
			    	{validacion();}
		    });

}

Document_Panel_saveDocumentCallback = function(response)
{
	unblockPage();

	if (response.error)
	{
		showMessage(response.message);
	}
	else
	{
		Document_Panel.current.clean();
		Document_Panel.current.close();

		if (response.message.length > 0)
			showMessage(response.message);

		Document_Panel.current.performHandler(Document_Panel.Events.DOCUMENT_SAVED, response.body);
		validacion();
	}
};


function validacion()
{
	jQuery("#blfieldlabel").hide();
	jQuery("#bltxt").hide();
	jQuery("#pedimentoFileLabel").hide();
	jQuery("#pedimentotxt").hide();
	jQuery("#linealabel").hide();
	jQuery("#linea_").hide();
	jQuery("#ferrocarrillabel").hide();
	jQuery("#ferrocarril_").hide();
	}


function validarchecklinea()
{
	if($("#linea_").is(':checked')) {  
		$("#linea").val("Activo"); 
    } else {  
    	$("#linea").val("Inactivo");
    }  
		
}

function validarcheckferrocarril()
{
	if($("#ferrocarril_").is(':checked')) {  
		$("#ferrocaril").val("Activo");
    }
	else
		{$("#ferrocaril").val("Inactivo");}
}