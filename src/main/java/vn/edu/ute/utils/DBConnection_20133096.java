package vn.edu.ute.utils;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection_20133096 {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=BookStore;encrypt=false;";
    private static final String USER = "sa"; 
    private static final String PASS = "sa"; 

    public static Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}