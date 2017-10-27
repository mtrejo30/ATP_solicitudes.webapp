<script type="text/javascript" src="thirdparty/jquery/i18n/grid.locale-es.js"></script>
<!-- <script type="text/javascript" src="thirdparty/jquery/jquery.jqGrid.min.js"></script>  -->
<script type="text/javascript" src="thirdparty/jquery/jquery.jqGrid.src.js"></script>


<link type="text/css" rel="Stylesheet" href="css/ui.jqgrid.css" />

<!-- <script type="text/javascript" src="thirdparty/jquery/i18n/grid.locale-es.js"></script> -->
<!-- <script type="text/javascript" src="thirdparty/jquery/jquery.jqGrid.min.js"></script> -->
<!-- <script type="text/javascript" src="thirdparty/jquery/grid.common.js"></script> -->
<!-- <script type="text/javascript" src="thirdparty/jquery/grid.celledit.js"></script> -->
<!-- <script type="text/javascript" src="thirdparty/jquery/grid.postext.js"></script> -->

<script type="text/JavaScript">
function updateTableWithRequest(aTable, postUrl, requestInfo)
{
	// block the page
	blockPage();
	// request to the server with the info
	jQuery.postJSON(postUrl, requestInfo, function(data)
	{
		// unblock the page
		unblockPage();

		if (!data.error)
		{
			// if no error, get the table information and update the element
			var id = data.body.id;
			var elementData = data.body.cell;

			updateTableWithRowData(aTable, id, elementData);
		}
		else
		{
			// notify the error
			showMessage(data.message, {title: 'Error'});
		}
	});
}

function updateTableWithRowData(aTable, rowId, elementData)
{
	// get the cols from the table
	var cols = aTable.getGridParam('colModel');
	var rowData = {};

	// convert from the array of cols to object structure
	for (var i = 0; i < cols.length; i++)
		rowData[cols[i].name] = elementData[i];

	// check for existing row
	var existingData = aTable.jqGrid('getRowData', rowId);

	// check if existing data has properties
	if (objectHasProperties(existingData))
	{
		// update the existing row
		aTable.jqGrid('setRowData', rowId, rowData);
	}
	else
	{
		// add the row at the top of the table
		aTable.jqGrid('addRowData', rowId, rowData, "first");
		// select the row
		aTable.jqGrid('setSelection', rowId, true);
	}
}

function deleteTableWithRowId(aTable, rowId)
{
	aTable.jqGrid('delRowData', rowId);
}
</script>