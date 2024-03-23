<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.misproject.controller.RatingControl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.misproject.model.Rating" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test</title>   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css" rel="stylesheet" />
</head>
<body>
    <div id="wrapper">
        <section>
            <div class="data-container"></div>
            <div id="review_con"></div>
        </section>
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
        var reviews = [
                    <% for (int i = 0; i < reviews.size(); i++) { %>
                        { user_name: "User<%= i+1 %>",
                          rating_star: <%= reviews.get(i).getRatingStar() %>,
                          comment: "<%= reviews.get(i).getComment() %>",
                          rating_date: "<%= reviews.get(i).getRatingDate() %>",
                          rating_time: "<%= reviews.get(i).getRatingTime() %>" } <%= (i < reviews.size() - 1) ? "," : "" %>                    
                    <% } %>   
                    ];
                    
        console.log(reviews);
        
    $(function() {
    var container = $('.data-container'); 
    $('#review_con').pagination({
        dataSource: reviews,
        locator: 'items', // 指定数据源中的数组名称
        pageSize: 5,
        showSizeChanger: true,
        callback: function(response, pagination) {
            var dataHtml = '<ul>';
            var pageStart = (pagination.pageNumber - 1) * pagination.pageSize;
            var pageEnd = pageStart + pagination.pageSize;
            $.each(response, function (index, item) {
                dataHtml += '<li>' + item.user_name + '</li>'; 
            });
            dataHtml += '</ul>';
            container.html(dataHtml);
        }
    });
});

</script>

</body>
</html>
