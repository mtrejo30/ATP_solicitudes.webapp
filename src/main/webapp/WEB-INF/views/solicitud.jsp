<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="Solicitudes" />

<html>
<head>
	<c:import url="/metas.jsp" />
	<title><c:out value='${title}' /></title>
	<c:import url="/libraries.jsp" />
	<c:import url="/libraries_table.jsp" />
	<c:import url="/libraries_plugins.jsp" />
	
	<script type="text/javascript" src="panels/solicitud-panel.js"></script>
    <script type="text/javascript" src="panels/fake-panel.js"></script>
	<script type="text/javascript" src="panels/comentario-panel.js"></script>
	<script type="text/javascript" src="panels/cancel-solicitud-panel.js"></script>
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

	<div class="genericSearchArea wideFields" Style="width: 1300px!important;background:#fff;border: 1px solid #fff;" align=center>
		<form id="searchSolicitudForm">
		 <div class="derecha">
		 <fieldset Style="width:700px">
			<legend Style="margin-left: -540px;">Búsquedas en Solicitudes</legend>
			<table class=rightAlignColumns>
				<tr>
					<td>
						<label for="typeSearchField"><spring:message code='Solicitud_type' />:</label>
						<select id="operationType_filter" style="width: 210px;" name="operationType" >
						</select>
					</td>
					
					<td class=rightAlignColumns>
						<label for="statusSearchField"><spring:message code='Status' />:</label>
						<select id="status_filter" style="width: 210px;" name="status" style="width: 210px;">
						</select>
					</td>							
				</tr>	
				<tr>
					<td>
						<label for="referenceearchField"><spring:message code='ReferenciaSearch' />:</label>
						<input type="text" id="referenceField" name="reference"  />
					</td>
					<td>
						<label for="folioSearchField"><spring:message code='FolioSearch' />:</label>
						<input type="text" id="folioField" name="folio"  />
					</td>
				</tr>
				
				<tr>		
					<td>
						<label for="nbrsearchField"><spring:message code='Appointment' />:</label>
						<input type="text" id="nbrField" name="nbrField"  />
					</td>
					<td>
						<sec:authorize access="hasAnyRole('TI','TA')">
						<label for="referenceusuariosearchField"><spring:message code='User' />:</label>
						<input type="text" id="usuarioField" name="usuario"  />
					    </sec:authorize>
					</td>
				</tr>
				<tr>		
					<td>
						<label for="contenedorsearchField " id="contenedorField_"><spring:message code='contenedor_' />:</label>
						<input type="text" id="contenedorField" name="contenedorField"  />
					</td>
					<td>
						<label for="blsearchField" id="blField_" ><spring:message code='bl_' />:</label>
						<input type="text" id="blField" name="bl"  />
					   
					</td>
				</tr>
				<tr>		
					<td>
						<label for="bokingsearchField" id="bokingField_" ><spring:message code='booking_' />:</label>
						<input type="text" id="bokingField" name="bookingField"  />
					</td>
					<td>
						<sec:authorize access="hasAnyRole('TI','TA')">
						<label for="custumsearchField" id="custumField_" >Pedimentos N4:</label>
						<input type="text" id="custumField" name="custumField"  />
						 </sec:authorize>
					</td>
				<tr>
			</table>
		</fieldset>
		</div>	
			<br/>
		<div class="izquierda">	
		<fieldset Style="height: 150px;">
			<legend Style="margin-left: -200px;">Búsquedas en Documentación</legend>
			<table class=rightAlignColumns>
				<tr>
					<td>
						<label for="blssearchField" id="blsField_" >Bls:</label>
						<input type="text" id="blsField" name="blsField"  />
					</td>					
				</tr>	
				<tr>
					<td>
						<label for="impedimentossearchField" id="impedimentosField_" >Pedimentos:</label>
						<input type="text" id="impedimentosField" name="impedimentosField"  />
					</td>
				</tr>
				<tr>
					<td>
						<label for="lineaField" id="leniaField_" >Linea Naviera:</label>
						<select name="linea" id="linea" style="width: 210px;">
							<option value="0" selected>-- Sin Seleccion --</option>
							<option value="1">Activo</option>
							<option value="2">Inactivo</option>
					   </select>
					</td>							
				</tr>	
				<tr>
					<td>
						<label for="ferrocarrilsearchField" id="ferrocarrilField_" >Ferrocarril:</label>
						<select name="ferrocarril" id="ferrocarril" style="width: 210px;">
							<option value="0" selected>-- Sin Seleccion --</option>
							<option value="1">Activo</option>
							<option value="2">Inactivo</option>
					   </select>
					</td>
				</tr>
				
			</table>
		</fieldset>
         </div>
           </br>
			<input _clickBind="searchClicked" class="_clickBind" Style="margin-left: 200px!important"  type="button" value="<spring:message code='Search' />" />
		</form>
	</div>
	<br/>
	
	<table class="display" id="solicitudTable"></table>
	<div id="solicitudPager"></div>
	<br/>
