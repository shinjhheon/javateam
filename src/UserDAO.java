package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; // 자바와 데이터베이스를 연결
	private PreparedStatement pstmt; // 쿼리문 대기 및 설정
	private ResultSet rs; // 결과값 받아오기
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/vvs";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인 기능을 담당하는 메소드
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	// 회원가입 기능을 담당하는 메소드
	public int join(User user) {
		String sql = "INSERT INTO USER (userID,userPassword,userName,userGender,userEmail) VALUES(?, ?, ?, ?, ?)";
		// user 테이블에 데이터를 입력하는 쿼리문
		try {
			pstmt = conn.prepareStatement(sql); // SQL 쿼리문을 대기시킨다.
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public String findID(String userName, String userEmail)
	{
		String SQL = "SELECT userID FROM USER WHERE userName = ? AND userEmail = ?";

		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				return rs.getString(1);	
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;	
	}
	
	public int findPwd(String userID, String userEmail)
	{
		String SQL = "SELECT * FROM USER WHERE userID = ? AND userEmail = ?";	
		try	
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);		
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next())
				return 1; 
			else
				return -1;	
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -2; 
	}
		
	public int changePwd(String userPassword, String userID)
	{
		String SQL = "UPDATE USER SET userPassword = ? WHERE userID = ?";
		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1; 	
	}
}
