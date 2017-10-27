<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="Report_consulta_operativo" />
 <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="http://www.shieldui.com/shared/components/latest/css/light/all.min.css" />
<script type="text/javascript" src="http://www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
<script type="text/javascript" src="http://www.shieldui.com/shared/components/latest/js/jszip.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>


<script type="text/javascript" src="js/tableExport.js"></script>

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
					<td class=rightAlignColumns><label for="typeSearchField">
						<spring:message code='Vessel_Voyage' />:</label>
						<select id="selectBuqueViaje" name="selectBuqueViaje"></select>
					</td>
					<td>
						<input type="radio" name="consulta" value="importacion" checked> 
						<spring:message code="Import" />
						<br/>
						<input type="radio" name="consulta" value="exportacion">
						<spring:message code="Export" />
					</td>
					<spring:message code='msjs' />:</label>
					<br>
					<br>
			
				</tr>	
			</table>			
			<br/>
			<input _clickBind="searchClicked" class="_clickBind"  type="button" value="<spring:message code='Search' />" />
			<!--<a href="javascript:void(0);"  Style="background: none repeat scroll 0 0 #4CC8E4;color: #FFFFFF;font-size: 10px;padding: 5px 10px; cursor: pointer;text-decoration:none"  type="button" onclick="exportData('4','pdf','Consulta Operativo Importación y Exportación');">Guardar en PDF</a>-->
			<button Style="background: none repeat scroll 0 0 #4CC8E4;color: #FFFFFF;font-size: 10px;padding: 5px 10px; cursor: pointer;text-decoration:none" onclick="printHTML()">Guardar en PDF</button>
	
		</form>
	</div>
	<br/>
	
	<table class="display" id="reportTable"></table>
	<div id="reportPager"></div>
	<br/>
	<form id="formstyle" action="GenerateGridPDFs" method="post" name="formstyle">
            <input type="hidden" name="pdfBuffer" id="pdfBuffer" value="" />
            <input type="hidden" name="fileName" id="fileName" value="Report_consulta_operativo" />
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

jQuery().ready(function (){
    //fillGrid();
});
var noSel = {vesselVoyage: "", vesselCode:""};
var buqueViajeCollection = <c:out value='${buqueViajeCollection}' escapeXml="false" />;

var baseUrl = "report_consulta_operativo";

//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded() 
{	
	//jQuery("#leyenda").hide();
	// individual button actions
	bindClickEvent("_clickBind");

	//currentMenu
	highlightNavigationBarReportsItem("operativosImpoExpo");
	
	//getBuqueViajeCollection();
	
	fillSelect(jQuery("#selectBuqueViaje"), [noSel].concat(buqueViajeCollection), function(eachObj) { return {value: eachObj.vesselVoyage, text: eachObj.vesselVoyage}; });

	// build the table
	buildTable();
	

 
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

function getBuqueViajeCollection()
{
	blockPage();		
	
	jQuery.getJSON(baseUrl + "/get-buque-viaje.json", { }, function(data) 
	{		
		
		jQuery.each(data, function(eachIndex, eachObject)
		{
		
			jQuery('#selectBuqueViaje').append(new Option(eachObject.vesselVoyage, eachObject.vesselCode));
		});
		unblockPage();
	});		
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
			{name:'contenedor', index:'contenedor', sortable: true, width:150, align: "left", label: "<spring:message code='Container' />"},
			{name:'buqueViaje', index:'buqueViaje', sortable: true, width:100, align: "left", label: "<spring:message code='Vessel_Voyage' />"},
			{name:'fechaOperativo', index:'fechaOperativo', sortable: true, width: 150, align: "left", label: "<spring:message code='Operating_date' />"},
		  	{name:'fechaLiberado', index:'fechaLiberado', sortable: true, width: 150, align: "left", label: "<spring:message code='Released_date' />"}
        ],
        pager:'#reportPager',
        rowNum: 1000,
       // rowList: [5, 10, 20, 50],
        sortname: 'id',
        //sortorder: 'asc',
        viewrecords: true,
        height: "50%",
        caption: "",
		sortname: "dateCreated",
		sortorder: "desc"
		
	}
	);
}


</script>
</html>