<%-- 
    Document   : pagnitation
    Created on : 18 Mar 2024, 7:02:23 pm
    Author     : 60174
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
        <link rel="stylesheet" href="../css/RatingReview/pagnitation.css" />
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card-body">
                        <h2 class="text-center text-primary">Ajax Make Pagnitation using JQuery, Java & MySQL</h2>
                        <div id="get_data"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script type="text/javascript">
            function fetch_data(page) {
                $.ajax({
                    url: "pagnitaion_test.jsp",
                    method: "POST",
                    data: {
                        page: page
                    },
                    success: function(data) {
                        $("#get_data").html(data);
                    }
                });
            }
            fetch_data();
            
            $(document).on("click", ".page-item", function(){
                var page = $(this).attr("id");
                fetch_data(page);
            });
        </script>
    </body>
</html>

