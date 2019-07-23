package app.comment;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/comment.do")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		String content = request.getParameter("comment_content");
		HttpSession session = request.getSession();
		String writer = (String)session.getAttribute("userId");
		int bbsId = 0;
		if(request.getParameter("bbsId")!=null) {
			bbsId = Integer.parseInt(request.getParameter("bbsId"));
		}
		CommentDAO commentDao = CommentDAO.getInstance();
		int result = commentDao.writeComment(bbsId, writer, content);
		if(result==1) {
			RequestDispatcher dis = request.getRequestDispatcher("view.jsp?bbsId="+ bbsId);
			dis.forward(request, response);
		}
		
	}

}
