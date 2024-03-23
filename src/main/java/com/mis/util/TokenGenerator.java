/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

/**
 *
 * @author zheng
 */
public class TokenGenerator {
    private TokenGenerator() {
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
            // 处理算法不支持的异常
            e.printStackTrace();
            return null;
        }
    }
}
