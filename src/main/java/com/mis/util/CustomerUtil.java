/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;

/**
 *
 * @author zheng
 */
public class CustomerUtil {
    private CustomerUtil() {
    }
    
    public static String generateToken(int length) {
        try {
            SecureRandom rand = new SecureRandom();
            
            byte[] randomBytes = new byte[length];
            rand.nextBytes(randomBytes);
 
            // Get MD5 instance
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(randomBytes);
            
            // Process the randomBytes by using MD5
            byte[] digest = md.digest();
            
            StringBuilder token = new StringBuilder();
            for (byte b : digest) {
                // %02 表示以两位十六进制的形式输出，不足两位时在前面补零，
                // x 表示使用小写字母表示十六进制数字
                token.append(String.format("%02x", b));
            }
            
            return token.toString();
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }
    
    public static String generateOTP(int length) {
        StringBuilder otp = new StringBuilder();
        Random random = new Random();
        
        // Make sure the first digit of OTP is not 0
        otp.append(random.nextInt(9) + 1);
        
        // Generate the remaining digits of OTP
        for (int i = 1; i < length; i++) {
            otp.append(random.nextInt(10));
        }
        
        return otp.toString();
    }
}
