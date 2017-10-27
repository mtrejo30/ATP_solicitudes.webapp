function Panel()
{
	this.parent = null;
	this.handlers = {};
	this.id = null;
}

Panel.registerSubclass = function(anObject)
{
	//jQuery.extend(anObject.prototype, Panel.prototype);
	//anObject.prototype._super = Panel.prototype;
	
	anObject.prototype = new Panel();
	anObject.prototype.constructor = anObject;
	anObject.prototype._super = Panel.prototype;
};

Panel.prototype.form = "#";
Panel.prototype.width = 600;

Panel.prototype.load = function(panelHtmlFile, initCallbackFunction)
{
	var myself = this;
	this.parent.load(panelHtmlFile + "?ts=" + new Date().getTime(), function() { initCallbackFunction(myself); });
};

Panel.prototype.init = function()
{
	// usually overwrited by subclasses to initialize DOM elements events or jQuery plugins
};

Panel.prototype.find = function(strSelector)
{
	return this.parent.find(strSelector);
};

Panel.prototype.registerHandler = function(handlerName, handlerAction)
{
	this.handlers[handlerName] = handlerAction;
};

Panel.prototype.performHandler = function(handlerName, extraData)
{
	var handler = this.handlers[handlerName];
	var sender = this;

	if (handler != null)
		handler(sender, extraData);
};

Panel.prototype.functionForHandler = function(handlerName)
{
	var myself = this;
	var func = function() { return myself.performHandler(handlerName); };
	
	return func;
};

Panel.prototype.getForm = function()
{
	return this.parent.find(this.form);
};

Panel.prototype.getObject = function()
{
	var obj = this.getForm().serializeObject();
	
	return obj;
};

Panel.prototype.clean = function()
{
	this.getForm().find(':input').val('');
	
	this.id = null;
};

Panel.prototype.fillFrom = function(object)
{
	if (object == null)
		return;

	var form = this.getForm();
	var myself = this;
	
	jQuery.each(object, function(propertyName, propertyValue)
	{
		var element = form.find("#" + propertyName);

		var value = myself.getValueForProperty(propertyName, propertyValue);

		element.val(value);
	});
};

Panel.prototype.getValueForProperty = function(propertyName, propertyValue)
{
	return propertyValue;
};

Panel.prototype.open = function(title)
{
	var container = jQuery(this.parent);
	
	container.dialog
    (
        {
        	title: title,
        	width: this.width,
            autoOpen: false,
            resizable: false,
            modal: true,
        }
    );

	container.dialog("open");
};

Panel.prototype.close = function()
{
	var container = jQuery(this.parent);
	container.dialog("close");
};

Panel.prototype.toMoney = function(numberValue)
{
	return numberValue.toMoney(2, ".", ",");
};

Panel.prototype.getDateFromDDMMYY = function(dateStr)
{
	var value = moment(dateStr, ['DD-MM-YY', 'DD-MM-YYYY']);
	
	return value.toDate();
};

Panel.prototype.getDateAsYYYYMMDD = function(aDate)
{
	return moment(aDate).format("YYYY-MM-DD");
};

Panel.prototype.getDateAsYYMMDD = function(aDate)
{
	return moment(aDate).format("YY-MM-DD");
};

Panel.prototype.getDateAsDDMMYY = function(aDate)
{
	return moment(aDate).format("DD-MM-YY");
};

Panel.prototype.getDateAsDDMMMYY = function(aDate)
{
	return moment(aDate).format("DD-MMM-YY");
};
