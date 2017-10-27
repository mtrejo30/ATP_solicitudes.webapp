<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<c:import url="/doctype.jsp" />
<html>

<!-- appointment jsp begins -->

<c:import url="/appointment.jsp" />

<!-- appointment jsp ends -->

<script>
	
	var tem;
	var contenedor;
	var myColumn;
	var rowData11;
	var a;
	/*validaciones */
	var i_;
	

	///////////////////////////////////
	function buildTransporterTableDefinition() {
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
		column.autocomplete_options = function(aColumn) {
			var opts = {};
			opts.minLength = 2;

			opts.source = function(req, resp) {
				jQuery.getJSON("rest/Transportista/like.json?results=20&match="
						+ encodeURIComponent(req.term.toUpperCase()), {}, resp);
			};
			opts.create = function(event, ui) {
				jQuery(event.target).addClass("inputToUppercase");
			};
			return opts;
		};
		///////////////////////////////////////////para obtener el id de la tabla temporal //////////////////////////////7// 
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {
			//alert($("#transporterTable").jqGrid('getLocalRow', iRow).id);
			a = $("#transporterTable").jqGrid('getLocalRow', rowid).id;
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
		column.autocomplete_options = function(aColumn) {
			var opts = {};
			opts.minLength = 3;
			opts.source = function(req, resp) {
				jQuery.getJSON(
						"rest/OperadorTransportista/like.json?results=20&match="
								+ encodeURIComponent(req.term.toUpperCase()),
						{}, resp);
			};
			opts.create = function(event, ui) {
				jQuery(event.target).addClass("inputToUppercase");
			};
			return opts;
		};
		transporterEdition.addColumn(column);

		/*
		 * plates column
		 */
		column = new JQGrid_Column_Model();
		column.name = "plates";
		column.type = "text";
		column.dataInit = function(element) {
			jQuery(element).css({
				'width' : '99%',
				'height' : '99%'
			}).addClass("inputToUppercase").attr('maxlength', 10);
		};
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {
			getTransporterTable().jqGrid("setCell", rowid, 'plates',
					value.toUpperCase());
		};
		transporterEdition.addColumn(column);

		/*
		 * date column
		 */
		column = new JQGrid_Column_Model();
		column.name = "date";
		column.type = "date";
		column.dateFormat = 'yy-mm-dd';
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {
			getTransporterTable().jqGrid('setCell', rowid, 'time', null);
		};
		transporterEdition.addColumn(column);

		/*
		 * time column
		 */
		column = new JQGrid_Column_Model();
		column.name = "time";
		column.type = "dropdown";
		column.dropdown_options = function(aColumn) {
			var rowData = getTransporterTable().jqGrid('getLocalRow',
					aColumn.getModel().cellInfo.rowid);
			var opts = {};
			opts.sourceUrl = "appointment/get-time-slots.json";
			opts.sourceParams = {
				date : rowData.date
			};

			// 		opts.optionObject = function(obj) {
			// 			return {
			// 				label : obj.descripcion,
			// 				id : obj.special
			// 			};
			// 		};

			opts.sourceError = function(data) {
				window.setTimeout(function() {
					aColumn.cancelColumnValue();
				}, 100);
				showMessage(data.message);
			};

			return opts;
		};
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {
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
			rowNum : 1000,
			//sortname : 'id',
			//sortorder : 'asc',
			width : '1000',
			shrinkToFit : false,
			forceFit : false,

			colModel : [ {
				name : 'id',
				index : 'id',
				label : 'ID',
				align : 'right',
				width : 25,
				sortable : false,
				editable : false
			}, {
				name : 'idpadre_',
				index : 'idpadre_',
				label : "ID",
				width : 110,
				sortable : false,
				editable : false,
				edittype : 'text',
				hidden : true
			}, {
				name : 'extra',
				index : 'extra',
				hidden : true
			}, {
				name : 'appointmentId',
				index : 'appointmentId',
				hidden : true
			}, {
				name : 'transporter',
				index : 'transporter',
				label : "<spring:message code='Transporter' />",
				width : 300,
				sortable : false,
				editable : vltransportista
			}, {
				name : 'operator',
				index : 'operator',
				label : "<spring:message code='Operator' />",
				width : 300,
				sortable : false,
				editable : vloperador
			}, {
				name : 'plates',
				index : 'plates',
				label : "<spring:message code='Plates' />",
				width : 110,
				sortable : false,
				editable : vlplacas
			//editoptions : { style: "text-transform: uppercase", maxlength : 10},
			}, {
				name : 'date',
				index : 'date',
				label : "<spring:message code='Date' />",
				width : 110,
				sortable : false,
				editable : vlfecha,
				edittype : 'text'
			}, {
				name : 'time',
				index : 'time',
				label : "<spring:message code='Time' />",
				width : 130,
				sortable : false,
				editable : vlhora
			}, {
				name : 'appointments',
				index : 'appointments',
				sortable : false,
				editable : false,
				hidden : true
			} ],
			onCellSelect : function(rowid, iCol, cellcontent, e) {
				//The grid appointments table will change each time we select a different carrier
				var data = getTransporterTable().jqGrid('getCell', rowid,
						'appointments');
				getTable().clearGridData(true).trigger("reloadGrid");
				if (data != "") {
					a = $("#transporterTable").jqGrid('getLocalRow', rowid).id;
					jQuery("#id").val(a);
					data = JSON.parse(data);
					getTable().jqGrid("setGridParam", {
						data : data
					}).trigger("reloadGrid");
				} else {
					a = $("#transporterTable").jqGrid('getLocalRow', rowid).id;
					jQuery("#id").val(a);
				}
			}
		};
	}

	function buildTableDefinition() {
		/*
		 * Column Edition
		 */
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
		column.autocomplete_options = function(aColumn) {
			var opts = {};
			opts.minLength = 11;
			opts.maxLength = opts.minLength;
			opts.source = function(req, resp) {
				//task #13
				if (!isValidContenedor(req.term)) {
					unblockPage();
					// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
					// 						function(){aColumn.restoreColumn("contenedor");});
					showMessage("<spring:message code='Invalid_container_number_format' />");
					window.setTimeout(function() {
						aColumn.restoreColumn("contenedor");
					}, 100);
				} else {
					jQuery
							.getJSON(
									'rest/Contenedor/status/'
											+ req.term.toUpperCase(), {},
									function(datta) {

									})
							.done(
									function(datta) {
										if (datta.collection[0] == null) {
											resp([ req.term.toUpperCase() ]);
										} else {
											showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
										}
									}).fail(function(datta) {
								resp([ req.term.toUpperCase() ]);
							});

					unblockPage();
				}

			};
			opts.create = function(event, ui) {
				jQuery(event.target).addClass("inputToUppercase");
			};
			return opts;
		};
		column.beforeEdit = function(rowid, cellname, value, iRow, iCol) {

			var rowData = getTable().jqGrid('getLocalRow', rowid);

			if (isRowRegistered(rowData)) {
				showMessage("<spring:message code='Cannot_change_container_from_a_registered_appointment' />");
				window.setTimeout(function() {
					getTable().jqGrid('restoreCell', iRow, iCol);
				}, 100);
			}
		};
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {

			myColumn = this;

			var accepF = function(data) {
				unblockPage();

				var obj = data;

				var typeFromContainer = obj == null ? null : obj.type_Iso;
				var lineFromContainer = obj == null ? null : obj.line_Op;
				var temporalFromContainer = obj == null ? null : obj.temporal;
				tem = temporalFromContainer;
				var specialFromContainer = obj == null ? null : obj.special;
				myColumn.setColumnValue('tipo',
						getColumnObjectForAtomicValue(typeFromContainer));
				myColumn.setColumnValue('linea',
						getColumnObjectForAtomicValue(lineFromContainer));
				myColumn.setColumnValue('temporal',
						getColumnObjectForAtomicValue(temporalFromContainer));
				getTable().jqGrid("setCell", rowid, 'temporal',
						temporalFromContainer);
				// set the extra values
				var extra = myColumn.getColumnValue('extra');
				extra.typeFromContainer = typeFromContainer;
				extra.lineFromContainer = lineFromContainer;
				extra.temporalFromContainer = temporalFromContainer;
				extra.specialFromContainer = null;
				contenedor = value;
				tipovalidacion=myColumn.getColumnValue('tipo');
				lineavalidacion=myColumn.getColumnValue('linea');
				agenciavalidacion =$("#solicitudAgenciaAduanalId").val();
				clientevalidacion=$("#solicitudClienteId").val();
				
				/////////////////////validacion con historial/////////////////////////////////////////
				if(tipovalidacion!=null && lineavalidacion!=null )
					{
					validaciontipos1();
					}
				
				if (temporalFromContainer == null
						&& getSolicitudStatus() == Solicitudes.Constants.SolicitudStatusValidated) {
					var opts = {};
					opts.minLength = 11;
					opts.maxLength = opts.minLength;
					opts.source = function(req, resp) {
						var isValidContainer = false;
						jQuery
								.getJSON(
										'rest/SolicitudContenedor/fromSolicitud/'
												+ $('#IdSolicitud').val(), {},
										function(datta) {
										})
								.done(
										function(datta) {

											$.each(datta, function(i, item) {
												if (item.unit_nbr == value) {
													isValidContainer = true;
												}
											});

											if (isValidContainer == true) {
												if (temporalFromContainer == null
														&& getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
													showMessage("<spring:message code='Appoiment_without_documentatio_validation' />");
												} else {
													if (!isValidContenedor(req.term)) {
														unblockPage();
														// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
														// 						function(){aColumn.restoreColumn("contenedor");});
														showMessage("<spring:message code='Invalid_container_number_format' />");
														window
																.setTimeout(
																		function() {
																			aColumn
																					.restoreColumn("contenedor");
																		}, 100);
													} else {
														jQuery
																.getJSON(
																		'rest/Contenedor/status/'
																				+ value,
																		{},
																		function(
																				datta) {

																		})
																.done(
																		function(
																				datta) {
																			if (datta.collection[0] == null) {
																				resp([ req.term
																						.toUpperCase() ]);
																				getTable()
																						.jqGrid(
																								"setCell",
																								rowid,
																								'temporal',
																								temporalFromContainer);
																			} else {
																				showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
																			}
																		})
																.fail(
																		function(
																				datta) {
																			resp([ req.term
																					.toUpperCase() ]);
																			getTable()
																					.jqGrid(
																							"setCell",
																							rowid,
																							'temporal',
																							temporalFromContainer);
																		});

														unblockPage();
													}
												}
											} else {
												unblockPage();
												showMessage("<spring:message code='Appoiment_without_documentatio_validation' />");
											}
										})
								.fail(
										function(datta) {
											showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
										});
					}
				}

				// if temporal not defined, notify
				if (temporalFromContainer == null
						&& getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {

					var isValidContainer = false;
					jQuery
							.getJSON(
									'rest/SolicitudContenedor/fromSolicitud/'
											+ $('#IdSolicitud').val(), {},
									function(datta) {
									})
							.done(
									function(datta) {

										$.each(datta, function(i, item) {
											if (item.unit_nbr == value) {
												isValidContainer = true;
											}
										});

										if (isValidContainer == true) {
											if (temporalFromContainer == null
													&& getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
												showMessage("<spring:message code='Appoiment_without_documentatio_validation' />");
											} else {
												if (!isValidContenedor(req.term)) {
													unblockPage();
													// 				showCustomMessage("<spring:message code='Invalid_container_number_format' />",
													// 						function(){aColumn.restoreColumn("contenedor");});
													showMessage("<spring:message code='Invalid_container_number_format' />");
													window
															.setTimeout(
																	function() {
																		aColumn
																				.restoreColumn("contenedor");
																	}, 100);
												} else {
													jQuery
															.getJSON(
																	'rest/Contenedor/status/'
																			+ req.term
																					.toUpperCase(),
																	{},
																	function(
																			datta) {

																	})
															.done(
																	function(
																			datta) {

																		if (datta.collection[0] == null) {
																			resp([ req.term
																					.toUpperCase() ]);
																			getTable()
																					.jqGrid(
																							"setCell",
																							rowid,
																							'temporal',
																							temporalFromContainer);
																		} else {
																			showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
																		}
																	})
															.fail(
																	function(
																			datta) {
																		resp([ req.term
																				.toUpperCase() ]);
																		getTable()
																				.jqGrid(
																						"setCell",
																						rowid,
																						'temporal',
																						temporalFromContainer);
																	});

													unblockPage();
												}
											}
										} else {
											unblockPage();
											showMessage("<spring:message code='Appoiment_without_documentatio_validation' />");
										}
									})
							.fail(
									function(datta) {
										showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
									});

				}

				// get the special
				// 			if (specialFromContainer != null)
				// 			{
				// 				blockPage();
				// 				jQuery.getJSON("rest/Special/" + encodeURIComponent(specialFromContainer), null, function (dataSpecial)
				// 				{
				// 					unblockPage();

				// 					myColumn.setColumnValue('special', {id: dataSpecial.special, label: dataSpecial.descripcion});
				// 				});
				// 			}
				// 			else
				// 			{
				// 				myColumn.setColumnValue('special', null);
				// 			}
			};

			blockPage();
			jQuery.getJSON("rest/Contenedor/recent/unit_nbr/"
					+ encodeURIComponent(value.label), null, accepF,
					function() {
						accepF(null);
					});
		};
		column.validate = function(value) {
		};
		edition.addColumn(column);

		/*
		 * line column
		 */
		column = new JQGrid_Column_Model();
		column.name = "linea";
		column.type = "autocomplete";
		column.autocomplete_options = function(aColumn) {
			var opts = {};
			opts.minLength = 2;
			opts.source = function(req, resp) {
				jQuery.getJSON("rest/LineaNaviera/like.json?results=10&match="
						+ encodeURIComponent(req.term.toUpperCase()), {}, resp);
			};
			opts.create = function(event, ui) {
				jQuery(event.target).addClass("inputToUppercase");
			};
			return opts;
		};
		column.beforeEdit = function(rowid, cellname, value, iRow, iCol) {
			var myColumn = this;
			var extra = myColumn.getColumnValue('extra');

			if (extra.lineFromContainer != null) {
				showMessage("<spring:message code='The_line_is_defined_by_container' />");
				window.setTimeout(function() {
					getTable().jqGrid('restoreCell', iRow, iCol);
				}, 100);
			}
		};
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {
		};
		column.validate = function(value) {
		};
		edition.addColumn(column);

		/*
		 * type column
		 */
		column = new JQGrid_Column_Model();
		column.name = "tipo";
		column.type = "autocomplete";
		column.autocomplete_options = function(aColumn) {
			var opts = {};
			opts.minLength = 2;
			opts.source = function(req, resp) {
				jQuery.getJSON(
						"rest/TipoRecepcionVacio/like.json?results=10&match="
								+ encodeURIComponent(req.term.toUpperCase()),
						{}, resp);
			};
			opts.create = function(event, ui) {
				jQuery(event.target).addClass("inputToUppercase");
			};
			return opts;
		};
		column.beforeEdit = function(rowid, cellname, value, iRow, iCol) {
			var myColumn = this;
			var extra = myColumn.getColumnValue('extra');

			if (extra.typeFromContainer != null) {
				showMessage("<spring:message code='The_type_is_defined_by_container' />");
				window.setTimeout(function() {
					getTable().jqGrid('restoreCell', iRow, iCol);
				}, 100);
			}
		};
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {
			////////////////////////validacion sin historial//////////////////////////
			myColumn=this;
			tipovalidacion=myColumn.getColumnValue('tipo');
			lineavalidacion=myColumn.getColumnValue('linea');
			validaciontipos1();
			/*var tipo = getTable().jqGrid('getLocalRow', rowid).tipo.label;
			var expreg = new RegExp("\\d{2}[T]\\d{1}");
			if (expreg.test(tipo)) {
				var myColumn = this;
				showMessage("<spring:message code='Recepcion_vacio_tipo' />");
				window.setTimeout(function() {
					getTable().jqGrid('restoreCell', iRow, iCol);
				}, 100);
				myColumn.setColumnValue('tipo',
						getColumnObjectForAtomicValue(""));

			}*/

		};
		column.validate = function(value) {
		};
		edition.addColumn(column);

		/*
		 * temporal column
		 */
		column = new JQGrid_Column_Model();
		column.name = "temporal";
		column.type = "text";
		column.beforeEdit = function(rowid, cellname, value, iRow, iCol) {

			var myColumn = this;
			var extra = myColumn.getColumnValue('extra');

			if (extra.temporalFromContainer != null) {
				showMessage("<spring:message code='Temporal_is_defined_by_container' />");
				window.setTimeout(function() {
					getTable().jqGrid('restoreCell', iRow, iCol);
				}, 100);
			}
			/*if(getTable().jqGrid('getLocalRow',rowid).contenedor){
				if(getTable().jqGrid('getLocalRow',rowid).temporal){
					showMessage("<spring:message code='Temporal_is_defined_by_container' />");
					window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
				}else{
					jQuery.getJSON("rest/user-document/get-document-appoiment/" + $("#IdSolicitud").val(), { }, function(data){
						if(!data){
							showMessage("<spring:message code='Appoiment_without_documentatio_validation' />");
							window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
						}
						
					});
				}
			}
			else{
				showMessage("<spring:message code='Appoiment_without_documentatio_validation' />");
				window.setTimeout(function() { getTable().jqGrid('restoreCell', iRow, iCol); }, 100);
			}*/
			var _contenedor = getTable().jqGrid('getLocalRow', rowid).contenedor;
			if (!getTable().jqGrid('getLocalRow', rowid).temporal) {

				if (tem == null
						&& getSolicitudStatus() == Solicitudes.Constants.SolicitudStatusValidated) {
					var isValidContainer = false;
					jQuery
							.getJSON(
									'rest/SolicitudContenedor/fromSolicitud/'
											+ $('#IdSolicitud').val(), {},
									function(datta) {
									})
							.done(
									function(datta) {
										$.each(datta, function(i, item) {
											if (item.unit_nbr == _contenedor) {
												isValidContainer = true;
											}
										});
										if (isValidContainer == true) {
											if (temp == null
													&& getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {

												showMessage("<spring:message code='msj_temporal_validacion' />");
												window.setTimeout(function() {
													getTable().jqGrid(
															'restoreCell',
															iRow, iCol);
												}, 100);
											} else {

											}
										} else {
											showMessage("<spring:message code='msj_temporal_validacion' />");
											window.setTimeout(function() {
												getTable().jqGrid(
														'restoreCell', iRow,
														iCol);
											}, 100);
										}
									})
							.fail(
									function(datta) {
										showMessage("<spring:message code='Container_with_Appoiment_Validation' />");
									});

				}
				if (tem == null
						&& getSolicitudStatus() != Solicitudes.Constants.SolicitudStatusValidated) {
					showMessage("<spring:message code='msj_temporal_validacion' />");
					window.setTimeout(function() {
						getTable().jqGrid('restoreCell', iRow, iCol);
					}, 100);
				}

			}

		};
		column.afterSave = function(rowid, cellname, value, iRow, iCol) {
			//alert("hola");
		};
		column.validate = function(value) {
			//alert("hola1");
		};
		edition.addColumn(column);
		edition.addColumn(getSpecialColumn());
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

			colModel : [ {
				name : 'id',
				index : 'id',
				label : 'ID',
				align : 'right',
				width : 25,
				sortable : false,
				editable : false
			}, {
				name : 'extra',
				index : 'extra',
				hidden : true
			}, {
				name : 'appointmentId',
				index : 'appointmentId',
				hidden : true
			}, {
				name : 'contenedor',
				index : 'contenedor',
				label : "<spring:message code='Container' />",
				width : 110,
				sortable : false,
				editable : true
			}, {
				name : 'linea',
				index : 'linea',
				label : "<spring:message code='Line' />",
				width : 110,
				sortable : false,
				editable : true
			}, {
				name : 'tipo',
				index : 'tipo',
				label : "<spring:message code='Type' />",
				width : 110,
				sortable : false,
				editable : true
			}, {
				name : 'temporal',
				index : 'temporal',
				label : "<spring:message code='Temporal' />",
				width : 110,
				sortable : false,
				editable : vltipo_,
				edittype : 'text'
			}, {
				name : 'special',
				index : 'special',
				label : "<spring:message code='Special' />",
				width : 210,
				sortable : false,
				editable : vlspecial
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
			}, {
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
			afterRestoreCell : function(rowid, value, iRow, iCol) {
				var rowData = getTable().jqGrid('getLocalRow', rowid);
				if (!isRowRegistered(rowData))
					showMessageIfInvalidContenedor(iCol,
							"<spring:message code='Invalid_container_number_length' />");
			}
		};
	}
   
	function operationValidateRowInfo(rowData) {
		
		
		
		var tipo = rowData.tipo.label;
        //alert(tipo);
		/*var expreg = new RegExp("\\d{2}[T]\\d{1}");
		if (expreg.test(tipo))
			throw "No se cuenta con instrucción para recepción de isotanques vacíos, favor de verificarlo con servicio a clientes";
		*/
		if (rowData.temporal == "undefined" || rowData.temporal == null
				|| rowData.temporal == "" || rowData.temporal.isEmpty
				|| isDataEmpty(rowData.temporal)) {
			throw "Favor de capturar información en el campo de temporal";
		}
		if (!rowData.temporal.isDataEmpty && !rowData.temporal.trim) {

		} else {
			var hola = rowData.temporal.trim();
			if (hola == "") {
				throw "Favor de capturar información en el campo de temporal";

			}
		}
	}
	
	
	function eliminardatos()
	{
		   myColumn.setColumnValue('contenedor',getColumnObjectForAtomicValue(""));
		   myColumn.setColumnValue('tipo',getColumnObjectForAtomicValue(""));
		   myColumn.setColumnValue('linea',getColumnObjectForAtomicValue(""));
		   myColumn.setColumnValue('temporal',getColumnObjectForAtomicValue(""));					
	}


</script>

</html>