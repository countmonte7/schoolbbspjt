package app.bbs;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import com.mysql.cj.Session;


@WebServlet("/BbsServlet")
public class BbsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public BbsServlet() {
        super();
    
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "view.jsp";
		int bbsId = Integer.parseInt(request.getParameter("bbsId"));
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		BbsDAO dao = new BbsDAO();
		boolean isGet = false;
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			for(Cookie c:cookies) {
				if(c.getName().equals("bbsId-"+bbsId)&& c.getValue().equals(userId)) {
					isGet = true;
				}
			}
		}
		if(!isGet) {
			Cookie c1 = new Cookie("bbsId-"+bbsId, userId);
			c1.setMaxAge(1*12*60*60);
			dao.updateReadCnt(bbsId);
			response.addCookie(c1);
		}
		
		Bbs bbs = dao.getBbs(bbsId);
		request.setAttribute("bbs", bbs);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
