function Holiday_Panel()
{
	Panel.call(this);
}

Panel.registerSubclass(Holiday_Panel);
Holiday_Panel.uiFile = "holiday-panel.jsp";

//UI properties
Holiday_Panel.prototype.form = "#holiday_form";
Holiday_Panel.prototype.width = "auto";

//events
Holiday_Panel.Events = {};
Holiday_Panel.Events.SAVE_DAY = 0;

Holiday_Panel.prototype.init = function()
{
	var myself = this;
	
	this.find("#saveHolidayButton").click(function() { myself.saveDay(); });
	this.find("#cancelHolidayButton").click(function() { myself.close(); });
};

Holiday_Panel.prototype.saveDay = function()
{
	var obj = this.getObject();
	obj.id = this.id;

	var myself = this;

	blockPage();
	jQuery.postJSON("holiday/save-holiday.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			myself.close();
			showMessage("Día Guardado");
			
			myself.performHandler(Holiday_Panel.Events.SAVE_DAY, data.body);
		}
	});
};

Holiday_Panel.prototype.getValueForProperty = function(propertyName, propertyValue)
{
	var result = null;

	if (propertyName == "date")
	{
		var date = new Date(propertyValue);
		result = this.getDateAsYYYYMMDD(date);
	}
	else
	{
		result = this._super.getValueForProperty(propertyName, propertyValue);
	}
	
	return result;
};