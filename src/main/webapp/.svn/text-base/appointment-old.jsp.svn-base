<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<head>

<title><c:out value='${title}' /></title>
<c:import url="/libraries.jsp" />
<c:import url="/libraries_table.jsp" />

<script type="text/javascript" src="js/jqgrid-column-edition.js"></script>
<script type="text/javascript" src="panels/fake-panel.js"></script>
<script type="text/javascript" src="panels/comentario-panel.js"></script>

</head>

<body>
	<c:import url="/header.jsp">
		<c:param name='title' value='${title}' />
	</c:import>

	<div align=center>
	
	<c:import url="/navigationbar.jsp" />
	
	<c:if test='${error == ""}'>
		<div align=center>
			<h1></h1>
			<p></p>
		</div>
	</c:if>

	<h2><c:out value='${title}' /></h2>

		<c:import url="/solicitud_header_data.jsp" />
		<br/>

		<div class="solicitudHeaderContainer" align=center>
			<table class=noPaddingTable>
				<tr>
					<td>
						<label><spring:message code='Transporter' />:</label>
						<input type=text id="transportista" />
					</td>
					<td>
						<label><spring:message code='Operator' />:</label>
						<input type=text id="operador" />
					</td>
				</tr>
				<tr>
					<td>
						<label><spring:message code='Plates' />:</label>
						<input type=text id="placas" class="inputToUppercase" />
					</td>
					<td>
					&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						<label><spring:message code='Date' />:</label>
						<input type=text id="dayScheduled" />
					</td>
					<td>
						<label><spring:message code='Time' />:</label>
						<select id="timeScheduled"></select>
					</td>
				</tr>
			</table>
			
			<br/>
			
			<input type="button" id="applySolicitudInfoButton" value="<spring:message code='Apply' />" />
		</div>
		<br/>

		<table class="display" id="table"></table>
		<div id="tablePager"></div>

		<div id="comentarioContainer" style="display: none;">
		</div>
	</div>

	<br/>

    <div class="genericButtonsArea" align=center>
	<sec:authorize access="!hasAnyRole('TI','TA')">
			<input _clickBind="updateAppointmentClicked" class="_clickBind" type=button value="<spring:message code='Update_Appointment' />" />
			<input _clickBind="canceledAppointmentClicked" class="_clickBind" type=button value="<spring:message code='Cancel_Appointment' />" />
	</sec:authorize>		
		    <input _clickBind="openComentarioPanel" class="_clickBind" type="button" value="<spring:message code='Comments' />" ></input>
			<input _clickBind="paseDeEntradaClicked" class="_clickBind" type=button value="<spring:message code='Entry_pass' />" />
 			| 
     	   	<input _clickBind="solicitudClicked" class="_clickBind" type=button value="<spring:message code='Return_solicitud' />" />
		</div>			
	<c:import url="/footer.jsp" />

	<div id="modalMessage">
		<p></p>
	</div>
	
	<iframe id="downloadDocument" name="downloadDocument" src="" style="display: none;"></iframe>
</body>

<script type="text/javascript">
//execute loaded function when page loaded
var baseRequestPath = "<c:out value='${view}' escapeXml="false" />";

var solicitudId = ${solicitud.folio};
var appointments = <c:out value='${appointments}' escapeXml="false" />;
var selectedAppointmentId = null;

var loggedUserId = ${_SessionModel.loggedUser.id};

var solicitudUserId = ${solicitudUser.id};
var solicitudUserN4Id = ${solicitudUser.usuarioN4_id};
var solicitudUserCompanyCode = "${solicitudUser.empresa.codigo}";
var solicitudTranType = "${solicitud.operationType.tranType}";

var solicitudIdApp = null;
var operationValidateRowInfo = null;

var comentarioPanel = null;

jQuery(document).ready(loaded);

var table = null;
var tableData = [];

