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
	
	this.find("#saveDocumentButton").click(function() { myself.saveDocument(); });
	this.find("#cancelDocumentButton").click(function() { myself.close(); });
	
	this.getForm().attr("action", this.saveDocumentUrl);
};

Document_Panel.prototype.fillType = function(col)
{
	var select = this.find("#typeSelect");
	fillSelect(select, col, function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
};

Document_Panel.prototype.saveDocument = function()
{
	blockPage();

	// always set the function call back here as it may be cleared by the clear panel method
	this.getForm().find("#_callbackFunctionName").val("Document_Panel_saveDocumentCallback");
	this.getForm().submit();
	
	Document_Panel.current = this;
};


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
	}
};