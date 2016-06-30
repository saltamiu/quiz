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
		<link rel="stylesheet" type="text/css" href="./css/challenge.css"/>
		<title>Quiz Website</title>
		<link rel="stylesheet" type="text/css" href="./css/styleHome.css"/>
		<link rel="stylesheet" type="text/css" href="./css/animate.css"/>
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
		
	<h3>								Challanges</h3>
	<fieldset>
		<div id="notificationContainer"></div>
		<div id="challengeContainer" style="display: none">
				<%if (challenges.length==0){ %>
					<h3> There is no challenges . . .  You Are Alone...</h3>
				<%} else{%>
					<%for(int i=0; i<challenges.length; i++){ %>
					<div>
						<input class="msgIDChallenge" type="hidden" value="<%=challenges[i].getId() %>">
						<h3> From: <a href="<%=challenges[i].getSender().getURL()%>"><%=challenges[i].getSender().getFirstname() + " " +challenges[i].getSender().getLastname() %></a></h3>
						Quiz: <a href="quizPage.jsp?quizID=<%=challenges[i].getQuizid() %>">get Quiz</a>
						<h4 color=blue>Msg: <%=challenges[i].getMsg() %></h4>
					</div>
					
					<%} %>
				<%}%>
		</div>
	</fieldset>
	
	
	<div class="notifications">
		<div style="display: inline-block">
				<h3 onclick="showChallenges()">Challenges  <%= challenges.length %></h3>
			</div>
	</div>
	
	<!-- <div id="chart1" style="width:600px;height:300px"></div>

		<script type="text/javascript">
			showChallenges();
		</script> -->
		
	<input type="button" value="Go Back!" onclick="history.back(-1)" />
	
	
	
</body>
<style>
		#button {
		    background-color: #ffff;
		    -moz-border-radius: 5px;
		    -webkit-border-radius: 5px;
		    border-radius:6px;
		    color: #fff;
		    font-family: 'Oswald';
		    font-size: 20px;
		    text-decoration: none;
		    cursor: pointer;
		    border:none;
		}
</style>
<%} %>
<script type="text/javascript">
function showChallenges(){
	var arr = [];
	$.each($(".msgIDChallenge"), function (i, e){
		arr.push($(e).val());
	});
	var data={
			action: "challenges",
			ids :arr
	};
	 $.ajax({
		url:"clearNotifications",
		type:"post",
		data: JSON.stringify(data)
	}); 
	$("#notificationContainer").html($("#challengeContainer").html());
}
</script>
</html>