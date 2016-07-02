<%@ page import="model.*"%>
<%@ page import="Servlets.*"%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
		<link rel="stylesheet" type="text/css" href="./css/Friend.css"/>
		<title>Request</title>
		<link rel="stylesheet" type="text/css" href="./css/styleHome.css"/>
		<!-- <link rel="stylesheet" type="text/css" href="./css/animate.css"/> -->
<!-- 		<link rel="stylesheet" type="text/css" href="./css/bootstrap/css/bootstrap.min.css"/>
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
	<div class="notifications">
		<div style="display: inline-block">	
			<h3>Friends</h3>
			</div>
			</div>
	<fieldset>
		<div id="notificationContainer"></div>
		<div id="friendRequestContainer" style="display: none">
			<%if (friendRequest.length==0){ %>
			<div style="display: inline-block">	
					<h3>                   You are not Popular!!! </h3>
				</div>
					<br>
					<br>
					<br>
					<img  class = "animated-gif" src="./img/king.gif">
					<img>
				<%}else{ %>
			<%for(int i=0; i<friendRequest.length; i++){ %>
			<div>
				<input class="msgIDRequest" type="hidden" value="<%=friendRequest[i].getId() %>">
				<h3><a class = "bolo" href="<%=friendRequest[i].getSender().getURL() %>"><%=friendRequest[i].getSender().getFirstname() + " " +friendRequest[i].getSender().getLastname() %></a> added you into his/her friends.</h3>
				<h4 color =red>If you don't want to friend this user you can go to his/her profile and unfriend him/her.</h4>
				<img  class = "an" src="./img/laughing.gif">
			</div>
			<%} %>
			<%} %>
		</div>
		</fieldset>
		
		<div style="display: inline-block">
				<%-- <h3 onclick="showFriendRequests()">Friend Requests  <%= friendRequest.length %></h3> --%>
			</div>
			
		<input type="button" value="Go Back!" onclick="history.back(-1)" />

</body>
<%} %>
<script type="text/javascript">
function showFriendRequests(){
	var arr = [];
	$.each($(".msgIDRequest"), function (i, e){
		arr.push($(e).val());
	});
	var data={
			action: "friendRequests",
			ids :arr
	};
	$("#notificationContainer").html($("#friendRequestContainer").html());$.ajax({
		url: "clearNotifications",
		type: "post",
		data: JSON.stringify(data)
	});
}
showFriendRequests();
</script>
</html>