function loaded()
{
	initializeSolicitudInfo();

	//cache the table on a JS variable
	table = jQuery("#table");

	// build the table
	buildTable();
	addAppointmentsToTable();
	
	// individual button actions
	bindClickEvent("_clickBind");

	// build comentario panel
	comentarioPanel = new Comentario_Panel();
	comentarioPanel.ownerId = solicitudId;
	comentarioPanel.mergeObject = {solicitudId: solicitudId, usuarioId: loggedUserId};
	comentarioPanel.restUrls =
	{
		get: "rest/SolicitudComentario/",
		save: "rest/SolicitudComentario/saveNotify/",
		list: "rest/SolicitudComentario/fromSolicitud/"
	};
	comentarioPanel.parent = jQuery("#comentarioContainer");
	comentarioPanel.load("comentario-panel.jsp", function(panel)
	{
		comentarioPanel.init();
	});
	 
	highlightNavigationBarItem("solicitudMenu");
}

function openComentarioPanel()
{
	comentarioPanel.update();
	comentarioPanel.open("<spring:message code='Comments' />");
}

function isContainerTipoR1(value)
{
	return value.indexOf('R') != -1;
}

function getTable()
{
	return table;
}

function getTableData()
{
    var ids = getTable().jqGrid('getDataIDs');
    
    var col = [];

    jQuery.each(ids, function(index, eachId)
    {
        var rowData = getTable().jqGrid('getLocalRow', eachId);

        var copy = { };
        jQuery.extend(copy, rowData);

        col[col.length] = copy; 
    });

    return col;
}

// global
var edition = null;
var gridOptions = null;

function addAppointmentsToTable()
{
	jQuery.each(appointments, function(eachAppointmentIndex, eachAppointment)
	{
		var newRow = { id : edition.getUniqueId() };
		getTable().jqGrid('addRowData', newRow.id, getRowForAppointment(eachAppointment));
	});
}

function getRowForAppointment(aRow)
{
	var obj = new Object();
	
	for (var key in aRow)
	{
		var slotValue = aRow[key];
		
		if (slotValue instanceof Object)
			obj[key] = new JQGrid_Column_Value(slotValue.id, slotValue.label);
		else
			obj[key] = slotValue;
	}
	
	return obj;
}

function getColumnObjectForAtomicValue(anObject)
{
	if (anObject == null)
		return null;

	return new JQGrid_Column_Value(null, anObject);
}

function cancelAppointment(appointmentId)
{
	var obj = { };
	
	obj.id = appointmentId;
	
	blockPage();

	jQuery.postJSON("solicitud/cancel-appointment.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, { title : 'Error' });
		}
		else
		{
			getTable().jqGrid('setCell', selectedAppointmentId, "status", data.body.status);

			showMessage(data.message);
		}
	});
}

function isRegisteredAppointment()
{
	var result = true;
	
	try
	{
		getAppointmentId();
	}
	catch (ex)
	{
		result = false;
	}
	
	return result;
}

function getAppointmentId()
{
	var rowData = getLocalRowData();
	
	if (rowData.appointmentId == null)
		throw "<spring:message code='The_appointment_is_not_registered_yet' />";
	
	return rowData.appointmentId;
}

function getAppointmentNbr()
{
	var rowData = getLocalRowData();
	
	if (rowData.appointmentId == null)
		throw "<spring:message code='The_appointment_is_not_registered_yet' />";
	
	return rowData.appointmentNbr;
}

function getLocalRowData()
{
	if (selectedAppointmentId == null)
		throw "<spring:message code='No_appointment_selected' />";

	var rowData = getTable().jqGrid('getLocalRow', selectedAppointmentId);

	return rowData;
}

function canceledAppointmentClicked()
{
	try
	{
		var appointmentId = getAppointmentId();
		
		showAcceptCancel
		(
			"<spring:message code='Confirm_cancel_appointment' />",
			function() { cancelAppointment(appointmentId); }
		);
	}
	catch (ex)
	{
		showMessage(ex);
	}
}

