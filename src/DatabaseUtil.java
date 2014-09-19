package tunebazaar;

import java.sql.*;

/**
 *
 * @author Mike Iserman
 */
public class DatabaseUtil {
    
    private static Connection connection;
    
    // use for group project server
    private static final String ConnectionString = "jdbc:mysql://localhost:3306/tune_bazaar";
    private static final String user = "miserman";
    private static final String pwd = "NgxTy88";
    
//    private static final String user = "root";
//    private static final String pwd = "Password";
    
    public static Connection createConnection() {       
       
        System.out.println("Creating database connection...");

        String driverName = "com.mysql.jdbc.Driver";
        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException ex) {
            System.out.println(ex.getMessage());
        }
        
        try {
           connection = DriverManager.getConnection(ConnectionString, user, pwd);
        } catch (SQLException ex) {
            System.out.println("Error - Creating database connection...");
            System.out.println(ex.getMessage());
        }

        return connection;

    }
    
}
