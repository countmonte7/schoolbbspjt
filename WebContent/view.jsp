<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.io.PrintWriter" %>
   <%@ page import="app.bbs.BbsDAO" %>
   <%@ page import="app.bbs.Bbs" %>
   <%@ page import="java.util.ArrayList" %>
   <%@ include file="tagLib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="viewStyle.css"  type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userId = null;
		if(session.getAttribute("userId") != null) {
			userId = (String)session.getAttribute("userId");
		}
		int bbsId = 0;
		if(request.getParameter("bbsId")!=null) {
			bbsId = Integer.parseInt(request.getParameter("bbsId"));	
		}
		if(bbsId == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp';");
			script.println("</script>");
		}
	%>
	<jsp:include page="navigation.jsp" flush="false" />

		<div class="container">
			<div class="row">
				<table class="table" style="text-align:center; border:1px solid #dddddd; word-break:break-all;">
					<tbody>
						<%
							BbsDAO bbsDAO = new BbsDAO();
							Bbs bbs = bbsDAO.getBbs(bbsId);
						%>
						<tr>
							<td style="width:10%;font-size:80%; border 1px solid"><%=bbs.getBbsId() %></td>
							<td style="width:60%;font-size:1.5em;"><%=bbs.getBbsTitle() %></td>
							<td style="width:30%;font-size:smaller;">작성시간 : <%=bbs.getBbsDate().substring(0,10) %> 
							<%=bbs.getBbsDate().substring(11,13) %>시 <%=bbs.getBbsDate().substring(14,16) %>분</td>
						</tr>
						<tr>
							<td colspan="2"></td>
							<td colspan="1" align="right" style="font-size:smaller;text-align:center;">작성자 : <%=bbs.getUserId() %></td>
						</tr>
						<tr>
							<td colspan="3"><%=bbs.getBbsContent() %></td>
						</tr>
					</tbody>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(userId != null && userId.equals(bbs.getUserId())) {
				%>
					<a href="update.jsp?bbsId=<%= bbsId %>" class="btn btn-primary">글 수정</a>
				<%
					}
				%>
			</div>
		</div>
</body>
</html>