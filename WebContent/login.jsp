<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link href="style.css" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<title>로그인</title>
</head>
<body>
	<form action="loginAction.jsp" class="login-form">
	    <h1>로그인</h1>
	    <div class="txtb">
	       <input type="text" name="userId">
	       <span data-placeholder="Username"></span>
	    </div>
	    <div class="txtb">
	       <input type="password" name="userPw">
	       <span data-placeholder="Password"></span>
	    </div>
	    
	    <input type="submit" class="logbtn" value="로그인">
	    <div class="bottom-text">
	        <a href="signup.jsp">회원가입</a>
	    </div>
	</form>
	
	<script type="text/javascript">
        $(".txtb input").on("focus", function(){
            $(this).addClass("focus");
        });
        
        $(".txtb input").on("blur", function(){
            if($(this).val()=="")
            $(this).removeClass("focus");
        });
    </script>
</body>
</html>