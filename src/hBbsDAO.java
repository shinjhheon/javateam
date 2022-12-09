package hbbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import hbbs.hBbs;

public class hBbsDAO {

	private Connection conn; // 자바와 데이터베이스를 연결
	private ResultSet rs; // 결과값 받아오기
	
	public hBbsDAO() {
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
	
	// 작성일자 메소드
	public String getDate() {
		String SQL = "SELECT NOW()"; // 쿼리문
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	// 게시글 번호 부여 메소드
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다.
		String SQL = "SELECT hbbsID FROM hbbs ORDER BY hbbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
		
	}
	
	// 글쓰기 메소드
	public int write(String hbbsTitle, String userID, String hbbsContent) {
		String SQL = "INSERT INTO HBBS VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 	// 게시글 번호
			pstmt.setString(2, hbbsTitle); 	// 글 제목 
			pstmt.setString(3, userID);		// 사용자 ID
			pstmt.setString(4, getDate());	// 게시글 작성일자
			pstmt.setString(5, hbbsContent);	// 게시글 내용
			pstmt.setInt(6, 1);				// 게시글의 유효번호
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	// 게시글 리스트 메소드.
	public ArrayList<hBbs> getList(int pageNumber){
		String SQL = "select * from hbbs where hbbsID < ? and hbbsAvailable = 1 order by hsbbsID desc limit 10";
		ArrayList<hBbs> list = new ArrayList<hBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				hBbs hbbs = new hBbs();
				hbbs.setHbbsID(rs.getInt(1));
				hbbs.setHbbsTitle(rs.getString(2));
				hbbs.setUserID(rs.getString(3));
				hbbs.setHbbsDate(rs.getString(4));
				hbbs.setHbbsContent(rs.getString(5));
				hbbs.setHbbsAvailable(rs.getInt(6));
				list.add(hbbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from hbbs where hbbsID < ? and hbbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public hBbs gethbbs(int bbsID) {
		String SQL = "SELECT * FROM HBBS WHERE hbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				hBbs hbbs = new hBbs();
				hbbs.setHbbsID(bbsID);
				hbbs.setHbbsTitle(rs.getString(2));
				hbbs.setUserID(rs.getString(3));
				hbbs.setHbbsDate(rs.getString(4));
				hbbs.setHbbsContent(rs.getString(5));
				hbbs.setHbbsAvailable(rs.getInt(6));
				return hbbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 게시글 수정 메소드
	public int update(int bbsID, String hbbsTitle, String hbbsContent) {
		String SQL = "update hbbs set hbbsTitle = ?, hbbsContent = ? where hbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, hbbsTitle);
			pstmt.setString(2, hbbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
		
	}
	
	// 게시글 삭제 메소드
	public int delete(int bbsID) {
		// 실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다.
		String SQL = "update hbbs set hbbsAvailable = 0 where hbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
		
	}
	
	public int read(int bbsID)
	{
		PreparedStatement pstmt = null;
		try {
			String SQL = "UPDATE hbbs SET readCount = readCount + 1 WHERE hbbsID = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
