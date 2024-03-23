/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.misproject.dao;

import com.mis.dbc.DBConnection;
import com.misproject.model.Rating;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author 60174
 */
public class RatingDA {
    private PreparedStatement stmt;
    private Connection conn;
    
    public RatingDA() {
        DBConnection dbConnection = new DBConnection();
        conn = dbConnection.getConnection();
    }
    
    public ArrayList<Rating> getRatings() {
        String sql = "SELECT * FROM RATING";
        ArrayList<Rating> ratings = new ArrayList<>();
        
        try {
            stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Rating rating = new Rating();
                rating.setRatingId(rs.getInt("rating_id"));
                rating.setRatingStar(rs.getInt("rating_star"));
                rating.setComment(rs.getString("comment"));
                rating.setMedia(rs.getString("media"));
                rating.setRatingDate(rs.getString("rating_date"));
                rating.setRatingTime(rs.getString("rating_time"));
                
                ratings.add(rating);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return ratings;
    }
}

