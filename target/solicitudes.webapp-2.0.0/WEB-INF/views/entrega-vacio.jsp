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
var a;
var myColumn ;
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
	///////////////////////////////////////////para obtener el id de la tabla temporal //////////////////////////////7// 
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{		
		//alert($("#transporterTable").jqGrid('getLocalRow', iRow).id);
		 a= $("#transporterTable").jqGrid('getLocalRow', rowid).id;
		 getTransporterTable().jqGrid("setCell", rowid, 'idpadre_', a);
		jQuery("#id").val(a);
	};
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		time2 = $("#transporterTable").jqGrid('getLocalRow', rowid).time;
		jQuery("#time_").val(time2);
		//alert("--prueba--"+time2)
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
		rowNum: 1000,
		cellsubmit : 'clientArray',
		pager : "#transporterPager",
		viewrecords : true,
		height : 150,
		//sortname : 'id',
		//sortorder : 'asc',
		width : '1000',
		shrinkToFit : false,
		forceFit : false,		

		colModel :
		[
			{ name : 'id', index : 'id', label : 'ID', align : 'right', width : 25, sortable : false, editable : false },
			{
				name : 'idpadre_',
				index : 'idpadre_',
				label : "ID",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text',
				hidden : true
			},
			{ name : 'extra', index : 'extra', hidden : true },
			{ name : 'appointmentId', index : 'appointmentId', hidden : true },
			{
				name : 'transporter',
				index : 'transporter',
				label : "<spring:message code='Transporter' />",
				width : 300,
				sortable : false,
				editable : vltransportista
			},
			{
				name : 'operator',
				index : 'operator',
				label : "<spring:message code='Operator' />",
				width : 300,
				sortable : false,
				editable : vloperador
			},
			{
				name : 'plates',
				index : 'plates',
				label : "<spring:message code='Plates' />",
				width : 110,
				sortable : false,
				editable : vlplacas
				//editoptions : { style: "text-transform: uppercase", maxlength : 10},
			},
			{
				name : 'date',
				index : 'date',
				label : "<spring:message code='Date' />",
				width : 110,
				sortable : false,
				editable : vlfecha,
				edittype : 'text'
			},
			{
				name : 'time',
				index : 'time',
				label : "<spring:message code='Time' />",
				width : 130,
				sortable : false,
				editable : vlhora
			},
			{
				name : 'appointments',
				index : 'appointments',
				sortable : false,
				editable : false,
				hidden: true
			}
			
			
		],		
		onCellSelect : function(rowid, iCol, cellcontent, e) 
		{
			//The grid appointments table will change each time we select a different carrier
			var data =  getTransporterTable().jqGrid('getCell',rowid,'appointments');
			getTable().clearGridData(true).trigger("reloadGrid");	
			if(data != "")
			{
				//alert("tablatransportes"+rowid);
				 a= $("#transporterTable").jqGrid('getLocalRow', rowid).id;
				jQuery("#id").val(a);
				data= JSON.parse(data);
				getTable().jqGrid("setGridParam", {data :data}).trigger("reloadGrid");
			}
			else
				{a= $("#transporterTable").jqGrid('getLocalRow', rowid).id;
				jQuery("#id").val(a);}
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
    var id_booking;
    var id_booking_item;
	/*
	* booking column
	*/
	var column = new JQGrid_Column_Model();
	column.name = "booking";
	column.type = "custom";
	column.custom_options = function(aColumn)
	{
		var opts = { };
		opts.enableKeyEvent = true;
		
		return opts;
	};
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
		var rowData = getTable().jqGrid('getLocalRow', rowid);

		if (isRowRegistered(rowData))
		{
			showMessage("<spring:message code='Cannot_change_booking_from_a_registered_appointment' />");
			window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
		}
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		
		agenciavalidacion =$("#solicitudAgenciaAduanalId").val();
		clientevalidacion=$("#solicitudClienteId").val();
		var myColumn = this;
		var isValid = false;
		if($('#folioSolicitud').val() == "IST"){
			if(value.label.toUpperCase().substring(0,1) === "S" && !value.label.toUpperCase().substring(1,3) === "LD" || value.label.toUpperCase().substring(0,1) === "S" && !value.label.toUpperCase().substring(1,4) === "UDU"
				|| value.label.toUpperCase().substring(0,1) === "S" && !value.label.toUpperCase().substring(1,4) === "SPH")
				isValid = true;
			else
				isValid = false;
		}else{
			if(value.label.toUpperCase().substring(0,1) === "S")
				if(value.label.toUpperCase().substring(1,3) === "LD" || value.label.toUpperCase().substring(1,4) === "UDU"|| value.label.toUpperCase().substring(1,4) === "SPH")
					isValid = true;
				else
					isValid = false;
			else
				isValid = true;
		}
		if(isValid){
			var myColumn = this;
	
			var bookingCode = value.label;
			
			// if gate is IST and booking starts with S avoid process
			try
			{
				validateBookingForGate(bookingCode);
			}
			catch (ex)
			{
				showMessage(ex.getMessage());
				window.setTimeout(function() { myColumn.setColumnValue('booking', null); }, 100);
				return;
			}
			blockPage();
			jQuery.getJSON("rest/Booking/name.json?results=10&name=" + value, null, function(data)
			{
				
				
				unblockPage();
				if (typeof data[0] === "undefined"){
					showMessage("<spring:message code='Booking_not_registered_on_system_please_verify_check' />");
					window.setTimeout(function() { myColumn.setColumnValue('booking', null); }, 100);
				}
				else
				{
					id_booking = data[0].id;
					var linea = data[0].linea;
					myColumn.setColumnValue('linea.label', getColumnObjectForAtomicValue(linea));
					lineavalidacion=getColumnObjectForAtomicValue(linea);
				}
			});
		}else{
			setBookingData(null);
			showMessage("<spring:message code='Booking_not_filter' />");
			window.setTimeout(function() { myColumn.setColumnValue('booking', null); }, 100);
		}
	};
	column.validate = function(value)
	{
	};
	edition.addColumn(column);

	/*
	* tipo column
	*/
	column = new JQGrid_Column_Model();
	column.name = "tipo";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		
		var rowData = getTable().jqGrid('getLocalRow', aColumn.getModel().cellInfo.rowid);
		var bookingId = rowData.booking.id;
        
		var opts = { };
		opts.sourceUrl = "rest/BookingItem/searchType.json";
		
		opts.sourceParams = { bookingId: id_booking};
		
		opts.optionObject = function(obj) { return { label : obj.typeIso, id : obj.id }; };

		opts.sourceError = function(data)
		{
			
			window.setTimeout(function() { aColumn.restoreColumn('tipo'); }, 100);
			showMessage(data.message);
		}
		return opts;
		
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		 myColumn = this;
		myColumn.setColumnValue('clase', getColumnObjectForAtomicValue(null));
		tipovalidacion=myColumn.getColumnValue('tipo');
		
		validaciontipos1();
	};
	column.validate = function(value)
	{
	};
	edition.addColumn(column);

	/*
	* clase column
	*/
	column = new JQGrid_Column_Model();
	column.name = "clase";
	column.type= "dropdown";
	column.dropdown_options = function(aColumn)
	{
		var rowData = getTable().jqGrid('getLocalRow', aColumn.getModel().cellInfo.rowid);

		var bookingId = rowData.booking.id;
		var bookingItemId = rowData.tipo.id;
		var opts = { };
		opts.sourceUrl = "rest/BookingItem/search.json";
		opts.sourceParams = { bookingId: id_booking, bookingItemId: bookingItemId };
		opts.optionObject = function(obj) { return { label : obj.grade, id : obj.id }; };
		opts.sourceError = function(data)
		{
			window.setTimeout(function() { aColumn.restoreColumn('clase'); }, 100);
			showMessage(data.message);
		};
		
		return opts;
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
	};
	column.validate = function(value)
	{
	};
	edition.addColumn(column);
	///////////////////////////////////////columna de id padre///////////////////////////////////////////////////////////////////////////
   

	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
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
				name : 'booking',
				index : 'booking',
				label : "<spring:message code='Booking' />",
				width : 110,
				sortable : false,
				editable : true
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
				name : 'tipo',
				index : 'tipo',
				label : "<spring:message code='Type' />",
				width : 110,
				sortable : false,
				editable : true
			},
			{
				name : 'clase',
				index : 'clase',
				label : "<spring:message code='Class' />",
				width : 110,
				sortable : false,
				editable : true
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
		afterRestoreCell : function (rowid, value, iRow, iCol, cellcontent, e) 
		{
		  
		}
	};
}

function operationValidateRowInfo(rowData)
{
	if (isDataEmpty(rowData.booking))
		throw  "Ingresar un Booking";

	if (isDataEmpty(rowData.tipo))
		throw  "Seleccionar unTipo";

	if (isDataEmpty(rowData.clase))
		throw  "debe seleccionar una clase";
}

function eliminardatos()
{
	   myColumn.setColumnValue('booking',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('tipo',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('linea.label',getColumnObjectForAtomicValue(""));				
}

</script>
</html>