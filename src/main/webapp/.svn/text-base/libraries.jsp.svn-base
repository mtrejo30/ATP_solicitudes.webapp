<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel='shortcut icon' href="images/ow-favicon.png" >

<link type="text/css" rel="Stylesheet" href="css/default.css" />
<link type="text/css" rel="Stylesheet" href="css/jquery-ui-1.8.12.custom.css" />
<!-- <link type="text/css" rel="Stylesheet" href="css/jquery-ui-1.10.3.custom.css" /> -->

<script type="text/javascript" src="thirdparty/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="thirdparty/jquery/json.min.js"></script>
<script type="text/javascript" src="thirdparty/jquery/showLoading.min.js"></script>
<script type="text/javascript" src="thirdparty/jquery/jquery-ui-1.10.3.custom.min.js"></script>

<script type="text/javascript" src="thirdparty/moment/moment.min.js"></script>
<script type="text/javascript" src="thirdparty/moment/es.min.js"></script>

<script type="text/javascript" src="js/panel.js"></script>
<script type="text/javascript" src="js/sprintf.js"></script>

<script type="text/javascript" src="model/solicitudes.jsp"></script>

<script type="text/JavaScript">

Array.prototype.isEmpty = function () {
	return this.length == 0;
}

function doExit()
{
	blockPage();
	redirectURL("<c:url value='logout' />");
}
function doMain()
{
	redirectURL("<c:url value='main.page' />");
}
function doNewPassword()
{
	redirectURL("<c:url value='new-password.page' />");
}

String.prototype.format = function ()
{
    var args = arguments;
    return this.replace(/\{(\d+)\}/g, function (m, n) { return args[n]; });
};

Number.prototype.toMoney = function(decimals, decimal_sep, thousands_sep)
{ 
   var n = this,
   c = isNaN(decimals) ? 2 : Math.abs(decimals), //if decimal is zero we must take it, it means user does not want to show any decimal
   d = decimal_sep || '.', //if no decimal separator is passed we use the dot as default decimal separator (we MUST use a decimal separator)

   /*
   according to [http://stackoverflow.com/questions/411352/how-best-to-determine-if-an-argument-is-not-sent-to-the-javascript-function]
   the fastest way to check for not defined parameter is to use typeof value === 'undefined' 
   rather than doing value === undefined.
   */   
   t = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep, //if you don't want to use a thousands separator you can pass empty string as thousands_sep value

   sign = (n < 0) ? '-' : '',

   //extracting the absolute value of the integer part of the number and converting to string
   i = parseInt(n = Math.abs(n).toFixed(c)) + '', 

   j = ((j = i.length) > 3) ? j % 3 : 0; 
   return sign + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : ''); 
};


/**
 * Takes the value in the input and sets it to the created div. Returns the lenght of the input.
 * @method htmlDecode
 * @param input
 * @return inputLenght
 */
function htmlDecode(input)
{
	var e = document.createElement('div');
	e.innerHTML = input;
	return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
}

function objectHasProperties(obj)
{
	for (var i in obj)
	{
		i;
		return true;
	}
	
	return false;
};

function redirectURL(anURL, doBlockPage)
{
	if (doBlockPage)
		blockPage();

    window.location.href = anURL;
}

function blockPage()
{
    $('body').showLoading();
}

function unblockPage()
{
    $('body').hideLoading();
}

function convertLinesToHTMLBreaks(source)
{
	return source.replace(new RegExp('\r?\n','g'), '<br/>');
}

function showMessage(message, extraOptions)
{
    var options = { message: message };

    var button = {
    	text: "<spring:message code='OK' />",
    	id: "showMessage_okButton",
    	click: function() { jQuery("#modalMessage").dialog("close"); }
    };

    options.buttons = [button];

    showModal(jQuery.extend(options, extraOptions));
}

function showCustomMessage(message, okFunction, extraOptions)
{
	var options = { message: message};
	var button = {
		text: "<spring:message code='OK' />",
    	id: "showMessage_okButton",
    	click: function() { jQuery("#modalMessage").dialog("close"); okFunction(); }	
	};
	
	options.buttons = [button];
    showModal(jQuery.extend(options, extraOptions));
}

function showAcceptCancel(message, okFunction, extraOptions)
{
	var options = { message: message };

    var b1 = {
        	text: "<spring:message code='Accept' />",
        	id: "showMessage_acceptButton",
        	click: okFunction
        };

    var b2 = {
        	text: "<spring:message code='Cancel' />",
        	id: "showMessage_cancelButton",
        	click: function() { jQuery("#modalMessage").dialog("close"); }
        };

    options.buttons = [b1, b2];

    showModal(jQuery.extend(options, extraOptions));
}

function setModalIframeSrc(sourceAttribute)
{
	jQuery("#modalIframe").attr("src", sourceAttribute);
}

function clearModalIframe()
{
	var iframe = jQuery("#modalIframe")[0];
	iframe.contentWindow.document.body.innerHTML = "";
}

function showModalIframe(options)
{
	var div = jQuery("#modalIframeDiv");

	var iframe = jQuery("#modalIframe");
	
	if (options.iframeWidth != null)
		iframe.attr("width", options.iframeWidth);
	if (options.iframeHeight != null)
		iframe.attr("height", options.iframeHeight);

	div.css("display", "block");

    div.dialog
    (
        {
            autoOpen: false,
            resizable: false,
            width: "auto",
          	height: options.height != null ? options.height : "auto",
            modal: true
        }
    );
    
    div.dialog("open");
}

function closeModalIframe()
{
	jQuery("#modalIframeDiv").dialog("close");
}

function showModal(paramOptions)
{
    jQuery("#modalMessage p").html(paramOptions.message);

    var opts = {
            autoOpen: false,
            resizable: false,
            //height: options.height != null ? options.height : 210,
            modal: true,
            buttons: paramOptions.buttons,
            title: paramOptions.title
        };

    if (paramOptions.width != null)
    	opts.width = paramOptions.width;
    else
    	opts.width = '300px';

    jQuery("#modalMessage").dialog(opts);
    jQuery("#modalMessage").dialog("open");
}

function setAutocompleteInfo(element, object, func)
{
	var info = { id: "", label: ""};

	if (object != null)
	{
		if (func != null)
			info = func(object);
		else
			info = object;
	}

	jQuery(element).val(info.label);
	jQuery(element).attr("objectId", info.id);
}

function fillSelect(selectObject, collection, dataFunction)
{
	jQuery.each(collection, function(eachIndex, eachObject)
	{
		var obj = dataFunction(eachObject);
		selectObject.append(new Option(obj.text, obj.value));
	});
}

function bindClickEvent(bindTag)
{
	jQuery.each(jQuery("." + bindTag), function(index, eachObj)
	{
		var obj = jQuery(eachObj);
		var func = window[obj.attr(bindTag)];
		obj.click(func);
	});
}
</script>