<input type="hidden" id="perfil" />
	<div id="solicitudPanelContainer" style="display: none;"></div>
	<div id="cancelPanelContainer" style="display: none;"></div>
	<div id="comentarioContainer" style="display: none;"></div>

	</div>
	
	<div class="genericButtonsArea" align=center>
	   <sec:authorize access="!hasAnyRole('TI','TA','TRA','CON')">
       		<input _clickBind="newSolicitudClicked" class="_clickBind" type=button value="<spring:message code='New_Solicitud' />" />       		
       </sec:authorize>	 
       <sec:authorize access="!hasAnyRole('TRA','CON')">  
       <input _clickBind="editSolicitudClicked" class="_clickBind" type=button value="<spring:message code='Edit_Solicitud' />" /> 
        </sec:authorize>	
        <sec:authorize access="!hasAnyRole('TRA','CON')"> 
       <input _clickBind="cancelSolicitudClicked" class="_clickBind" type=button value="<spring:message code='Cancel_solicitud' />" />
         </sec:authorize>
       <sec:authorize access="hasAnyRole('TI','TA')">
	    	<input _clickBind="errorSolicitudClicked" class="_clickBind" type=button value="<spring:message code='Error_solicitud' />" />
    		<input _clickBind="validateSolicitudClicked" class="_clickBind" type=button value="<spring:message code='Validate_solicitud' />" />
     	</sec:authorize>  
     	|
     	<input _clickBind="appointmentSolicitudClicked" class="_clickBind" type=button value="<spring:message code='Appointment_Solicitud' />" />
		<sec:authorize access="!hasRole('TRA')">  
			<input _clickBind="documentsClicked" class="_clickBind" type=button value="<spring:message code='documents' />" />
			<input _clickBind="openComentarioPanel" class="_clickBind" type="button" value="<spring:message code='Comments' />"></input>
     	</sec:authorize>  
     	
	</div>



<c:import url="/footer.jsp" />

<div id="modalMessage">
<p></p>
</div>
</body>
	
<script type="text/javascript">
var solicitudId = null;
var n4 = <c:out value='${n4}' escapeXml="false" />;

var noSel = { id: "", name: "<spring:message code='_No_Selection_' />"};
var typeList = (<c:out value='${typeList}' escapeXml="false" />);
var statusList = (<c:out value='${statusList}' escapeXml="false" />);
var userId = ${_SessionModel.loggedUser.id};
var userId1 = (<c:out value='${n4}' escapeXml="false" />);
var hideUserNameColumn = true;
var solicitudPanel = null;

var selectedSolicitudId = null; 

var cancelList = (<c:out value='${cancelList}' escapeXml="false" />);

var cancelPanel = null;

var comentarioPanel = null;
var txtperfil ="${perfil}";


var solicitudStatusMap = { };

jQuery.each(statusList, function(eachIndex, eachObject)
{
	solicitudStatusMap[eachObject.name] = eachObject;
});

