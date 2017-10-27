function exportData(cols,file,titulo){
    var columns = cols.toString().split(",");
    var columnNms = $("#reportTable").jqGrid('getGridParam','colNames');
    var theads = "";
    for(var cc=0;cc<columnNms.length;cc++){
        var isAdd = true;
        for(var p=0;p<columns.length;p++){
            if(cc==columns[p]){
                isAdd = false;
                break;
            }
        }
        if(isAdd){
            theads = theads +"<th>"+columnNms[cc]+"</th>"
        }
    }
    theads = "<tr>"+theads+"</tr>";
    var mya=new Array();
    mya=jQuery("#reportTable").getDataIDs();  // Get All IDs
    var data=jQuery("#reportTable").getRowData(mya[0]);     // Get First row to get the labels
    //alert(data['id']);
    var colNames=new Array();
    var ii=0;
    for (var i in data){
        colNames[ii++]=i;
    }
   // alert(mya);
    //var img="<img src='mages/atp-logo.jpg'/>";
    var pageHead = "HERRAMIENTA AL SERVICIO DE NUESTROS CLIENTES";
    var pageHead_pe="Te recordamos que toda la informaci\u00F3n aqu\u00ED mostrada es de consulta,";
    var pageHead_pe1="no es v\u00E1lida para reclamaciones de \u00EDndole legal o comercial.";
    titulo =titulo.replace("Ã³","ó");
    var titulo =titulo;
    var html="<html><head><style script='css/text'>.tble{margin-left:110px}.f{margin-top:-96px;margin-left:150px;}.imagen{display:inline-block;}.pf3{margin-top:30px;text-align:center}.pf{margin-top:15px;}.pf1{margin-top:1px;}.pageHead_pe{font-size:12px;font-weight: bold;text-align: center;margin-bottom: 0cm;}table.tableList_1 th {border:1px solid #a3a1a1; border-bottom:2px solid #a3a1a1; text-align:center; vertical-align: middle; padding:8px; background:#ddd;}table.tableList_1 td {border:1px solid #b5aeaa; text-align: left; vertical-align: top; padding:7px;} .pageHead_3{font-size:19px;font-weight: bold;text-align:center;margin-bottom: 0.2cm;}</style></head><body><div class='imagen'><img src='http://148.223.29.18:5065/citasweb/images/atp-logo.jpg'/><p class='f pageHead_3'>"+pageHead+"</p><p class='f pageHead_pe pf'>"+pageHead_pe+"</p><p class='f pageHead_pe pf1'>"+pageHead_pe1+"</p><p class='f titulo pf3'>"+titulo+"</p></div> <table border='"+(file=='pdf'? '0' : '1')+"' class='tableList_1 tble' cellspacing='0' cellpadding='0'>"+theads;
    //alert('len'+mya.length);
    for(i=0;i<mya.length;i++)
    {
        html=html+"<tr>";
        data=jQuery("#reportTable").getRowData(mya[i]); // get each row
        for(j=0;j<colNames.length;j++){
            var isjAdd = true;
            for(var pj=0;pj<columns.length;pj++)
            {
                if(j==columns[pj]){
                    isjAdd = false;
                    break;
                }
            }
            if(isjAdd){
                html=html+"<td>"+data[colNames[j]]+"</td>"; // output each column as tab delimited
            }
        }
        html=html+"</tr>";  // output each row with end of line

    }
    html=html+"</table></body></html>";  // end of line at the end
  //  alert(html);
    document.formstyle.pdfBuffer.value=html;
    document.formstyle.fileType.value=file;
    document.formstyle.method='POST';
    document.formstyle.action='GenerateGridPDFs';  // send it to server which will open this contents in excel file
    document.formstyle.submit();
}