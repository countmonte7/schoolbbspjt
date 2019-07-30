<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.bbs.Bbs" %>
<%@ page import="app.comment.CommentDAO" %>
<%@ page import="app.comment.Comment" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="tagLib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>comment</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script src="js/timeago.js"></script>
<style type="text/css">
	table {
		width: 100%;
		margin-left: 0 auto;
		margin-right: 0 auto;
	}
	td {
		margin-right: 30px;
	}
</style>
</head>
<body>
				<%
					int bbsId = 0;
					if(request.getParameter("bbsId")!= null) {
						bbsId = Integer.parseInt(request.getParameter("bbsId"));
					}
					String userId = null;
					if(session.getAttribute("sessionId") != null) {
						userId = (String)session.getAttribute("sessionId");
					}
					
					CommentDAO commentDao = CommentDAO.getInstance();
					ArrayList<Comment> commentList = commentDao.getCommentList(bbsId);
					if(commentList!=null) {
					%>
					
					<table>
						<tbody>
						<tr>
							<td colspan="5" style="text-align:center;background-color: gray;">
											댓글 목록
							</td>
						</tr>
					<%
						for(int i=0, len = commentList.size();i<len;i++) {
					%>
							<tr>
									<td colspan="1" style="width:100px;">
											<%= commentList.get(i).getWriter() %>
									</td>
									<td colspan="2" style="width:300px;text-align:left;">
											<%=commentList.get(i).getComment_content() %>
									</td>
									<td colspan="1" style="width:100px;">
										<time class="timeago" datetime="<%=commentList.get(i).getComment_datetime() %>"><%=commentList.get(i).getComment_datetime() %></time>
									</td>
									<td colspan="1" style="width:100px;">
											<a href="#">[댓글]</a>
											<%
												if(commentList.get(i).getWriter().equals(userId)) {
											%>
												<a href="updateCommentAction.jsp">[수정]</a>
												<a href="deleteCommentAction.jsp?bbsId=<%=bbsId %>&commentId=<%=commentList.get(i).getCommentId()%>">[삭제]</a>
											<%
												}
											%>
									</td>
								</tr>
							<% 
							}
						%>
						</tbody>
					</table>
					<%
					}
					%>
									
	<% 
		if(userId != null) { 
	%>
			<form action="comment.do" method="post">
				<div id="comment_box">
					<input type="hidden" name="bbsId" value=<%=request.getParameter("bbsId") %>>
					<textarea rows="7" cols="100" name="comment_content"></textarea>
					<input type="submit" class="btn btn-primary" value="등록">
				</div>
			</form>
	<%
	}
	%>
	<script type="text/javascript">
		jQuery(document).ready(function timeagoNoti() {
				$("time.timeago").timeago();	
			})
	</script>
</body>
</html>