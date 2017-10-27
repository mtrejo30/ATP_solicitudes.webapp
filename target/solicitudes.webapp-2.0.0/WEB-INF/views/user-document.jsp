<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />
<spring:message var='title' code="Documents" />

<html>
<head>
	<title><c:out value='${title}' /></title>
	<c:import url="/metas.jsp" />
	<c:import url="/libraries.jsp" />
	<c:import url="/libraries_table.jsp" />
	<c:import url="/libraries_plugins.jsp" />
	
	<script type="text/javascript" src="panels/document-panel.js"></script>
	<script type="text/javascript" src="js/jqgrid-column-edition.js"></script>
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

	<table class="display" id="userDocumentTable"></table>
	<div id="userDocumentPager"></div>
	
	<br/>
	
	<table class="display" id="userContainerTable"></table>
	<div id="userContainerPager"></div>
	
	<br/>
	<sec:authorize access="hasAnyRole('TI','TA')">
		<table id="jqGrid"></table>
	    <div id="jqGridPager"></div>
    </sec:authorize>
    <br/>
    
	<div class="documentsContainer" align=center>			   	   
			<sec:authorize access="!hasAnyRole('TI','TA','CON')">
       			<input _clickBind="newDocumentClicked" class="_clickBind" type=button value="<spring:message code='new_document' />" />       		
       		</sec:authorize>
       		<sec:authorize access="!hasRole('CON')">
       		<input _clickBind="cancelDocumentClicked" class="_clickBind" type=button value="<spring:message code='cancel_document' />" />
       		</sec:authorize>
       		<sec:authorize access="hasAnyRole('TI','TA')">
	       		<input _clickBind="errorDocumentClicked" class="_clickBind" type=button value="<spring:message code='error_document' />" />
    	   		<input _clickBind="validateDocumentClicked" class="_clickBind" type=button value="<spring:message code='validate_document' />" />
       		    <input _clickBind="invalidateDocumentClicked" class="_clickBind" type=button value="<spring:message code='invalidate_document' />" />
       		</sec:authorize>         
       		    | 
     	   		<input _clickBind="solicitudClicked" class="_clickBind" type=button value="<spring:message code='Return_solicitud' />" />
	</div>

	<div id="documentPanelContainer" style="display: none;"></div>
		
	<br/>
</div>

<c:import url="/footer.jsp" />

<div id="modalMessage">
	<p></p>
</div>

</body>

<script type="text/javascript">

var documentId = null;
var documentPanel = null;

var documenTypeList = (<c:out value='${documenTypeList}' escapeXml="false" />);
var documentStatusList = (<c:out value='${documentStatusList}' escapeXml="false" />);
var documentStatusMap = createMap(documentStatusList);

var edition = null;
var containerGridOptions = null;

function createMap(list)
{
	var map = { };
	
	jQuery.each(list, function(eachIndex, eachObject)
	{
		map[eachObject.name] = eachObject;
	});	
	
	return map;
}

jQuery(document).ready(loaded);

function loaded()
{
 	jQuery("#documentPanelContainer").load(Document_Panel.uiFile, function(response, status, xhr) 
 	{		
 		documentPanel = new Document_Panel();
 		documentPanel.registerHandler(Document_Panel.Events.DOCUMENT_SAVED, function(sender, object)
		{
			var requestInfo = { id: object.id };
			updateTableWithRequest(getTable(), "user-document/document-table-row.json", requestInfo);
		});

		documentPanel.parent = jQuery("#document_container");
		documentPanel.saveDocumentUrl = "user-document/upload-document.page";
		documentPanel.fillType(documenTypeList);
		documentPanel.init();	
	});

	// build the table
	buildTable();
	buildContainerTable();
	
	// individual button actions
	bindClickEvent("_clickBind");

	//currentMenu
	highlightNavigationBarItem("documentMenu");
	
	
	$("#jqGrid").jqGrid(edition.computeOptionsForGrid(containerGridOptions));
	addContainerTable();
}


