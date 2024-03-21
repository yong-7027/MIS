<%-- 
    Document   : payment-method
    Created on : 13 Mar 2024, 7:04:13 pm
    Author     : 60174
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : payment
    Created on : 13 Mar 2024, 6:57:42 pm
    Author     : 60174
--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="../css/payment/payment-method.css" rel="stylesheet" type="text/css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="jquery.backDetect.js"></script>
    <title>MIS</title>
</head>
<body>     
    <h1>Payment Method</h1>
    <div class="flex-container">
        <div class="buyDetails" onclick="toggleArrow(); dropdownActive()">
            Purchase Details <span class="arrow"></span>
        </div>   
        <div class="dropdown">
            <table class="table"> 
                <tr>
                    <td colspan="3">TICKETS</td>
                </tr>
                <%-- Here you can embed Java code to retrieve data from server-side --%>
                <%-- Replace $_SESSION with Java equivalent to retrieve session data --%>
                <%-- Replace PHP echo with Java out.print to display dynamic content --%>
                <tr class='row-2'>
                    <td>Adult</td>                        
                    <td>(RM<%= session.getAttribute("adultTicket_Price") %> x <%= session.getAttribute("adultQty") %>)</td>
                    <td>RM<%= session.getAttribute("adult_total") %></td>
                </tr>
                <tr class='row-3'>
                    <td>Child</td>                        
                    <td>(RM<%= session.getAttribute("childTicket_Price") %> x <%= session.getAttribute("childQty") %>)</td>
                    <td>RM<%= session.getAttribute("child_total") %></td>
                </tr>
                <tr>
                    <td colspan="3"><hr></td>
                </tr>           
                <tr class="row-5">
                    <td colspan="2">Sub Total</td>
                    <td>RM<%= session.getAttribute("total") %></td>
                </tr>
                <tr>
                    <td colspan="3"><hr></td>
                </tr>
                <tr class="row-7">
                    <td colspan="2">Processing Fee</td>
                    <td>RM<%= session.getAttribute("processing_fee") %></td>
                </tr>
                <tr>
                    <td colspan="2">Total</td>
                    <td>RM<%= session.getAttribute("total_price") %></td>
                </tr>
            </table> 
        </div>
           
        <div class="button-container">
            <button type="button" value="Paypal" name="paypal" class="paypal" onclick="location='paypal.jsp'">
                <img src="../images/payment/paypal-logo.png" alt="paypal" width="120px" height="43px" />
            </button>
            
            <button type="button" value="Debit or Credit Card" name="card" class="card" onclick="location='stripe.jsp'">
                <img src="../images/payment/credit2.png" alt="credit" class="credit" />
                <img src="../images/payment/debit-logo.png" alt="debit" class="debit" />
                <span class="text">Debit or Credit Card</span>                   
            </button>              
        </div>
    </div>
        
    <script>            
        function toggleArrow(){
            var arrow = document.querySelector(".arrow");
            arrow.classList.toggle("active"); 
        }
    
        function dropdownActive(){
            var dropdown = document.querySelector(".dropdown");
            dropdown.classList.toggle("dropdown-active");          
        }  
    
        // Press the current state into the browser's history when the page is loaded
        window.history.pushState({fromHistory: false}, '');

        // When the user clicks the Continue button, the current state is pressed into the browser's history
        document.querySelector('button').addEventListener('click', function() {
            window.history.pushState({fromHistory: false}, '');
        });
    </script>
</body>
</html>


