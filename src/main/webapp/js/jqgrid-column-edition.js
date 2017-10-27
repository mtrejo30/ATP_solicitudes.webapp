function JQGrid_Column_Edition()
{
	this.grid = null;

	this.cellInfo =
	{
		row : 0,
		col : 0,
		rowid : 0,
		edition : false
	};

	this.selection = { };
	this.columns = { };
	
	this.uniqueId = 0;
}

JQGrid_Column_Edition.prototype.getUniqueId = function()
{
	this.uniqueId++;
	return this.uniqueId;
};

JQGrid_Column_Edition.prototype.computeOptionsForGrid = function(gridOptions)
{
	var options = { };

	var myself = this;

	options.beforeEditCell = function() { myself.call_beforeEditCell.apply( myself, arguments ); };
	options.afterSaveCell = function() { myself.call_afterSaveCell.apply( myself, arguments ); };

	this.mergeColumnsWithOptions(gridOptions);

	return jQuery.extend(gridOptions, options);
};


JQGrid_Column_Edition.prototype.mergeColumnsWithOptions = function(gridOptions)
{
	var myself = this;

	jQuery.each(this.columns, function(eachColumnIndex, eachColumn)
	{
		var colName = eachColumn.name;
		
		var colModel = myself.getColModelFromOptions(colName, gridOptions);

		if (colModel != null)
		{
			eachColumn.applyOptionsToColModel(colModel);
		}
	});
};

JQGrid_Column_Edition.prototype.getColModelFromOptions = function(columnName, gridOptions)
{
	var colModel = null;

	jQuery.each(gridOptions.colModel, function(eachColumnIndex, eachColumn)
	{
		if (eachColumn.name == columnName)
		{
			colModel = eachColumn;
			// stop the execution, condition met, return false
			return false;
		}
	});
	
	return colModel;
};

JQGrid_Column_Edition.prototype.call_beforeEditCell = function(rowid, cellname, value, iRow, iCol)
{
	this.cellInfo.row = iRow;
	this.cellInfo.col = iCol;
	this.cellInfo.rowid = rowid;

	var columnModel = this.columns[cellname];
	
	if (columnModel != null)
		if (columnModel.beforeEdit != null)
			columnModel.beforeEdit.apply(columnModel, arguments);
	
	if (this.beforeEditCell != null)
		this.beforeEditCell.apply(this, arguments);
};

JQGrid_Column_Edition.prototype.call_afterSaveCell = function(rowid, cellname, value, iRow, iCol)
{
	var columnModel = this.columns[cellname];
	
	if (columnModel != null)
		if (columnModel.afterSave != null)
			columnModel.afterSave.apply(columnModel, arguments);
	
	if (this.afterColumnSave != null)
		this.afterColumnSave.apply(this, arguments);
};

JQGrid_Column_Edition.prototype.addColumn = function(aColumn)
{
	this.columns[aColumn.name] = aColumn;

	aColumn.grid = this.grid;
	aColumn.model = this;
};


/*
 * 
 */

function JQGrid_Column_Model()
{
	this.name = null;
	this.model = null;
	this.grid = null;
	this.type = null;
};

JQGrid_Column_Model.prototype.getGrid = function()
{
	return this.grid;
};

JQGrid_Column_Model.prototype.getModel = function()
{
	return this.model;
};

