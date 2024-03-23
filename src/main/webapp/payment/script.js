/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    var map;
    var geocoder;
    var infowindow;

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: -34.397, lng: 150.644},
            zoom: 15
        });
        geocoder = new google.maps.Geocoder();
        infowindow = new google.maps.InfoWindow();
    }

    document.getElementById('get-location-btn').addEventListener('click', function () {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var location = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };

                geocoder.geocode({'location': location}, function (results, status) {
                    if (status === 'OK') {
                        if (results[0]) {
                            map.setZoom(15);
                            var marker = new google.maps.Marker({
                                position: location,
                                map: map
                            });
                            infowindow.setContent(results[0].formatted_address);
                            infowindow.open(map, marker);
                            document.getElementById('current-location').innerHTML = 'Current Location: ' + results[0].formatted_address;
                        } else {
                            window.alert('No results found');
                        }
                    } else {
                        window.alert('Geocoder failed due to: ' + status);
                    }
                });
            }, function () {
                handleLocationError(true, infowindow, map.getCenter());
            });
        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infowindow, map.getCenter());
        }
    });

    function handleLocationError(browserHasGeolocation, infowindow, pos) {
        infowindow.setPosition(pos);
        infowindow.setContent(browserHasGeolocation ?
            'Error: The Geolocation service failed.' :
            'Error: Your browser doesn\'t support geolocation.');
        infowindow.open(map);
    }

    initMap();
});