//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded() 
{	
	
	
				/*var perfil =jQuery("#userN4_Profile").val();
			    if(perfil == 'TA' || perfil == 'TI' || perfil == 'AA' )
			    	{
			    		jQuery("#contenedorField_").show();
			    		jQuery("#contenedorField").show();
			    		jQuery("#blField_").show();
			    		jQuery("#blField").show();
			    		jQuery("#bokingField_").show();
			    		jQuery("#bokingField").show();
			    	}
			    else
			    	{
			    	jQuery("#contenedorField_").hide();
		    		jQuery("#contenedorField").hide();
		    		jQuery("#blField_").hide();
		    		jQuery("#blField").hide();
		    		jQuery("#bokingField_").hide();
		    		jQuery("#bokingField").hide();
			    	}
		   
	*/
	 //System.out.println("-----id----------   " + userId);
	 //alert(userId1);
	 $("#perfil").val(txtperfil);
	 
	 if($("#perfil").val()=="TRA")
		 {
		 	$('#blsField').attr('readonly', true);
		 	$('#impedimentosField').attr('readonly', true);
		 	$('#linea').attr('disabled', true);
		 	$('#ferrocarril').attr('disabled', true);
		 
		 }
	jQuery("#solicitudPanelContainer").load(Solicitud_Panel.uiFile, function(response, status, xhr) 
	{		
		solicitudPanel = new Solicitud_Panel();
		/*jQuery.getJSON("solicitud/nivel/" + userId1, { }, function(datta)
				{
				
				});*/
		solicitudPanel.registerHandler(Solicitud_Panel.Events.SOLICITUD_SAVED, function(sender, object)
		{
			var requestInfo = { id: object.id };
			updateTableWithRequest(getSolicitudTable(), "solicitud/solicitud-table-row.json", requestInfo);
		});
		
		solicitudPanel.parent = jQuery("#solicitud_container");
		solicitudPanel.saveSolicitudUrl = "solicitud/save-solicitud.page";
		solicitudPanel.fillType(typeList);
		solicitudPanel.init();	
	});
	
	fillSelect(jQuery("#operationType_filter"), [noSel].concat(typeList), function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
	fillSelect(jQuery("#status_filter"), [noSel].concat(statusList), function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
	
	
	jQuery("#cancelPanelContainer").load(Cancel_Solicitud_Panel.uiFile, function(response, status, xhr) 
			{		
				cancelPanel = new Cancel_Solicitud_Panel();
				
				cancelPanel.registerHandler(Cancel_Solicitud_Panel.Events.SOLICITUD_CANCELED, function(sender, object)
				{
				    
					var requestInfo = { id: object.id, };
					updateTableWithRequest(getTable(), "solicitud/solicitud-table-row.json", requestInfo);
				});

				cancelPanel.parent = jQuery("#cancelPanelContainer");
//		 		solicitudPanel.saveSolicitudUrl = "solicitud/save-solicitud.page";
				cancelPanel.fillCancellation(cancelList);
				cancelPanel.init();	
			});
	
	//autocomplete fileField
    jQuery("#referenceField")
	    .autocomplete({
			source:		"solicitud/solicitud-reference.json", 
			minLength: 	4,
	    });
	
    //autocomplete folioField
    jQuery("#folioField")
	    .autocomplete({
			source:		"solicitud/solicitud-folio.json", 
			minLength: 	2,
	    });
  
    //autocomplete folioField
    jQuery("#usuarioField")
	    .autocomplete({
			source:		"solicitud/usuario.json", 
			minLength: 	4,
	    });
    
  //autocomplete nbrField
//   var obj = { };
//   obj.id = solicitudId;
    jQuery("#nbrField")
	    .autocomplete({
			source:		"solicitud/solicitud-nbr.json", 
			minLength: 	2,
	    });
    
	// individual button actions
	bindClickEvent("_clickBind");

	<sec:authorize access="hasAnyRole('TI','TA')">
		hideUserNameColumn = false;
	</sec:authorize>

	// build the table
	buildTable();

	// build comentario panel
	comentarioPanel = new Comentario_Panel();
	comentarioPanel.ownerId = solicitudId;
	comentarioPanel.mergeObject = {solicitudId: solicitudId, usuarioId: userId};
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

	//currentMenu
	highlightNavigationBarItem("solicitudMenu");
}

function cellSelected(rowid, iCol, cellcontent, e)
{
	selectedSolicitudId = rowid;
}

function documentsClicked()
{
	if (solicitudId == null)
	{
		showMessage("<spring:message code='Solicitud_not_selected' />");
		return;
	}
	
	var obj = { };
	 
	obj.id = solicitudId;

	jQuery.postJSON("solicitud/documents-solicitud.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			redirectURL(data.body +".page");
		}
	});
}