function buildTable()
{	
	getTable().jqGrid
	(
		{
			// set url to get information from the server
			url:'user-document/documentTableInfoRequest.json?q=2',
			datatype: "json",
			mtype: 'POST',			
			colModel:
			[
				{name:'type', index:'type', width:80, align: "left", label: "<spring:message code='document_type' />"},
				{name:'clave',index:'clave', width:150, align: "left", label : "<spring:message code='document_clave' />"},
				{name:'file',index:'file', width:150, align: "left", label : "<spring:message code='document_short_name' />"},
				{name:'status',index:'status', width:100, align: "left", label : "<spring:message code='document_status' />"},
				{name:'date',index:'date', width:200, align: "left", label : "<spring:message code='document_upload_date' />"},
				{name:'pedimentos',index:'pedimentos', width:100, align: "left", label : "Pedimentos"},
				{name:'bls',index:'bls', width:100, align: "left", label : "Bls"},			 
				{name:'linea_naviera',index:'linea_naviera', width:100, align: "left", label : "Línea Naviera"},			 
				{name:'ferrocarril',index:'ferrocarril', width:100, align: "left", label : "Ferrocarril"	}		 		 
			],	
			onSelectRow: rowSelected,
			rowNum: 15,
			rowList:[15,30,50],
			pager: '#userDocumentPager',
			viewrecords: true,
			caption:'<spring:message code="documents" />' 					
		}
	);
	
	addDownloadButton();
	// default sort column
	getTable().sortGrid("name", false);
			
}

function addDownloadButton()
{
	getTable().navGrid('#userDocumentPager', {edit:false, add:false, del:false, search:false, refresh:false})
	.navButtonAdd('#userDocumentPager', 
	{
		caption:'<spring:message code="download_document" />', 
		buttonicon:"ui-icon-disk", 
		onClickButton: downloadDocumentClicked,
		position:"first"
	});
}

function getTable()
{
	return jQuery('#userDocumentTable');
}

function reloadTable()
{
	documentId = null;
	getTable().jqGrid('setGridParam',{page:1});
	getTable().jqGrid().trigger('reloadGrid');
}

function rowSelected(id)
{	
	documentId = id;	
}

function newDocumentClicked()
{
	//jQuery.postJSON("user-document/can-add-or-change-document-status.json", { }, function(data)
	jQuery.post("user-document/can-add-or-change-document-status.page", function(data, status, xhr)
	{
		unblockPage();
		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			documentPanel.clean();
			documentPanel.open();		
		}
	}, "json");
}

function cancelDocumentClicked()
{
	showConfirmationMessage("<spring:message code='confirm_cancel_document' />", {id:documentId, status: documentStatusMap["Cancelado"].id});
}

function validateDocumentClicked()
{
	showConfirmationMessage("<spring:message code='confirm_validate_document' />", {id:documentId, status:documentStatusMap["Validado"].id});
}

function errorDocumentClicked()
{
	showConfirmationMessage("<spring:message code='confirm_error_document' />", {id:documentId, status:documentStatusMap["Error"].id});
}

function invalidateDocumentClicked()
{
	showConfirmationMessage("<spring:message code='confirm_invalidate_document' />", {id:documentId, status:documentStatusMap["Invalido"].id});
}


function showConfirmationMessage(msg, params)
{
	//jQuery.postJSON("user-document/can-add-or-change-document-status.json", function(data)
	jQuery.post("user-document/can-add-or-change-document-status.page", function(data, status, xhr)
	{
		unblockPage();

		if (data.error)
		{
			showMessage(data.message, {title: 'Error'});
		}
		else
		{
			if (documentId == null)
			{
				showMessage("<spring:message code='Document_not_selected' />");
			}
			else
			{
				var updateDocStatusCall = function() { updateDocumentStatus(params); };
				showAcceptCancel(msg, updateDocStatusCall);
			}
		}
	}, "json");
	
// 	if (documentId == null)
// 	{
// 		showMessage("<spring:message code='Document_not_selected' />");
// 		return;
// 	}
	
// 	var updateDocStatusCall = function() { updateDocumentStatus(params); };

// 	showAcceptCancel(msg, updateDocStatusCall);	
}

