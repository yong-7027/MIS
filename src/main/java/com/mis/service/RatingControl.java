/*
 * This class represents the controller for managing ratings.
 */
package com.mis.service;

import com.google.gson.Gson;
import com.misproject.dao.RatingDA;
import com.misproject.model.Rating;
import java.util.ArrayList;

/**
 * Controller class for managing ratings.
 * 
 * This class provides methods to retrieve ratings from the data access layer,
 * calculate various statistics such as the number of ratings for each star,
 * and calculate the average rating.
 * 
 * @author 60174
 */
public class RatingControl {

    private RatingDA ratingDA;

    public RatingControl() {
        ratingDA = new RatingDA();
    }

    /**
     * Retrieves all ratings from the data access layer.
     * 
     * @return An ArrayList containing all ratings.
     */
    public ArrayList<Rating> getAllRatings() {
        return ratingDA.getRatings();
    }

    /**
     * Calculates the number of ratings for each star.
     * 
     * @param ratings An ArrayList containing the ratings for which the star counts will be calculated.
     * @return An integer array containing the count of ratings for each star.
     *         The array follows the format: {totalRatings, fiveStar, fourStar, threeStar, twoStar, oneStar}.
     */
    public int[] getRatingStar(ArrayList<Rating> ratings) {
        int totalRatingTimes = 0;
        int fiveStar = 0;
        int fourStar = 0;
        int threeStar = 0;
        int twoStar = 0;
        int oneStar = 0;  

        for (Rating rating : ratings) {
            totalRatingTimes++;
            int ratingStar = rating.getRatingStar();
            switch (ratingStar) {
                case 5:
                    fiveStar++;
                    break;
                case 4:
                    fourStar++;
                    break;
                case 3:
                    threeStar++;
                    break;
                case 2:
                    twoStar++;
                    break;
                case 1:
                    oneStar++;
                    break;
                default:
                    break;
            }
        }
        
        int[] ratingStars = {totalRatingTimes, fiveStar, fourStar, threeStar, twoStar, oneStar};
        return ratingStars;
    }
    
    /**
     * Calculates the average rating based on the counts of ratings for each star.
     * 
     * @param ratingStars An integer array containing the count of ratings for each star.
     *                    The array follows the format: {totalRatings, fiveStar, fourStar, threeStar, twoStar, oneStar}.
     * @return The average rating.
     */
    public double getAvgRating(int[] ratingStars) {
        int totalRatingTimes = ratingStars[0];
        int fiveStar = ratingStars[1];
        int fourStar = ratingStars[2];
        int threeStar = ratingStars[3];
        int twoStar = ratingStars[4];
        int oneStar = ratingStars[5];
        
        double avgRating = (5 * fiveStar + 4 * fourStar + 3 * threeStar + 2 * twoStar + 1 * oneStar) / (double) totalRatingTimes;
        return avgRating;
    }
}
