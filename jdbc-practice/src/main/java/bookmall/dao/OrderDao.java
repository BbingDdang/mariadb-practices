package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;
import bookshop.vo.BookVo;

public class OrderDao {
	
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

	public int insert(OrderVo vo) {
		int result = 0;

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt1 = conn.prepareStatement("insert into orders(user_no, number, payment, shipping, status) values(?, ?, ?, ?, ?)");
			PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
		) {
			pstmt1.setLong(1, vo.getUserNo());
			pstmt1.setString(2, vo.getNumber());
			pstmt1.setInt(3, vo.getPayment());
			pstmt1.setString(4, vo.getShipping());
			pstmt1.setString(5, vo.getStatus());
			result = pstmt1.executeUpdate();
			
			ResultSet rs = pstmt2.executeQuery();
			vo.setNo(rs.next() ?  rs.getLong(1) : null);
			System.out.println(vo.getNo());
			rs.close();
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;	
		
	}
	
	public int insertBook(OrderBookVo vo) {
		int result = 0;

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt1 = conn.prepareStatement("insert into orders_books(order_no, book_no, quantity, price) values(?, ?, ?, ?)");
			//PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
		) {
			
			pstmt1.setLong(1, vo.getOrderNo());
			pstmt1.setLong(2, vo.getBookNo());
			pstmt1.setInt(3, vo.getQuantity());
			pstmt1.setLong(4, vo.getPrice());
			result = pstmt1.executeUpdate();
			
//			ResultSet rs = pstmt2.executeQuery();
//			vo.setNo(rs.next() ?  rs.getLong(1) : null);
//			rs.close();
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;	
		
	}

	public OrderVo findByNoAndUserNo(Long no, Long user_no) {
		OrderVo vo = null;
		ResultSet rs = null;
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("select no, number, payment, shipping, status, user_no from orders where no = ? and user_no = ? order by no desc");
			
		) {
			pstmt.setLong(1, no);
			pstmt.setLong(2, user_no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Long no1 = rs.getLong(1);
				String number = rs.getString(2);
				int payment = rs.getInt(3);
				String shipping = rs.getString(4);
				String status = rs.getString(5);
				Long userNo = rs.getLong(6);
				
				vo = new OrderVo();
				vo.setNo(no1);
				vo.setNumber(number);
				vo.setPayment(payment);
				vo.setShipping(shipping);
				vo.setStatus(status);
				vo.setUserNo(userNo);
				
				
			}
		} 
		catch (SQLException e) {
			System.out.println("error:" + e);
		} 
		finally {
			try {
				if(rs != null) {
					rs.close();
				}
			} 
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		return vo;
		
	}
	
	public List<OrderBookVo> findBooksByNoAndUserNo(Long no, Long user_no) {
		List<OrderBookVo> result = new ArrayList<>();
		ResultSet rs = null;
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("select o.no, ob.quantity, ob.price, b.no, b.title from orders o, orders_books ob, book b where ob.order_no = o.no and ob.book_no = b.no and o.no = ? and o.user_no = ?");
			
		) {
			pstmt.setLong(1, no);
			pstmt.setLong(2, user_no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Long orderNo = rs.getLong(1);
				int quantity = rs.getInt(2);
				int price = rs.getInt(3);
				Long bookNo = rs.getLong(4);
				String title = rs.getString(5);
				
				
				OrderBookVo vo = new OrderBookVo();
				vo.setOrderNo(orderNo);
				vo.setQuantity(quantity);
				vo.setPrice(price);
				vo.setBookNo(bookNo);
				vo.setBookTitle(title);
				
				
				result.add(vo);
			}
		} 
		catch (SQLException e) {
			System.out.println("error:" + e);
		} 
		finally {
			try {
				if(rs != null) {
					rs.close();
				}
			} 
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}

	public int deleteByNo(Long no) {
		int result = 0;

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("delete from orders where no = ?");
		) {
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;	
		
	}

	public int deleteBooksByNo(Long no) {
		int result = 0;

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("delete from orders_books where order_no = ?");
		) {
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;	
		
	}

	

	
}
