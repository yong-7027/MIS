<%-- 
    Document   : pagnitation_test
    Created on : 18 Mar 2024, 7:17:14 pm
    Author     : 60174
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//    // Fetch Limit Data Code
//    int limit = 5;
//    int page = 0;
//    String output = "";
//    if (request.getParameter("page") != null) {
//        page = Integer.parseInt(request.getParameter("page"));
//    } else {
//        page = 1;
//    }
//    
//    int start_from = (page - 1) * limit;
//    String sql = "SELECT * FROM RATING ORDER BY RATING_ID DESC LIMIT start_from, limet";
//    output .= ""
//            + "<div class='table-responsive'>"
//            + "<table class='table'>"
//            + "<tr>"
//            + "<t
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pagination Example</title>
<style>
    .pagination {
        display: flex;
        list-style-type: none;
        padding: 0;
    }
    .pagination li {
        margin-right: 5px;
        cursor: pointer;
        padding: 5px 10px;
        border: 1px solid #ccc;
    }
    .pagination li.active {
        background-color: #007bff;
        color: #fff;
    }
</style>
</head>
<body>
    <div id="content">
        <!-- Pagination will be inserted here -->
    </div>

    <ul class="pagination" id="pagination">
        <!-- Pagination links will be inserted here -->
    </ul>

    <script>
        var currentPage = 1;
        var pageSize = 5; // Number of items per page
        var totalItems = 25; // Total number of items

        function loadPage(page) {
            // Assuming you have an API endpoint to fetch data for the specified page
            // You can replace this with your own AJAX call to fetch data
            console.log('Loading page', page);
            // Here you would make an AJAX request to fetch data for the specified page
            // and update the content and pagination accordingly
            currentPage = page;
            updateContent();
        }

        function updateContent() {
            // Update content based on current page
            var content = document.getElementById('content');
            content.innerHTML = 'Displaying items ' + ((currentPage - 1) * pageSize + 1) + '-' + Math.min(currentPage * pageSize, totalItems) + ' of ' + totalItems;
        }

        function updatePagination() {
            // Update pagination links based on current page
            var pagination = document.getElementById('pagination');
            pagination.innerHTML = '';
            var totalPages = Math.ceil(totalItems / pageSize);
            for (var i = 1; i <= totalPages; i++) {
                var li = document.createElement('li');
                li.textContent = i;
                li.addEventListener('click', function() {
                    loadPage(parseInt(this.textContent));
                });
                if (i === currentPage) {
                    li.classList.add('active');
                }
                pagination.appendChild(li);
            }
        }

        // Initial load
        updateContent();
        updatePagination();
    </script>
</body>
</html>