function buildTable()
{
	buildTableDefinition();

	var fullOptions = edition.computeOptionsForGrid(gridOptions);
	
	getTable().jqGrid(fullOptions);

	getTable().jqGrid('navGrid', '#tablePager',
	{
		add : true,
		del : true,
		edit : false,
		search : false,
		delfunc : function(rowId)
		{
			var rowData = getTable().jqGrid('getLocalRow', rowId);

			if (rowData.appointmentId != null)
			{
				showMessage("<spring:message code='Cannot_delete_a_registered_appointment' />");
				return;
			}

			getTable().jqGrid('resetSelection');
			getTable().jqGrid('delRowData', rowId);

			edition.cellInfo.rowid = null;
			
			selectedAppointmentId = null;
		},
		addfunc : function()
		{
			var newRow = { id : edition.getUniqueId(), extra : { } };
			getTable().jqGrid('addRowData', newRow.id, newRow);

			selectedAppointmentId = null;
		}
	});
	
	jQuery.jgrid.info_dialog = function(caption, message)
	{
		showMessage(message, { title : caption } );
	};
}

function cellSelected(rowid, iCol, cellcontent, e)
{
	selectedAppointmentId = rowid;
}

function updateTimeSlotsFromDate(value)
{
	getTable().jqGrid('setCell', edition.cellInfo.rowid, "time", null);
}

function acceptAppointment(aRowId)
{
	var rowData = getTable().jqGrid('getLocalRow', aRowId);
	
	blockPage();
	jQuery.postJSON(baseRequestPath + "/accept-appointment-data.json", rowData, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, { title : 'Error' });
			getTable().jqGrid('setCell', aRowId, "time", null);
		}
		else
		{
			getTable().jqGrid('setCell', aRowId, "appointmentNbr", data.body.appointmentNbr);
			getTable().jqGrid('setCell', aRowId, "appointmentId", data.body.appointmentId);
			getTable().jqGrid('setCell', aRowId, "status", data.body.status);

			showMessage(data.message);
		}
	});
}

function updateAppointment(aRowId)
{
	var rowData = getTable().jqGrid('getLocalRow', aRowId);
	
	blockPage();
	jQuery.postJSON(baseRequestPath + "/accept-appointment-data.json", rowData, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, { title : 'Error' });
		}
		else
		{
			getTable().jqGrid('setCell', aRowId, "appointmentNbr", data.body.appointmentNbr);

			showMessage(data.message);
		}
	});
}

function updateAppointmentClicked()
{
	try
	{
		getAppointmentId();
		updateAppointment(selectedAppointmentId);
	}
	catch (ex)
	{
		showMessage(ex);
	}
}

function solicitudClicked()
{ 
	redirectURL("solicitud.page");
}

function paseDeEntradaClicked()
{
	try
	{
		var appointmentNbr = getAppointmentNbr();
		
		jQuery("#downloadDocument").attr("src", "rest/PaseDeEntradaReport/pdf/" + appointmentNbr);
	}
	catch (ex)
	{
		showMessage(ex);
	}
}

function getTransportistaColumn()
{
	var column = new JQGrid_Column_Model();
	column.name = "transportista";
	column.type= "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 5;
		opts.source = function(req, resp)
		{
			jQuery.getJSON("rest/Transportista/like.json?results=20&match=" + encodeURIComponent(req.term.toUpperCase()), { }, resp);
		};
		opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");	};
		return opts;
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
	};
	column.validate = function(value)
	{
	};
	return column;
}

function getOperadorColumn()
{
	var column = new JQGrid_Column_Model();
	column.name = "operador";
	column.type= "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 5;
		opts.source = function(req, resp)
		{
			jQuery.getJSON("rest/OperadorTransportista/like.json?results=20&match=" + encodeURIComponent(req.term.toUpperCase()), { }, resp);
		};
		opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");	};
		return opts;
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
	};
	column.validate = function(value)
	{
		if (value == null)
			return;
	};
	return column;
}

