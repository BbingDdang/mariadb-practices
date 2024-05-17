package driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyDriverTest {

	public static void main(String[] args) {
		Connection connection = null;
		try {
			Class.forName("driver.MyDriver");
			String url = "jdbc:mydb://127.0.0.1:2202/webdb";
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
