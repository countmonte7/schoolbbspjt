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
<title>JSP 게시판 웹사이트</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<style type="text/css">
	body {border: 1px solid MediumSeaGreen;width:100%;height:100%;}
	.container {
		position:absolute;
		margin-left: 10px auto;
		margin-right: 10px auto;
		top: 10%;
	}
	
	table {
		padding: 10px;
	}
	
	table > td {
		text-align: left;
	}
	
	.bottom {
		clear: both;
		position:absolute;
		margin: 0 auto;
		top: 100%;
		padding: 30px;
		-webkit-box-sizing: border-box;
     	-moz-box-sizing: border-box;
         box-sizing: border-box;
	}
	
	.row1, .row2, .row3 {
		display: block;
		margin-left: auto;
		margin-right: auto;
	}
</style>
</head>
<body>
	<div class="container">
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
			
			int nthValue = 0; //네비게이션 active 클래스 추가를 위해
			if(session.getAttribute("userId") != null) {
				userId = (String)session.getAttribute("userId");
				nthValue = 4;
			}else {
				nthValue = 3;
			}
			pageContext.setAttribute("userId", userId);
			pageContext.setAttribute("value", nthValue);
		%>
	
		<jsp:include page="navigation.jsp" flush="false">
					<jsp:param name="bbsActiveClass" value="${value}" />
		</jsp:include>
	
			<div class="middle">
					<table class="table" style="text-align:center; border:1px solid #dddddd; word-break:break-all;">
						<tbody>
							<%
								BbsDAO bbsDAO = new BbsDAO();
								Bbs bbs = bbsDAO.getBbs(bbsId);
							%>
							<tr>
								<td style="width:10%;font-size:80%; border 1px solid"><%=bbs.getBbsId() %></td>
								<td style="width:50%;font-size:1.5em;"><%=bbs.getBbsTitle() %></td>
								<td style="width:20%;font-size:smaller;text-align:right;">작성자 : <%=bbs.getUserId() %></td>
								<td style="wdith:20%;font-size:smaller;">조회수 : <%= bbs.getBbsHit() %></td>
							</tr>
							<tr>
								<td colspan="3"></td>
								<td colspan="1" align="right" style="font-size:smaller;">작성시간 : <%=bbs.getBbsDate().substring(0,10) %> 
								<%=bbs.getBbsDate().substring(11,13) %>시 <%=bbs.getBbsDate().substring(14,16) %>분</td>
							</tr>
							<tr>
								<td colspan="4"><%=bbs.getBbsContent() %></td>
							</tr>
						</tbody>
					</table>
					<div class="update">
						<%
							if(userId != null && userId.equals(bbs.getUserId())) {
						%>
								<a href="update.jsp?bbsId=<%= bbsId %>">글 수정</a>
								<a href="deleteAction.jsp?bbsId=<%=bbsId %>">글 삭제</a>
						<%
							}
						%>
					</div>
			</div>
			<div class="bottom">
				<div class="row2">
					<jsp:include page="comment.jsp" flush="false" />
				</div>
				<div class="row3">
					<a href="bbs.jsp">목록</a>
				</div>
			</div>
	</div>
</body>
</html>