function getSolicitudTable()
{
	return jQuery('#solicitudTable');
}

function openComentarioPanel()
{
	if (solicitudId == null)
	{
		showMessage("<spring:message code='Solicitud_not_selected' />");
		return;
	}

	comentarioPanel.ownerId = solicitudId;
	comentarioPanel.mergeObject = {solicitudId: solicitudId, usuarioId: userId};
	comentarioPanel.update();
	comentarioPanel.open("<spring:message code='Comments' />");
}

function newSolicitudClicked()
{
	if (n4 == null)
	{
		showMessage("<spring:message code='User_is_not_associate_to_N4_user' />");
		return;
	}

	solicitudPanel.clean();
	solicitudPanel.open();
}

function editSolicitudClicked()
{
	
	if (n4 == null)
	{
		showMessage("<spring:message code='User_is_not_associate_to_N4_user' />");
		return;
	}
	 
	if (solicitudId == null)
	{
		showMessage("<spring:message code='Solicitud_not_selected' />");
		return;
	}
	
	jQuery.postJSON("solicitud/edit-solicitud.json", { id: solicitudId }, editSolicitudClicked_callback);
	blockPage(); 
}

function editSolicitudClicked_callback(data)
{
	unblockPage();
	
	if (data.error)
	{
		showMessage(data.message, {title: 'Error'});
	}
	else
	{
		solicitudPanel.fillFrom(data.body);
		solicitudPanel.open();
	}
}

function searchClicked()
{
	jQuery("#errorContainer").text("");
	getSolicitudTable().jqGrid().trigger('reloadGrid');
	solicitudId = null;
}

function queryInfo()
{
	var obj = jQuery("#searchSolicitudForm").serializeObject();
	var jsonObj = JSON.stringify(obj);
	jsonObj = jQuery.parseJSON(jsonObj);
	jsonObj['userN4'] = $("#Id_userN4_Id").val();
	return JSON.stringify(jsonObj);
}

function getSolicitudId()
{
	var rowData = getSelectedRowData();
	return rowData.folio;
}


function getSelectedRowData()
{
	var rowData = getRowData(selectedSolicitudId);

	return rowData;
}

function getRowData(rowIndex)
{
	return getSolicitudTable().jqGrid('getLocalRow',rowIndex); 
}

function buildTable()
{
	getSolicitudTable().jqGrid
	(
	{
		// set url to get information from the server
		url:'solicitud/solicitud-table-info.json',
		postData: 
		{
			search_info: queryInfo,
		},
		datatype: "json",
		// column properties
		colModel:
		[
			{name:'folio', index:'folio', width:100, align: "left", label: "<spring:message code='Folio' />"},
			{name:'reference', index:'reference', width:260, align: "left", label: "<spring:message code='Reference' />"},
			{hidden: hideUserNameColumn, name:'username', index:'username', sortable: false, width: 150, align: "left", label: "<spring:message code='User' />"},
			{name:'type', index:'operationType', width:260, align: "left", label: "<spring:message code='Type' />"},
			{name:'status', index:'status', width:150, align: "left", label: "<spring:message code='Status' />"},
// 			{name:'dateScheduled', index:'dateScheduled', width:220, align: "left", label: "<spring:message code='Date_Scheduled' />"},
			{name:'dateCreated', index:'dateCreated', width:220, align: "left", label: "<spring:message code='Date_Created' />"},
			{name:'dateUpdated', index:'dateUpdated', width:240, align: "left", label: "<spring:message code='Date_Updated' />"},
			{name:'hasDocuments', index:'hasDocuments', width:200, align: "left", label: "<spring:message code='Has_Documents' />"}
		],
		onSelectRow: rowSelected,
		rowNum: 15,
		rowList:[15,30,50],
		pager: '#solicitudPager',
		viewrecords: true,
		sortname: "dateCreated",
		sortorder: "desc",
		width: '1100',
		caption:'<spring:message code="Solicitud" />'
	}
	);
	
	//addButtonsToNavgrid();
}

