<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.Enumeration" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userId = null;
		String filesysname = null;
		MultipartRequest multi = null;
		String bbsTitle = null;
		String bbsContent = null;
		//세션 아이디 존재 검증
		if(session.getAttribute("sessionId") != null) {
			userId = (String)session.getAttribute("sessionId");
		}
		if(userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해야 글을 쓸 수 있습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		ServletContext context = getServletContext();
		String realFolder = context.getRealPath("/img");
		System.out.println(realFolder);
		int sizeLimit = 1024*1024*15;
		multi = new MultipartRequest(request, realFolder, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames();
		String str = (String)files.nextElement();
		if(str!=null) {
			filesysname = multi.getFilesystemName(str);
		}
		//게시판 제목과 내용 가져오기
		bbsTitle = multi.getParameter("bbsTitle");
		bbsContent = multi.getParameter("bbsContent");
		//null 검증	
		if(userId!=null) {
			if(bbsTitle == null || bbsTitle.equals("") || 
					bbsContent==null || bbsContent.equals("")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbsTitle, userId, bbsContent, filesysname);
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