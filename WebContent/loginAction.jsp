<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="app.user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <jsp:useBean id="user" class="app.user.User" scope="page" />
    <jsp:setProperty name="user" property="userId" />
    <jsp:setProperty name="user" property="userPw" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		UserDAO userDao = new UserDAO();
		int result = userDao.login(user.getUserId(), user.getUserPw());
		if(result== 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}else if(result==0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result==-1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result==-2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>