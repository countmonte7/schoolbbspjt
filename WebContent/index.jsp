<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html; charset=UTF-8">
<link href="indexstyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userId = null;
		if(session.getAttribute("userId") != null) {
			userId = (String)session.getAttribute("userId");
		}
	%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	        <a class="navbar-brand" href="index.jsp">학교 게시판 웹사이트</a>
	        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav"
	            aria-expanded="false">
	            <span class="navbar-toggler-icon"></span>
	        </button>
	        <div class="collapse navbar-collapse" id="navbarNav">
	            <ul class="navbar-nav">
	                <li class="nav-item active">
	                    <a class="nav-link" href="index.jsp">홈<span class="sr-only">(current)</span></a>
	                </li>
	                <% if(userId == null) { %>
	                <li class="nav-item">
	                    <a class="nav-link" href="login.jsp">로그인</a>
	                </li>
	                <% } else { %>
	                <li class="nav-item">
	                    <a class="nav-link" href="mypage.jsp">마이페이지</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="logoutAction.jsp">로그아웃</a>
	                </li>
	                <% } %>
	                <li class="nav-item">
	                    <a class="nav-link" href="bbs.jsp">게시판</a>
	                </li>
	            </ul>	
	        </div>
		</nav>
</body>
</html>