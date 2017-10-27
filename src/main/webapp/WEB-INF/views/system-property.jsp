<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="System_Property" />

<html>
<head>

<title><c:out value='${title}' /></title>
<c:import url="/libraries.jsp" />
<c:import url="/libraries_table.jsp" />
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

	<div class="genericSearchArea wideFields" align=center>
		<form id="systemPropertyForm">
			<table class=rightAlignColumns>
				<tr>
					<td><label for="propertyNameSearchField"><spring:message code='System_Property_Name' />:</label></td>
					<td><input type="text" id="propertyNameSearchField" name="name" value="${name}" /></td>
					<td>								
				</tr>				
			</table>			
			<br/>
		</form>
	</div>

	<br/>
	
	<table>
		<tr>
			<td>
				<table class="display" id="systemPropertyTable"></table>
				<div id="systemPropertyPager"></div>
			</td>
			
		</tr>
	</table>

	<br/>
</div>

<c:import url="/footer.jsp" />

<div id="modalMessage">
<p></p>
</div>

</body>

<script type="text/javascript">

//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded()
{
	jQuery("#propertyNameSearchField")
	    .autocomplete({
			source:		"system-property/system-properties-names.json", 
			minLength: 	0,
			search: 	searchClicked,
			delay:		400  //in milliseconds, Default -> 400 for remote & 10 for local
	    });
	
	// build the table
	buildTable();
	
	//currentMenu
	highlightNavigationBarItem("propertyMenu");
}

function searchClicked()
{
	getSystemPropertyTable().jqGrid().trigger('reloadGrid');

	// return false in autocomplete/search call, to avoid showing the autocomplete options
	return false;
}

function getSystemPropertyTable()
{
	return jQuery("#systemPropertyTable");
}

function queryInfo()
{
	var obj = jQuery("#systemPropertyForm").serializeObject();
	return JSON.stringify(obj);
}

function buildTable()
{
	getSystemPropertyTable().jqGrid
	(
	{
		// set url to get information from the server
		url:'system-property/system-property-table-info.json',
		postData: 
		{
			search_info: queryInfo,
		},
		datatype: "json",
		// column names
		colNames:["<spring:message code='System_Property_Id' />", "<spring:message code='System_Property_Name' />",  "<spring:message code='System_Property_Value' />"],
		// column properties
		colModel:
		[
			{name:'id',index:'id', width:55,  key:true, align: "center"},
			{name:'name',index:'name', width:200, align: "left"},
			{name:'value',index:'value', width:350, align: "left", editable: true,editoptions:{maxlength:"150"}},
		],
	    beforeSubmitCell: function(rowId, cellname, value, iRow, iCol)
	    {
	    	return {cellName: cellname, iRow: iRow, iCol: iCol};
	    },
		afterSubmitCell: function(ajaxResponse, rowid, cellname, value, iRow, iCol)
		{
			if (ajaxResponse.status != 200)
			{
				showMessage(ajaxResponse.status);
				return [false, "Status=" + status + "Text=" + ajaxResponse.responseText ];
			}

			// Takes a well-formed JSON string from ajaxResponse.responseText
			// and returns the resulting JavaScript object.
			var serverResponse = JSON.parse(ajaxResponse.responseText);

			if (serverResponse.error)
				return [false, serverResponse.message];
			else
			{
				showMessage(serverResponse.message);
				return [true];
			}
		},
		serializeCellData: function(postdata)
		{
			return postdata;
		},
		cellEdit : true,
		cellsubmit : 'remote',
		cellurl : 'system-property/edit-system-property.json',
		rowNum: 15,
		rowList:[15,30,50],
		pager: '#systemPropertyPager',
		viewrecords: true,
		caption:'<spring:message code="System_Property" />',
		sortname: "name",
		sortorder: "asc",
	}
	);
}
</script>
</html>