/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.util;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;
import jakarta.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author zheng
 */
public class RequestUtil {

    private RequestUtil() {
    }

    public static String getBody(HttpServletRequest request) throws IOException {
        String body;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        try {
            InputStream inputStream = request.getInputStream();
            System.out.println("InputStream: " + inputStream);
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                String line;
                while ((line = bufferedReader.readLine()) != null) {
                    // 忽略掉分隔符
                    if (!line.startsWith("------")) {
                        stringBuilder.append(line).append("\n");
                    }
                }
            }
        } catch (IOException ex) {
            // throw ex;
            return "";
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {

                }
            }
        }

        body = stringBuilder.toString().trim();

        System.out.println("Body: " + body);
        
        return body;
        
//        JsonObject jsonObject = JsonParser.parseString(body).getAsJsonObject();
//        
//        System.out.println("Json: " + jsonObject);
//
//        return jsonObject;
    }
    
    public static String convertFormDataToJson(String formData) {
        JSONArray jsonArray = new JSONArray();
        String[] lines = formData.split("\n");
        JSONObject currentObject = null;

        for (String line : lines) {
            if (line.startsWith("Content-Disposition: form-data; name=")) {
                // 新字段开始
                if (currentObject != null) {
                    jsonArray.put(currentObject); // 添加上一个字段
                }
                currentObject = new JSONObject(); // 创建新的 JSON 对象
                String fieldName = line.split("name=\"")[1].replace("\"", ""); // 提取字段名
                currentObject.put("name", fieldName); // 添加字段名到 JSON 对象
            } else {
                // 读取字段值
                currentObject.put("value", line.trim()); // 添加字段值到 JSON 对象
            }
        }

        if (currentObject != null) {
            jsonArray.put(currentObject); // 添加最后一个字段
        }

        return jsonArray.toString(); // 返回 JSON 数组字符串
    }
}
