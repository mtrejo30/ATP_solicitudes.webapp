<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:import url="/doctype.jsp" />

<html>
<head>
</head>

<script type="text/javascript">

/**
 * Calls the parent window to performt the function whit the name and parameter passed as parameters in the function.
 * @method performParentFunction
 * @param functionName
 * @param parameter 
 */
function performParentFunction(functionName, parameter)
{
	parent.window[functionName](parameter);
}

 /**
 * Function called when the document is loaded. Ask to perform an action in the iframe parent.  
 * @method loaded
 */
function loaded()
{
	performParentFunction('<c:out value="${functionName}" escapeXml="false" />', <c:out value="${parameter}" escapeXml="false" />);
}
</script>

<body onload="loaded();">
</body>
	
</html>