<%-- 
    Document   : stripe
    Created on : 13 Mar 2024, 10:49:08 pm
    Author     : 60174
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link href="../css/payment/stripe.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>Payment</title>
    </head>
    <body>       
        <div class="container"> 
            <h2>Pay by Credit / Debit Card<hr><div class="checkout">Checkout</div><br></h2>            
            <div class="flex1">   
                <form action="./stripe-charge.php" method="POST" id="payment-form">                                   
                    <table class="table1">                           
                        <tr>
                            <td colspan="3" class="name">Cardholder Name</td>
                        </tr>
                        <tr>
                            <td colspan="3"><input type="text" id="cardHolderName" name="cardHolderName" class="StripeElement StripeElement--empty" placeholder="Enter Name" required></td>
                        </tr>
                        <tr>
                            <td colspan="3"><div id="name-error"></div></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="contact-no"><br><br>Contact Number</td>
                        </tr>
                        <tr>
                            <td colspan="3"><input type="text" id="contactNo" name="contactNo" class="StripeElement StripeElement--empty" placeholder="60123456789" maxlength="12" required></td>
                        </tr>
                        <tr>
                            <td colspan="3"><div id="contactNo-error"></div></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="cardNo"><br><br>Card Number</td>
                        </tr>
                        <tr>
                            <td colspan="3"><div id="cardNumber"></div></td>
                        </tr>
                        <tr>
                            <td colspan="3"><div id="cardNumber-errors" role="alert"></div></td>
                        </tr>           
                        <tr class="footTable">
                            <td class="expiryDate"><br><br>Expiration Date</td>
                            <td></td>
                            <td class="cvcNo"><br><br>CVC/CVC2 Number</td>
                        </tr>
                        <tr class="footTable">
                            <td><div id="cardExpiry"></div></td>
                            <td></td>
                            <td><div id="cardCVC"></div></td>
                        </tr>
                        <tr class="footTable">
                            <td><div id="cardExpiry-errors" role="alert"></div></td>
                            <td></td>
                            <td><div id="cardCVC-errors" role="alert"></div></td>
                        </tr>              
                        <tr>
                            <td colspan="3"><br><button type="submit">Make Payment</button></td>
                        </tr>
                    </table>                                        
                </form>
            </div>
            
<!--            <?php 
            $movie_id = $_SESSION['movie_id'];
            $user_id = $_SESSION['user_id'];
            $booking_date = $_SESSION['booking_date'];
            $booking_time = $_SESSION['booking_time'];
            $childTicket_Qty = $_SESSION['childQty'];
            $adultTicket_Qty = $_SESSION['adultQty'];
            $total = $_SESSION['total'];  
            $booking_status = 'PENDING';
            
            require_once '../config/db.php';
            
            $con = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
            
            $sql = "SELECT * FROM TICKET T, BOOKING B, MOVIE M, HALL H, CINEMA C                    
                    WHERE T.BOOKING_ID = B.BOOKING_ID
                    AND T.MOVIE_ID = M.ID
                    AND T.HALL_ID = H.HALL_ID
                    AND H.CINEMA_ID = C.CINEMA_ID
                    AND USER_ID = ? 
                    AND MOVIE_ID = ? 
                    AND BOOKING_DATE = ? 
                    AND BOOKING_TIME = ?
                    AND UPPER(BOOKING_STATUS) = ?";
            
            $stmt = $con->prepare($sql);
            $stmt->bind_param('iisss', $user_id, $movie_id, $booking_date, $booking_time, $booking_status);
            $stmt->execute();
            
            $result = $stmt->get_result();
            
            while($rows = mysqli_fetch_assoc($result)){
                $row[] = array(
                    'booking_id'       =>    $rows['booking_id'],
                    'movie_name'       =>    $rows['mv_name'],
                    'cinema_location'  =>    $rows['cinema_address']                     
                );
            }
            
            $_SESSION['booking_id'] = $row[0]['booking_id'];
            
            $sql = "SELECT * FROM PAYMENT";
            $result = mysqli_query($con, $sql);
            
            $i = 0;
            
            while($record = mysqli_fetch_assoc($result)){
                $i = 1;
                $payment_id = $record['payment_id'];
            }
            
            if(!$i){
                $payment_id = 0;
            }
            ?>-->
                     
            <div class='flex2'>
                <table class="table2">
                    <tr>
                        <th colspan="2">$ Payment Details</th>
                    </tr>
                    <tr class="space">
                        <td>Booking ID</td> 
                        <td><!--<?php echo str_pad($row[0]['booking_id'], 12, '0', STR_PAD_LEFT); ?>--></td>
                    </tr>
                    <tr class="space">
                        <td>Payment ID</td>
                        <td><!--<?php echo str_pad($payment_id + 1, 12, '0', STR_PAD_LEFT); ?>--></td>
                    </tr>
                    <tr class="space">
                        <td>Payment Description</td>
                        <td>
