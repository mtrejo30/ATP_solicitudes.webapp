<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<spring:message var='title' code="User_Admin" />

<html>
<head>
	<c:import url="/metas.jsp" />
	<title><c:out value='${title}' /></title>
	<c:import url="/libraries.jsp" />
	<c:import url="/libraries_table.jsp" />
	<c:import url="/libraries_plugins.jsp" />
	
	<script type="text/javascript" src="panels/user-panel.js"></script>
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
		<form id="searchUserForm">
			<table>
				<tr>
					<td class=rightAlignColumns><label for="userNameSearchField"><spring:message code='User_Name' />:</label></td>
					<td><input id="username_filter" type="text" name="username" /></td>
					<td>	
					
					<td class=rightAlignColumns><label for="statusSearchField"><spring:message code='Status' />:</label></td>
					<td>
						<select id="status_filter" type="text" name="status">
						</select>
					</td>							
				</tr>	
				<tr>
					<td class=rightAlignColumns><label for="emailSearchField"><spring:message code='Email' />:</label></td>
					<td><input id="email_filter" type="text" name="email" /></td>
					<td>	
					 
					<td class=rightAlignColumns><label for="roleSearchField"><spring:message code='Profile' />:</label></td>
					<td>
						<select id="profile_filter" name="profile">
						</select>
					</td>					
				</tr>			
			</table>			
			<br/>
			<input type="submit" value="<spring:message code='Search' />" />
		</form>
	</div>
	<br/>
	
	<table class="display" id="userAdminTable"></table>
	<div id="userAdminPager"></div>
	<br/>

	<div id="userAdminContainer" style="display: none;">
	</div>
	
	<div class="genericButtonsArea wideFields" align=center>
	   <input id=newUserButton type=button value="<spring:message code='NewUser' />" />
       <input id=editUserButton type=button value="<spring:message code='EditUser' />" />
       <input id=deleteUserButton type=button value="<spring:message code='DeleteUser' />" />
	</div>
</div>



<c:import url="/footer.jsp" />

<div id="modalMessage">
<p></p>
</div>

</body>

<script type="text/javascript">

var userId = null;
var userPanel = null;
var noSel = { id: "", name: "<spring:message code='_No_Selection_' />"};

var statusList = (<c:out value='${statusList}' escapeXml="false" />);
var profileList = (<c:out value='${profileList}' escapeXml="false" />);
var empresaList = (<c:out value='${empresaList}' escapeXml="false" />);
var reportAccessLevelList = (<c:out value='${reportAccessLevelList}' escapeXml="false" />);

//execute loaded function when page loaded
jQuery(document).ready(loaded);

function loaded() 
{
	jQuery("#username_filter").autocomplete({
		source:"user-admin/get-user-names.json", 
		minLength: 3});
	
	jQuery("#email_filter").autocomplete({
		source:"user-admin/get-user-emails.json", 
		minLength: 3});		
	
	fillSelect(jQuery("#status_filter"), [noSel].concat(statusList), function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });
	fillSelect(jQuery("#profile_filter"), [noSel].concat(profileList), function(eachObj) { return {value: eachObj.id, text: eachObj.name}; });

	jQuery("#userAdminContainer").load(User_Panel.uiFile + "?ts=" + new Date().getTime(), function()
	{
		userPanel = new User_Panel();
		userPanel.registerHandler(User_Panel.Events.SAVE_USER, function(sender, object)
		{
			var requestInfo = { id: object.id };
			updateTableWithRequest(getUserTable(), "user-admin/user-table-row.json", requestInfo);
		});

		userPanel.parent = jQuery("#userAdminContainer");
		userPanel.fillStatus(statusList);
		userPanel.fillProfile(profileList);
		userPanel.fillReportAccessLevel(reportAccessLevelList);
		userPanel.fillEmpresa(empresaList);
		userPanel.init();
	});
	
	// do searchClicked when form submited
	jQuery("#searchUserForm").submit(searchClicked);

	// individual button actions
	jQuery("#newUserButton").click(newUserClicked);
	jQuery("#editUserButton").click(editUserClicked);
	jQuery("#deleteUserButton").click(deleteUserClicked);
	//jQuery("#assignProjectButton").click(assignProjectClicked);

	// build the table
	buildTable();

	//currentMenu
	highlightNavigationBarItem("userMenu");
}

