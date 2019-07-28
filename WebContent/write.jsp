<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html; charset=UTF-8">
<link href="writeStyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userId = null;
		int nthValue = 0; //네비게이션 active 클래스 추가를 위해
		if(session.getAttribute("sessionId") != null) {
			userId = (String)session.getAttribute("sessionId");
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
	
		<div class="container">
			<div class="row">
				<form action="writeAction.jsp" method="POST" enctype="multipart/form-data">
					<table class="table table-striped" style="text-align:center; width:800px; border:1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글쓰기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;"></textarea></td>
							</tr>
							<tr>
								<td><input type="file" name="filename"></td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="btn btn-primary" value="글쓰기">
				</form>
			</div>
		</div>
</body>
</html>