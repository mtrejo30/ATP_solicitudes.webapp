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
		var myColumn = this;
		
		blockPage();
		var jqxhr = 
			jQuery.getJSON("rest/Booking/name.json?results=10&name=" + encodeURIComponent(value.label.toUpperCase()), 
			{}, 
			function(data) 
			{
				if (data.isEmpty())
				{
					setBookingData(null);
					showMessage("<spring:message code='Booking_not_found' />");
					window.setTimeout(function() { myColumn.setColumnValue('booking', null); }, 100);
				} 
				else
				{				
			 		setBookingData(data);
			 		// if gate is IST and booking starts with S avoid process
			 		try
			 		{
			 			//data is an Array filled with bookings that have same name but different line
			 			validateBookingForGate(data[0].nombre);
			 		}
			 		catch (ex)
			 		{
			 			setBookingData(null);
			 			showMessage(ex.getMessage());
			 			window.setTimeout(function() { myColumn.setColumnValue('booking', null); }, 100);
			 			return;
			 		}			 	
			 		
			 		var isRegistered = data.some(function(element, index, array) 
			 		{
			 			return element.hasOwnProperty('linea') && element['linea'] != "";			 			
			 		});
			 		
			 		if (!isRegistered)
			 		{
			 			showMessage("<spring:message code='Booking_not_registered_on_system_please_verify_check' />");
		 				window.setTimeout(function() { myColumn.setColumnValue('booking', null); }, 100);
			 		}			 					 		
				}
				//clear all fields each time we entered a new booking
				window.setTimeout(function() 
				{ 
					myColumn.setColumnValue('linea', null);
					myColumn.setColumnValue('buqueViaje.label', null);
					myColumn.setColumnValue('pod', null);
					myColumn.setColumnValue('fpod', null);
					myColumn.setColumnValue('fk', null);
	
					myColumn.setColumnValue('tipo', null);
					myColumn.setColumnValue('contenedor', null);
					myColumn.setColumnValue('contenido', null);
				}, 100);
			}
		)
		.always(function() 
		{
			unblockPage();
		});
	};
	column.validate = function(value) 
	{
		if (value.label.trim().length == 0)
			throw ("<spring:message code='Booking_must_be_defined' />");
	};
	edition.addColumn(column);
	
	/*
	* Linea column
	*/

	column = new JQGrid_Column_Model();
	column.name = "linea";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		return { staticData : getBookingData() };
	};
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
		var rowData = getTable().jqGrid('getLocalRow', rowid);

		if (isRowRegistered(rowData))
		{
			showMessage("<spring:message code='Cannot_change_line_from_a_registered_appointment' />");
 			window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
		}
		else
		{
			if (rowData.booking == null || rowData.booking.label == null)
			{
				showMessage("<spring:message code='You_have_to_select_a_booking' />");
				window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
			}
		}		
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		var myColumn = this;

 		blockPage();
 		jQuery.getJSON("rest/Booking/" + value.id, null, function(data)
 		{
 			unblockPage();

			myColumn.setColumnValue('buqueViaje.label', getColumnObjectForAtomicValueWithId(data.buqueViajeNombre+ " - " + data.buqueViaje));
			myColumn.setColumnValue('pod.label', getColumnObjectForAtomicValueWithId(data.podName));
			myColumn.setColumnValue('fpod.label', getColumnObjectForAtomicValueWithId(data.fpodName));
			myColumn.setColumnValue('fk.label', getColumnObjectForAtomicValueWithId(data.fk));

			myColumn.setColumnValue('tipo', null);
			myColumn.setColumnValue('contenedor.label', null);
			myColumn.setColumnValue('contenido.label', null);
			myColumn.setColumnValue('costado', checked = true);							
 		});
	};
	column.validate = function(value) 
	{
		if (value.label.trim().length == 0)			
			throw ("<spring:message code='Invalid_line' />");
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

		//var bookingId = rowData.booking.id;
		/*
		* linea is now holding the booking id. 
		* This is necessary because the booking name could appear more than once, but with different line,
		* so obviously each booking will have different id according to the selected line.
		*/
		var bookingId = rowData.linea.id;

		var opts = { };
		opts.sourceUrl = "rest/BookingItem/search.json";
		opts.sourceParams = { bookingId: bookingId };
		opts.optionObject = function(obj) { return { label : obj.typeIso, id : obj.id }; };
		opts.sourceError = function(data)
		{
			window.setTimeout(function() { aColumn.getGrid().jqGrid('restoreCell', aColumn.getModel().cellInfo.rowid, 'tipo'); }, 100);
			showMessage(data.message);
		};

		return opts;
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		var myColumn = this;

		var process = function(bookingItem)
		{
			unblockPage();

			myColumn.setColumnValue('contenedor', null);

			if (bookingItem == null)
			{
				myColumn.setColumnValue('contenido.label', null);
				myColumn.setColumnValue('imo', null);
 				myColumn.setColumnValue('undg', null);

				myColumn.setColumnValue('hasHazard', null);
				myColumn.setColumnValue('hasMarinePollutants', null);
				myColumn.setColumnValue('hasDimensions', null);
				myColumn.setColumnValue('requireConnection', null);
				myColumn.setColumnValue('setPoint', null);
				mymyColumn.setColumnValue('costado', null);

			}
			else
			{
				myColumn.setColumnValue('contenido.label', getColumnObjectForAtomicValue(bookingItem.cmdy));
				myColumn.setColumnValue('imo', getColumnObjectForAtomicValue(bookingItem.imos));
 				myColumn.setColumnValue('undg', getColumnObjectForAtomicValue(bookingItem.undgField));
				
				myColumn.setColumnValue('hasHazard', (bookingItem.hasHazard));
				myColumn.setColumnValue('hasMarinePollutants', (bookingItem.hasMarinePollutants));
				myColumn.setColumnValue('hasDimensions', (bookingItem.hasDimensions));
				myColumn.setColumnValue('requireConnection', (bookingItem.requireConnection));
				myColumn.setColumnValue('setPoint', (bookingItem.tempRequired));
			}

// 			updateRequireConnection(myColumn);
		};
		
		blockPage();
		jQuery.getJSON("rest/BookingItem/" + value.id, null, process, function() { process(null); });
	};
	column.validate = function(value)
	{
	};
	edition.addColumn(column);

	/*
	* contenedor column
	*/
	column = new JQGrid_Column_Model();
	column.name = "contenedor";
	column.type = "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 11;
		opts.maxLength = opts.minLength;
		opts.source = function(req, resp) { resp([req.term.toUpperCase()]);	};
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
		
		var accepF = function(data)
		{
			unblockPage();

			var container = data;

			try
			{
				validatesBookingInfoAgainstContainer(container, myColumn);
			}
			catch (ex)
			{
				showMessage(ex.getMessage());
				window.setTimeout(function() { myColumn.setColumnValue("contenedor", null); }, 100);
				return;
			}
			
// 			updateRequireConnection(myColumn);
		};

		blockPage();
		jQuery.getJSON("rest/Contenedor/recent/unit_nbr/"
			+ encodeURIComponent(value.label), null,
			accepF, function() { accepF(null); });
	};
	column.validate = function(value)
	{
		if (!isValidContenedor(value.label))
			throw ("<spring:message code='Invalid_container_number_format' />");
	};
	edition.addColumn(column);
	
	column = new JQGrid_Column_Model();
	column.name = "recintoOrigen";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		var opts = { };
	
		opts.sourceUrl = "rest/RecintoOrigen/get-all";
		opts.sourceParams = { };
		opts.optionObject = function(obj) { return { label : obj.descripcion, id : obj.recinto }; };

		opts.sourceError = function(data)
		{
			window.setTimeout(function() { aColumn.cancelColumnValue(); }, 100);
			showMessage(data.message);
		};

		return opts;
	};
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
	};
	edition.addColumn(column);

	edition.addColumn(getSpecialColumn());
