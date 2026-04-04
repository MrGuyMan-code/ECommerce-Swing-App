/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ecommerceapp;

import java.sql.*;

/**
 *
 * @author desktop
 */
public class DatabaseConnection {
    private static final String URL = "jdbc:mariadb://localhost:3306/ecommerce_db?allowPublicKeyRetrieval=true&useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "1234"; // Put your password here
    
    private static Connection connection = null;
    
    public static Connection getConnection() {
        if (connection == null) {
            try {
                // EXPLICITLY REGISTER THE DRIVER - ADD THIS LINE!
                Class.forName("org.mariadb.jdbc.Driver");
                
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("✅ Connected to database!");
            } catch (ClassNotFoundException e) {
                System.out.println("❌ Driver not found: " + e.getMessage());
            } catch (SQLException e) {
                System.out.println("❌ Connection failed: " + e.getMessage());
            }
        }
        return connection;
    }
    
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("🔌 Connection closed");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Test the connection
    public static void main(String[] args) {
        getConnection();
    }

}
