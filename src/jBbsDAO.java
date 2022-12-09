package jbbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import jbbs.jBbs;

public class jBbsDAO {
	private Connection conn; // 자바와 데이터베이스를 연결
	private ResultSet rs; // 결과값 받아오기
	
	public jBbsDAO() {
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
		String SQL = "SELECT jbbsID FROM jbbs ORDER BY jbbsID DESC";
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
	public int write(String jbbsTitle, String userID, String jbbsContent) {
		String SQL = "INSERT INTO JBBS VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 	// 게시글 번호
			pstmt.setString(2, jbbsTitle); 	// 글 제목 
			pstmt.setString(3, userID);		// 사용자 ID
			pstmt.setString(4, getDate());	// 게시글 작성일자
			pstmt.setString(5, jbbsContent);	// 게시글 내용
			pstmt.setInt(6, 1);				// 게시글의 유효번호
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	// 게시글 리스트 메소드.
	public ArrayList<jBbs> getList(int pageNumber){
		String SQL = "select * from jbbs where jbbsID < ? and jbbsAvailable = 1 order by jbbsID desc limit 10";
		ArrayList<jBbs> list = new ArrayList<jBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				jBbs jbbs = new jBbs();
				jbbs.setJbbsID(rs.getInt(1));
				jbbs.setJbbsTitle(rs.getString(2));
				jbbs.setUserID(rs.getString(3));
				jbbs.setJbbsDate(rs.getString(4));
				jbbs.setJbbsContent(rs.getString(5));
				jbbs.setJbbsAvailable(rs.getInt(6));
				list.add(jbbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from jbbs where jbbsID < ? and jbbsAvailable = 1";
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
	
	public jBbs getjbbs(int bbsID) {
		String SQL = "SELECT * FROM JBBS WHERE jbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				jBbs jbbs = new jBbs();
				jbbs.setJbbsID(bbsID);
				jbbs.setJbbsTitle(rs.getString(2));
				jbbs.setUserID(rs.getString(3));
				jbbs.setJbbsDate(rs.getString(4));
				jbbs.setJbbsContent(rs.getString(5));
				jbbs.setJbbsAvailable(rs.getInt(6));
				return jbbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 게시글 수정 메소드
	public int update(int bbsID, String jbbsTitle, String jbbsContent) {
		String SQL = "update jbbs set jbbsTitle = ?, jbbsContent = ? where jbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, jbbsTitle);
			pstmt.setString(2, jbbsContent);
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
		String SQL = "update jbbs set jbbsAvailable = 0 where jbbsID = ?";
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
			String SQL = "UPDATE jbbs SET readCount = readCount + 1 WHERE jbbsID = ?";
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
