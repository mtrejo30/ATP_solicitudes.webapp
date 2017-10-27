<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />
<spring:message var='title' code="Activity_Log" />

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

		<div class="genericSearchArea wideFields" align=center>
			

			<form id="searchActivityLogForm">
				<table class=rightAlignColumns>
					<tr>
						<td><label for="actionField"><spring:message code='Action' />:</label></td>
						<td><input id="action_filter" type="text" name="action" /> </td>
					
						<td><label for="informationField"><spring:message code='Information' />:</label></td>
						<td><input id="data_filter" type="text" name="data" /> </td>
					</tr>	
		
					<tr>
						<td><label for="initialDateField"><spring:message code='Initial_Date' />:</label></td>
						<td><input id="initialDate_filter" type="text" name="initial_date" /></td>
			
						<td><label for="finalDateField"><spring:message code='Final_Date' />:</label></td>
						<td><input id="finalDate_filter" type="text" name="final_date" /></td>
					</tr>	
				</table>
					<br/>
					<input type="submit" value="<spring:message code='Search' />" />
			</form>
		</div>
		<br/>

		<table class="display" id="logTable"></table>
		<div id="logPager"></div>
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
	jQuery("#data_filter").autocomplete({
		source:"activity-log/activity-log-search-data.json", 
		minLength: 3});
	
	jQuery("#action_filter").autocomplete({
		source:"activity-log/activity-log-search-action.json", 
		minLength: 3});		
	
	// do searchClicked when form submited
	jQuery("#searchActivityLogForm").submit(searchClicked);
	
	// set both initial and final dates as jQuery date pickers
	jQuery("#initialDate_filter").datepicker({dateFormat: 'yy-mm-dd'});
	jQuery("#finalDate_filter").datepicker({dateFormat: 'yy-mm-dd'});

	// build the table
	buildTable();
	
	//currentMenu
	highlightNavigationBarItem("activityMenu");
}

function searchClicked()
{
	getActivityLogTable().jqGrid().trigger('reloadGrid');
	return false;
}

function getActivityLogTable()
{
	return jQuery("#logTable");
}

function queryInfo()
{
	var obj = jQuery("#searchActivityLogForm").serializeObject();
	return JSON.stringify(obj);
}

function buildTable()
{
	getActivityLogTable().jqGrid
	(
		{
			// set url to get information from the server
			url:'activity-log/activity-log-table-info.json',
			postData: 
			{
				search_info: queryInfo,
			},
			mtype: 'POST',
			loadui: "block",
			datatype: "json",
			// column names
			colNames:["<spring:message code='Action' />", "<spring:message code='Ip' />", "<spring:message code='Information' />", "<spring:message code='Date' />", "<spring:message code='User' />"],
			// column properties
			colModel:
			[
				{name:'action',index:'action', width:100, align: "left"},
				{name:'accessed_from', index: 'accessed_from', width:100,align:"center"},
				{name:'data',index:'data', width:380, align:"left"},				
				{name:'timestamp',index:'timestamp', width:150, align:"center"},
				{name:'user',index:'user', width:100, align:"left"}
			],
			rowNum: 50,
			rowList:[50,100,300],
			pager: '#logPager',
			viewrecords: true,
			sortname: "timestamp",
			sortorder: "desc",
			caption:'<spring:message code="Activity_Log" />'
		}
	);
}
</script>
</html>