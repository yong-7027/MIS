/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.dao.impl;

import com.mis.pojo.Customer;
import com.mis.dbc.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import com.mis.dao.UserDao;

/**
 *
 * @author zheng
 */
public class UserDaoImpl implements UserDao {
    
    @Override
    public Map<String, Object> selectByUserName(String userName) throws SQLException {
        Map<String, Object> result = new HashMap<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM user WHERE user_name = ? LIMIT 1";
        
        try {
            conn = DatabaseUtil.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, userName);
            
            rs = ps.executeQuery();
            while (rs.next()) {
                result.put("user_id", rs.getInt("user_id"));
                result.put("password", rs.getString("password"));
                result.put("user_type", rs.getString("user_type"));
                result.put("verify_status", rs.getInt("verify_status"));
                result.put("last_attempt_time", rs.getInt("last_attempt_time"));
                result.put("life", rs.getInt("life"));
                result.put("account_available", rs.getString("account_available"));
            }
            
            return result;
        } catch (SQLException e) {
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, ps, rs);
        }
    }

    @Override
    public Map<String, Object> selectByToken(String token) throws SQLException {
        Map<String, Object> result = new HashMap<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT verify_token, verify_status FROM user WHERE verify_token = ? LIMIT 1";
        
        try {
            conn = DatabaseUtil.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, token);
            
            rs = ps.executeQuery();
            while (rs.next()) {
                result.put("verify_token", rs.getString("verify_token"));
                result.put("verify_status", rs.getInt("verify_status"));
            }
            
            return result;
        } catch (SQLException e) {
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, ps, rs);
        }
    }
    
    @Override
    public boolean isExists(String columnName, String value) throws SQLException {
        String sql = "SELECT * FROM user WHERE " + columnName + " = ? LIMIT 1";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, value);
            try (ResultSet resultSet = ps.executeQuery()) {
                return resultSet.next();  // return true if exists
            }
        } catch (SQLException e) {
            throw e;
        }
    }
    
    @Override
    public void addCustomer(Customer cust) throws SQLException {
        // This try-with-resources will auto release the resource after using
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement("INSERT INTO user (user_name, email, password, verify_token, join_date) VALUES (?, ?, ?, ?, ?)")) {
            ps.setString(1, cust.getLogin().getUserName());
            ps.setString(2, cust.getEmail());
            ps.setString(3, cust.getLogin().getPassword());
            ps.setString(4, cust.getVerifyToken());
            ps.setDate(5, new java.sql.Date(cust.getJoinDate().getTime()));
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    @Override
    public boolean updateVerifyStatus(String verifyToken) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE user SET verify_status='1' WHERE verify_token = ? LIMIT 1";
        
        try {
            conn = DatabaseUtil.getConnection(); 
            ps = conn.prepareStatement(sql);
            ps.setString(1, verifyToken);
            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;  
        } catch(SQLException e) {
            return false;
        } finally {
            DatabaseUtil.closeAll(conn, ps, null);
        }
    }

    @Override
    public boolean resetLife(String userName) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE user SET life = 5 WHERE user_name = ?";
        
        try {
            conn = DatabaseUtil.getConnection(); 
            ps = conn.prepareStatement(sql);
            ps.setString(1, userName);
            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;  
        } catch(SQLException e) {
            return false;
        } finally {
            DatabaseUtil.closeAll(conn, ps, null);
        }
    }
    
    @Override
    public boolean updateLifeAndTime(int life, long lastAttemptTime, String userName) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE user SET life = ?, last_attempt_time = ? WHERE user_name = ?";
        
        try {
            conn = DatabaseUtil.getConnection(); 
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, life);
            ps.setLong(2, lastAttemptTime);
            ps.setString(3, userName);
            
            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;  
        } catch(SQLException e) {
            return false;
        } finally {
            DatabaseUtil.closeAll(conn, ps, null);
        }
    }
}
