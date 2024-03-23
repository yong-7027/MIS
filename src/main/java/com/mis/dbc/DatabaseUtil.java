/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.dbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author zheng
 */
public class DatabaseUtil {

    private static final String DB_URL = "jdbc:derby://localhost:1527/MIS";
    private static final String DB_UNAME = "MIS";
    private static final String DB_PSD = "12345678";
    // Use the Druid data source

    // private constructor to prevent instantiation
    private DatabaseUtil() {
    }

    public static Connection getConnection() throws SQLException {
        // 获取连接
        return DriverManager.getConnection(DB_URL, DB_UNAME, DB_PSD);
    }

    public static void closeAll(Connection conn, Statement stmt, ResultSet rs) throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
}