function updateDocumentStatus(params)
{
	// send the information to the server
	jQuery.postJSON("user-document/update-document-status.json", params, updateDocumentStatusCallBack);

	// we should block the page to avoid further activities here
	blockPage();
	
	// return false to avoid the form submit from the event
	return false;
}

function updateDocumentStatusCallBack(response)
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
		//reloadGrid();
		getTable().jqGrid('setRowData', documentId, response.body);
		// show modal with server response
		showMessage(response.message);
		documentId = null;
	}
}

function downloadDocumentClicked()
{
	// if no user selected, notify it
	if (documentId == null)
	{
		showMessage("<spring:message code='Document_not_selected' />");
		return;
	}
	else
	{
		jQuery("#postDocument").attr("src", "user-document/get-document.page?id=" + documentId);
	}
}

function solicitudClicked()
{ 
	redirectURL("solicitud.page");
}
function isValidContenedor(contenedor)
{
	return /[A-Z]{4,4}[0-9]{7,7}/.test(contenedor.toUpperCase().trim());
}

function buildContainerTable(){
	edition = new JQGrid_Column_Edition();
	edition.grid = $("#jqGrid");
	
	column = new JQGrid_Column_Model();
	column.name = "unit_nbr";
	column.type = "text";
	column.dataInit = function(element) { jQuery(element).css({'width': '99%', 'height':'99%'}).addClass("inputToUppercase").attr({'maxlength': 11,'minlength': 11} ); 
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{		
		$("#jqGrid").jqGrid("setCell", rowid, 'value', value.toUpperCase());
		var rowData = $("#jqGrid").jqGrid('getLocalRow', rowid);
		var datosContenedor;
		var isValidContainer = false;
		jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta)
		{
		}).done(function(datta) {
			$.each(datta, function(i, item) {
			    if(item.unit_nbr == rowData.unit_nbr.toUpperCase())
			    {
			    	isValidContainer=true;
			    }			   
			});
			if(isValidContainer)
			{
				//task #13
				unblockPage();
				showMessage("<spring:message code='registro_duplicate' />");
					$('#jqGrid').jqGrid('setGridParam', {data: datta});
					$("#jqGrid").trigger('reloadGrid');
			}
			else{
			if (!isValidContenedor(rowData.unit_nbr.toUpperCase()))
			{
				unblockPage();
				// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
				// 						function(){aColumn.restoreColumn("contenedor");});
								showMessage("<spring:message code='Invalid_container_number_format' />");
								
			}
			else
				{

				
				if (typeof rowData.fecha === "undefined")
				{
					
					datosContenedor = '{"unit_nbr":"'+rowData.unit_nbr.toUpperCase()+'","idsolicont":null,"solicitud":'+$("#IdSolicitud").val()+',"fecha":null}';
					$('#jqGrid').jqGrid('setGridParam', {data: datta});
					$("#jqGrid").trigger('reloadGrid');
			}else
				{
					
					datosContenedor = '{"unit_nbr":"'+rowData.unit_nbr.toUpperCase()+'","idsolicont":'+rowData.idsolicont+',"solicitud":'+$("#IdSolicitud").val()+',"fecha":"'+rowData.fecha+'"}';
				}
				 
				datosContenedor = jQuery.parseJSON(datosContenedor);
				if (typeof rowData.fecha === "undefined"){
					var jqxhr = 
						jQuery.postJSON("rest/SolicitudContenedor/", 
						datosContenedor	, 
						function(data) 
						{
							jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
								$('#jqGrid').jqGrid('setGridParam', {data: datta});
								$("#jqGrid").trigger('reloadGrid');
				    		});
							
						}
					);
				}else{
					var jqxhr = 
						jQuery.postJSON("rest/SolicitudContenedor/update", 
						datosContenedor	, 
						function(data) 
						{
							jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
								$('#jqGrid').jqGrid('setGridParam', {data: datta});
								$("#jqGrid").trigger('reloadGrid');
				    		});
							
						}
					);
				}
			};
		}
			
		  });
					
	}	
		
			
		
	edition.addColumn(column);
	
	
	
	containerGridOptions = {
		// set url to get information from the server
		url:'rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(),
		datatype: "json",
		mtype: 'GET',			
		colModel:
		[
			{name:'idsolicont', index:'idsolicont', width:80, align: "left", hidden: true},
			{name:'solicitud',index:'solicitud', width:150, align: "left", hidden: true},
			{name:'unit_nbr',index:'unit_nbr', width:150, align: "left", label : '<spring:message code="Solicitud_Container_Name" />', editable: true,editoptions: {size:11, maxlength: 11}},
			{name:'fecha',index:'fecha', width:150, align: "left", label : '<spring:message code="Solicitud_Container_Date" />', editable: false}
		],	
		loadonce : true,
		cellEdit : true,
		cellsubmit : 'clientArray',
		onSelectRow: rowSelected,
		rowNum: 15,
		rowList:[15,30,50],
		pager: "#jqGridPager",
		viewrecords: true,
		width: '600',
		caption:'<spring:message code="Solicitud_Container_Title" />'
    };
		
		
	
}

