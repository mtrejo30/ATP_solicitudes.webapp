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

var _tit ="false";
var recinto;
var id;
var valuee ;
var value1;
var buque;
var contenedorspecial;
var id_booking;
var id_contenedor;
var _cargapeligrosa;
//alert(_cargapeligrosa);
var _reqconexion;
var _sobredimension;
var _special_;
var a;

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
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{		
		//alert($("#transporterTable").jqGrid('getLocalRow', iRow).id);
		 a= $("#transporterTable").jqGrid('getLocalRow', rowid).id;
		 getTransporterTable().jqGrid("setCell", rowid, 'idpadre_', a);
		jQuery("#id").val(a);
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
				  _tit ="true"
				  //alert("tocar   "+ _tit);
				  this.checked = true;
				}else{
					$('#checkTIT').attr('value', "0");
					  _tit ="false"
					//alert("tocar  "+ _tit);
					this.checked = false;
				}
			});
	}; 
	
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{		
		id = rowid
		valuee =value;
		getTransporterTable().jqGrid("setCell", rowid, 'TIT', value);
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
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		time2 = $("#transporterTable").jqGrid('getLocalRow', rowid).time;
		jQuery("#time_").val(time2);
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
		//sortname : 'idpadre_',
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
				name : 'TIT',
				index : 'TIT',
				label : "<spring:message code='isTIT' />",
				width : 30,
				sortable : false,
				editable : vltit,
				edittype : 'checkbox',
				formatter : 'checkbox',
				checked:'true',
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
			
			id = rowid
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
							var id_ = data[i].id
							var rowData1 = getTable().jqGrid('getLocalRow', id_);
							if (rowData1.recintoOrigen ==null || isDataEmpty(rowData1.recintoOrigen) || rowData1.recintoOrigen.label =="" || rowData1.recintoOrigen==rowData1.recintoOrigen.trim || rowData1.recintoOrigen =="undefined")
							{
								
								getTransporterTable().jqGrid("setCell", rowid, 'TIT', valuee);
								_tit="false";
								//alert ("entre en falso cuando me seleccionan");
							}
						else
							{
							val="yes";
							getTransporterTable().jqGrid("setCell", rowid, 'TIT', val);
							_tit="true";
							//alert ("entre en true cuando me seleccionan");
							}
					 }
				}
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
	/*
	* booking column
	*/
	var column = new JQGrid_Column_Model();
	column.name = "booking";
 	column.type = "custom";
 	column.custom_options = function(aColumn)
 	{
 		//_tit="false";
		var opts = { };
		opts.enableKeyEvent = true;
		return opts;
		
 	};
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
		//getTransporterTable().jqGrid("setCell", id, 'TIT', valuee);
		id_contenedor = rowid;
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
			if(value.label.toUpperCase().substring(0,1) === "S" && !value.label.toUpperCase().substring(1,3) === "LD"|| value.label.toUpperCase().substring(0,1) === "S" && !value.label.toUpperCase().substring(1,4) === "SPH")
				isValid = true;
			else
				isValid = false;
		}else{
			if(value.label.toUpperCase().substring(0,1) === "S")
				if(value.label.toUpperCase().substring(1,3) === "LD"|| value.label.toUpperCase().substring(1,4) === "SPH")
					isValid = true;
				else
					isValid = false;
			else
				isValid = true;
		}
		if(isValid){
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
		}else{
			setBookingData(null);
			showMessage("<spring:message code='Booking_not_filter' />");
			window.setTimeout(function() { myColumn.setColumnValue('booking', null); }, 100);
		}
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
 		 buque = value.id;	
 			jQuery.getJSON("rest/Booking/" + encodeURIComponent(value.id), 
 			{},
 			function(data)
 			{
 			unblockPage();
 			setDatosData(data);
			//myColumn.setColumnValue('buqueViaje.label', getColumnObjectForAtomicValueWithId(data.buqueViajeNombre+ " - " + data.buqueViaje));
			//myColumn.setColumnValue('pod.label', getColumnObjectForAtomicValueWithId(data.podName));
			//myColumn.setColumnValue('fpod.label', getColumnObjectForAtomicValueWithId(data.fpodName));
			myColumn.setColumnValue('fk.label', getColumnObjectForAtomicValueWithId(data.fk));
			id_booking =data.podName;
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
	/*buqueViaje*/
	column = new JQGrid_Column_Model();
	column.name = "buqueViaje.label";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		
		var rowData = getTable().jqGrid('getLocalRow', aColumn.getModel().cellInfo.rowid);
		var bookingId = rowData.booking.id;
        
		var opts = { };
		opts.sourceUrl = "rest/Booking/searchType.json";
		
		opts.sourceParams = { bookingId: buque};
		
		opts.optionObject = function(obj) { return { label : obj.buqueViajeNombre+ " - " + obj.buqueViaje, id : obj.id }; };

		opts.sourceError = function(data)
		{
			
			window.setTimeout(function() { aColumn.restoreColumn('buqueViaje.label'); }, 100);
			showMessage(data.message);
		}
		return opts;
	
	};
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
		
			
	};
	column.validate = function(value) 
	{
			if (value.label.trim().length == 0)
				throw ("<spring:message code='You_have_to_select_a_booking1' />");
		
		
	};
	edition.addColumn(column);
	
	/*puerto final*/
	column = new JQGrid_Column_Model();
	column.name = "fpod.label";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		
		var rowData = getTable().jqGrid('getLocalRow', aColumn.getModel().cellInfo.rowid);
		var bookingId = rowData.booking.id;
        
		var opts = { };
		opts.sourceUrl = "rest/Booking/searchType.json";
		
		opts.sourceParams = { bookingId: buque};
		
		opts.optionObject = function(obj) { return { label : obj.fpodName, id : obj.id }; };

		opts.sourceError = function(data)
		{
			
			window.setTimeout(function() { aColumn.restoreColumn('fpod.label'); }, 100);
			showMessage(data.message);
		}
		return opts;
	
	};
	column.validate = function(value) 
	{
			if (value.label.trim().length == 0)
				throw ("<spring:message code='You_have_to_select_a_booking3' />");
		
		
	};
	edition.addColumn(column);
	
	/*validar puerto descarga-transbordo*/
	column = new JQGrid_Column_Model();
	column.name = "pod.label";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		
		var rowData = getTable().jqGrid('getLocalRow', aColumn.getModel().cellInfo.rowid);
		var bookingId = rowData.booking.id;
        
		var opts = { };
		opts.sourceUrl = "rest/Booking/searchType.json";
		
		opts.sourceParams = { bookingId: buque};
		
		opts.optionObject = function(obj) { return { label : obj.podName, id : obj.id }; };

		opts.sourceError = function(data)
		{
			
			window.setTimeout(function() { aColumn.restoreColumn('pod.label'); }, 100);
			showMessage(data.message);
		}
		return opts;
	
	};
	column.validate = function(value) 
	{
			if (value.label.trim().length == 0)
				throw ("<spring:message code='You_have_to_select_a_booking2' />");
		
		
	};
	edition.addColumn(column);

	
    // tipo column

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
		 myColumn = this;
		 lineavalidacion=myColumn.getColumnValue('linea');
		 tipovalidacion=myColumn.getColumnValue('tipo');
		validaciontipos1();
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
				myColumn.setColumnValue('imo.label', getColumnObjectForAtomicValue(bookingItem.imos));
 				myColumn.setColumnValue('undg', getColumnObjectForAtomicValue(bookingItem.undgField));
				myColumn.setColumnValue('hasHazard', (bookingItem.hasHazard));
				myColumn.setColumnValue('hasMarinePollutants', (bookingItem.hasMarinePollutants));
				myColumn.setColumnValue('hasDimensions', (bookingItem.hasDimensions));
				myColumn.setColumnValue('requireConnection', (bookingItem.requireConnection));
				myColumn.setColumnValue('setPoint', (bookingItem.tempRequired));
				
				_cargapeligrosa =bookingItem.hasHazard ;
				
				 _reqconexion= bookingItem.requireConnection;
				 _sobredimension =bookingItem.hasDimensions;
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
		//alert(_tit);
		 if(_cargapeligrosa == true || _reqconexion== true || _sobredimension==true && _tit=="false")
		 {
		 	//alert("=====ENTRE AQUI==");
		 	opts.source = function(req, resp) {	
				jQuery.getJSON('rest/Contenedor/status/' + req.term.toUpperCase() , {}, function(datta){
				}).done(function(datta) {
				if(datta.collection[0] == null)
					{
					 resp([req.term.toUpperCase()]);
					}
				else
					{
					unblockPage();
				showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
					}
				});	
			}
			opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");};
			
		 }
	if(_cargapeligrosa == true || _reqconexion== true ||_sobredimension==true && _tit==true )
		{
		
		if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
			unblockPage();
			showMessage("<spring:message code='Solicitud_requires_documentation_verif' />");
			}
			else
				{
				
		opts.source = function(req, resp) {
		var isValidContainer = false;
		
		jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
		}).done(function(datta) {
			
			$.each(datta, function(i, item)
			{
			
			    if(item.unit_nbr == req.term.toUpperCase())
			    {
			    	isValidContainer = true;
			    }
			});
			
			if(isValidContainer==true)
			{
				if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
					unblockPage();
					showMessage("<spring:message code='Solicitud_requires_documentation_verif' />");
				}
				else
					{
				if (!isValidContenedor(req.term))
				{
					unblockPage();
	// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
	// 						function(){aColumn.restoreColumn("contenedor");});
					throw 'Verifique número de contenedor, formato no valido';
					window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
				}
				else
				{
					jQuery.getJSON('rest/Contenedor/status/' + req.term.toUpperCase(), {}, function(datta){
						
						
					}).done(function(datta) {
					if(datta.collection[0] == null)
						{
						 resp([req.term.toUpperCase()]);
						}
					else
						{
						unblockPage();
					showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
						}
					});
				   /* resp([req.term.toUpperCase()]);
					unblockPage();*/
				}
			}
			}
				else{
					unblockPage();
					showMessage("<spring:message code='New_Msj_solicitud_ligada' />");	
				}
			  })
		}
		};	
		}
	
	if(_cargapeligrosa == false && _reqconexion== false &&_sobredimension==false && _tit =="false" )
	{
		
		opts.source = function(req, resp) {	
			
			
			jQuery.getJSON('rest/Contenedor/status/' + req.term.toUpperCase() , {}, function(datta){
			}).done(function(datta) {
			if(datta.collection[0] == null)
				{
				 resp([req.term.toUpperCase()]);
				}
			else
				{
				unblockPage();
			showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
				}
			});	
		}
		opts.create = function(event, ui) { jQuery(event.target).addClass("inputToUppercase");};
	}
	
			if(_cargapeligrosa == false && _reqconexion== false &&_sobredimension==false && _tit =="true" )
			{
				opts.source = function(req, resp) {
					
				if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
					unblockPage();
					showMessage("<spring:message code='Solicitud_requires_documentation_verif' />");
					}
					else
						{
				
				var isValidContainer = false;
				jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
				}).done(function(datta) {
					
					$.each(datta, function(i, item)
					{
					    if(item.unit_nbr == req.term.toUpperCase())
					    {
					    	isValidContainer = true;
					    }
					});
					
					if(isValidContainer==true)
					{
						if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
							unblockPage();
							showMessage("<spring:message code='Solicitud_requires_documentation_verif' />");
						}
						else
							{
						if (!isValidContenedor(req.term))
						{
							unblockPage();
			// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
			// 						function(){aColumn.restoreColumn("contenedor");});
							throw 'Verifique número de contenedor, formato no valido';
							window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
						}
						else
						{

							jQuery.getJSON('rest/Contenedor/status/' + req.term.toUpperCase(), {}, function(datta){
								
								
							}).done(function(datta) {
							if(datta.collection[0] == null)
								{
								 resp([req.term.toUpperCase()]);
								}
							else
								{
								unblockPage();
							showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
								}
							});
						   /* resp([req.term.toUpperCase()]);
							unblockPage();*/
						}
					}
					}
						else{
							unblockPage();
							showMessage("<spring:message code='New_Msj_solicitud_ligada' />");	
						}
					  })
				}
				};	
			}
	      
		
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
		if(_special_=="Contenedor con VGM y previo" || _special_=="Previo Express" )
		{
		
		if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
			unblockPage();
			//(id_contenedor);
			getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
			throw "el special seleccionado requiere documentación(carta no despacho)..";
			}
			else
				{
		
		var isValidContainer = false;
		jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
		}).done(function(datta) {
			//alert(value);
			
			$.each(datta, function(i, item)
			{
			    if(item.unit_nbr == value)
			    {
			    	isValidContainer = true;
			    }
			});
			//alert(isValidContainer);
			if(isValidContainer==true)
			{
				if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
					unblockPage();
					getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
					throw "el special seleccionado requiere documentación(carta no despacho)..";
					}
				else
					{
				if (!isValidContenedor(value))
				{
					unblockPage();
//	 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
//	 						function(){aColumn.restoreColumn("contenedor");});
					throw 'Verifique número de contenedor, formato no valido';
					window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
				}
				else
				{

					jQuery.getJSON('rest/Contenedor/status/' + value, {}, function(datta){
						
						
					}).done(function(datta) {
					if(datta.collection[0] == null)
						{
						 resp([value]);
						}
					else
						{
						unblockPage();
						getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
						showMessage("<spring:message code='New_Msj_solicitud_ligada' />");
						throw "El contenedor ya tiene una cita creada en la Terminal, favor de verificar con Servicio a Clientes.";
					
						}
					});
				   /* resp([req.term.toUpperCase()]);
					unblockPage();*/
				}
			}
			}
				else
				{
					unblockPage();
					getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
					showMessage("<spring:message code='New_Msj_solicitud_ligada' />");
					throw "El contenedor no esta ligado a la solicitud, favor de revisarlo con Servicio a Clientes ";
			
						}
			  })
			}
		}
		contenedorspecial =value;
		value1 =value;
		if (!isValidContenedor(value.label))
			throw 'Verifique número de contenedor, formato no valido';
	};
	edition.addColumn(column);
	var rw;
	var rowData__;
	column = new JQGrid_Column_Model();
	column.name = "recintoOrigen";
	column.type = "dropdown";
	column.dropdown_options = function(aColumn)
	{
		var opts = { };
	     var op;
		opts.sourceUrl = "rest/RecintoOrigen/get-all";
		opts.sourceParams = { };
		opts.optionObject = function(obj) {
			return { label : obj.descripcion, id : obj.recinto }; 
			};
		opts.sourceError = function(data)
		{
			window.setTimeout(function() { aColumn.cancelColumnValue(); }, 100);
			showMessage(data.message);
		};
		
		
	//getTransporterTable().jqGrid("setCell", id, 'TIT', value1);
		
		return opts;
		
	};
	
	column.beforeEdit = function(rowid, cellname, value, iRow, iCol)
	{
	/*	 rowData__ = getTransporterTable().jqGrid('getLocalRow', id);
		rw=rowid;
		var rowData = getTable().jqGrid('getLocalRow', rowid);
		//alert(rowData__.TIT);
		if(rowData__.TIT=="no" || rowData__.TIT==undefined)
		{
			getTransporterTable().jqGrid("setCell", id, 'TIT', valuee);
			_tit="false";
			throw  'No tiene permisos de recinto Origen ';
		}
		else
			{
				val ="yes";
			 	_tit="true";
				getTransporterTable().jqGrid("setCell", id, 'TIT', val);
			}
		
		/*if (isDataEmpty(rowData.recintoOrigen.label)||rowData.recintoOrigen ==null || rowData.recintoOrigen.label =="" || rowData.recintoOrigen==rowData.recintoOrigen.trim || rowData.recintoOrigen =="undefined")
		{
			
			getTransporterTable().jqGrid("setCell", id, 'TIT', valuee);
			_tit="false";
			//alert ("entre en falso cuando me seleccionan recintoorigen");
		}
	else
		{
		
		 val ="yes";
		getTransporterTable().jqGrid("setCell", id, 'TIT', val);
		column = new JQGrid_Column_Model();
		column.name = "TIT";
		column.type = "text";
		column.dataInit = function(element) { jQuery(element)
			.change(function() {
				 //alert( "Handler for .change() called." + this.checked );
				  if(this.checked =="false"){
					  $('#checkTIT').attr('value', "1");
					 
					  this.checked = true;
				  }
				});
		};
		 _tit="true";
		 //alert ("entre en true cuando me seleccionan");
		}
	*/
		
			};
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		
	};
	column.validate = function(value) 
	{
		
		
		
	};
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
	column.afterSave = function(rowid, cellname, value, iRow, iCol)
	{
		_special_ =value;
	};
	column.validate = function(value) 
	{
		/*var q = getTable().jqGrid('getLocalRow',id_ );
		//r1= rowid;
		row = getTransporterTable().getRowData(rowid);
		if (_tit =="false" && row.operator !="" && !isDataEmpty(q.special))
		{
				//alert("entre sin special");
		throw  'No tiene permisos de edicion, si lo desea debe cancelar';		
		}*/
		
		_special_ =value;
		if(value=="Contenedor con VGM y previo" || value=="Previo Express" )
			{
			
			if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
				unblockPage();
				//alert(id_contenedor);
				getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
				throw "El special seleccionado requiere documentación(carta no despacho), Favor de anexar";
				}
				else
					{
			
			var isValidContainer = false;
			jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
			}).done(function(datta) {
				//alert(contenedorspecial);
				$.each(datta, function(i, item)
				{
				    if(item.unit_nbr == contenedorspecial)
				    {
				    	isValidContainer = true;
				    }
				});
				
				if(isValidContainer==true)
				{
					if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
						unblockPage();
						getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
						throw "El special seleccionado requiere documentación(carta no despacho), Favor de anexar";
							}
					else
						{
					if (!isValidContenedor(contenedorspecial))
					{
						unblockPage();
		// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
		// 						function(){aColumn.restoreColumn("contenedor");});
						throw 'Verifique número de contenedor, formato no valido';
						window.setTimeout(function() { aColumn.restoreColumn("contenedor"); }, 100);
					}
					else
					{

						jQuery.getJSON('rest/Contenedor/status/' + contenedorspecial, {}, function(datta){
							
							
						}).done(function(datta) {
						if(datta.collection[0] == null)
							{
							 resp([contenedorspecial]);
							}
						else
							{
							unblockPage();
							getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
						showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
							}
						});
					   /* resp([req.term.toUpperCase()]);
						unblockPage();*/
					}
				}
				}
					else{
						unblockPage();
						getTable().jqGrid("setCell", id_contenedor, 'contenedor', " ");
						showMessage("<spring:message code='New_Msj_solicitud_ligada' />");	
					}
				  })
			}
		
			}
	};
	edition.addColumn(column);
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
				editable : true,
			},
			{
				name : 'pod.label',
				index : 'pod',
				label : "<spring:message code='POD' />",
				width : 200,
				sortable : false,
				editable : true
			},
			{
				name : 'fpod.label',
				index : 'fpod',
				label : "<spring:message code='FPOD' />",
				width : 140,
				sortable : false,
				editable : true
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
				editable : vltipo_
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
				editable : vlpeso_,
				edittype : 'text'
			},

			{
				name : 'special',
				index : 'special',
				label : "<spring:message code='Special' />",
				width : 250,
				sortable : false,
				editable : vltipo_
			},
			{
				name : 'undg',
				index : 'undg',
				label : "<spring:message code='UNDG' />",
				width : 110,
				sortable : false,
				editable : vltipo_,
				edittype : 'text'
			},
			{
				name : 'contenido.label',
				index : 'contenido',
				label : "<spring:message code='Contenido' />",
				width : 110,
				sortable : vltipo_,
				editable : false
			},
			{
				name : 'sello1',
				index : 'sello1',
				label : "<spring:message code='Sello1' />",
				width : 110,
				sortable : false,
				editable : vltipo_,
				edittype : 'text'
			},
			{
				name : 'sello2',
				index : 'sello2',
				label : "<spring:message code='Sello2' />",
				width : 110,
				sortable : false,
				editable : vltipo_,
				edittype : 'text'
			},
			{
				name : 'sello3',
				index : 'sello3',
				label : "<spring:message code='Sello3' />",
				width : 110,
				sortable : false,
				editable : vltipo_,
				edittype : 'text'
			},
			{
				name : 'sello4',
				index : 'sello4',
				label : "<spring:message code='Sello4' />",
				width : 110,
				sortable : false,
				editable : vltipo_,
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
				editable : vltipo_
			},
			{
				name : 'costado',
				index : 'costado',
				label : "<spring:message code='Side' />",
				width : 110,
				sortable : false,
				editable : vltipo_,
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
		afterRestoreCell : function (rowid, value, iRow, iCol, cellcontent, e) 
		{
			var rowData = getTable().jqGrid('getLocalRow', rowid);
			
			/*if(rowData.linea !="undefined" || rowData.booking!="undefined" ||rowData.buqueViaje!="undefined" || rowData.recintoOrigen!="undefined" )
			{
				
				if (isDataEmpty(rowData.recintoOrigen.label)||rowData.recintoOrigen ==null || rowData.recintoOrigen.label =="" || rowData.recintoOrigen==rowData.recintoOrigen.trim || rowData.recintoOrigen =="undefined")
				{
					_tit=false;
					getTransporterTable().jqGrid("setCell", id, 'TIT', valuee);
					
				}
			else
				{
				 _tit=true;
				getTransporterTable().jqGrid("setCell", id, 'TIT', value);
				column = new JQGrid_Column_Model();
				column.name = "TIT";
				column.type = "text";
				column.dataInit = function(element) { jQuery(element)
					.change(function() {
						 //alert( "Handler for .change() called." + this.checked );
						  if(this.checked =="false"){
							  $('#checkTIT').attr('value', "1");
							 
							  this.checked = true;
						  }
						});
				}; 
				}
			}*/

			
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
	
	if (isDataEmpty(rowData.buqueViaje))
		throw  "Se debe definir un Buque Viaje ";
	
	if (isDataEmpty(rowData.pod))
		throw  "Se debe definir un Puerto Descarga-Transbordo ";
	
	if (isDataEmpty(rowData.fpod))
		throw  "Se debe definir  un Puerto Final ";

	if (isDataEmpty(rowData.contenedor))
		throw "Se debe definir un contenedor";
	
	if (isDataEmpty(rowData.peso))
		throw "Se debe definir un Peso";


	
	
	
	if((rowData.recintoOrigen == null|| rowData.recintoOrigen== "") &&   _tit =="false")
	{
			
	}
	
	if(_tit == "true"   && (rowData.recintoOrigen =="" || rowData.recintoOrigen ==null || rowData.recintoOrigen =="undefined"))
	{
		//alert("tit true y vacio recinto");
		 throw  "El contenedor no tiene indicado Recinto Origen, Favor de seleccionar de nuevo la celda recinto hasta que se marque el chek box de movimiento TIT o desmarcar el check box ";
			
	}
	
	if(rowData.recintoOrigen != null  &&  _tit =="true" )
	 {
	  	 }
     
	if((rowData.recintoOrigen == null ) &&   _tit =="false")
	{
			
	}
 	

	if(_tit == "false"   && rowData.recintoOrigen != null )
	{
		//alert("tit false y lleno recinto");
		throw  "El contenedor tiene indicado Recinto Origen, favor de seleccionar de nuevo la celda recinto hasta que se marque el chek box de movimiento TIT ";
	}
	
	//h= rowData.recintoOrigen.la"bel.trim();
	if( _tit =="true" && (rowData.recintoOrigen ==  "null" )  )
	{
		//alert("tit true y vacio recinto");
		 throw  "El contenedor no tiene indicado Recinto Origen, Favor de seleccionar de nuevo la celda recinto hasta que se marque el chek box de movimiento TIT ";
	
	}
	
	if(rowData.recintoOrigen ==='undefined'  &&  _tit =="true" )
	{
		//alert("tit true y vacio recinto");
		 throw  "El contenedor no tiene indicado Recinto Origen, Favor de seleccionar de nuevo la celda recinto hasta que se marque el chek box de movimiento TIT ";
	
	}
	
	if(isDataEmpty(rowData.recintoOrigen) &&  _tit =="true" )
	{
		//alert("tit true y vacio recinto");
		 throw  "El contenedor no tiene indicado Recinto Origen, Favor de seleccionar de nuevo la celda recinto hasta que se marque el chek box de movimiento TIT ";
	
	}
	
	
	if(_cargapeligrosa == true || _reqconexion== true ||_sobredimension==true && _tit==true )
	{
		
	if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
		unblockPage();
		throw "La solicitud requiere documentación Favor de anexar";
		}
		else
			{
				jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
				}).done(function(datta) {
					var filacontenedor = getTable().jqGrid('getLocalRow',id_contenedor);
					//alert(id_contenedor);
					var isValidContainer = false;	  
					$.each(datta, function(i, item)
					{
						//alert("teclee " + filacontenedor.contenedor.label);
						// alert("base "+ item.unit_nbr);
					    if(item.unit_nbr == filacontenedor.contenedor.label)
					    {
					    	isValidContainer = true;
					      //  alert ("ADENTRO" + isValidContainer);
					    }
					});
				
				   // alert ("afuera " + isValidContainer);
					if(isValidContainer==true)
					{
						//alert("adentro de true");
						if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
							
							unblockPage();
							showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
							throw "La solicitud requiere documentación Favor de anexar";
						}
						else
							{
							
							}
					}
						else{
							//alert("adentro de false");
							unblockPage();
							showMessage("<spring:message code='New_Msj_solicitud_ligada' />");
							throw "El contenedor no esta ligado a la solicitud, favor de revisarlo con Servicio a Clientes ";
						}
					 
				 })
			}
	}

		if(_cargapeligrosa == false && _reqconexion== false &&_sobredimension==false && _tit =="true" )
		{
			//alert(_cargapeligrosa);
			//alert(_reqconexion);
			//alert($('#IdSolicitud').val());
			if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated)
				{
				unblockPage();
				throw "La solicitud requiere documentación Favor de anexar";
				}
				else
					{
					//alert("verifico contenedor");
					//alert(rowData.contenedor.label);
					var isValidContainer = false;
					jQuery.getJSON('rest/SolicitudContenedor/fromSolicitud/' + $('#IdSolicitud').val(), {}, function(datta){
					}).done(function(datta) {
						var filacontenedor = getTable().jqGrid('getLocalRow',id_contenedor);
						//alert(id_contenedor);
						var isValidContainer = false;	
						$.each(datta, function(i, item)
						{
							//alert(item.unit_nbr);
						    if(item.unit_nbr == filacontenedor.contenedor.label)
						    {
						    	//alert(isValidContainer);
						    	isValidContainer = true;
						    }
						});
					  
					//alert("isValidContainer "+ isValidContainer);
					 if(isValidContainer==true)
						{
							//alert("verdadero");
							if (getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated)
							{
								unblockPage();
								unblockPage();
								showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
								throw "La solicitud requiere documentación Favor de anexar";
							}
							else
								{
							
								}
						}
						 else
							{
								unblockPage();
								showMessage("<spring:message code='New_Msj_solicitud_ligada' />");
								//alert("falso contenedor");
								throw "El contenedor no esta ligado a la solicitud, favor de revisarlo con Servicio a Clientes ";
							}
					})
					}
		}
		
		
		
}

function eliminardatos()
{
	   myColumn.setColumnValue('booking',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('tipo',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('linea',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('fk.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('fpod.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('pod.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('buqueViaje.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('contenido.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('imo.label',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('hasHazard',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('hasMarinePollutants',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('hasDimensions',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('requireConnection',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('setPoint',getColumnObjectForAtomicValue(""));
	   myColumn.setColumnValue('undg', getColumnObjectForAtomicValue(""));
}

</script>
</html>