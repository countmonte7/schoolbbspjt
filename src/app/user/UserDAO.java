package app.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import app.model.DB;



public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			DB db = new DB();
			conn = db.doConnect();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userId, String userPw) {
		String sql = "SELECT userPw from user WHERE userId=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPw)) {
					return 1; //로그인 성공
				}else {
					return 0; //비밀번호 불일치
				}
			}else {
				return -1; //아이디 존재하지 않음
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int signup(User user) {
		String sql = "INSERT INTO user VALUES (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPw());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setInt(5, user.getStudentCode());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