function addContainerTable(){
	$("#jqGrid").jqGrid(
			'navGrid',
			'#jqGridPager',
			{
				add : true,
				del : true,
				edit : false,
				search : false,
				delfunc : function(rowId) {

					var rowData = $("#jqGrid").jqGrid('getLocalRow', rowId);
					if(rowData.unit_nbr == null)
						{
						var datosContenedor = '{"unit_nbr":"'+rowData.unit_nbr+'","idsolicont":'+rowId+',"solicitud":'+$("#IdSolicitud").val()+',"fecha":"'+rowData.fecha+'"}';
						
						}
					if(rowData.idsolicont== null)
						{
						var datosContenedor = '{"unit_nbr":"'+rowData.unit_nbr.toUpperCase()+'","idsolicont":'+rowId+',"solicitud":'+$("#IdSolicitud").val()+',"fecha":"'+rowData.fecha+'"}';
						
						}
					else
						{
						var datosContenedor = '{"unit_nbr":"'+rowData.unit_nbr.toUpperCase()+'","idsolicont":'+rowData.idsolicont+',"solicitud":'+$("#IdSolicitud").val()+',"fecha":"'+rowData.fecha+'"}';
						
						}
					
					datosContenedor = jQuery.parseJSON(datosContenedor);
					var jqxhr = 
						jQuery.postJSON("rest/SolicitudContenedor/delete", 
						datosContenedor	, 
						function(data) 
						{
							jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
								$('#jqGrid').jqGrid('setGridParam', {data: datta});
								$("#jqGrid").trigger('reloadGrid');
				    		});
							
						}
					);
					

					
					$("#jqGrid").jqGrid('resetSelection');
					$("#jqGrid").jqGrid('delRowData', rowId);

					edition.cellInfo.rowid = null;

				},
				addfunc : function() {
					try {	
						
						//validateTransporterData(selectedRow);
						//validateAddNewRow();

						var newRow = {
							id : getNextNewId(),
							extra : {}
						};
						$("#jqGrid").jqGrid('addRowData', newRow.id, newRow);
						$("#jqGrid").jqGrid('editCell', newRow.id, 0, false);
					} catch (ex) {
						showMessage(ex.getMessage());
					}
				}
			});
}
function getNextNewId() {
	var ids = $("#jqGrid").jqGrid('getDataIDs');

	if (ids.length == 0)
		return 1;
	else
		return parseInt(ids[ids.length - 1]) + 1;
}
</script>
</html>