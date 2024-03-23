/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.misproject.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author 60174
 */
public class DBConnection {
    private String host = "jdbc:derby://localhost:1527/MIS";
    private String user = "MIS";
    private String password = "12345678";
    private Connection connection;
    
    public DBConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("Cannot find the Derby JDBC's driver.");
            e.printStackTrace();
        }
    }
    
    // Build the DB connection
    public Connection getConnection() {
        try {
            connection = DriverManager.getConnection(host, user, password);
        } catch (SQLException e) {
            System.err.println("Error occur when connect to the database.");
            e.printStackTrace();
        }
        
        return connection;
    }
    
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            System.err.println("Error occur when close the database connection.");
            e.printStackTrace();
        }
    }
}
