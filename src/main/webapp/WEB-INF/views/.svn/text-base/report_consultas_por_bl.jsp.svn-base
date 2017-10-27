<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="Report_consulta_bl" />

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
					<td class=rightAlignColumns><label for="typeSearchField"><spring:message code='Bl' />:</label></td>
					<td>
						<input type="text" id="inputBL" name="inputBL"  />
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
var baseUrl = "report_consultas_por_bl";

//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded() 
{	
	// individual button actions
	bindClickEvent("_clickBind");

	// build the table
	buildTable();

	//currentMenu
	highlightNavigationBarReportsItem("consultasPorBL");
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
			{name:'contenedor', index:'contenedor', sortable: false, width:150, align: "left", label: "<spring:message code='Container' />"},
			{name:'tipo', index:'tipo', sortable: false, width:100, align: "left", label: "<spring:message code='Type' />"},
			{name:'fecha', index:'fecha', sortable: false, width: 180, align: "left", label: "<spring:message code='Date' />"},
		    {name:'buque', index:'buque', sortable: false, width: 150, align: "left", label: "<spring:message code='Vessel' />"},
		    {name:'viaje', index:'viaje', sortable: false, width: 150, align: "left", label: "<spring:message code='Voyage' />"},
		    {name:'estatus', index:'estatus', sortable: false, width: 150, align: "left", label: "<spring:message code='Status' />"}
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