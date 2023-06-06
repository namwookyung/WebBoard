package wb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class WbDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	// 기본
	public WbDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/WB";
			String dbID = "root";
			String dbPassword = "nwk951207@";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 작성일자
	public String getDate() {
		String sql = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";	// 데이터베이스 오류
	}
	
	// 게시글 번호 부여
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구함
		String sql = "select wbID from wb order by wbID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;	// 첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	// 글쓰기
	public int write(String wbTitle, String userID, String wbContent) {
		String sql = "insert into wb value(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, wbTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, wbContent);
			pstmt.setInt(6, 1);	// 글의 유효번호
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	// 게시글 리스트
	public ArrayList<Wb> getList(int pageNumber) {
		String sql = "select * from wb where wbID < ? and wbAvailable = 1 order by wbID desc limit 10";
		ArrayList<Wb> list = new ArrayList<Wb>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Wb wb = new Wb();
				wb.setWbID(rs.getInt(1));
				wb.setWbTitle(rs.getString(2));
				wb.setUserID(rs.getString(3));
				wb.setWbDate(rs.getString(4));
				wb.setWbContent(rs.getString(5));
				wb.setWbAvailable(rs.getInt(6));
				list.add(wb);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리
	public boolean nextPage(int pageNumber) {
		String sql = "select * from wb where wbID < ? and wbAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 게시글 상세
	public Wb getWb(int wbID) {
		String sql = "select * from wb where wbID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wbID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Wb wb = new Wb();
				wb.setWbID(rs.getInt(1));
				wb.setWbTitle(rs.getString(2));
				wb.setUserID(rs.getString(3));
				wb.setWbDate(rs.getString(4));
				wb.setWbContent(rs.getString(5));
				wb.setWbAvailable(rs.getInt(6));
				return wb;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 게시글 수정
	public int update(int wbID, String wbTitle, String wbContent) {
		String sql = "update wb set wbTitle = ?, wbContent = ? where wbID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, wbTitle);
			pstmt.setString(2, wbContent);
			pstmt.setInt(3, wbID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	// 게시글 삭제
	public int delete(int wbID) {
		// 실제 데이터를 삭제하는 것이 아니라 게시글 유효 숫자를 '0'으로 수정함
		String sql = "update wb set wbAvailable = 0 where wbID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wbID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
}
