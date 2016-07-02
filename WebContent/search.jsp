<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="Servlets.DBHelper"%>
<%@ page import="model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	HttpSession ses = request.getSession();
	
	User user = (User) ses.getAttribute("user");
	if(user == null)
		response.sendRedirect("index.html");
	else{
		Message[] messages = DBHelper.getUserUnreadMessages(user.getUserID());
		Challenge[] challenges = DBHelper.getUnseenChallenges(user);
		FriendRequest[] friendRequest = DBHelper.getUnseenFriendRequest(user);
		Quiz[] popQuizes = DBHelper.getPopularQuizes();
		Quiz[] recentCreatedQuizes = DBHelper.getRecentlyCreatedQuizes(user);
		Quiz[] recentQuizActivities = DBHelper.getRecentQuizActivities(user);
		Quiz[] userPlayedQuizes = DBHelper.getUserPlayedQuizes(user);
		//User[] search = DBHelper.searchUsers("");
%>
	<head>
		<link rel="stylesheet" type="text/css" href="./css/challenge.css"/>
		<link rel="stylesheet" type="text/css" href="./css/search.css"/>
		<!-- <link rel="stylesheet" type="text/css" href="./css/transi.css"/> -->
		<title>Challenge</title>
		<link rel="stylesheet" type="text/css" href="./css/styleHome.css"/>
		<!-- <link rel="stylesheet" type="text/css" href="./css/animate.css"/> -->
<!-- 		<link rel="stylesheet" type="text/css" href="./css/css/bootstrap.min.css"/>
 -->		<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
		
	</head>
<body>
<a href="creatQuiz.jsp"><img class = "quiz" src="./img/blaa.png" title="Create New Quiz"></a>
			<hr>
		<div class = "headerMenu" size = "60">
			<div class = "search-box">

				<form action="search" method = "GET" id = "search">
					<input id="searchForm" type = "text" name="q" size="60" placeholder="Search ...">
				</form>
				<a href="https://instagram.com/"><img class = "link" src="./img/2.png"></a>
				<p class="out"><a href="SignOutServlet">Sing Out</a></p>
				<p class = "boloshi"><a href="home.jsp"><%=user.getFirstname() %> <%=user.getLastname() %></a></p>
				<a href="home.jsp"><img class = "user" src="./img/user.jpg"></a>
				
			</div>
		</div>

	<fieldSet>
		<div style="width: 100%">
    		<img style="float:right;" class = "animated bounce" src="./img/search1.gif">
		<legend>Result:</legend>

		<%
			User[] users = (User[]) request.getAttribute("users");
			if (users.length == 0) {
		%>
		<h4>there is no User</h4>
		<img class = "animat" src="./img/noSearch.gif">
		<%
			}
			for (int i = 0; i < users.length; i++) {
		%>

		<h5>
			<a href="<%=users[i].getURL()%>"> <%=users[i].getFirstname() + " "
						+ users[i].getLastname()%></a>
		</h5>
		<%
			}
		%>
		<h5>
		<br>
		<br>
		<br>
		<br>
			<a href="home.jsp">RETURN HOMEPAGE</a>
		</h5>
		</div>
	</fieldSet>

</body>
<%} %>
</html>