<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="bloqueos" />

<html>
<head>
	<c:import url="/metas.jsp" />
	<title><c:out value='${title}' /></title>
	<c:import url="/libraries.jsp" />
	<c:import url="/libraries_table.jsp" />
	<c:import url="/libraries_plugins.jsp" />
	
	<script type="text/javascript" src="js/jqgrid-column-edition.js"></script>
    
    <script type="text/javascript" src="panels/fake-panel.js"></script>
    <script type="text/javascript" src="panels/user-bloqueos.js"></script>
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


	<br/>
	
	<table class="display" id="transportistasTable"></table>
	<div id="transportistasPager"></div>
	<br/>
     <div id="userAdminContainer" style="display: none;"></div>
		<div class="genericButtonsArea wideFields" align=center>
			<input id=editUserButton type=button value="<spring:message code='EditUser' />" />
			<input id=newUserButton type=button value="<spring:message code='NewUser' />" />
			
		</div>

	</div>
     



<c:import url="/footer.jsp" />
<div id="modalMessage">
	<p></p>
</div>

</body>
<script type="text/javascript">
var nombre1;
userId=null;
var str;
var userPanel = null;
var str1;
var edition = null;
jQuery(document).ready(loaded);
function loaded() {
	buildTransportistasTable();
	
	
	jQuery("#newUserButton").click(newUserClicked);
	jQuery("#editUserButton").click(editUserClicked);
	
	function newUserClicked() {
		userPanel.clean();
		userPanel.open();
	}

	jQuery("#userAdminContainer").load(
			User_Bloqueos.uiFile + "?ts=" + new Date().getTime(),
			function() {
				userPanel = new User_Bloqueos();
				userPanel.registerHandler(User_Bloqueos.Events.SAVE_USER,
						function(sender, object) {
							var requestInfo = {
								id : object.id
							};
							location.href="bloqueos.page"
							/*updateTableWithRequest(getUserTable(),
									"rest/bloqueos_/UserN4.json",
									requestInfo);*/
						});

				userPanel.parent = jQuery("#userAdminContainer");
				userPanel.init();
			});
	
	$("#transportistasTable").jqGrid(edition.computeOptionsForGrid(containerGridOptions));
	addContainerTable();
}

function getUserTable() {
	return jQuery('#transportistasTable');
}

function buildTransportistasTable(){
	edition = new JQGrid_Column_Edition();
	edition.grid = $("#transportistasTable");

	
	containerGridOptions = {
		// set url to get information from the server
		url:'rest/bloqueos_/UserN4',
		datatype: "json",
		mtype: 'POST',			
		colModel:
		[
			{name:'id', index:'id', width:50, align: "left", hidden: false,editable: true},
			{name:'Tipo_Movimiento',label : 'Movimiento',index:'Tipo_Movimiento', width:100, align: "left", hidden: false,editable: true},
			{name:'nombre_agencia_excluir',label : 'Agecia',index:'nombre_agencia_excluir', width:190, align: "left", hidden: false,editable: true},
			{name:'nombre_cliente_excluir',label : 'Cliente',index:'nombre_nombre_excluir', width:210, align: "left", hidden: false,editable: true},
			{name:'lineas',label : 'Linea',index:'lineas', width:50, align: "left", hidden: false,editable: true},
			{name:'Tipo_contendor',index:'Tipo_contendor',label : 'Tipos', width:250, align: "left", hidden: false,editable: true},
			{name:'mensaje',index:'mensaje',label : 'Mensaje', width:250, align: "left", hidden: false,editable: true},	
			{name:'fecha_desactivacion',label : 'Fecha Desactivacion',index:'fecha_desactivacion', width:150, align: "left", hidden: false,editable: true},	
				],	
		onSelectRow : rowSelected,
		loadonce : true,
		cellsubmit : 'clientArray',
		rowNum: 15,
		rowList:[15,30,50],
		pager: "#transportistasPager",
		viewrecords: true,
		width: '1400',
		caption:'<spring:message code="Solicitud_Container_Title" />'
    };
}
function rowSelected(id) {
	
	id_=$("#transportistasTable").jqGrid('getLocalRow', id).id
	userId = id_;
}

function editUserClicked() {
	// if no user selected, notify it
	if (userId == null) {
		showMessage("<spring:message code='No_user_selected' />");
		return;
	}
	
	// retrieve user information from the serverbloqueos_hola
	jQuery.postJSON("rest/bloqueos_/edit-user.json", {
		id : userId
	}, editUserClicked_callback);
	

	// we should block the page to avoid further activities here
	blockPage();
}
function addContainerTable(){
	$("#transportistasTable").jqGrid(
			'navGrid',
			'#transportistasPager',
			{
				add : false,
				del : true,
				edit : false,
				search : false,
				delfunc : function(rowId) {
					var rowData = $("#transportistasTable").jqGrid('getLocalRow', rowId);
					jQuery.getJSON('rest/bloqueos_/delete/' + rowData.id,{},function(data) {
						location.href="bloqueos.page"
					});

					$("#transportistasTable").jqGrid('resetSelection');
					$("#transportistasTable").jqGrid('delRowData', rowId);
					edition.cellInfo.rowid = null;

				}
			});
}
function getNextNewId() {
	var ids = $("#transportistasTable").jqGrid('getDataIDs');

	if (ids.length == 0)
		return 1;
	else
		return parseInt(ids[ids.length - 1]) + 1;
}





function editUserClicked_callback(data) {
	unblockPage();

	if (data.error) {
		showMessage(data.message, {
			title : 'Error'
		});
	} else {
		userPanel.fillFrom(data.body);
		userPanel.id = userId;
		userPanel.open();
	}
}


</script>
</html>