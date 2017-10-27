<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="Report_consulta_operativo" />

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

	<h2><c:out value='${title}' /></h2>

	<div class="reportContainer wideFields" align=center>
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
				</tr>	
			</table>			
			<br/>
			<input _clickBind="searchClicked" class="_clickBind"  type="button" value="<spring:message code='Search' />" />
		</form>
	</div>
	<br/>
	
	<table class="display" id="reportTable"></table>
	<div id="reportPager"></div>
	<br/>
</div>



<c:import url="/footer.jsp" />

<div id="modalMessage">
<p></p>
</div>

</body>

<script type="text/javascript">

var noSel = {vesselVoyage: "<spring:message code='_No_Selection_' />", vesselCode:""};
var buqueViajeCollection = <c:out value='${buqueViajeCollection}' escapeXml="false" />;

var baseUrl = "report_consulta_operativo";

//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded() 
{	
	// individual button actions
	bindClickEvent("_clickBind");

	//currentMenu
	highlightNavigationBarReportsItem("operativosImpoExpo");
	
	//getBuqueViajeCollection();
	
	fillSelect(jQuery("#selectBuqueViaje"), [noSel].concat(buqueViajeCollection), function(eachObj) { return {value: eachObj.vesselVoyage, text: eachObj.vesselCode}; });

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
			{name:'contenedor', index:'contenedor', sortable: false, width:150, align: "left", label: "<spring:message code='Container' />"},
			{name:'buqueViaje', index:'buqueViaje', sortable: false, width:100, align: "left", label: "<spring:message code='Vessel_Voyage' />"},
			{name:'fechaOperativo', index:'fechaOperativo', sortable: false, width: 150, align: "left", label: "<spring:message code='Operating_date' />"},
		    {name:'estatus', index:'estatus', sortable: false, width: 150, align: "left", label: "<spring:message code='Status' />"},
			{name:'fechaLiberado', index:'fechaLiberado', sortable: false, width: 150, align: "left", label: "<spring:message code='Released_date' />"}
        ],
		width: '800px',
		rowNum: 15,
		rowList:[15,30,50],
		pager: '#reportPager',
		viewrecords: true,
		caption:'<spring:message code="Reports" />'
	}
	);
}
</script>
</html>