 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />
<script type="text/javascript" src="js/tableExport.js"></script>
<spring:message var='title' code="Report_contenedores_llenos_entrega_puerta" />

<html>
<head>
	<title><c:out value='${title}' /></title>
	<c:import url="/libraries.jsp" />
	<c:import url="/libraries_table.jsp" />
	<c:import url="/libraries_plugins.jsp" />
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
<div id="leyenda" Style='width:600px;'>Te recordamos que toda la información aquí mostrada es de consulta, no es válida para reclamaciones de índole legal o comercial.</div>
	
	<h2><c:out value='${title}' /></h2>

	<div id="cuadro" class="reportContainer wideFields" align=center>
		<form id="searchForm">
			<table>
				<tr>
					<td class=rightAlignColumns><label for="typeSearchField"><spring:message code='Container' />:</label></td>
					<td>
						<input type="text" id="contenedorDigitoVerificador" name="contenedorDigitoVerificador"  />
					</td>	
				</tr>	
			</table>			
			<br/>
			<input _clickBind="searchClicked" class="_clickBind"  type="button" value="<spring:message code='Search' />" />
			<!--  <a href="javascript:void(0);"  Style="background: none repeat scroll 0 0 #4CC8E4;color: #FFFFFF;font-size: 10px;padding: 5px 10px; cursor: pointer;text-decoration:none"  type="button" onclick="exportData('4','pdf','Consulta DE Contenedores Llenos Entrega por Puerta');">Guardar en PDF</a>-->
			<button Style="background: none repeat scroll 0 0 #4CC8E4;color: #FFFFFF;font-size: 10px;padding: 5px 10px; cursor: pointer;text-decoration:none" onclick="printHTML()">Guardar en PDF</button>
	
		</form>
	</div>
	<br/>
	
	<table class="display" id="reportTable"></table>
	<div id="reportPager"></div>
	<br/>
	<form id="formstyle" action="GenerateGridPDFs" method="post" name="formstyle">
            <input type="hidden" name="pdfBuffer" id="pdfBuffer" value="" />
            <input type="hidden" name="fileName" id="fileName" value="Report_contenedores_llenos_entrega_puerta" />
            <input type="hidden" name="fileType" id="fileType" value="" />
        </form>
</div>



<c:import url="/footer.jsp" />

<div id="modalMessage">
<p></p>
</div>

</body>

<script type="text/javascript">
function printHTML() {
	  if (window.print)
	  {
		jQuery("#searchForm").hide();
		jQuery("#navigationBarDiv").hide();
		jQuery("#cuadro").hide();
		jQuery("#leyenda").show();
	    window.print();
	    
	  }
}
var baseUrl = "report_contenedores_llenos_entrega_por_puerta";

//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded() 
{	
	//jQuery("#leyenda").hide();
	// individual button actions
	bindClickEvent("_clickBind");

	// build the table
	buildTable();

	//currentMenu
	highlightNavigationBarReportsItem("contenedoresLlenos_EntregaPorPuerta");
}

function getReportTable()
{
	return jQuery('#reportTable');
}

function searchClicked()
{
	jQuery("#errorContainer").text("");
	getReportTable().jqGrid().trigger('reloadGrid');
}

function queryInfo()
{
	var obj = jQuery("#searchForm").serializeObject();
	return JSON.stringify(obj);
}

function buildTable()
{
	getReportTable().jqGrid
	(
	{
		// set url to get information from the server
		url: baseUrl + '/report-table-info.json',
		postData: 
		{
			search_info: queryInfo,
		},
		datatype: "json",
		// column properties
		colModel:
		[
			{name:'contenedor', index:'contenedor', sortable: false, width:200, align: "left", label: "<spring:message code='Container' />"},
			{name:'tipo', index:'tipo', sortable: false, width:150, align: "left", label: "<spring:message code='Type' />"},
			{name:'fechaDeSalida', index:'fechaDeSalida', sortable: false, width: 200, align: "left", label: "<spring:message code='Departure_date' />"},
			{name:'estatus', index:'estatus', sortable: false, width: 200, align: "left", label: "<spring:message code='Status' />"}
		],
		  //search:true,
        pager:'#reportPager',
        rowNum: 1000,
       // rowList: [5, 10, 20, 50],
        sortname: 'id',
        //sortorder: 'asc',
        viewrecords: true,
        height: "50%",
        caption: ""
	}
	);
}
</script>
</html>