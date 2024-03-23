<%-- 
    Document   : address
    Created on : 16 Mar 2024, 10:50:16 pm
    Author     : 60174
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Current Location</title>
     引入 Leaflet 库 
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <style>
        /* 设置地图容器的大小 */
        #map {
            height: 400px;
        }
    </style>
</head>
<body>
     地图容器 
    <div id="map"></div>
     显示地址的元素 
    <div id="address"></div>

    <script>
        // 初始化地图对象
        var map = L.map('map');

        // 添加瓦片图层
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // 尝试获取当前位置
        navigator.geolocation.getCurrentPosition(function(position) {
            var latlng = L.latLng(position.coords.latitude, position.coords.longitude);

            // 在地图上添加一个标记表示当前位置
            L.marker(latlng).addTo(map)
                .bindPopup('Your current location').openPopup();

            // 使用地理编码服务获取地址
            fetch('https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=' + position.coords.latitude + '&lon=' + position.coords.longitude)
                .then(response => response.json())
                .then(data => {
                    // 提取详细地址
                    var address = data.display_name;

                    // 将地址信息显示在页面上
                    document.getElementById('address').innerText = 'Your current address: ' + address;
                })
                .catch(error => {
                    console.error('Error getting address:', error);
                });

            // 将地图的视图设置到当前位置
            map.setView(latlng, 15);
        }, function(error) {
            console.error('Error getting geolocation:', error);
        });
    </script>
</body>
</html>-->

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Get Current Location</title>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBOti4mM-6x9WDnZIjIeyEU21OpBXqWBgw&libraries=places"></script>
    <iframe src="https://maps.google.com/maps?q=Tangesir%20Dates%20Products&amp;t=&amp;z=13&amp;ie=UTF8&amp;iwloc=&amp;output=embed" width=300 height=150 allowfullscreen></iframe>
</head>
<body>
    <!-- Your HTML content here -->
    <div id="map"></div>
    <button id="get-location-btn">Get Current Location</button>
    <div id="current-location"></div>

    <script src="script.js"></script>
</body>
</html>
