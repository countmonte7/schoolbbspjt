<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="app.user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <jsp:useBean id="user" class="app.user.User" scope="page" />
    <jsp:setProperty name="user" property="userId" />
    <jsp:setProperty name="user" property="userPw" />
    <jsp:setProperty name="user" property="userName" />
    <jsp:setProperty name="user" property="userEmail" />
    <jsp:setProperty name="user" property="studentCode" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(user.getUserId() == null || user.getUserPw()==null ||
			user.getUserName()==null || user.getUserEmail()==null ||
			user.getStudentCode()==0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else {
			UserDAO userDao = new UserDAO();
			int result = userDao.signup(user);
			if(result== -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result==0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 일치하지 않습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입이 완료됐습니다.')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>