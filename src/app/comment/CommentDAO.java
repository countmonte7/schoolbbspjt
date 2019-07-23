package app.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import app.model.DB;

public class CommentDAO {
	
	private Connection conn;
	private static CommentDAO dao = new CommentDAO();
	public static CommentDAO getInstance() {
		return dao;
	}
	
	public CommentDAO() {
		try {
			DB db = new DB();
			conn = db.doConnect();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext() {
		String sql = "SELECT commentId FROM comment ORDER BY commentId DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물의 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String getDate() {
		String sql = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	
	public int writeComment(int bbsId, String writer, String comment_content) {
		String sql = "INSERT INTO comment VALUES (?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, bbsId);
			pstmt.setString(3, writer);
			pstmt.setString(4, comment_content);
			pstmt.setString(5, getDate());
			int result = pstmt.executeUpdate();
			if(result == 1) {
				return result;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Comment> getCommentList(int bbsId) {
		ArrayList<Comment> list = new ArrayList<>();
		String sql = "SELECT * FROM comment WHERE bbsId = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment commentVO = new Comment();
				commentVO.setCommentId(rs.getInt(1));
				commentVO.setBbsId(rs.getInt(2));
				commentVO.setWriter(rs.getString(3));
				commentVO.setComment_content(rs.getString(4));
				commentVO.setComment_datetime(rs.getString(5));
				list.add(commentVO);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	

}
