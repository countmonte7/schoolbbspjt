<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.bbs.BbsDAO" %>
<%@ page import="app.bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int bbsId = Integer.parseInt(request.getParameter("bbsId"));
		String userId = null;
		BbsDAO bbsDAO = new BbsDAO();
		if(session.getAttribute("sessionId")!=null) {
			userId = (String)session.getAttribute("sessionId");
		}
		Bbs bbs = bbsDAO.getBbs(bbsId);
		if(!bbs.getUserId().equals(userId)) {
			PrintWriter script = response.getWriter();
			script.print("<script>");
			script.print("alert('게시글 작성자만 삭제할 수 있습니다.')");
			script.print("history.back()");
			script.print("</script>");
		}else {
			int result = bbsDAO.deleteBbs(bbsId);
			if(result==1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글이 삭제되었습니다.')");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>