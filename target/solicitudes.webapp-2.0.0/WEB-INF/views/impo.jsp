<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:import url="/doctype.jsp" />
<html>

<!-- appointment jsp begins -->

<c:import url="/appointment.jsp" />

<!-- appointment jsp ends -->
<input type="text" id="custumrelease" />
<script>
var dataTransportSelect;
var special_ = false;
var _tit= "false";
var recinto;
var id;
var value2_;
var valuee;
var row;
var id_;
var a;
var custumvisible=false;
var myColumn;
function buildTableDefinition()
{

	/*
 Column Edition */
	
	edition = new JQGrid_Column_Edition();
	edition.grid = getTable();
	edition.afterColumnSave = afterColumnSave;
	edition.beforeEditCell = beforeEditCell;

	/*
	* contenedor column
	*/

	var column = new JQGrid_Column_Model();
	column.name = "contenedor";
	column.type = "autocomplete";
	column.autocomplete_options = function(aColumn)
	{
		var opts = { };
		opts.minLength = 11;
		opts.maxLength = opts.minLength;
		opts.source = function(req, resp) { 
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
						jQuery.getJSON('rest/Contenedor/status/' + req.term.toUpperCase(), {}, function(datta)
						{
						}).done(function(datta) {
								if(datta.collection[0] == null)
									{
									 var url = "rest/Contenedor/recent/unit_nbr/"
											+ encodeURIComponent(req.term.toUpperCase());
									jQuery.getJSON(
											url,
											{},
											function(data) {
												if (data.length == 0) {
													unblockPage();
													//showCustomMessage("<spring:message code='Container_was_not_found' />", function(){aColumn.restoreColumn("contenedor");});
													showMessage("<spring:message code='Container_was_not_found' />");
													window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
												} 
												if (data == null) {
														unblockPage();
														//showCustomMessage("<spring:message code='Container_was_not_found' />", function(){aColumn.restoreColumn("contenedor");});
														showMessage("<spring:message code='Container_was_not_found' />");
														window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
													} 
												else {
													  id_ =data.unit_gkey;
													  recinto = data.recinto_Tit;
													  resp([req.term.toUpperCase()]);	
												}
											});	
									}
								else
									{
									unblockPage();
								showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
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
		
	}
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		agenciavalidacion =$("#solicitudAgenciaAduanalId").val();
		clientevalidacion=$("#solicitudClienteId").val();
		
		 myColumn = this;
		jQuery.getJSON("rest/Contenedor/" + id_, null, function(data)
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

			if (recinto ==null)
				{
				if(_tit =="false")
					{
					
					//alert(iRow);
					//getTable().jqGrid("setCell", rowid, 'special.label', '',{editable:true});
					//getTable().trigger("reloadGrid");
					//getTable().jqGrid('editCell', newRow.id, 0, false);
					
					//getTable().jqGrid('editCell',iRow,iCol, false);
					//getTable().trigger("reloadGrid");
					//getTable().trigger("reloadGrid");
					//var cm = $('#table').jqGrid('setCell',"special..label");

//  					{   cm.editable=true;}
					myColumn.setColumnValue('bl.label', getColumnObjectForAtomicValue(obj.bl_Nbr));
					myColumn.setColumnValue('custum.label', getColumnObjectForAtomicValue(obj.customrelease));
					myColumn.setColumnValue('tipo.label', getColumnObjectForAtomicValue(obj.type_Iso));
					myColumn.setColumnValue('linea.label', getColumnObjectForAtomicValue(obj.line_Op));
					myColumn.setColumnValue('temporal', obj.temporal);
					myColumn.setColumnValue('recintoDestino.label', getColumnObjectForAtomicValue(obj.recinto_Tit));
					myColumn.setColumnValue('special', null);
					myColumn.setColumnValue('costado', checked=true);
					//myColumn.setColumnValue('special', editable=true);getColumnObjectForAtomicValue(obj.special)
					$("#custumrelease").val(getColumnObjectForAtomicValue(obj.customrelease))
					$('#recintoSelected').attr('value', obj.recinto_Tit);
					tipovalidacion=getColumnObjectForAtomicValue(obj.type_Iso);
					lineavalidacion=getColumnObjectForAtomicValue(obj.line_Op);
					validaciontipos1();
					}
				else
					{
					unblockPage();
					showMessage("<spring:message code='TIT_without_recinto' />");
					}
				}
			else
				{
				//alert(_tit);
				if(_tit =="true")
				{
				myColumn.setColumnValue('bl.label', getColumnObjectForAtomicValue(obj.bl_Nbr));
				myColumn.setColumnValue('custum.label', getColumnObjectForAtomicValue(obj.customrelease));
				myColumn.setColumnValue('tipo.label', getColumnObjectForAtomicValue(obj.type_Iso));
				myColumn.setColumnValue('linea.label', getColumnObjectForAtomicValue(obj.line_Op));
				myColumn.setColumnValue('temporal', obj.temporal);
				myColumn.setColumnValue('recintoDestino.label', getColumnObjectForAtomicValue(obj.recinto_Tit));
				myColumn.setColumnValue('special', null);
				$("#custumrelease").val(getColumnObjectForAtomicValue(obj.customrelease))
				myColumn.setColumnValue('costado', checked=true);
				//getSpecialColumn();
				$('#recintoSelected').attr('value', obj.recinto_Tit);
				tipovalidacion=myColumn.getColumnValue(getColumnObjectForAtomicValue(obj.type_Iso));
				lineavalidacion=myColumn.getColumnValue(getColumnObjectForAtomicValue(obj.line_Op));
				validaciontipos1();
				
				}
			else
				{
				unblockPage();
				showMessage("<spring:message code='Recinto_without_TIT' />");
				}
				}
			
		});
	};
	//edition.addColumn(getSpecialColumn());
	
	edition.addColumn(column);
	
	var column = new JQGrid_Column_Model();
	column.name = "special";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn) {
		var opts = {};
		opts.sourceUrl = "rest/Special/search";
		opts.sourceParams = {
			moveWithAll : solicitudTranType,
			companyLike : solicitudUserCompanyCode
		};
		opts.optionObject = function(obj) {
			return {
				label : obj.descripcion,
				id : obj.special,
				id_hold : obj.id_hold
				
			};
		};

		opts.sourceError = function(data) {
			window.setTimeout(function() {
				aColumn.cancelColumnValue();
			}, 100);
			showMessage(data.message);
		};

		return opts;
	};
	var r;
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol) 
	{	
		//alert("SZDA");
		var rowData = getTable().jqGrid('getLocalRow', rowid);
		r= rowid;
		if (_tit !="false")
		{
			recinto1 =rowData.recintoDestino.label;
			if (!isDataEmpty (recinto1))
			{
				//alert("entre sin special");
				 throw  'No tiene permisos de seleccionar special';
				
			}
		}
		else
			{
				special1 =rowData.special;
				//alert(special1.label);
				if(r>2)
				{
				special1 =rowData.special.label;
				}
				if (!isDataEmpty(special1)  )
				{
					//alert("entre cuando tengo special");
					 throw  'No tiene permisos de modificación';
				}
			}
			
		
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		//alert("entre 1");
		if(titulo =='Entrega de Importación')
		{
		if (recinto !=null)
		{
		if(_tit !="false")
			{
			//alert("entre 1");
			 throw  'No tiene permisos de seleccionar special';
			}
			 
			}
		
		}
	};
	column.validate = function(value) 
	{
		var rowData = getTable().jqGrid('getLocalRow', r);
		//alert("entre va");
		if(titulo =='Entrega de Importación')
		{
		if (recinto !=null)
		{
		if(_tit !="false")
			{
			//alert("entre va");
			  throw  'No tiene permisos de seleccionar special';
			}
		}
		if(_tit =="false")
			{
			
				special1 =rowData.special;
				if(r>2)
				{
				special1 =rowData.special.label;
				}
				if (!isDataEmpty (special1) )
				{
					
					//alert("entre cuando tengo special");
				
					 throw  'No tiene permisos de modificación ';
				}
			
			
		}
		}
		
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
				editable : true
			},
			{
				name : 'bl.label',
				index : 'bl',
				label : "<spring:message code='Bl' />",
				width : 120,
				sortable : false,
				editable : false
			},
			{
				name : 'custum.label',
				index : 'custum',
				label : "Pedimento N4",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text',
				hidden : custumvisible 
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
				name : 'temporal',
				index : 'temporal',
				label : "<spring:message code='Temporal' />",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text'
			},
			{
				name : 'recintoDestino.label',
				index : 'recintoDestino',
				label : "<spring:message code='Target_Recint' />",
				width : 130,
				sortable : false,
				editable : false,
				edittype : 'text'
			},
			{
				name : 'special',
				index : 'special',
				label : "<spring:message code='Special' />",
				width : 260,
				sortable : false,
				editable : true
				//editoptions: { value:"Yes:No"}
				//special_
			},
			{
				name : 'costado',
				index : 'costado',
				label : "<spring:message code='Side' />",
				width : 110,
				sortable : true,
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
		/*	 
			var rowData = getTable().jqGrid('getLocalRow', rowid);
			if (rowData.recintoDestino ==null || rowData.recintoDestino.label =="" || rowData.recintoDestino==rowData.recintoDestino.trim || rowData.recintoDestino =="undefined")
			{
				_tit=false;
				getTransporterTable().jqGrid("setCell", id, 'TIT', valuee);
			}
		else
			{
			getTransporterTable().jqGrid("setCell", id, 'TIT', value);
			alert(value);
			column = new JQGrid_Column_Model();
			column.name = "TIT";
			column.type = "text";
			column.dataInit = function(element) { jQuery(element)
				.change(function() {
					 //alert( "Handler for .change() called." + this.checked );
					  if(this.checked =="false"){
						  this.checked = true;
						}
					});
			}; 
			}*/
		
			var rowData = getTable().jqGrid('getLocalRow', rowid);
			if (!isRowRegistered(rowData))
				showMessageIfInvalidContenedor(iCol, "<spring:message code='Invalid_container_number_length' />");
		}
	};
}
function eliminardatos()
{
	   myColumn.setColumnValue('contenedor',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('bl.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('linea.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('temporal',getColumnObjectForAtomicValue(""));	
	   myColumn.setColumnValue('custum.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('tipo.label',getColumnObjectForAtomicValue(""));	
}
	

function operationValidateRowInfo(rowData)
{
	if (isDataEmpty(rowData.contenedor))
		throw new SolicitudError("<spring:message code='Container_must_be_defined' />");
	
	/*if (recinto ==null)
	{
	if(_tit =="false")
		{
			if (isDataEmpty(rowData.special))
			throw "Seleccionar un special";
		}
	}*/
	 
}

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

	/////neitek
	/*var r2;
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol) 
	{	
		//alert(id_);
		var q = getTable().jqGrid('getLocalRow',id_ );
		//alert (q.special);
		row = getTransporterTable().getRowData(rowid);
		//alert("SZDA");
	     r2= rowid;
		if (_tit =="false" && row.transporter !="" && !isDataEmpty(q.special))
		{
		
		//alert("entre sin special");
		//getTransporterTable().jqGrid("setCell", rowid, 'transporter', 'AUTOTRANSPORTE CABALLERO E HIJOS');
	    throw  'No tiene permisos de edicion, si lo desea debe cancelar';

		
		//window.location.reload();	
		}	
		
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		/*row = getTransporterTable().getRowData(rowid);
		if (_tit =="false"  && row.transporter !="")
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar2';		
		}
	};
	
	column.validate = function(value) 
	{
		var q = getTable().jqGrid('getLocalRow',id_ );
		row = getTransporterTable().getRowData(r2);
		if (_tit =="false" && row.transporter !="" && !isDataEmpty(q.special))
		{
	
		//alert("entre sin special 11");
		
			//getTransporterTable().jqGrid("setCell", r2, 'transporter', 'AUTOTRANSPORTE CABALLERO E HIJOS');
			throw  'No tiene permisos de edicion, si lo desea debe cancelar';
		//window.location.reload();	
		}
	};*/
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
/////neitek
	/*
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol) 
	{	
		//alert("SZDA");
		var q = getTable().jqGrid('getLocalRow',id_ );
		//r1= rowid;
		row = getTransporterTable().getRowData(rowid);
		if (_tit =="false" && row.operator !="" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
		
			
		
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		/*row = getTransporterTable().getRowData(rowid);
		if (_tit =="false" && row.operator !="")
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
	};
	column.validate = function(value) 
	{
		var q = getTable().jqGrid('getLocalRow',id_ );
		row = getTransporterTable().getRowData(r2);
		if (_tit =="false" && row.operator !="" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
		
	};*/
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
	/////neitek
	/*var r2;
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol) 
	{	
		//alert("SZDA");
		r2 =rowid;
		var q = getTable().jqGrid('getLocalRow',id_ );
		row = getTransporterTable().getRowData(rowid);
		if (_tit =="false" && row.plates !="" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar 1';		
		}
		
			
		
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		/*row = getTransporterTable().getRowData(rowid);
		if (_tit =="false" && row.plates !="")
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
	};
	column.validate = function(value) 
	{
		var q = getTable().jqGrid('getLocalRow',id_ );
		//alert("<input type=\"text\" id=\""+r2+"_plates\" name=\"plates\" role=\"textbox\" class=\"inputToUppercase\" maxlength=\"10\" style=\"width: 99%; height: 99%;\">");
		row = getTransporterTable().getRowData(r2);
		if (_tit =="false" && row.plates !="<input type=\"text\" id=\""+r2+"_plates\" name=\"plates\" role=\"textbox\" class=\"inputToUppercase\" maxlength=\"10\" style=\"width: 99%; height: 99%;\">" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar 2';		
		}
	};*/
	transporterEdition.addColumn(column);
	
	/*
	* TIT column
	*/
	column = new JQGrid_Column_Model();
	column.name = "TIT";
	column.type = "text";
	column.dataInit = function(element) { jQuery(element)
		.change(function() {
			 //alert( "Handler for .change() called." + this.checked );
			  if(this.checked){
				  $('#checkTIT').attr('value', "1");
				  _tit = "true";
				  this.checked = true;
				}else{
					$('#checkTIT').attr('value', "0");
					 _tit ="false";
					this.checked = false;
				}
			});
	}; 
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{	
		id = rowid
		valuee =value;
		getTransporterTable().jqGrid("setCell", rowid, 'TIT', value);
		/*if (_tit =="false" && row.TIT !="")
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}*/
	};
/////neitek
	
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol) 
	{	
		//alert("SZDA");
		
	/*	r1= rowid;
		if (_tit =="false")
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
		
			
		*/
	};
	column.validate = function(value) 
	{
	/*	if (_tit =="false")
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}*/
		
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
		row = getTransporterTable().getRowData(rowid);
		/*if (_tit =="false" && row.date !="") 
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}*/
		
	};
/////neitek
	var r1;
	/*column.beforeEdit = function(rowid, cellname, value, iRow, iCol) 
	{	
		//alert("SZDA");
		var q = getTable().jqGrid('getLocalRow',id_ );
		row = getTransporterTable().getRowData(rowid);
		r1= rowid;
		if (_tit =="false" && row.date !="" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
		
			
		
	};*/
	/*column.validate = function(value) 
	{
		var q = getTable().jqGrid('getLocalRow',id_ );
		row = getTransporterTable().getRowData(r1);
	//	alert("<input type=\"text\" id=\""+r1+"_date\" name=\"date\" role=\"textbox\" class=\"customelement hasDatepicker\" style=\"width: 98%;\">");
		if (_tit =="false" && row.date !="<input type=\"text\" id=\""+r1+"_date\" name=\"date\" role=\"textbox\" class=\"customelement hasDatepicker\" style=\"width: 98%;\">" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		window.location.reload();
		throw  'No tiene permisos de edicion, si lo desea debe cancelar 2';		
		}
		
	};*/
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
		opts.sourceParams = { date : rowData.date, tit : rowData.TIT };
		
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
/////neitek
	/*var r1;
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol) 
	{	
		//alert("SZDA");
		var q = getTable().jqGrid('getLocalRow',id_ );
		r1= rowid;
		row = getTransporterTable().getRowData(rowid);
		if (_tit =="false" && row.time !="" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
		
			
		
	};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
	/*	row = getTransporterTable().getRowData(rowid);
		if (_tit =="false" && row.time !="") 
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
	};
	column.validate = function(value) 
	{
		var q = getTable().jqGrid('getLocalRow',id_ );
		row = getTransporterTable().getRowData(r1);
		if (_tit =="false" && row.time !="" && !isDataEmpty(q.special)) 
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}
		
	};*/
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
		cellsubmit : 'clientArray',
		pager : "#transporterPager",
		viewrecords : true,
		height : 150,
		rowNum: 1000,
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
				width : 80,
				sortable : false,
				editable : vlplacas
				//editoptions : { style: "text-transform: uppercase", maxlength : 10},
			},
			{
				name : 'TIT',
				index : 'TIT',
				label : "<spring:message code='isTIT' />",
				width : 30,
				sortable : false,
				editable : vltit,
				edittype : 'checkbox',
				formatter : 'checkbox',
				editoptions: { value:"Yes:No"}
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
		onCellSelect : function(rowid, iCol, cellcontent,value) {
				
			id= rowid;
			//The grid appointments table will change each time we select a different carrier
			var rowData_ = getTable().jqGrid('getLocalRow', rowid);
			var data =  getTransporterTable().jqGrid('getCell',rowid,'appointments');
			dataTransportSelect= getTransporterTable().jqGrid('getCell',rowid,'appointments');
			getTable().clearGridData(true).trigger("reloadGrid");	
			if(data != "")
			{
				 a= $("#transporterTable").jqGrid('getLocalRow', rowid).id;
				jQuery("#id").val(a);
				data= JSON.parse(data);
				getTable().jqGrid("setGridParam", {data :data}).trigger("reloadGrid");
				if(rowData_.TIT=="yes")
				{
				}
				else
					{
				
						for ( i = 0; i < data.length; i ++ )
						{
							
							id_ = data[i].id
							var rowData = getTable().jqGrid('getLocalRow', id_);
							//alert(rowData.recintoDestino);
							if (rowData.recintoDestino ==null || rowData.recintoDestino.label =="" || rowData.recintoDestino==rowData.recintoDestino.trim || rowData.recintoDestino =="undefined")
							{
								//alert("hola");
								//v="yes";
								//getTable().jqGrid("setCell", 1, 'special.label', v).enable =true;
								//$("#table").jqGrid('editCell',1,'special.label', {editable:true});
								//getTable().jqGrid('editCell',iRow,special.label, true);
								getTransporterTable().jqGrid("setCell", rowid, 'TIT', 0);
								_tit="false";
							}
						else
							{
							//alert("hola1");
							val ="yes";
							getTransporterTable().jqGrid("setCell", rowid, 'TIT', val);
							column = new JQGrid_Column_Model();
							_tit="true";
							
							}
						}
			
					}
			}
			else
				{ a= $("#transporterTable").jqGrid('getLocalRow', rowid).id;
				jQuery("#id").val(a);}
		}
	};

}

	


</script>
</html>