function addButtonsToNavgrid()
{
	getSolicitudTable().navGrid('#solicitudPager', {edit:false, add:false, del:false, search:false, refresh:false})
	.navButtonAdd('#solicitudPager', 
	{
		caption:'<spring:message code="download_document" />', 
		buttonicon:"ui-icon-disk", 
		onClickButton: appointmentSolicitudClicked,
		position:"first"
	});
}

function rowSelected(id)
{
	solicitudId = id;
}

function appointmentSolicitudClicked()
{
	if (solicitudId == null)
	{
		showMessage("<spring:message code='Solicitud_not_selected' />");
		return;
	}

	var obj = { };
 
	obj.id = solicitudId;

	jQuery.postJSON("solicitud/citas-solicitud.json", obj, function(data)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			redirectURL(data.body + ".page");
		}
	});
}

function canceledAppointment()
{
// 	var solicitud_Id = getSolicitudId();
	cancelSolicitud(solicitudId);
	
}

function cancelSolicitud (solicitudId)
{
	unblockPage();
	cancelPanel.open("<spring:message code='Cancellation' />");
}

function cancelSolicitudClicked()
{
  	
//   	status:solicitudStatusMap["Cancelado"].id;
// 	canceledAppointment();
// 	cancelPanel.open("<spring:message code='Cancellation' />", 
// 		$("#cancelPanelContainer").find("#folio").val(solicitudId);
// 			cancelPanel.open("<spring:message code='Cancellation' />",
// 					{id:solicitudId, status:solicitudStatusMap["Cancelado"].id});
// 		getSolicitudTable().jqGrid().trigger('reloadGrid');
		
		var obj = { };
	 
		obj.id = solicitudId;
		
		jQuery.postJSON("appointment/cancel-solicitud.json", obj, function(data)
				{
					unblockPage();

					if (data.error)
					{
						showMessage(data.message, {title: 'Error'});
					}
					else
					{
						myself.close();
						showMessage("Solicitud Cancelada");

						myself.performHandler(Cancel_Solicitud_Panel.Events.SOLICITUD_CANCELED, data.body);
					}
				});

// 		jQuery.postJSON("solicitud/update-solicitud-status.json",{ id:solicitudId, status:solicitudStatusMap["Cancelado"].id});

}

function errorSolicitudClicked()
{
	showConfirmationMessage("<spring:message code='Confirm_error_solicitud' />", {id:solicitudId, status:solicitudStatusMap["Error"].id});
}

function validateSolicitudClicked()
{
	showConfirmationMessage("<spring:message code='Confirm_validate_solicitud' />", {id:solicitudId, status:solicitudStatusMap["Validado"].id});
}

function showConfirmationMessage(msg, params)
{
	if (solicitudId == null)
	{
		showMessage("<spring:message code='Solicitud_not_selected' />");
		return;
	}
	
	var updateSolStatusCall = function() { updateSolicitudStatus(params); };

	showAcceptCancel(msg, updateSolStatusCall);	
}

function updateSolicitudStatus(params)
{
	// send the information to the server
	jQuery.postJSON("solicitud/update-solicitud-status.json", params, updateSolicitudStatusCallBack);

	// we should block the page to avoid further activities here
	blockPage();
	
	// return false to avoid the form submit from the event
	return false;
}

function updateSolicitudStatusCallBack(response)
{
	// unblock the page
	unblockPage();
	
	// check if error or everything went fine
	if (response.error)
	{
		// notify the user about the error
		showMessage(response.message);
	}
	else
	{		
		getSolicitudTable().jqGrid('setRowData', solicitudId, response.body);
		// show modal with server response
		showMessage(response.message);
	}
};

</script>
</html>