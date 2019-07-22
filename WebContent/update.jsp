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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="writeStyle.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
</head>
<body>
	<%
		int bbsId = Integer.parseInt(request.getParameter("bbsId"));
		String userId = null;
		BbsDAO bbsDAO = new BbsDAO();
		if(session.getAttribute("userId")!=null) {
			userId = (String)session.getAttribute("userId");
		}
		Bbs bbs = bbsDAO.getBbs(bbsId);
		if(!userId.equals(bbs.getUserId())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 작성자만 글을 수정할 수 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
		
		<jsp:include page="navigation.jsp" flush="false">
			<jsp:param name="bbsActiveClass" value="${value}" />
		</jsp:include>
		
		<div class="container">
			<div class="row">
				<form action="updateAction.jsp?bbsId=<%=bbsId %>" method="POST">
					<table class="table table-striped" style="text-align:center; width:800px; margin:auto; border:1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글쓰기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>"></td>
							</tr>
							<tr>
								<td>
									<textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;"><%=bbs.getBbsContent()%>
									</textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="btn btn-primary" value="수정하기">
				</form>
			</div>
		</div>
</body>
</html>