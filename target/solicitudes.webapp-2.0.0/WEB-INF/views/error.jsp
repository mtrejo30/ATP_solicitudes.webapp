<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:import url="/doctype.jsp" />

<html>
<head>
<title><c:out value='${title}'/></title>
<c:import url="/libraries.jsp" />

</head>
<body>
<div class="pageContent">
	
    <div class="main">
        <div class="mainContent">	
        
        <p><c:out value="${errorMessage}" /></p>

        <div id="modalMessage">
            <p></p>
        </div>
    </div>
    <div class="footer">
    </div>
</div>
</div>
</body>

<script>

jQuery(document).ready(loaded);
function loaded()
{	
}

</script>
</html>