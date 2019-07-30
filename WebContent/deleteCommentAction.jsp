<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int bbsId = 0;
		if(request.getParameter("bbsId")!=null) {
			bbsId = Integer.parseInt(request.getParameter("bbsId"));
		}
	
		int commentId = 0;
		if(request.getParameter("commentId")!=null) {
			commentId = Integer.parseInt(request.getParameter("commentId"));
		}
		CommentDAO commentDAO = CommentDAO.getInstance();
		int result = commentDAO.deleteComment(commentId);
		System.out.println(result);
		if(result==1) {
			System.out.println("됐음");
			PrintWriter script = response.getWriter();
			script.print("<script>");
			script.print("alert('댓글을 삭제했습니다.');");
			script.print("location.href='BbsServlet?bbsId=" + bbsId +"'");
			script.print("</script>");
		}
	%>
</body>
</html>