<!--                            <?php 
                            if($adultTicket_Qty > 0 && $childTicket_Qty > 0){
                                $_SESSION['description'] = $row[0]['movie_name'].' | '.$row[0]['cinema_location'].' | Child: '.$childTicket_Qty.' | Adult: '.$adultTicket_Qty.' | '.$booking_date.' | '.$booking_time;
                                echo $_SESSION['description'];
                            }
                            
                            else if($adultTicket_Qty > 0){
                                $_SESSION['description'] = $row[0]['movie_name'].' | '.$row[0]['cinema_location'].' | Adult: '.$adultTicket_Qty.' | '.$booking_date.' | '.$booking_time; 
                                echo $_SESSION['description'];
                            }
                            
                            else {
                                $_SESSION['description'] = $row[0]['movie_name'].' | '.$row[0]['cinema_location'].' | Child: '.$childTicket_Qty.' | '.$booking_date.' | '.$booking_time; 
                                echo $_SESSION['description'];
                            }
                            ?>-->
                        </td>
                    </tr>                   
                    <tr class="space">
                        <td>Total</td> 
                        <td>MYR <!--<?php echo number_format($_SESSION['total_price'], 2); ?>--></td>
                    </tr>
                </table>               
            </div>
        </div>
        
        <script>
            $(document).ready(function(){               
                $('#cardHolderName').on('input', function(){
                    if($('#cardHolderName').val() !== ''){
                        var cardHolderName = $(this).val();
                        $.ajax({
                            url: "./format-validation.php", 
                            method: "POST",
                            data:{name:cardHolderName},
                            dataType: "JSON",
                            success:function(data){
                                $('#cardHolderName').css('box-shadow', 'none');
                                $('#cardHolderName').addClass('invalid');
                                $('#name-error').text(data);
                            }
                        });                 
                    }
                    
                    $('#cardHolderName').css('box-shadow', '0 2px 4px 0 #cfd7df');
                    $('#cardHolderName').removeClass('invalid');
                    $('#name-error').text('');
                });

                $('#cardHolderName').on('blur', function(){
                    var cardHolderName = $(this).val();
                    if($('#cardHolderName').val() !== ''){
                        $.ajax({
                            url: "./format-validation.php", 
                            method: "POST",
                            data:{name:cardHolderName},
                            dataType: "JSON",
                            success:function(data){
                                $('#cardHolderName').css('box-shadow', 'none');
                                $('#cardHolderName').addClass('invalid');
                                $('#name-error').text(data);
                            }
                        });
                    }
                });      
                
                $('#contactNo').on('input', function(){
                    if($('#contactNo').val().length === 12){
                        var contactNo = $(this).val();
                        $.ajax({
                            url: "./format-validation.php", 
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
                            url: "./format-validation.php", 
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
        </script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://js.stripe.com/v3/"></script>
        <script src="../js/stripe-charge.js"></script>
    </body>
</html>

