<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Sample secured web application</title>
</head>
<body>
<h1>
	You are authorized to view
	<%=((HttpServletRequest) pageContext.getRequest()).getServletPath().replaceAll("/(.*)/index.*", "$1")
                   .replaceAll(".*index.*", "unprotected home")%>
	page
</h1>
<pre>
AuthType:  ${pageContext.request.authType}
Principal: ${empty pageContext.request.userPrincipal ?"": pageContext.request.userPrincipal.name}
</pre>
<p>This application contains 3 pages:</p>
<ul>
	<li><a href="<c:url value='/'/>">Home page</a> - unprotected</li>
	<li><a href="<c:url value='/marvel/'/>">Marvel page</a> - only users with marvel role can access it</li>
	<li><a href="<c:url value='/dccomics/'/>">DCComics page</a> - only users with dccomics role can access it</li>
</ul>
</body>
</html>