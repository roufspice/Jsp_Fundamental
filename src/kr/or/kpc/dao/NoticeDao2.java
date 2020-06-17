package kr.or.kpc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.or.kpc.dto.NoticeDto;
import kr.or.kpc.dto.NoticeDto2;
import kr.or.kpc.util.ConnLocator;

public class NoticeDao2 {
	
	public static NoticeDao2 dao;
	private NoticeDao2() {}
	public static NoticeDao2 getInstance() {
		if(dao== null) {
			dao = new NoticeDao2();
			
		}
		return dao;
		
	}
	
	public int insert(NoticeDto2 dto) {
		int resultCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnect();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO notice(n_num, n_writer, n_title, n_content, n_regdate) ");
			sql.append("VALUES(?, ?,?,?,NOW()) ");
			//sql.append("");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;
			pstmt.setInt(++index, dto.getNum());
			pstmt.setString(++index, dto.getWriter());
			pstmt.setString(++index, dto.getTitle());
			pstmt.setString(++index, dto.getContent());

			resultCount = pstmt.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		
		
		return resultCount;
	}
	
	
	public int update(NoticeDto2 dto) {
		int resultCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnect();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE notice ");
			sql.append("SET n_writer=?, n_title=?, n_content=?, n_regdate = NOW() ");
			sql.append("WHERE n_num = ? ");
			

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;
			pstmt.setString(++index, dto.getWriter());
			pstmt.setString(++index, dto.getTitle());
			pstmt.setString(++index, dto.getContent());
			pstmt.setInt(++index, dto.getNum());
			

			resultCount = pstmt.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return resultCount;
		
			}
	
	
	public int delete(int num) {
		int resultCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnect();
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM notice ");
			sql.append("WHERE n_num = ? ");
			

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;
			pstmt.setInt(++index, num);
			

			resultCount = pstmt.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return resultCount;
		
	}
	
	public ArrayList<NoticeDto2> select(int start, int len) {
		ArrayList<NoticeDto2> list = new ArrayList<NoticeDto2>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnect();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT n_num, n_writer, n_title, n_content, ");
			sql.append("DATE_FORMAT(n_regdate,'%Y.%m.%d %h:%i') ");
			sql.append("FROM notice ");
			sql.append("ORDER BY n_num DESC ");
			sql.append("LIMIT ? , ? ");
			

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;

			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				index = 0;
				int num = rs.getInt(++index);
				String writer = rs.getString(index++);
				String title = rs.getString(index++);
				String content = rs.getString(index++);
				String regdate = rs.getString(index++);
				

				list.add(new NoticeDto2(num, writer, title, content, regdate));
			}

		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

		}
		return list;
	}
	
	public NoticeDto2 select(int num) {
		NoticeDto2 dto = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnect();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT n_num, n_writer, n_title, n_content, ");
			sql.append("DATE_FORMAT(n_regdate,'%Y.%m.%d %h:%i') ");
			sql.append("FROM notice ");
			sql.append("WHERE n_num = ? ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;

			pstmt.setInt(++index, num);
			

			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = 0;
				int _num = rs.getInt(++index);
				String writer = rs.getString(++index);
				String title = rs.getString(++index);
				String content = rs.getString(++index);
				String regdate = rs.getString(++index);
				

				dto = new NoticeDto2(_num, writer, title, content, regdate);
			}

		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

		}
		return dto;
	}
	
	public int getRows() {
		int count = 0 ;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnect();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(*) FROM notice");
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				count = rs.getInt(++index);
			}
			
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
		}
		return count;
	}
	public int getMaxNum() {
		int max = 0 ;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnect();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT ifnull(MAX(n_num)+1,1) FROM notice");
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				max = rs.getInt(++index);
			}
			
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
		}
		return max;
	}

}
