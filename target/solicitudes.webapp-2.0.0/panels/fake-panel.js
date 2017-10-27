function Fake_Panel()
{
	Panel.call(this);
}
Panel.registerSubclass(Fake_Panel);

Fake_Panel.uiFile = "fake-panel.jsp";

// UI properties
Fake_Panel.prototype.form = "#fake_form";
Fake_Panel.prototype.width = 450;

Fake_Panel.prototype.init = function()
{
	var myself = this;
	this.find("#saveButton").click(function() { myself.save(); });
	this.find("#cancelButton").click(function() { myself.cancel(); });
};

Fake_Panel.prototype.save = function()
{
	var obj = this.getObject();
	this.column.acceptColumnValue(new JQGrid_Column_Value(obj.id, obj.label));
	this.close();
};

Fake_Panel.prototype.cancel = function()
{
	this.column.cancelColumnValue();
	this.close();
};