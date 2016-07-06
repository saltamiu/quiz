<%@page import="model.Quiz.QuizHandle"%>
<%@ page import="model.*"%>
<%@ page import="Servlets.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	HttpSession ses = request.getSession();

	User user = (User) ses.getAttribute("user");
	if (user == null)
		response.sendRedirect("index.html");
	else {
		String username = request.getParameter("username");
		User other = DBHelper.findUser(username);
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=other == null ? "User" : other.getUsername()%></title>
<link rel="stylesheet" type="text/css" href="./css/styleHome.css" />
<link rel="stylesheet" type="text/css" href="./css/animate.css" />
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<%
		if (other == null) {
	%>
	<h1>
		No Such User: '<%=username%>'
	</h1>
	<%
		} else {
	%>
	<a href="creatQuiz.jsp"><img class="quiz" src="./img/blaa.png"
		title="Create New Quiz"></a>
	<hr>

	<div class="headerMenu" size="60">
		<div class="search-box">
			<script type="text/javascript">
				function search() {
					window.location.replace("search.jsp?query="
							+ $("#searchField").val());
				}
			</script>
			<form action="search" method="GET" id="search">
				<input id="searchForm" type="text" name="q" size="60"
					placeholder="Search ...">
			</form>
			<a onclick="$('#search').submit()"><img class="link"
				src="./img/2.png"></a>
			<p class="out">
				<a href="SignOutServlet">Sign Out</a>
			</p>
			<p>
				<a href="home.jsp"><%=user.getFirstname()%> <%=user.getLastname()%></a>
			</p>
			<a href="home.jsp"><img class="user" src="./img/user.jpg"></a>


		</div>
	</div>
	
	
</body>

<%
	}
	}
%>

</html>