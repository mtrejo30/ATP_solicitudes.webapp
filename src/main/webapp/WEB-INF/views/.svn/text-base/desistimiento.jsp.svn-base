<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:import url="/doctype.jsp" />
<html>

<!-- appointment jsp begins -->

<c:import url="/appointment.jsp" />

<!-- appointment jsp ends -->

<script>
	
function buildTransporterTableDefinition()
{
	transporterEdition = new JQGrid_Column_Edition();
	transporterEdition.grid = getTransporterTable();
	transporterEdition.afterColumnSave = afterColumnSave;
	transporterEdition.beforeEditCell = beforeEditCell;
	
	/*
	* transporter column
	*/
	var column = new JQGrid_Column_Model();
	column.name = "transporter";
	column.type = "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 2;
		
		opts.source = function(req, resp)
		{
			jQuery.getJSON("rest/Transportista/like.json?results=20&match=" + encodeURIComponent(req.term.toUpperCase()), { }, resp);
		};
		opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");	};
		return opts;
	};	
	transporterEdition.addColumn(column);
	
	/*
	* operator column
	*/
	column = new JQGrid_Column_Model();
	column.name = "operator";
	column.type = "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 3;
		opts.source = function(req, resp)
		{
			jQuery.getJSON("rest/OperadorTransportista/like.json?results=20&match=" + encodeURIComponent(req.term.toUpperCase()), { }, resp);
		};
		opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");	};
		return opts;
	};	
	transporterEdition.addColumn(column);
	
	/*
	* plates column
	*/
	column = new JQGrid_Column_Model();
	column.name = "plates";
	column.type = "text";
	column.dataInit = function(element) { jQuery(element).css({'width': '99%', 'height':'99%'}).addClass("inputToUppercase").attr('maxlength', 10); };
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{		
		getTransporterTable().jqGrid("setCell", rowid, 'plates', value.toUpperCase());
	};
	transporterEdition.addColumn(column);
	
	/*
	* date column
	*/
	column = new JQGrid_Column_Model();
	column.name = "date";
	column.type = "date";
	column.dateFormat = 'yy-mm-dd';
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		getTransporterTable().jqGrid('setCell', rowid, 'time', null);
	};
	transporterEdition.addColumn(column);
	
	/*
	* time column
	*/
	column = new JQGrid_Column_Model();
	column.name = "time";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		var rowData = getTransporterTable().jqGrid('getLocalRow', aColumn.getModel().cellInfo.rowid);		
		var opts = {};
		opts.sourceUrl = "appointment/get-time-slots.json";
		opts.sourceParams = { date : rowData.date };
		
// 		opts.optionObject = function(obj) {
// 			return {
// 				label : obj.descripcion,
// 				id : obj.special
// 			};
// 		};

		opts.sourceError = function(data) {
			window.setTimeout(function() { aColumn.cancelColumnValue(); }, 100);
			showMessage(data.message);
		};
		
		return opts;
	};
	transporterEdition.addColumn(column);
	
	
	
	/*
	* grid options
	*/
	transporterGridOptions = {
		caption : "<spring:message code='Transporters' />",
		datatype : 'local',
		data : transporterTableData,
		loadonce : true,
		cellEdit : true,
		cellsubmit : 'clientArray',
		pager : "#transporterPager",
		viewrecords : true,
		height : 150,
		sortname : 'id',
		sortorder : 'asc',
		width : '1000',
		shrinkToFit : false,
		forceFit : false,		

		colModel :
		[
			{ name : 'id', index : 'id', label : 'ID', align : 'right', width : 25, sortable : false, editable : false },
			{ name : 'extra', index : 'extra', hidden : true },
			{ name : 'appointmentId', index : 'appointmentId', hidden : true },
			{
				name : 'transporter',
				index : 'transporter',
				label : "<spring:message code='Transporter' />",
				width : 300,
				sortable : false,
				editable : true
			},
			{
				name : 'operator',
				index : 'operator',
				label : "<spring:message code='Operator' />",
				width : 300,
				sortable : false,
				editable : true
			},
			{
				name : 'plates',
				index : 'plates',
				label : "<spring:message code='Plates' />",
				width : 110,
				sortable : false,
				editable : true
				//editoptions : { style: "text-transform: uppercase", maxlength : 10},
			},
			{
				name : 'date',
				index : 'date',
				label : "<spring:message code='Date' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'time',
				index : 'time',
				label : "<spring:message code='Time' />",
				width : 130,
				sortable : false,
				editable : true
			},
			{
				name : 'appointments',
				index : 'appointments',
				sortable : false,
				editable : false,
				hidden: true
			}
		],		
		onCellSelect : function(rowid, iCol, cellcontent, e) {
			//The grid appointments table will change each time we select a different carrier
			var data =  getTransporterTable().jqGrid('getCell',rowid,'appointments');
			getTable().clearGridData(true).trigger("reloadGrid");	
			if(data != "")
			{
				data= JSON.parse(data);
				getTable().jqGrid("setGridParam", {data :data}).trigger("reloadGrid");
			}
		}	
	};
}
	
