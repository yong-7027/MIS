/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.service;

import com.mis.pojo.Login;
import java.io.IOException;

/**
 *
 * @author zheng
 */
public interface LoginService {
    public String processLogin(Login loginInfo) throws IOException;
}