function getSpecialColumn()
{
	var column = new JQGrid_Column_Model();
	column.name = "special";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		var opts = { };
	
		opts.sourceUrl = "rest/Special/search";
		opts.sourceParams = { moveWithAll: solicitudTranType, companyLike: solicitudUserCompanyCode };
		opts.optionObject = function(obj) { return { label : obj.descripcion, id : obj.special }; };
		
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
	return column;
}

function getReferenciaColumn()
{
	var column = new JQGrid_Column_Model();
	column.name = "referencia";
	column.type = "text";
	column.dataInit = function(element) { jQuery(element).addClass("inputToUppercase"); };
	return column;
}

function getPlacasColumn()
{
	var column = new JQGrid_Column_Model();
	column.name = "placas";
	column.type = "text";
	column.dataInit = function(element) { jQuery(element).addClass("inputToUppercase"); };
	edition.addColumn(column);
	return column;
}

function getDateColumn()
{
	var column = new JQGrid_Column_Model();
	column.name = "date";
	column.type = "date";
	column.dateFormat = 'yy-mm-dd';
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		window.setTimeout(function() { updateTimeSlotsFromDate(value); }, 100);
	};
	column.validate = function(value)
	{
	};
	edition.addColumn(column);
	return column;
}

function getTimeColumn()
{
	var column = new JQGrid_Column_Model();
	column.name = "time";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		var opts = { };

		// if is not valid, exit
		var extra = aColumn.getColumnValue('extra');
		if (!extra.validInfo)
		{
			window.setTimeout(function() { aColumn.cancelColumnValue(); }, 100);

			opts.sourceUrl = null;
			return opts;
		}

		var dateValue = aColumn.getColumnValue('date');
		opts.sourceParams = { date: dateValue };
		opts.sourceUrl = "appointment/get-time-slots.json";
		opts.optionObject = function(obj) { return { label : obj, id : obj }; };
		
		opts.sourceError = function(data)
		{
			window.setTimeout(function() { aColumn.cancelColumnValue(); }, 100);
			showMessage(data.message);
		};

		return opts;
	};
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
		var myColumn = this;
		var extra = myColumn.getColumnValue('extra');

		// set valid info to false
		extra.validInfo = false;
		myColumn.setColumnValue('extra', extra);

		var rowData = getTable().jqGrid('getLocalRow', rowid);

		// generic validation
		try
		{
			genericValidateRowInfo(rowData);
		}
		catch (ex)
		{
			showMessage(ex);
			return;
		}
		
		// operation specific validation
		if (operationValidateRowInfo != null)
		{
			try
			{
				operationValidateRowInfo(rowData);
			}
			catch (ex)
			{
				showMessage(ex);
				return;
			}
		}
		
		// info is valid
		extra.validInfo = true;
		myColumn.setColumnValue('extra', extra);
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		if (value != "")
		{
			// save the appointment if not registered
			if (!isRegisteredAppointment())
			{
				window.setTimeout(function() { acceptAppointment(rowid); }, 100);
			}
		}
	};
	return column;
}

function isDataEmpty(data)
{
	return data == null || data == "";
}

function afterColumnSave(rowid, cellname, value, iRow, iCol)
{
	console.log(cellname + "," + rowid + "=" + value);
}

function beforeEditCell(rowid, cellname, value, iRow, iCol)
{
	var rowData = getTable().jqGrid('getLocalRow', rowid);

	if (rowData.status != Solicitudes.Constants.AppointmentStatusCreated && rowData.status != null)
	{
		showMessage("<spring:message code='The_appointment_cannot_be_modified' />");

		window.setTimeout(function()
		{
			getTable().jqGrid('restoreCell', iRow, iCol);
		}, 100);
	}
}

function validateBookingForGate(bookingCode)
{
	if (bookingCode.charAt(0) == "S" && solicitudUserCompanyCode == "IST")
		throw "<spring:message code='Invalid_booking_number_for_gate' />";
}
</script>
