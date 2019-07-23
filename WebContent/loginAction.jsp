<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="app.user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <%@ include file="tagLib.jsp" %>
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
		String userId = null;
		if(session.getAttribute("userId") != null) {
			userId = (String)session.getAttribute("userId");
		}
		if(userId != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인된 상태입니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}else {
			userId = request.getParameter("userId");
			String password = request.getParameter("userPw");
			if(userId.equals("") || password.equals("")) {
				PrintWriter script = response.getWriter();
				request.setAttribute("error", "아이디와 비밀번호를 입력해주세요.");
				pageContext.forward("login.jsp");
			}
			UserDAO userDao = new UserDAO();
			int result = userDao.login(userId, password);
			if(result== 1) {
				session.setAttribute("userId", userId);
			%>
				<c:set var="sessionId" value="userId" scope="session"/>
			<%
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
			}else if(result==0) {
				PrintWriter script = response.getWriter();
				request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
				pageContext.forward("login.jsp");
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
		}
	%>
</body>
</html>