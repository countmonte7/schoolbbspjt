<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>comment</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
</head>
<body>
	<form action="insertCommentAction.jsp" method="post">
		<div id="comment_box">
			<textarea rows="7" cols="100" name="comment_content"></textarea>
			<input type="submit" class="btn btn-primary" value="등록">
		</div>
	</form>
</body>
</html>