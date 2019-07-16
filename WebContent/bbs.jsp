<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.io.PrintWriter" %>
   <%@ page import="app.bbs.BbsDAO" %>
   <%@ page import="app.bbs.Bbs" %>
   <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="bbsStyle.css"  type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userId = null;
		if(session.getAttribute("userId") != null) {
			userId = (String)session.getAttribute("userId");
		}
		
		int pageNum = 1;
		if(request.getParameter("pageNum")!=null)  {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
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
	                <li class="nav-item">
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
	                <li class="nav-item active">
	                    <a class="nav-link" href="bbs.jsp">게시판</a>
	                </li>
	            </ul>	
	        </div>
		</nav>
		<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align:center;">번호</th>
							<th style="background-color: #eeeeee; text-align:center;">제목</th>
							<th style="background-color: #eeeeee; text-align:center;">작성자</th>
							<th style="background-color: #eeeeee; text-align:center;">작성날짜</th>
						</tr>
					</thead>
					<tbody>
						<%
							BbsDAO bbsDAO = new BbsDAO();
							ArrayList<Bbs> list = bbsDAO.getList(pageNum);
							for(int i = 0, listSize = list.size();i < listSize;i++) {
						%>
						<tr>
							<td><%= list.get(i).getBbsId() %></td>
							<td><a href="view.jsp?bbsId=<%=list.get(i).getBbsId() %>"><%= list.get(i).getBbsTitle() %></a></td>
							<td><%= list.get(i).getUserId() %></td>
							<td><%= list.get(i).getBbsDate().substring(0,11) + 
							list.get(i).getBbsDate().substring(11,13) + "시 " + 
									list.get(i).getBbsDate().substring(14,16) + "분" %></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<%
					if(pageNum != 1) {
				%>
					<a href="bbs.jsp?pageNum=<%= pageNum -1 %>" class="btn btn-success btn-arrow-left">이전 페이지</a>
				<%
					} if(bbsDAO.nextPage(pageNum + 1)) {
				%>
					<a href="bbs.jsp?pageNum=<%= pageNum +1 %>" class="btn btn-success btn-arrow-left">다음 페이지</a>
				<%
					}
				%>
				
				<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			</div>
		</div>
</body>
</html>