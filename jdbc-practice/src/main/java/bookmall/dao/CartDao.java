package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookshop.vo.BookVo;

public class CartDao {
	
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.64.10:3306/bookmall?charset=utf8";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		}
		
		return conn;
	}

	public int insert(CartVo vo) {
		int result = 0;

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt1 = conn.prepareStatement("insert into cart(user_no, book_no, quantity) values(?, ?, ?)");
			//PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
		) {
			pstmt1.setLong(1, vo.getUserNo());
			pstmt1.setLong(2, vo.getBookNo());
			pstmt1.setLong(3, vo.getQuantity());
			result = pstmt1.executeUpdate();
			
			//ResultSet rs = pstmt2.executeQuery();
//			vo.setNo(rs.next() ?  rs.getLong(1) : null);
			//rs.close();
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;	
		
	}

	public List<CartVo> findByUserNo(Long no) {
		List<CartVo> result = new ArrayList<>();
		ResultSet rs = null;
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("select c.user_no, b.no, b.title, c.quantity from book b, cart c where c.book_no = b.no and c.user_no = ?");
			
		) {
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				System.out.println("*");
				Long userNo = rs.getLong(1);
				Long bookNo = rs.getLong(2);
				String bookTitle = rs.getString(3);
				int quantity = rs.getInt(4);
				
				
				CartVo vo = new CartVo();
				vo.setBookTitle(bookTitle);
				vo.setQuantity(quantity);
				vo.setUserNo(userNo);
				vo.setBookNo(bookNo);
				
				result.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			 
			try {
				if (rs != null) {
					rs.close();	
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		
		}
		
		
		return result;
		
	}

	public int deleteByUserNoAndBookNo(Long user_no, Long book_no) {
		int result = 0;

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("delete from cart where user_no = ? and book_no = ?");
		) {
			pstmt.setLong(1, user_no);
			pstmt.setLong(2, book_no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;	
		
	}
}
