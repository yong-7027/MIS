<%-- 
    Document   : checkout
    Created on : Mar 21, 2024, 10:49:07 PM
    Author     : 60174
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/payment/checkout.css" />
        <link href="https://fonts.googleapis.com;css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    </head>
    <body>
        <div class="small-container cart-page">
            <table>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
                <tr>
                    <td>
                        <div class="cart-info">
                            <img src="../images/payment/buy-1.jpg" alt="">
                            <div>
                                <p>Red Printed Tshirt</p>
                                <small>Price: $50.00</small>
                                <a href="">Remove</a>
                                <br>
                            </div>
                        </div>
                    </td>
                    <td><input type="number" value="1" /></td>
                    <td>$50.00</td>
                </tr>
                <tr>
                    <td>
                        <div class="cart-info">
                            <img src="../images/payment/buy-2.jpg" alt="">
                            <div>
                                <p>Red Printed Tshirt</p>
                                <small>Price: $50.00</small>
                                <a href="">Remove</a>
                                <br>
                            </div>
                        </div>
                    </td>
                    <td><input type="number" value="1" /></td>
                    <td>$50.00</td>
                </tr>
                <tr>
                    <td>
                        <div class="cart-info">
                            <img src="../images/payment/buy-3.jpg" alt="">
                            <div>
                                <p>Red Printed Tshirt</p>
                                <small>Price: $50.00</small>
                                <a href="">Remove</a>
                                <br>
                            </div>
                        </div>
                    </td>
                    <td><input type="number" value="1" /></td>
                    <td>$50.00</td>
                </tr>
            </table>
            
            <div class="total-price">
                <table>
                    <tr>
                        <td>Subtotal</td>
                        <td>$200.00</td>
                    </tr>
                    <tr>
                        <td>Tax</td>
                        <td>$35.00</td>
                    </tr>
                    <tr>
                        <td>Total</td>
                        <td>$230.00</td>
                    </tr>
                </table>
            </div>
            
            <div class="paypal text-center">   
            <form action="invoice.jsp" method="POST" id="payment-form">                                   
                <table>                           
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
        </div>
        
        <script>
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
