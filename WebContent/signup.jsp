<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link href="signupstyle.css" rel="stylesheet" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<title>회원가입</title>
</head>
<body>
	<jsp:include page="back.jsp" />
    <form action="signupAction.jsp" class="signup-form" method="POST">
        <h1>회원가입</h1>
        <div class="input_obj">
            <input type="text" name="userId" placeholder="아이디">
        </div>
        <div class="input_obj">
            <input type="password" name="userPw" placeholder="패스워드">
        </div>
        <div class="input_obj">
            <input type="password" name="userPw2" placeholder="패스워드 확인">
        </div>
        <div class="input_obj">
            <input type="text" name="userName" placeholder="이름">
        </div>
        <div class="input_obj">
            <input type="email" name="userEmail" placeholder="이메일">
        </div>
         <div class="input_obj">
            <input type="text" name="studentCode" placeholder="학번">
        </div>
        <input type="submit" class="signupBtn" value="회원가입">
    </form>		
</body>
</html>