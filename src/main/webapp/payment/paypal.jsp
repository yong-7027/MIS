<%-- 
    Document   : paypal
    Created on : 13 Mar 2024, 9:17:35 pm
    Author     : 60174
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../css/payment/paypal.css" rel="stylesheet" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container"> 
        <div class="checkout">Checkout</div><br></h2>            
        <div class="flex1">   
            <form action="invoice.jsp" method="POST" id="payment-form">                                   
                <table class="table1">                           
                    <tr>
                        <td>
                            <script src="https://www.paypal.com/sdk/js?client-id=AbFfpSQKEcoGRn3A7oOOH-M5pj9qxTypGhSkYSKi6DHEW4sNaHeNtupC7JMs6lcMIb9NsZRQWVvNg4wI"></script>
                            
                            <!-- Set up a container element for the button -->
                            <div id="paypal-button-container"></div>
                        </td>
                    </tr>
                </table>     
            </form>
        </div>
                 
        <% 
//        int movie_id = (int) session.getAttribute("movie_id");
//        int user_id = (int) session.getAttribute("user_id");
//        String booking_date = (String) session.getAttribute("booking_date");
//        String booking_time = (String) session.getAttribute("booking_time");
//        int childTicket_Qty = (int) session.getAttribute("childQty");
//        int adultTicket_Qty = (int) session.getAttribute("adultQty");
//        String booking_status = "PENDING";
//        
//        Connection con = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//        
//        try {
//            con = DriverManager.getConnection(DB_HOST, DB_USER, DB_PASS, DB_NAME);
//            
//            String sql = "SELECT * FROM TICKET T, BOOKING B, MOVIE M, HALL H, CINEMA C " +
//                         "WHERE T.BOOKING_ID = B.BOOKING_ID " +
//                         "AND T.MOVIE_ID = M.ID " +
//                         "AND T.HALL_ID = H.HALL_ID " +
//                         "AND H.CINEMA_ID = C.CINEMA_ID " +
//                         "AND USER_ID = ? " +
//                         "AND MOVIE_ID = ? " +
//                         "AND BOOKING_DATE = ? " +
//                         "AND BOOKING_TIME = ? " +
//                         "AND UPPER(BOOKING_STATUS) = ?";
//            
//            stmt = con.prepareStatement(sql);
//            stmt.setInt(1, user_id);
//            stmt.setInt(2, movie_id);
//            stmt.setString(3, booking_date);
//            stmt.setString(4, booking_time);
//            stmt.setString(5, booking_status);
//            rs = stmt.executeQuery();
//            
//            // 处理结果集
//            while(rs.next()){
//                int booking_id = rs.getInt("booking_id");
//                String movie_name = rs.getString("mv_name");
//                String cinema_location = rs.getString("cinema_address");
//                // 可以进一步处理结果集，例如存入 List 中
//            }
//            
//            // Select Payment ID            
//            sql = "SELECT * FROM PAYMENT";
//            rs = con.createStatement().executeQuery(sql);
//            
//            int i = 0;
//            int payment_id = 0;
//            while(rs.next()){
//                i = 1;
//                payment_id = rs.getInt("payment_id");
//            }
//            
//            if(i == 0){
//                payment_id = 0;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if(rs != null) rs.close();
//                if(stmt != null) stmt.close();
//                if(con != null) con.close();
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
        %>
                 
        <div class='flex2'>
            <table class="table2">
                <tr>
                    <th colspan="2">$ Payment Details</th>
                </tr>
                <tr class="space">
                    <td>Booking ID</td> 
                    <td><%//= String.format("%012d", booking_id) %></td>
                </tr>
                <tr class="space">
                    <td>Payment ID</td>
                    <td><%//= String.format("%012d", payment_id + 1) %></td>
                </tr>
                <tr class="space">
                    <td>Payment Description</td>
                    <td>
                        <% 