JQGrid_Column_Model.prototype.applyOptionsToColModel = function(colModel)
{
	var myself = this;

	if (this.type == "autocomplete" || this.type == "dropdown" || this.type == "custom")
	{
		colModel.edittype = 'custom';

		colModel.unformat = function(cellValue, options, cell)
		{
			var rowId = options.rowId;
			
			var rowData = myself.getGrid().jqGrid('getLocalRow', rowId);
			var cellData = rowData[options.colModel.index];

			return cellData == null ? '' : cellData;
		};

		colModel.formatter = function(value)
		{
			if (value == null)
				return '';

			// if is an object with a label property
			if (value.label != null)
				return value.label;

			// if atomic value (no object)
			return value;
		};
	}
	
	// make sure we have the editoptions attribute
	if (colModel.editoptions == null)
		colModel.editoptions = { };

	if (this.type == "autocomplete")
		this.apply_autocomplete_colModel(colModel);
	if (this.type == "dropdown")
		this.apply_dropdown_colModel(colModel);
	if (this.type == "custom")
		this.apply_custom_colModel(colModel);
	if (this.type == 'date')
	{
		colModel.editoptions.dataInit = function(elem)
		{
			jQuery(elem).addClass("customelement");
			jQuery(elem).datepicker({dateFormat: myself.dateFormat});
			
			jQuery(elem).change(function()
			{
				myself.getGrid().jqGrid('saveCell', myself.getModel().cellInfo.row, myself.getModel().cellInfo.col);
			});
		};
	}
	
	if (this.dataInit != null)
	{
		colModel.editoptions.dataInit = this.dataInit;
	}

	if (this.validate != null)
	{
		colModel.editrules = { custom : true };
		
		colModel.editrules.custom_func = function(value, property)
		{
			try
			{
				myself.validate(value);
				return [true];
			}
			catch (exception)
			{
				return [false, exception];
			}
		};
	}
};

// regular operations

JQGrid_Column_Model.prototype.cancelColumnValue = function()
{
	this.getGrid().jqGrid('restoreCell', this.getModel().cellInfo.row, this.getModel().cellInfo.col);
};

JQGrid_Column_Model.prototype.restoreColumn = function(aColumn)
{
	this.getGrid().jqGrid('restoreCell', this.getModel().cellInfo.row, aColumn);
};

JQGrid_Column_Model.prototype.acceptColumnValue = function(obj)
{
	this.currentValue = obj;
	this.getGrid().jqGrid('saveCell', this.getModel().cellInfo.row, this.getModel().cellInfo.col);
};

JQGrid_Column_Model.prototype.setColumnValue = function(columnName, obj)
{
	this.getGrid().jqGrid('setCell', this.getModel().cellInfo.rowid, columnName, obj);
};

JQGrid_Column_Model.prototype.getRow = function()
{
	return this.getGrid().jqGrid('getLocalRow', this.getModel().cellInfo.rowid);
};

JQGrid_Column_Model.prototype.getColumnValue = function(columnName)
{
	var rowData = this.getRow();
	return rowData[columnName];
};

// apply custom properties

JQGrid_Column_Model.prototype.apply_autocomplete_colModel = function(colModel)
{
	var myself = this;

	var editoptions = { };
	colModel.editoptions = editoptions;
	
	editoptions.maxLength = 4;

	editoptions.custom_element =  function(value, options)
	{
		var field = jQuery('<input>');

		field.css("width", "99%");
		field.css("height", "99%");		

		var rowData = myself.getGrid().jqGrid('getLocalRow', myself.getModel().cellInfo.rowid);
		var info = rowData[options.name];
		myself.currentValue = info;

		if (info != null)
			field.val(info.label);

		var dynamic_autocomplete_options = myself.autocomplete_options(myself);
		
		//maxLength 
		if (typeof dynamic_autocomplete_options.maxLength != 'undefined')
			field.attr("maxLength", dynamic_autocomplete_options.maxLength);		

		var autocomplete_options = {
//			minLength : 3,
			select : function(event, ui)
			{
				if (ui.item)
				{
					myself.acceptColumnValue(new JQGrid_Column_Value(ui.item.key, ui.item.value));
				}
			},

			search : function(event, ui)
			{
				blockPage();
			},

			open : function(event, ui)
			{
				unblockPage();
			},

			response : function(event, ui)
			{
				unblockPage();
			}
		};

		field.autocomplete(jQuery.extend(dynamic_autocomplete_options, autocomplete_options));

		setTimeout(function() { field.focus(); }, 100);

		return field;
	};
	
	editoptions.custom_value = function(elem, operation, value)
	{
		if (operation == 'get')
		{
			return myself.currentValue == null ? "" : myself.currentValue;
		}
	};
};