function getUserTable()
{
	return jQuery('#userAdminTable');
}

function newUserClicked()
{
	userPanel.clean();
	userPanel.open();
}

function searchClicked()
{
	jQuery("#errorContainer").text("");
	getUserTable().jqGrid().trigger('reloadGrid');
	return false;
}

function deleteUserClicked()
{
	if (userId == null)
	{
		// show modal to confirm user deletion
		showMessage("<spring:message code='No_user_selected' />");
		return;
	}

	// show modal to confirm user deletion
	
	showAcceptCancel("<spring:message code='confirm_delete_user' />", deleteUser);
}

function deleteUser()
{
	// send the information to the server, acceptNewUser as callback
	jQuery.postJSON("user-admin/delete-user.json", {id: userId}, deleteUser_callback);

	// we should block the page to avoid further activities here
	blockPage();

	// clean error container
	jQuery("#errorContainer").text("");

	// return false to avoid the form submit from the event
	return false;
}

function deleteUser_callback(data)
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
		// refresh the table, so it gets fresh information from the server
		//getUserTable().jqGrid().trigger('reloadGrid');
		getUserTable().jqGrid('delRowData',userId);

		// show modal with server response
		showMessage(data.message);
	}
}

function queryInfo()
{
	var obj = jQuery("#searchUserForm").serializeObject();
	return JSON.stringify(obj);
}

function buildTable()
{
	getUserTable().jqGrid
	(
	{
		// set url to get information from the server
		url:'user-admin/user-admin-table-info.json',
		postData: 
		{
			search_info: queryInfo,
		},
		datatype: "json",
		// column names
		colNames:["<spring:message code='User_Id' />", "<spring:message code='User_Name' />",  "<spring:message code='first_Name' />", "<spring:message code='last_Name' />", "<spring:message code='Profile' />", "<spring:message code='Status' />", "<spring:message code='Email' />"],
		// column properties
		colModel:
		[
			{name:'id',index:'id', width:55, align: "center"},
			{name:'username',index:'username', width:100, align: "left"},
			{name:'firstName',index:'firstName', width:100, align: "left"},
			{name:'lastName',index:'lastName', width:100, align: "left"},
//  			{name:'status', index: 'status', width:60,align:"left", sortable: false},
			{name:'profile',index:'profile', width:155, align:"left", sortable: false},	
			{name:'status', index: 'status', width:60,align:"left", sortable: false},
			{name:'email',index:'email', width:200, align:"left"},
		],
		onSelectRow: rowSelected,
		rowNum: 15,
		rowList:[15,30,50],
		pager: '#userAdminPager',
		viewrecords: true,
		sortname: "username",
		sortorder: "asc",
		caption:'<spring:message code="User_Admin" />'
	}
	);
}

function rowSelected(id)
{
	userId = id;
}

function editUserClicked()
{
	// if no user selected, notify it
	if (userId == null)
	{
		showMessage("<spring:message code='No_user_selected' />");
		return;
	}

	// retrieve user information from the server
	jQuery.postJSON("user-admin/edit-user.json", { id: userId }, editUserClicked_callback);

	// we should block the page to avoid further activities here
	blockPage();
}

function editUserClicked_callback(data)
{
	unblockPage();
	
	if (data.error)
	{
		showMessage(data.message, {title: 'Error'});
	}
	else
	{
		userPanel.fillFrom(data.body);
		userPanel.id = userId;
		userPanel.open();
	}
}

</script>
</html>