//                        String description = "";
//                        if(adultTicket_Qty > 0 && childTicket_Qty > 0){
//                            description = movie_name + " | " + cinema_location + " | Child: " + childTicket_Qty + " | Adult: " + adultTicket_Qty + " | " + booking_date + " | " + booking_time;
//                            out.println(description);
//                        } else if(adultTicket_Qty > 0){
//                            description = movie_name + " | " + cinema_location + " | Adult: " + adultTicket_Qty + " | " + booking_date + " | " + booking_time;
//                            out.println(description);
//                        } else {
//                            description = movie_name + " | " + cinema_location + " | Child: " + childTicket_Qty + " | " + booking_date + " | " + booking_time;
//                            out.println(description);
//                        }
                        %>
                    </td>
                </tr>                   
                <tr class="space">
                    <td>Total</td> 
                    <td>MYR <%//= String.format("%.2f", (double) session.getAttribute("total_price")) %></td>
                </tr>
            </table>               
        </div>
    </div>               

    <script> 
        $(document).ready(function(){               
                $('#name').on('input', function(){
                    if($('#name').val() !== ''){
                        var name = $(this).val();
                        $.ajax({
                            url: "format-validation.php", 
                            method: "POST",
                            data:{name:name},
                            dataType: "JSON",
                            success:function(data){
                                $('#name').css('box-shadow', 'none');
                                $('#name').addClass('invalid');
                                $('#name-error').text(data);
                            }
                        });
                    }
                    
                    $('#name').css('box-shadow', '0 2px 4px 0 #cfd7df');
                    $('#name').removeClass('invalid');
                    $('#name-error').text('');
                });

                $('#name').on('blur', function(){
                    var name = $(this).val();
                    if($('#name').val() !== ''){
                        $.ajax({
                            url: "format-validation.php", 
                            method: "POST",
                            data:{name:name},
                            dataType: "JSON",
                            success:function(data){
                                $('#name').css('box-shadow', 'none');
                                $('#name').addClass('invalid');
                                $('#name-error').text(data);
                            }
                        });
                    }
                });      
                
                $('#contactNo').on('input', function(){
                    if($('#contactNo').val().length === 12){
                        var contactNo = $(this).val();
                        $.ajax({
                            url: "format-validation.php", 
                            method: "POST",
                            data:{contactNo:contactNo},
                            dataType: "JSON",
                            success:function(data){
                                $('#contactNo').css('box-shadow', 'none');
                                $('#contactNo').addClass('invalid');
                                $('#contactNo-error').text(data);
                            }
                        });
                    }
                    
                    $('#contactNo').css('box-shadow', '0 2px 4px 0 #cfd7df');
                    $('#contactNo').removeClass('invalid');
                    $('#contactNo-error').text('');
                });

                $('#contactNo').on('blur', function(){
                    var contactNo = $(this).val();
                    if($('#contactNo').val() !== ''){
                        $.ajax({
                            url: "format-validation.php", 
                            method: "POST",
                            data:{contactNo:contactNo},
                            dataType: "JSON",
                            success:function(data){
                                $('#contactNo').css('box-shadow', 'none');
                                $('#contactNo').addClass('invalid');
                                $('#contactNo-error').text(data);
                            }
                        });
                    }
                });               
            });
        
        paypal.Buttons({
            // Order is created on the server and the order id is returned
            createOrder: function(data, actions){
                return actions.order.create({
                    // Capture payment from buyer
                    intent: 'CAPTURE',
                    payer: {
                        name: {
                            given_name: "John", // First name
                            surname: "Doe"      // Last name
                        },
                        address: {
                            address_line_1: "123 Main Street", // Street address
                            address_line_2: "Apt 1",            // Street address line 2 (optional)
                            admin_area_2: "San Jose",           // City
                            admin_area_1: "CA",                 // State/Province
                            postal_code: "95131",               // Postal code
                            country_code: "US"                  // Country code
                        },
                        email_address: "john.doe@example.com", // Email address
                
                        phone: {
                            phone_type: "MOBILE",
                            phone_number: {
                                national_number: "1234567890" // Phone number
                            }
                        }
                    },
                
                    purchase_units: [{                                                       
                        amount: {  
                            currency_code: 'USD',
                            value: 1500 // Amount
                        }
                    }]
                });
            },
    
            // Finalize the transaction on the server after payer approval
//            onApprove: function(data, actions){
//                // Payment approved
//                return actions.order.capture().then(function(orderData){   
//                    var payment_method = "Paypal";
//                    var cust_name = $('#name').val();
//                    var cust_phone = $('#contactNo').val();
//                    $.ajax({
//                        url: 'success.php',
//                        method: 'POST',
//                        data:{payment_method:payment_method, cust_name:cust_name, cust_phone:cust_phone},
//                        success:function(data){
//                            console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
//                            const transaction = orderData.purchase_units[0].payments.captures[0];
//                            window.location.href = 'invoice.php';
//                        }
//                    });                   
//                });
//            },

            // Handle payment cancellation
            onCancel: function(data){
                // Show alert if payment is cancelled
                alert("Payment cancelled");
            },
    
            // Handle errors during payment process
            onError: function(err){
                // Show alert for any errors during checkout
                alert("Something wrong with your address information that prevents checkout");
            }
        }).render('#paypal-button-container');

    </script>
  </body>
</html>