package app.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import app.model.DB;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			DB db = new DB();
			conn = db.doConnect();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String sql = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String sql = "SELECT bbsId FROM bbs ORDER BY bbsId DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물의 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String bbsTitle, String userId, String bbsContent) {
		String sql = "INSERT INTO bbs VALUE (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userId);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList(int pageNum) {
		String sql = "SELECT * FROM bbs WHERE bbsId < ? AND bbsAvailable = 1 ORDER BY bbsId DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNum -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsId(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNum) {
		String sql = "SELECT * FROM bbs WHERE bbsId < ? AND bbsAvailable = 1 ORDER BY bbsId DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNum -1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
}