JQGrid_Column_Model.prototype.apply_dropdown_colModel = function(colModel)
{
	var myself = this;

	var editoptions = { };
	colModel.editoptions = editoptions;

	editoptions.custom_element =  function(value, options)
	{
		var field = jQuery('<select>');

		field.css("width", "95%");
		field.find('option').remove();

		var rowData = myself.getGrid().jqGrid('getLocalRow', myself.getModel().cellInfo.rowid);
		var info = rowData[options.name];
		myself.currentValue = info;

		var dynamic_dropdown_options = myself.dropdown_options(myself);

		// if no sourceUrl
		if (dynamic_dropdown_options.sourceUrl == null)
		{
			var staticData = dynamic_dropdown_options.staticData;
			if (null != staticData)
			{
				field.append(new Option("", null));
				jQuery.each(staticData, function(eachIndex, eachObject)
				{
					//console.log(eachObject.linea);
					field.append(new Option(eachObject.linea, eachObject.id));
				});
				
				if (info != null)
					field.val(info.id);
			}
			
			setTimeout(function() { field.focus(); }, 100);
			
			field.change(function()
			{
				var opt = field.find('option:selected');
				myself.acceptColumnValue(new JQGrid_Column_Value(opt.val(), opt.text()));
			});
			
			return field;
		}

		blockPage();

		jQuery.postJSON(dynamic_dropdown_options.sourceUrl, dynamic_dropdown_options.sourceParams,
		function(data)
		{
			unblockPage();

			if (data.error)
			{
				if (dynamic_dropdown_options.sourceError != null)
					dynamic_dropdown_options.sourceError(data);
			}
			else
			{
				var col = data.body;
	
				field.append(new Option("", null));

				jQuery.each(col, function(eachIndex, eachObject)
				{
					var eachSelObj = { };

					if (dynamic_dropdown_options.optionObject != null)
					{
						eachSelObj = dynamic_dropdown_options.optionObject(eachObject);
					}
					else
					{
						var label = dynamic_dropdown_options.elementLabel == null ?
							eachObject.toString()
							:
							dynamic_dropdown_options.elementLabel(eachObject);

						eachSelObj.id = eachObject.id;
						eachSelObj.label = label;
					}

					field.append(new Option(eachSelObj.label, eachSelObj.id));
				});

				if (info != null)
					field.val(info.id);
			}
			
			return field;
		},
		function(errorData)
		{
			unblockPage();
		}
		);

		setTimeout(function() { field.focus(); }, 100);
		
		field.change(function()
		{
			var opt = field.find('option:selected');
			myself.acceptColumnValue(new JQGrid_Column_Value(opt.val(), opt.text()));
		});

		return field;
	};
	
	editoptions.custom_value = function(elem, operation, value)
	{
		if (operation == 'get')
		{
			return myself.currentValue == null ? "" : myself.currentValue;
		}
	};
};

JQGrid_Column_Model.prototype.apply_custom_colModel = function(colModel)
{
	var myself = this;

	var editoptions = { };
	colModel.editoptions = editoptions;

	editoptions.pressed = false;
	//this don't do anything, just to remember this is possible
	editoptions.dataEvents = 
	[{   
	 	type:'keypress', fn:function(e) 
	 	{
	 		
	 	}
	}];
	editoptions.custom_element =  function(value, options)
	{
		var field = jQuery('<input>');

		field.css("width", "99%");
		field.css("height", "99%");
		field.css("text-transform", "uppercase");

		var rowData = myself.getGrid().jqGrid('getLocalRow', myself.getModel().cellInfo.rowid);
		var info = rowData[options.name];
		myself.currentValue = info;

		var opts = myself.custom_options(myself);
		if (opts != null)
		{
			if (opts.enableKeyEvent)
			{
				field.keydown(function(event) 
				{
					//Enter
					if (event.which == 13) 
					{
						//alert(field.val());
						//we should use booking's key instead of rowid, we are changing it on the corresponding getJSON function.
						myself.acceptColumnValue(new JQGrid_Column_Value(myself.getModel().cellInfo.rowid, field.val().toUpperCase()));
					}
				});
			}
		}
		
		setTimeout(function() { field.focus(); }, 100);

		return field;
	};
	
	editoptions.custom_value = function(elem, operation, value)
	{
		if (operation == 'get')
		{
			return myself.currentValue == null ? "" : myself.currentValue;
		}
	};
};


function JQGrid_Column_Value(id, label)
{
	this.id = id;
	this.label = label;
}

JQGrid_Column_Value.prototype.toString = function()
{
	return this.label;
};