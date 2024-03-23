<%-- 
    Document   : viewRating
    Created on : 18 Mar 2024, 9:56:02 pm
    Author     : 60174
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.misproject.controller.RatingControl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.misproject.model.Rating" %>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHPWebPage.php to edit this template
-->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <!--        <link href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css" rel="stylesheet" />-->
        <link href="../css/rating/viewRating.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
        <!--        <script src="../js/RatingReview/viewRatingReview.js" defer></script>-->
        <!--        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <title>Product Ratings</title>
    </head>
    <body>   
        <div class="container mt-5">
            <div class="header text-left">Product Ratings
                <div class="row justify-content-center m-4">
                    <div class="col-md-2">
                        <div class="d-flex flex-column align-items-center">                
                            <p class="avgRate"><b><span id="average_rating">0.0</span></b></p>
                            <div class="d-flex">
                                <i class="fas fa-star star-light mr-1 main_star"></i>
                                <i class="fas fa-star star-light mr-1 main_star"></i>
                                <i class="fas fa-star star-light mr-1 main_star"></i>
                                <i class="fas fa-star star-light mr-1 main_star"></i>
                                <i class="fas fa-star star-light mr-1 main_star"></i>
                            </div>
                            <p class="mt-3 small"><span id="total_review">0 </span> Ratings</p>
                        </div>               
                    </div>

                    <div class="d-flex flex-column col-md-9 justify-content-center">
                        <% for (int i = 5; i>= 1; i--) { %>
                        <div class="row align-items-center">
                            <div class="col-md-1 col-2 text-right star-text"><%= i %></div>
                            <div class="col-md-11 col-10">
                                <div class="progress my-2">
                                    <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="star<%= i %>_progress"></div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <br><br>

                <div id="wrapper">
                    <section>
                        <div class="data-container"></div>
                        <div class="review-box pagination-container" id="review_content"></div>
                    </section>
                </div>
            </div>  

            <!--            <div class="alert alert-warning alert-dismissible fade show display" role="alert">
                            <strong>Holy guacamole!</strong> You should check in on some of those fields below.
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>-->

            <div id="review_modal" class="modal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Your Review</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <h4 class="text-center mt-2 mb-4" id="rate">
                                <i class="fas fa-star star-light submit_star mr-1 org-star" id="submit_star_1" data-rating="1"></i>
                                <i class="fas fa-star star-light submit_star mr-1 org-star" id="submit_star_2" data-rating="2"></i>
                                <i class="fas fa-star star-light submit_star mr-1 org-star" id="submit_star_3" data-rating="3"></i>
                                <i class="fas fa-star star-light submit_star mr-1 org-star" id="submit_star_4" data-rating="4"></i>
                                <i class="fas fa-star star-light submit_star mr-1 org-star" id="submit_star_5" data-rating="5"></i>
                            </h4>
                            <div class="form-group">
                                <textarea name="user_review" id="user_review" class="form-control" placeholder="Share your feelings"></textarea>
                            </div>
                            <div class="form-group text-center mt-4">
                                <button type="button" class="btn btn-primary" id="save_review">Submit</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="show-review" class="modal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">All Reviews</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div id="wrapper" class="modal-body">
                            <div class="reviews-list data-container">
                                <div id="all-reviews" class="all-reviews"></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
        // Instantiate RatingControl
        RatingControl ratingControl = new RatingControl();
        // Get rating data from the controller
        ArrayList<Rating> reviews = ratingControl.getAllRatings();
        int[] ratingStars = ratingControl.getRatingStar(reviews);
        double avgRating = ratingControl.getAvgRating(ratingStars);
        %>

        <script>
            var user_id = 456;
            var movie_id = 123;
            var reviews = [
            <% for (int i = 0; i < reviews.size(); i++) { %>
            { user_name: "User<%= i+1 %>",
                    rating_star: <%= reviews.get(i).getRatingStar() %>,
                    comment: "<%= reviews.get(i).getComment() %>",
                    rating_date: "<%= reviews.get(i).getRatingDate() %>",
                    rating_time: "<%= reviews.get(i).getRatingTime() %>" } <%= (i < reviews.size() - 1) ? "," : "" %>
            <% } %>
            ];

            var data = {
                avg_rating: <%= avgRating %>,
                rating_times: <%= ratingStars[0] %>,
                five_star: <%= ratingStars[1] %>,
                four_star: <%= ratingStars[2] %>,
                three_star: <%= ratingStars[3] %>,
                two_star: <%= ratingStars[4] %>,
                one_star: <%= ratingStars[5] %>
            };

            function load_rating() {
                $('#average_rating').text(data.avg_rating);
                $('#total_review').text(data.rating_times);
                var count_star = 0;

                $('.main_star').each(function () {
                    count_star++;
                    $(this).removeClass('text-warning star-light');
                    if (Math.ceil(data.avg_rating) >= count_star) {
                        $(this).addClass('text-warning');
                        $(this).addClass('star-light');
                    }
                });

                if (data.rating_times === 0) {
                    data.rating_times = 1;
                }

                $('#star5_progress').css('width', (data.five_star / data.rating_times) * 100 + '%');
                $('#star4_progress').css('width', (data.four_star / data.rating_times) * 100 + '%');
                $('#star3_progress').css('width', (data.three_star / data.rating_times) * 100 + '%');
                $('#star2_progress').css('width', (data.two_star / data.rating_times) * 100 + '%');
                $('#star1_progress').css('width', (data.one_star / data.rating_times) * 100 + '%');

//            if (data.reviews.length >= 0) {
//                var i = 0;
//                
//                for (var count = 0; count < data.reviews.length; count++) {
//                    if ((data.reviews[count].comment && i < 15) || (user_id === String(data.reviews[count].user_id) && movie_id === String(data.reviews[count].movie_id))) {
//                        if (user_id === String(data.reviews[count].user_id) && movie_id === String(data.reviews[count].movie_id)) {
//                            i--;
//                        }
//
//                        html += '<div class="review-container">';
//                        html += '<div class="headshot">' + data.reviews[count].user_name.charAt(0) + '</div>';
//                        html += '<div class="user-name"><b>' + data.reviews[count].user_name + '</b></div>';
//                        if (user_id === String(data.reviews[count].user_id)) {
//                            html += '<span class="btnBackground"></span><i class="fas fa-ellipsis-v" id="deletebtn"></i>';
//                            html += '<a id="delete-review">Delete Review</a>';
//                        }
//
//                        html += '</div>';
//                        html += '<div class="rating-info rating-date">';
//                        for (var star = 1; star <= 5; star++) {
//                            var class_name = '';
//                            if (data.reviews[count].rating_star >= star) {
//                                class_name = 'text-warning';
//                            } else {
//                                class_name = 'star-light';
//                            }
//
//                            html += '<i class="fas fa-star ' + class_name + ' mr-1"></i>';
//                        }
//
//                        html += '&nbsp;&nbsp;' + data.reviews[count].rating_date + '</div>';
//
//                        html += '<div class="review-info">' + data.reviews[count].comment;
//                        html += '</div><br>';
//                        i++;
//                    }
//                }
//
//                //$('#review_content').html(html);
//            }

                //renderReviews(data.reviews);
            }

            // 定义一个函数来销毁并重新初始化 pagination 插件
//            function reinitializePagination(pageRange) {
//                $('#review_content').pagination('destroy');
//                $('#review_content').pagination({
//                    dataSource: reviews,
//                    locator: 'items',
//                    pageSize: 3,
//                    pageRange: pageRange
//                });
//            }

            var windowWidth = window.innerWidth;
            var pageSize;
            var pageRange;

            // 根据窗口宽度调整 pageRange 的值
            if (windowWidth < 768) {
                pageSize = 4;
                pageRange = 1;
            } else {
                pageSize = 3;
                pageRange = 2;
            }

            // 监听窗口大小变化事件
            window.addEventListener('resize', function () {
                // 获取当前窗口宽度
                var windowWidth = window.innerWidth;

                // 根据窗口宽度调整 pageRange 的值
                if (windowWidth < 768) {
                    pageSize = 4;
                    pageRange = 1;
                } else {
                    pageSize = 3;
                    pageRange = 2;
                }

                // 重新初始化 pagination 插件
                reinitializePagination(pageSize, pageRange);
            });


            // 定义一个函数来销毁并重新初始化 pagination 插件
            function reinitializePagination(pageSize, pageRange) {
                $('#review_content').pagination('destroy');

                var container = $('.data-container');
                $('#review_content').pagination({
                    dataSource: reviews,
                    locator: 'items',
                    pageSize: pageSize,
                    pageRange: pageRange,
                    callback: function (response, pagination) {
                        var pageStart = (pagination.pageNumber - 1) * pagination.pageSize;
                        var pageEnd = pageStart + pagination.pageSize;
                        var html = '';

                        $.each(response, function (index, item) {
                            html += '<div class="review-container">';
                            html += '<div class="headshot">' + item.user_name.charAt(0) + '</div>';
                            html += '<div class="user-name"><b>' + item.user_name + '</b></div>';
                            html += '</div>';
                            html += '<div class="rating-info rating-date">';

                            for (var star = 1; star <= 5; star++) {
                                var class_name = '';
                                if (item.rating_star >= star) {
                                    class_name = 'text-warning';
                                } else {
                                    class_name = 'star-light';
                                }

                                html += '<i class="fas fa-star ' + class_name + ' mr-1"></i>';
                            }

                            html += '&nbsp;&nbsp;' + item.rating_date + '</div>';

                            html += '<div class="review-info">' + item.comment;
                            html += '</div><br>';
                        });

                        container.html(html);
                    }
                });
            }


            $(function () {
                var container = $('.data-container');

                $('#review_content').pagination({
                    dataSource: reviews,
                    locator: 'items', // 指定数据源中的数组名称
                    pageSize: pageSize,
                    pageRange: pageRange,
                    callback: function (response, pagination) {
                        var pageStart = (pagination.pageNumber - 1) * pagination.pageSize;
                        var pageEnd = pageStart + pagination.pageSize;
                        var html = '';

                        $.each(response, function (index, item) {
                            html += '<div class="review-container">';
                            html += '<div class="headshot">' + item.user_name.charAt(0) + '</div>';
                            html += '<div class="user-name"><b>' + item.user_name + '</b></div>';
                            html += '</div>';
                            html += '<div class="rating-info rating-date">';

                            for (var star = 1; star <= 5; star++) {
                                var class_name = '';
                                if (item.rating_star >= star) {
                                    class_name = 'text-warning';
                                } else {
                                    class_name = 'star-light';
                                }

                                html += '<i class="fas fa-star ' + class_name + ' mr-1"></i>';
                            }

                            html += '&nbsp;&nbsp;' + item.rating_date + '</div>';

                            html += '<div class="review-info">' + item.comment;
                            html += '</div><br>';
                        });

                        container.html(html);
                    }
                });
            });

            // Load reviews on page load
            window.onload = function () {
                load_rating();
            };
        </script>
    </body>
</html>
