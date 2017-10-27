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
	<div class="documentsContainer" align=center>			   	   
			<sec:authorize access="!hasAnyRole('TI','TA')">
       			<input _clickBind="newDocumentClicked" class="_clickBind" type=button value="<spring:message code='new_document' />" />       		
       		</sec:authorize>
       		<input _clickBind="cancelDocumentClicked" class="_clickBind" type=button value="<spring:message code='cancel_document' />" />
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
	
	// individual button actions
	bindClickEvent("_clickBind");

	//currentMenu
	highlightNavigationBarItem("documentMenu");
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
				{name:'file',index:'file', width:250, align: "left", label : "<spring:message code='document_short_name' />"},
				{name:'status',index:'status', width:100, align: "left", label : "<spring:message code='document_status' />"},
				{name:'date',index:'date', width:200, align: "left", label : "<spring:message code='document_upload_date' />"}			 
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

</script>
</html>