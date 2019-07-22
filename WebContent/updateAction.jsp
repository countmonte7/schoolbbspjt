<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="app.bbs.BbsDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <jsp:useBean id="bbs" class="app.bbs.Bbs" scope="page" />
    <jsp:setProperty name="bbs" property="bbsTitle" />
    <jsp:setProperty name="bbs" property="bbsContent" />
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
		
		if(userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해야 글을 수정할 수 있습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		if(!userId.equals(bbs.getUserId())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓴이만 글을 수정할 수 있습니다.')");
			script.println("location.href = 'history.back()'");
			script.println("</script>");
		}else {
			if(bbs.getBbsTitle() == null || bbs.getBbsContent()==null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userId, bbs.getBbsContent());
					if(result== -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}else  {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href='bbs.jsp'");
						script.println("</script>");
					}
				}
		}
	%>
</body>
</html>