// 	edition.addColumn(getReferenciaColumn());

	/*
	* undg column
	*/
	column = new JQGrid_Column_Model();
	column.name = "undg";
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
		var rowData = getTable().jqGrid('getLocalRow', rowid);
		if (!rowData.hasHazard)
			window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
	};
	column.validate = function(value) 
	{
	};
	edition.addColumn(column);

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
				editable : true,
				edittype : 'text',
				editoptions : { style: "text-transform: uppercase"}
			},			
			{
				name : 'linea',
				index : 'linea',
				label : "<spring:message code='Line' />",
				width : 110,
				sortable : false,
				editable : true
			},
			{
				name : 'buqueViaje.label',
				index : 'buqueViaje',
				label : "<spring:message code='Buque_Viaje' />",
				width : 180,
				sortable : false,
				editable : false,
			},
			{
				name : 'pod.label',
				index : 'pod',
				label : "<spring:message code='POD' />",
				width : 200,
				sortable : false,
				editable : false
			},
			{
				name : 'fpod.label',
				index : 'fpod',
				label : "<spring:message code='FPOD' />",
				width : 140,
				sortable : false,
				editable : false
			},
			{
				name : 'fk.label',
				index : 'fk',
				label : "<spring:message code='FK' />",
				width : 135,
				sortable : false,
				editable : false
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
				name : 'contenedor',
				index : 'contenedor',
				label : "<spring:message code='Container' />",
				width : 110,
				sortable : false,
				editable : true
			},
			{
				name : 'peso',
				index : 'peso',
				label : "<spring:message code='Weight_tara' />",
				width : 130,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'undg',
				index : 'undg',
				label : "<spring:message code='UNDG' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'contenido.label',
				index : 'contenido',
				label : "<spring:message code='Contenido' />",
				width : 110,
				sortable : false,
				editable : false
			},
			{
				name : 'sello1',
				index : 'sello1',
				label : "<spring:message code='Sello1' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'sello2',
				index : 'sello2',
				label : "<spring:message code='Sello2' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'sello3',
				index : 'sello3',
				label : "<spring:message code='Sello3' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'sello4',
				index : 'sello4',
				label : "<spring:message code='Sello4' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'text'
			},
			{
				name : 'hasHazard',
				index : 'hasHazard',
				label : "<spring:message code='Has_Hazard' />",
				width : 110,
				sortable : false,
				editable : false,
				formatter : 'checkbox'
			},
			{
				name : 'imo.label',
				index : 'imo',
				label : "<spring:message code='IMO' />",
				width : 110,
				sortable : false,
				editable : false
			}, 
			{
				name : 'hasMarinePollutants',
				index : 'hasMarinePollutants',
				label : "<spring:message code='Marine_Pol' />",
				width : 110,
				sortable : false,
				editable : false,
				formatter : 'checkbox'
			},
			{
				name : 'requireConnection',
				index : 'requireConnection',
				label : "<spring:message code='Req_Connection' />",
				width : 110,
				sortable : false,
				editable : false,
				formatter : 'checkbox'
			},
			{
				name : 'setPoint',
				index : 'setPoint',
				label : "<spring:message code='Set_Point' />",
				width : 110,
				sortable : false,
				editable : false
			},
			{
				name : 'hasDimensions',
				index : 'hasDimensions',
				label : "<spring:message code='Has_Dimensions' />",
				width : 110,
				sortable : false,
				editable : false,
				formatter : 'checkbox'
			},
			{
				name : 'recintoOrigen',
				index : 'recintoOrigen',
				label : "<spring:message code='Recinto_Origen' />",
				width : 110,
				sortable : false,
				editable : true
			},
			{
				name : 'special',
				index : 'special',
				label : "<spring:message code='Special' />",
				width : 250,
				sortable : false,
				editable : true
			},
			{
				name : 'costado',
				index : 'costado',
				label : "<spring:message code='Side' />",
				width : 110,
				sortable : false,
				editable : true,
				edittype : 'checkbox',
				formatter : 'checkbox'
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
// 		afterSaveCell : function(rowid, cellname, value, iRow, iCol) { 
// 			saveAppointmentsToGridData(); 
// 		}
	};
	//bind the below event to the save appointments method
	//pretty much the same as the above event, but it didnt work..
	getTable().bind('jqGridAfterSaveCell', function() { saveAppointmentsToGridData();});
}

function updateRequireConnection(myColumn)
{
	var contenedor = myColumn.getColumnValue("contenedor");
	var tipo = myColumn.getColumnValue("tipo");

	// require connection when container is R1 and booking requires a connection (temperature != null))
	var requireConnection = tipo != null && tipo.requireConnection ;
// 	var requireConnection = tipo != null && tipo.requireConnection && contenedor != null && (contenedor.label.indexOf('R') != -1);

	myColumn.setColumnValue('requireConnection', requireConnection);
}

function operationValidateRowInfo(rowData)
{
	if (isDataEmpty(rowData.booking))
		throw new SolicitudError("<spring:message code='Booking_must_be_defined' />");

	if (isDataEmpty(rowData.contenedor))
		throw new SolicitudError("<spring:message code='Container_must_be_defined' />");
	
	if (isDataEmpty(rowData.peso))
		throw new SolicitudError("<spring:message code='Weight_must_be_defined' />");
}
</script>
</html>