<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="Transportistas" />

<html>
<head>
	<c:import url="/metas.jsp" />
	<title><c:out value='${title}' /></title>
	<c:import url="/libraries.jsp" />
	<c:import url="/libraries_table.jsp" />
	<c:import url="/libraries_plugins.jsp" />
	
	<script type="text/javascript" src="js/jqgrid-column-edition.js"></script>
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


	<br/>
	
	<table class="display" id="transportistasTable"></table>
	<div id="transportistasPager"></div>
	<br/>


	</div>




<c:import url="/footer.jsp" />
<div id="modalMessage">
	<p></p>
</div>

</body>
<script type="text/javascript">
var nombre1;
var str;
var str1;
var edition = null;
jQuery(document).ready(loaded);
function loaded() {
	buildTransportistasTable();
	
	$("#transportistasTable").jqGrid(edition.computeOptionsForGrid(containerGridOptions));
	addContainerTable();
}


//Id_userN4_Id
var nose;
function buildTransportistasTable(){
	edition = new JQGrid_Column_Edition();
	edition.grid = $("#transportistasTable");
	

	
	//user name
	var column = new JQGrid_Column_Model();
	column.name = "username";
	column.type = "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 3;
		opts.source = function(req, resp)
		{
			
			jQuery.getJSON("rest/Transportista/likes/" + req.term.toUpperCase(), { },resp) 
			/*str= $("#transportistasTable").jqGrid('getLocalRow', '14').username;
			alert(str);
			jQuery.getJSON("rest/Transportista/status/" + str, { }, function(datta)
					{
				
					});*/
			
		};
		opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");	};
		//alert(opts.key);
		return opts;
	};	
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		//alert(value);
		
		var rem = value + '';
		rem =rem.replace(".","%2c");
		rem =rem.replace("/","diag");
		rem =rem.replace(",","coma");
		rem =rem.replace(".","%2c");
		rem =rem.replace(".","%2c");
		rem =rem.replace(".","%2c");
		rem =rem.replace(".","%2c");
		rem =rem.replace(".","%2c");
		rem =rem.replace("&","sig");
		rem =rem.replace(" ","bla");
		//alert(value);
		//alert("4"+rem);
	 
		jQuery.getJSON('rest/Transportista/nombre/' + rem, {}, function(datta)
			{
				//alert(value);
				str = datta.id;
			
		var myColumn = this;
		//myColumn.setColumnValue('transportista_id', getColumnObjectForAtomicValue(bookingItem.cmdy));
		//alert(str);
		nombre1= rem;
		var rowData = $("#transportistasTable").jqGrid('getLocalRow', rowid);
		//alert(rowData.username.id);
		var isValidContainer=false;
		jQuery.getJSON("rest/Transportista/status/" + str, { }, function(datta)
				{
			//(datta);
			if(datta == "")
					{
					   rowData.username="";
					   str1="";
					   showMessage("<spring:message code='registro_noexiste' />");
					   $('#transportistasTable').jqGrid('setGridParam', {data: datta});
						$("#transportistasTable").trigger('reloadGrid');
						//location.reload(true);
						setTimeout("location.reload(true);",2000);
					}
			     else
			    	 {
			    		jQuery.getJSON('rest/UserTransportistas/UserN4/' + $('#Id_userN4_Id').val(), { }, function(data) {
			    			
						}).done(function(datta) {
							$.each(datta, function(i, item) {
								str1=item.username;
							    if(str1 == rowData.username)
							    {
							    
							    	isValidContainer=true;
							    }			   
							});
							if(isValidContainer)
							{
								
								//task #13
								unblockPage();
								//alert("yo1");
								rowData.username="";
								str1="";
								showMessage("<spring:message code='registro_duplicate' />");
									$('#transportistasTable').jqGrid('setGridParam', {data: datta});
									$("#transportistasTable").trigger('reloadGrid');
									
							}
							else
								{
								var myColumn = $("#transportistasTable").jqGrid('getLocalRow', rowid);
						 		if(myColumn.id_user_trans){
						 			
						 			var rem = myColumn.username + '';
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace("/","diag");
						 			rem =rem.replace(",","coma");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace("&","sig");
						 			rem =rem.replace(" ","bla");
						 			
						 			jQuery.getJSON('rest/Transportista/nombre/' + rem, {}, function(datta){
						 				//alert("entre updote");
						 				jQuery.getJSON('rest/UserTransportistas/update.json?trans_id='+datta.id+'&nivel='+myColumn.nivel+'&id='+myColumn.id_user_trans+'&username='+ rem, {}, function(datta){
						 					
						 				});
						 			});
						 			//rest/UserTransportistas/update.json?trans_id=377901644&nivel=Intermedio&id=44
						 			
						 		} if(myColumn.nivel)
						 		  {
						 			if(myColumn.username==null && myColumn.nivel == null)
						 				{
						 			var rem = myColumn.username + '';
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace("/","diag");
						 			rem =rem.replace(",","coma");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace(".","%2c");
						 			rem =rem.replace("&","sig");
						 			rem =rem.replace(" ","bla");
						 			//usern4 nivel trans_id username
						 			jQuery.getJSON('rest/Transportista/nombre/' + rem, {}, function(datta){
						 				//alert("5"+rem);
						 				//alert("guardo");
						 				jQuery.getJSON('rest/UserTransportistas/save.json?usern4='+$("#Id_userN4_Id").val()+'&nivel='+myColumn.nivel+'&trans_id='+datta.id+'&username='+rem+'&idUser='+$("#Id_user_bitacora").val(), {}, function(dattta){
						 							
						 				});
						 			}).done(function() {
						 				jQuery.getJSON('rest/UserTransportistas/UserN4/' + $('#Id_userN4_Id').val(), { }, function(data) {
						 					
						 				})
						 				.done(function(data){
						 					$('#transportistasTable').jqGrid('setGridParam', {data: data});
						 					$('#transportistasTable').trigger('reloadGrid');
						 				});
						 			  });
						 				}
						 	
						 		if(myColumn.username==null && myColumn.nivel == null)
						 		{var nivel =$("#nivel").val();

						 		var rem =value + '';
					 			rem =rem.replace(".","%2c");
					 			rem =rem.replace("/","diag");
					 			rem =rem.replace(",","coma");
					 			rem =rem.replace(".","%2c");
					 			rem =rem.replace(".","%2c");
					 			rem =rem.replace(".","%2c");
					 			rem =rem.replace(".","%2c");
					 			rem =rem.replace(".","%2c");
					 			rem =rem.replace("&","sig");
					 			rem =rem.replace(" ","bla");
						 				//usern4 nivel trans_id username
						 				jQuery.getJSON('rest/Transportista/nombre/' + rem , {}, function(datta){
						 					nombre1= rem;
						 					//jQuery.getJSON('rest/UserTransportistas/save.json?usern4='+$("#Id_userN4_Id").val()+'&nivel='+ nivel+'&trans_id='+datta.id+'&username='+datta.nombre+'&idUser='+$("#Id_user_bitacora").val(), {}, function(dattta){
						 								
						 					//});
						 				}).done(function() {
						 					jQuery.getJSON('rest/UserTransportistas/UserN4/' + $('#Id_userN4_Id').val(), { }, function(data) {
						 						
						 					})
						 					.done(function(data){
						 						$('#transportistasTable').jqGrid('setGridParam', {data: data});
						 						$('#transportistasTable').trigger('reloadGrid');
						 					});
						 				  });
						 			}
						 					}
						    	 
								
								}
						 });
			    	 
			    	 
			    	 }
			    	 
			     
				});
		
			});
	};
			
	edition.addColumn(column);
	
	var column = new JQGrid_Column_Model();
	column.name = "nivel";
	column.type = "select";
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		var myColumn = $("#transportistasTable").jqGrid('getLocalRow', rowid);
		
		if(myColumn.id_user_trans){
			var rem =myColumn.username + '';
 			rem =rem.replace(".","%2c");
 			rem =rem.replace("/","diag");
 			rem =rem.replace(",","coma");
 			rem =rem.replace(".","%2c");
 			rem =rem.replace(".","%2c");
 			rem =rem.replace(".","%2c");
 			rem =rem.replace(".","%2c");
 			rem =rem.replace(".","%2c");
 			rem =rem.replace("&","sig");
 			rem =rem.replace(" ","bla");
			jQuery.getJSON('rest/UserTransportistas/update.json?trans_id='+myColumn.transportista_id+'&nivel='+myColumn.nivel+'&id='+myColumn.id_user_trans+'&username='+rem, {}, function(datta){
				
			});
			//
			//rest/UserTransportistas/update.json?trans_id=377901644&nivel=Intermedio&id=44
			
		}
		if(myColumn.username){

			if(myColumn.id_user_trans){
				jQuery.getJSON('rest/UserTransportistas/update.json?trans_id='+myColumn.transportista_id+'&nivel='+myColumn.nivel+'&id='+myColumn.id_user_trans+'&username='+rem, {}, function(datta){
					
				});
			}
				else
					{
					var rem =myColumn.username + '';
		 			rem =rem.replace(".","%2c");
		 			rem =rem.replace("/","diag");
		 			rem =rem.replace(",","coma");
		 			rem =rem.replace(".","%2c");
		 			rem =rem.replace(".","%2c");
		 			rem =rem.replace(".","%2c");
		 			rem =rem.replace(".","%2c");
		 			rem =rem.replace(".","%2c");
		 			rem =rem.replace("&","sig");
		 			rem =rem.replace(" ","bla");
			jQuery.getJSON('rest/Transportista/nombre/' + rem, {}, function(datta){
				//alert("s" +rem);
				jQuery.getJSON('rest/UserTransportistas/save.json?usern4='+$("#Id_userN4_Id").val()+'&nivel='+myColumn.nivel+'&trans_id='+datta.id+'&username='+ rem +'&idUser='+$("#Id_user_bitacora").val(), {}, function(dattta){
						
							
				});
			}).done(function() {
				//alert(str);
				jQuery.getJSON('rest/UserTransportistas/UserN4/' + $('#Id_userN4_Id').val(), { }, function(data) {
					
				})
				.done(function(data){
					$('#transportistasTable').jqGrid('setGridParam', {data: data});
					$('#transportistasTable').trigger('reloadGrid');
				});
			  });
					}
		}

		if( myColumn.nivel == null)	
		{
			    var _nivel
			    if(value ==1)
			    	{
			    	_nivel ='Nivel 1';
			    	
			    	}
			    if(value ==2)
		    	{
		    	_nivel ='Nivel 2';
		    	
		    	}

			    if(value ==3)
		    	{
		    	_nivel ='Nivel 3';
		    	
		    	}

			    if(value ==4)
		    	{
		    	_nivel ='Ninguno';
		    	
		    	}

			   
				//usern4 nivel trans_id username
				jQuery.getJSON('rest/Transportista/nombre/' + nombre1, {}, function(datta){
					//alert(nombre1);
					jQuery.getJSON('rest/UserTransportistas/save.json?usern4='+$("#Id_userN4_Id").val()+'&nivel='+ _nivel+'&trans_id='+datta.id+'&username='+nombre1+'&idUser='+$("#Id_user_bitacora").val(), {}, function(dattta){
								
					});
				}).done(function() {
					
					jQuery.getJSON('rest/UserTransportistas/UserN4/' + $('#Id_userN4_Id').val(), { }, function(data) {
						
					})
					.done(function(data){
						$('#transportistasTable').jqGrid('setGridParam', {data: data});
						$('#transportistasTable').trigger('reloadGrid');
					});
				  });
			}
		
		
		/*jQuery.getJSON('rest/user-admin/username/' + value, {}, function(datta){
			myColumn.setColumnValue('user_name', datta.fullName);
		});*/
	};
	edition.addColumn(column);
	
	containerGridOptions = {
		// set url to get information from the server
		url:'rest/UserTransportistas/UserN4/' + $('#Id_userN4_Id').val(),
		datatype: "json",
		mtype: 'GET',			
		colModel:
		[
			{name:'id_user_trans', index:'id_user_trans', width:80, align: "left", hidden: true},
			{name:'transportista_id',index:'transportista_id', width:150, align: "left", hidden: true},
			{name:'user_n4_id',index:'user_n4_id', width:150, align: "left", hidden: true},
			{name:'username',index:'username', width:150, align: "left", label : '<spring:message code="Header_Transportistas_Tranportista" />', editable: true},
			
			{name:'nivel',index:'nivel', width:150, align: "left", label : '<spring:message code="Header_Transportistas_Nivel" />', edittype:'select', editable: true, editoptions: { value: '4:Ninguno; 1:Nivel 1; 2:Nivel 2; 3:Nivel 3' }}
		],	
		loadonce : true,
		cellEdit : true,
		cellsubmit : 'clientArray',
		rowNum: 15,
		rowList:[15,30,50],
		pager: "#transportistasPager",
		viewrecords: true,
		width: '600',
		caption:'<spring:message code="Solicitud_Container_Title" />'
    };
}

function addContainerTable(){
	$("#transportistasTable").jqGrid(
			'navGrid',
			'#transportistasPager',
			{
				add : true,
				del : true,
				edit : false,
				search : false,
				delfunc : function(rowId) {
					var rowData = $("#transportistasTable").jqGrid('getLocalRow', rowId);
					jQuery.getJSON('rest/UserTransportistas/delete/' + rowData.id_user_trans,{},function(data) {
						jQuery.getJSON('rest/UserTransportistas/UserN4/' + $('#Id_userN4_Id').val(), { }, function(data) {
								$('#transportistasTable').jqGrid('setGridParam', {data: data});
								$("#transportistasTable").trigger('reloadGrid');
						});
					});

					$("#transportistasTable").jqGrid('resetSelection');
					$("#transportistasTable").jqGrid('delRowData', rowId);
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
						$("#transportistasTable").jqGrid('addRowData', newRow.id, newRow);
						$("#transportistasTable").jqGrid('editCell', newRow.id, 0, false);
					} catch (ex) {
						showMessage(ex.getMessage());
					}
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

</script>
</html>