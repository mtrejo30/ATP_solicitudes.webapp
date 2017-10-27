<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="holiday" />

<html>
<head>
	<title><c:out value='${title}' /></title>
	<c:import url="/metas.jsp" />
	<c:import url="/libraries.jsp" />
	<c:import url="/libraries_table.jsp" />
	<c:import url="/libraries_plugins.jsp" />
	
	<script type="text/javascript" src="panels/holiday-panel.js"></script>
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
	
	<table>
		<tr>
			<td>
				<table class="display" id="holidaysTable"></table>
				<div id="holidaysPager"></div>
			</td>
		</tr>
	</table>

	<br/>
	
	<div id="holidayContainer" style="display: none;">
	</div>
	
	<div class="genericButtonsArea" align=center>
	   <input id=newHolidayButton type=button value="<spring:message code='new_holiday' />" />
       <input id=editHolidayButton type=button value="<spring:message code='edit_holiday' />" />
       <input id=deleteHolidayButton type=button value="<spring:message code='delete_holiday' />" />
	</div>
	
</div>

<c:import url="/footer.jsp" />

<div id="modalMessage">
<p></p>
</div>

</body>

<script type="text/javascript">

var holidayID = null;
var holidayPanel = null;

//execute loaded function when page loaded
jQuery(document).ready( function() {

	jQuery.get(Holiday_Panel.uiFile, function(response) {   
		jQuery("#holidayContainer").html(response);      
		
		holidayPanel = new Holiday_Panel();
		holidayPanel.registerHandler(Holiday_Panel.Events.SAVE_DAY, function(sender, object)
		{
			var requestInfo = { id: object.id };
			updateTableWithRequest(getHolidaysTable(), "holiday/holiday-table-row.json", requestInfo);
		});
		holidayPanel.parent = jQuery("#holidayContainer");
		holidayPanel.init();
		
		jQuery("#date").datepicker({dateFormat: 'yy-mm-dd'});
	});
	
 	jQuery("#newHolidayButton").click(newHolidayClicked);	
 	jQuery("#editHolidayButton").click(editHolidayClicked); 
 	jQuery("#deleteHolidayButton").click(deleteHolidayClicked); 	 	
		
	// build the table
	buildTable();
	
	// currentMenu
	highlightNavigationBarItem("holidaysMenu");
});

function rowSelected(id)
{
	holidayID = id;
}

function newHolidayClicked()
{	
	holidayPanel.clean();
	holidayPanel.open();		
}

function editHolidayClicked()
{
	// if no user selected, notify it
	if (holidayID == null)
	{
		showMessage("<spring:message code='no_holiday_selected' />");
		return;
	}

	// retrieve user information from the server
	jQuery.postJSON("holiday/edit-holiday.json", { id: holidayID }, editHolidayClicked_callback);

	// we should block the page to avoid further activities here
	blockPage();
}

function editHolidayClicked_callback(data)
{
	unblockPage();
	
	if (data.error)
	{
		showMessage(data.message, {title: 'Error'});
	}
	else
	{
		holidayPanel.fillFrom(data.body);
		holidayPanel.id = holidayID;
		holidayPanel.open();
	}
}

function deleteHolidayClicked()
{
	if (holidayID == null)
	{
		// show modal to confirm day deletion
		showMessage("<spring:message code='no_holiday_selected' />");
		return;
	}

	// show modal to confirm day deletion	
	showAcceptCancel("<spring:message code='confirm_delete_holiday' />", deleteHoliday);
}

function deleteHoliday()
{
	// send the information to the server
	jQuery.postJSON("holiday/delete-holiday.json", {id: holidayID}, deleteHoliday_callback);

	// we should block the page to avoid further activities here
	blockPage();

	// clean error container
	jQuery("#errorContainer").text("");

	// return false to avoid the form submit from the event
	return false;
}

function deleteHoliday_callback(data)
{
	// unblock the page
	unblockPage();
	
	// check if error or everything went fine
	if (data.error)
	{
		// notify the user about the error
		showMessage(data.message);
	}
	else
	{
		deleteTableWithRowId(getHolidaysTable(), data.body.id);

		// show modal with server response
		showMessage(data.message);
	}
}


function getHolidaysTable()
{
	return jQuery("#holidaysTable");
}

function queryInfo()
{
	var obj = jQuery("#systemPropertyForm").serializeObject();
	return JSON.stringify(obj);
}

function buildTable()
{
	getHolidaysTable().jqGrid
	(
	{
		// set url to get information from the server
		url:'holiday/holiday-table-info.json',
		postData: 
		{
			search_info: queryInfo,
		},
		datatype: "json",
		// column names
		colNames:["<spring:message code='holiday_id' />", "<spring:message code='holiday_name' />",  "<spring:message code='holiday_date' />"],
		// column properties
		colModel:
		[
			{name:'id',index:'id', width:100,  key:true, align: "center"},
			{name:'name',index:'name', width:220, align: "left"},
			{name:'date',index:'date', width:220, align: "center"},
		],
		onSelectRow: rowSelected,
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
		cellEdit : false,
		cellsubmit : 'remote',
		cellurl : 'holiday/holiday-table-info.json',
		rowNum: 15,
		rowList:[15,30,50],
		pager: '#holidaysPager',
		viewrecords: true,
		caption:'<spring:message code="holiday" />',
		sortname: "name",
		sortorder: "asc",
	}
	);
}
</script>
</html>