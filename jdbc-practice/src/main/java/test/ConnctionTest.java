package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnctionTest {

	public static void main(String[] args) {
		//1. JDBC Driver Loading
		Connection connection = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.64.10:3306/webdb?charset=utf8";
			connection = DriverManager.getConnection(url, "webdb", "webdb");
			
			System.out.println("Success!");
			
		} 
		catch (ClassNotFoundException e) {
		
			System.out.println("드라이버 로딩 실패: " + e);
			
		}
		catch (SQLException e) {
			System.out.println("error:" + e);
		}
		finally {
			try {
				if(connection != null) {
					connection.close();
				}
				
			}
			catch (SQLException e) {
				System.out.println("error : " + e);
			}
		}
		
		
	}
	
	
}