function buildTableDefinition()
{
	/*
	* Column Edition
	*/
	edition = new JQGrid_Column_Edition();
	edition.grid = getTable();
	edition.afterColumnSave = afterColumnSave;
	edition.beforeEditCell = beforeEditCell;
	
	/*
	* booking column
	*/
	var column = new JQGrid_Column_Model();
	column.name = "contenedor";
	column.type = "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 11;
		opts.maxLength = opts.minLength;
		opts.source = function(req, resp)
		{	
			//task #13
			if (!isValidContenedor(req.term))
			{
				unblockPage();
// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
// 						function(){aColumn.restoreColumn("contenedor");});
				showMessage("<spring:message code='Invalid_container_number_format' />");
				window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
			}
			else
			{
				//task #22
				var url = "rest/Contenedor/desistimiento/like.json?results=10&match="
						+ encodeURIComponent(req.term.toUpperCase())
						+ "&consigne=" + encodeURIComponent(solicitudUserCompanyCode);
				jQuery.getJSON(
						url,
						{},
						function(data) {
							if (data.length == 0) {
								unblockPage();
								//showCustomMessage("<spring:message code='Container_was_not_found' />", function(){aColumn.restoreColumn("contenedor");});
								showMessage("<spring:message code='Container_was_not_found' />");
								window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
							} else {
								resp(data);
							}
						});				
			}	
		};
		opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");	};
		return opts;
	};
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{	
		var rowData = getTable().jqGrid('getLocalRow', rowid);

		if (isRowRegistered(rowData))
		{
			showMessage("<spring:message code='Cannot_change_container_from_a_registered_appointment' />");
			window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
		}
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		var myColumn = this;

		jQuery.getJSON("rest/Contenedor/" + value.id, null, function(data)
		{
			var obj = data;

			// validates customer and shipper solicitud matches container
			try
			{
				validatesSolicitudInfoAgainstContainer(obj);
			}
			catch (ex)
			{
				showMessage(ex.getMessage());
				window.setTimeout(function() { myColumn.setColumnValue(myColumn.name, null); }, 100);
				return;
			}

			myColumn.setColumnValue('categoria.label', getColumnObjectForAtomicValue(obj.category));
			myColumn.setColumnValue('tipo.label', getColumnObjectForAtomicValue(obj.type_Iso));
			myColumn.setColumnValue('linea.label', getColumnObjectForAtomicValue(obj.line_Op));
			myColumn.setColumnValue('recintoDestino', getColumnObjectForAtomicValue(obj.recinto_Tit));
		});
	};	
	column.validate = function(value)
	{
		
	};
	edition.addColumn(column);

// 	edition.addColumn(getReferenciaColumn());

	/*
	* grid options
	*/
	gridOptions = {
		caption : "<spring:message code='Appointments' />",
		datatype : 'local',
		data : tableData,
		loadonce : true,
		cellEdit : true,
		cellsubmit : 'clientArray',
		pager : "#tablePager",
		viewrecords : true,
		height : 150,
		sortname : 'id',
		sortorder : 'asc',
		width : '1000',
		shrinkToFit : false,
		forceFit : false,

		colModel :
		[
			{ name : 'id', index : 'id', label : 'ID', align : 'right', width : 25, sortable : false, editable : false },
			{ name : 'extra', index : 'extra', hidden : true },
			{ name : 'appointmentId', index : 'appointmentId', hidden : true },
			{
				name : 'contenedor',
				index : 'contenedor',
				label : "<spring:message code='Container' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'categoria.label',
				index : 'categoria',
				label : "<spring:message code='Category' />",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text'
			},
			{
				name : 'tipo.label',
				index : 'tipo',
				label : "<spring:message code='Type' />",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text'
			},
			{
				name : 'linea.label',
				index : 'linea',
				label : "<spring:message code='Line' />",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text'
			},
			{
				name : 'recintoDestino',
				index : 'recintoDestino',
				label : "<spring:message code='Target_Recint' />",
				width : 130,
				sortable : false,
				editable : false,
				edittype : 'text'
			},
// 			{
// 				name : 'referencia',
// 				index : 'referencia',
// 				label : "<spring:message code='Reference' />",
// 				width : 110,
// 				sortable : false,
// 				editable : true,
// 				edittype : 'text'
// 			},
			{
				name : 'appointmentNbr',
				index : 'appointmentNbr',
				label : "<spring:message code='Appointment' />",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text'
			},
			{
				name : 'status',
				index : 'status',
				label : "<spring:message code='Status' />",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text'
			}
		],		
		onCellSelect : cellSelected,
		afterRestoreCell : function (rowid, value, iRow, iCol) {		
			var rowData = getTable().jqGrid('getLocalRow', rowid);
			if (!isRowRegistered(rowData))
				showMessageIfInvalidContenedor(iCol, "<spring:message code='Invalid_container_number_length' />");
		}
	};
} 
 
function operationValidateRowInfo(rowData)
{
	if (isDataEmpty(rowData.contenedor))
		throw new SolicitudError("<spring:message code='Container_must_be_defined' />");
}
</script>
</html>