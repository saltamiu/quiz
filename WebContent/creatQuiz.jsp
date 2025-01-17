<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>

<!DOCTYPE html>
<html>
<%
HttpSession ses = request.getSession();
User user = (User) ses.getAttribute("user");
if(user == null){
	response.sendRedirect("index.html");
}else{
%>
<head>
	<meta charset="ISO-8859-1">
	<title>Create new Quiz</title>
			 <link rel="stylesheet" type="text/css" href="./css/Quiz.css"/>
			 <link rel="stylesheet" type="text/css" href="./css/HeaderSCC.css"/>
			 
	<!-- <link rel="stylesheet" type="text/css" href="./css/styleHome.css"/> 
 -->		 
	<!-- <link rel="stylesheet" type="text/css" href="./css/styleHome.css"/> -->
	<!-- <link rel="stylesheet" type="text/css" href="./css/bootstrap/css/bootstrap.min.css"/> -->
	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<%-- <a href="creatQuiz.jsp"><img class = "quiz" src="./img/blaa.png" title="Create New Quiz"></a>
			<hr>
	
		<div class = "headerMenu" size = "60">
			<div class = "search-box">

				<form action="search.php" method = "GET" id = "search">
					<input type = "text" name="q" size="60" placeholder="Search ...">
				</form>
				<a href="https://instagram.com/"><img class = "link" src="./img/2.png"></a>
				<p class="out"><a href="SignOutServlet">Sign Out</a></p>
				<p><a href="home.jsp"><%=user.getFirstname() %> <%=user.getLastname() %></a></p>
				<a href="home.jsp"><img class = "user" src="./img/user.jpg"></a>
				
			</div>
		</div>
		 --%>
		 
		 
		 
<a href="creatQuiz.jsp"><img class = "quiz" src="./img/blaa.png" title="Create New Quiz"></a>
			<hr>
		<div class = "headerMenu" size = "60">
			<div class = "search-box">

				<form action="search" method = "GET" id = "search">
					<input id="searchForm" type = "text" name="q" size="60" placeholder="Search ...">
				</form>
				<a href="https://instagram.com/"><img class = "link" src="./img/2.png"></a>
				<p id = "bla" class="out"><a href="SignOutServlet">Sing Out</a></p>
				<p id = "bla" class = "boloshi"><a href="home.jsp"><%=user.getFirstname() %> <%=user.getLastname() %></a></p>
				<a href="home.jsp"><img class = "user" src="./img/user.jpg"></a>
				
			</div>
		</div>
		 
<div id="questionTemplate" style="display: none">
	<fieldset class="question">
		<div class="questionType">
			Question Type:
			<select class="questionTypeSelect">
				<option value="questionAnswerTemplate">Question Answer</option>
				<option value="multipleChoiceTemplate">Multiple Choice</option>
				<option value="pictureQuestionTemplate">Picture Question</option>
				<option value="fillTheGapsTemplate">Fill the gaps</option>
			</select>
			<button class = "but" onclick="removeQuestion(this)">Remove</button>
		</div>
		<div class="questionBody">
			<h6>Enter Question</h6>
			<textarea rows="5" cols="100" class="questionText"></textarea>
			<h6>Enter correct answer</h6>
			<textarea rows="2" cols="100" class="questionAnswer"></textarea>
		</div>
	</fieldset>
</div>
<div id="questionAnswerTemplate" style="display: none">
	<h6>Enter Question</h6>
	<textarea rows="5" cols="100" class="questionText"></textarea>
	<h6>Enter correct answer</h6>
	<textarea rows="2" cols="100" class="questionAnswer"></textarea>
</div>
<div id="multipleChoiceTemplate" style="display: none">
	<h6>Enter Question</h6>
	<textarea rows="5" cols="100" class="questionText"></textarea>
	<p>A: <input type="text" class="choice1"></p>
	<p>B: <input type="text" class="choice2"></p>
	<p>C: <input type="text" class="choice3"></p>
	<p>D: <input type="text" class="choice4"></p>
	<p>
		Correct Answer: <select class="correctAnswer">
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
						</select>
						</p>
</div>
<div id="pictureQuestionTemplate" style="display: none">
	<h6>Enter picture url:</h6>
	<input type="text" class="pictureURL" onchange="changePictureURL(this)"/>
	<img class="pqImage" width="100px" height="100px"/>
	<h6>Enter correct answer</h6>
	<textarea rows="2" cols="100" class="pictureAnswer"></textarea>
</div>
<div id="fillTheGapsTemplate" style="display: none">
	<h6>Enter Question</h6>
	<textarea rows="5" cols="100" class="questionText"></textarea>
	<h6>Enter answers quantity</h6>
	<input type="number" class="ftgNumberQuantity" onchange="quantityAnswersChange(this)" value="1"/>
	<h6>Enter correct answers:</h6>
	<div class="answers">
		<input type="text" class="ftgAnswer1"/>
	</div>
</div>

<!-- <body> -->




<div>
	
	<fieldset>
	<div style="width: 100%">
    		<img style="float:right;" class = "animated bounce" src="./img/kiss.gif">
	<legend>Quiz</legend>
		<p>Enter Quiz name  <input class="form-control" type="text" id="quizName" style="width: 200px;"></p>
		<p>Enter Quiz description <textarea class="form-control" id="quizDescription" style="width: 200px;"></textarea></p>
		<!-- <p><input type="checkbox" id="quizRandom"/>Random</p>
		<p><input type="checkbox" id="quizFeedback"/>Feedback</p>
		<p><input type="checkbox" id="quizIsOnePage"/>Is One Page</p>  -->
		</div>
	</fieldset>
</div>
	<fieldset id="questions">
		<legend>Questions</legend>
		
		<button class="btn btn-primary" id="addQuestion" onclick="addQuestion()">Add Question</button>
	</fieldset>
	<button class = "but" id="addQuiz">Add Quize</button>
 </body> 
<script>
var bla;
$('#addQuiz').click(function(){
	var quiz = {};
	quiz.name = $("#quizName").val();
	quiz.description = $("#quizDescription").val();
	quiz.random = $("#quizRandom").is(":checked");
	quiz.isOnePage = $("#quizIsOnePage").is(":checked");
	quiz.feedback = $("#quizFeedback").is(":checked");
	quiz.questions = [];
	bla = quiz;
	if(quiz.name == "" || quiz.description == ""){
		alert("You should fill all fields of quiz");
	}else{
		var questions = $("#questions").find(".question");
		for(var i=0; i<questions.length; i++){
			var question = questions[i];
			switch($(question).find(".questionTypeSelect").val()){
				case "questionAnswerTemplate":{
					var obj = {category: 1};
					obj.question = $(question).find(".questionText").val();
					obj.answer = $(question).find(".questionAnswer").val();
					if(obj.question == "" || obj.answer == ""){
						alert("fill all fields of question "+(i+1));
						return;
					}
					quiz.questions.push(obj);
					break;
				}
				case "multipleChoiceTemplate":{
					var obj = {category: 2}
					obj.question = $(question).find(".questionText").val();
					for(var j=1; j<=4; j++)
						obj["choice"+j] = $(question).find(".choice"+j).val();
					obj.answer = $(question).find(".correctAnswer").val();
					console.log(obj);
					if(obj.question == "" || obj.choice1 == "" || obj.choice2 == "" || obj.choice3 == "" || obj.choice4 == "" || 
							obj.answer == ""){
						alert("fill all fields of question "+(i+1));
						return;
					}
					quiz.questions.push(obj);
					break;
				}
				case "pictureQuestionTemplate":{
					var obj = {category :3 }
					obj.url = $(question).find(".pictureURL").val();
					obj.answer = $(question).find(".pictureAnswer").val();
					if(obj.url == "" || obj.answer == ""){
						alert("fill all fields of question "+(i+1));
						return;
					}
					quiz.questions.push(obj);
					break;
				}
				case "fillTheGapsTemplate":{
					var obj = {category :4 }
					obj.question=$(question).find(".questionText").val();
					obj.answers = [];
					for(var k=1; k<=$(question).find(".ftgNumberQuantity").val(); k++){
						obj.answers.push($(question).find(".ftgAnswer"+k).val());
					}
					console.log(obj);
					if(obj.question == ""){
						alert("fill all fields of question "+(i+1));
						return;
					}
					for(var k=1; k<=$("ftgNumberQuantity").val(); k++){
						if(obj["answer"+k] == ""){
							alert("fill all fields of question "+(i+1));
							return;
						}
					}
					quiz.questions.push(obj);
					break;
				}
			}
		}
		console.log(quiz);
		$.ajax({
			url: "addQuiz",
			type: "post",
			data: JSON.stringify(quiz),
			success: function(data){
				window.location.replace(data);
			},
			error: function(err){
				alert("error");
			}
		});
	}
});

function removeQuestion(e){
	$(e).parent().parent().remove();
}
function changePictureURL(e){
	$(e).parent().find(".pqImage").attr('src', $(e).val());
}
function quantityAnswersChange(e){
	var answers = $(e).parent().find(".answers");
	var html = "";
	for(var i=1; i<=$(e).val(); i++){
		html += '<input type="text" class="ftgAnswer'+i+'"/>';
	}
	answers.html(html);
}
function addQuestion(){
	var elem = $(document.getElementById("questionTemplate").innerHTML);
	$(elem).find(".questionTypeSelect").change(function(e){
		$(this).parent().next().html($("#"+$(this).val()).html());
	});
	$(elem).insertBefore('#addQuestion');
	window.scrollTo(0,document.body.scrollHeight);
}
</script>
<%} %>
</html>
