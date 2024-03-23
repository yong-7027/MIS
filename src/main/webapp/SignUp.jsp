<%-- 
    Document   : SignUp
    Created on : 20 Mar 2024, 4:30:26 pm
    Author     : zheng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/sign_up.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/sign_up.js" type="text/javascript"></script>
        <script src="https://kit.fontawesome.com/8d6dbf3dd8.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&family=Tilt+Neon&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;900&display=swap');
        </style>
        <title>MIStore</title>
    </head>
    <body>
        <div id="container">
            <div class="title">
                <div class="icons">
                    <img src="images/add-user.png" alt="" width="50px" height="50px" />
                </div>
                <h1 class="form-title">Sign Up</h1>
            </div>

            <!-- Sign up form -->
            <form action="" method="post" id="signup-form">
                <div class="row-1">
                    <div class="info">
                        <input type="text" id="user-name" name="user-name" required />
                        <label for="user-name">User Name<span class="star">*</span></label>
                        <i id="dice" class="fa-solid fa-dice"></i>
                        <div id="error_message_1"></div>
                    </div>               

                    <div class="info">
                        <input type="text" id="email" name="email" required />
                        <label for="email">Email Address<span class="star">*</span></label>
                        <i class="fa-solid fa-envelope"></i>
                        <div id="error_message_2"></div>
                    </div>
                </div>

                <div class="row-2">
                    <div class="info">
                        <input type="password" id="psd" name="psd" required />
                        <label for="psd">Password<span class="star">*</span></label>
                        <i id="eye-1" class="fa-sharp fa-regular fa-eye-slash"></i>
                        <i id="eye-2" style="display: none" class="fa-regular fa-eye"></i>
                        <div id="error_message_3"></div>
                    </div>

                    <div class="info">
                        <input type="password" id="confirm-psd" name="confirm-psd" required />
                        <label for="confirm-psd">Confirm Password<span class="star">*</span></label>
                        <i id="eye-3" class="fa-sharp fa-regular fa-eye-slash"></i>
                        <i id="eye-4" style="display: none" class="fa-regular fa-eye"></i>
                        <div id="error_message_4"></div>
                    </div>
                </div>

                <div id="psd-requirements">
                    <p>Password must contain the following:</p>
                    <div id="letter" class="invalid">A <span class="requirement">lowercase</span> letter</div>
                    <div id="capital" class="invalid">A <span class="requirement">capital (uppercase)</span> letter</div>
                    <div id="number" class="invalid">A <span class="requirement">number</span> and a <span class="requirement">symbol</span></div>
                    <div id="length" class="invalid">Minimum <span class="requirement">8 characters</span></div>
                </div>

                <div class="row-3">
                    <div class="form-submit">
                        <input type="button" name="submit" id="btnSubmit" value="SIGN UP" onclick="ajaxFunction()" />
                    </div>

                    <div class="sign-in">
                        <div>Already Member?</div>
                        <a href="sign_in.php" id="signin-btn">Sign In</a>
                    </div>
                </div>
            </form>
        </div>

        <script type="text/javascript">
            // verify the info entered by the user and display the error message in real time 
            // before they click the submit button
            document.getElementById("user-name").addEventListener("blur", checkUserName);
            document.getElementById("email").addEventListener("blur", checkEmail);
            document.getElementById("email").addEventListener("input", checkEmail);
            document.getElementById("psd").addEventListener("blur", checkPsd);
            document.getElementById("psd").addEventListener("input", checkPsd);
            document.getElementById("psd").addEventListener("keyup", display);
            document.getElementById("confirm-psd").addEventListener("blur", checkConfirmPsd);
            document.getElementById("confirm-psd").addEventListener("input", checkConfirmPsd);
        </script>

        <script>
            // ajax -> verify the info entered by the user after they click the submit button
            // If there is no error message, redirect them to the sign in page and send the verification/account activate email to them
            // Else display the error message
            function ajaxFunction() {
                var xmlhttp;
                var formdata = new FormData(document.getElementById("signup-form"));

                if (window.XMLHttpRequest)
                    xmlhttp = new XMLHttpRequest();
                else if (ActiveXObjext("Microsoft.XMLHTTP"))
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                else {
                    alert("Problem with your browser!");
                    return false;
                }

                // Create a function that will receive data from the server
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState === 4) {
                        var response = JSON.parse(xmlhttp.responseText);

                        if (response.username) {
                            $("#error_message_1").text(response.username).show();
                        }
                        if (response.email) {
                            $("#error_message_2").text(response.email).show();
                        }
                        if (response.password) {
                            $("#error_message_3").text(response.password).show();
                        }
                        if (response.confirm_pass) {
                            $("#error_message_4").text(response.confirm_pass).show();
                        }
                        if (response.url) {
//                            var token = response.token;
//                            var send_email = response.send_email;
                            var xhttp = new XMLHttpRequest();
                            var emailData = {
                                subject: "Email Verification from MIStore",
                                content: "<h2>You have Registered with MIStore</h2>\n"
                                        + "<h5>Verify your email address to Login with the below given link</h5>\n"
                                        + "<br/><br/>\n"
                                        + "<a href='http://localhost/MIS/email/verify?token=" + response.token + "'>Activate</a>",
                                email: response.email
                            };

                            xhttp.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    console.log("Email sent successfully.");
                                }
                            };
                            
                            xhttp.open("POST", "<%= request.getContextPath()%>/email/send", true);
                            xhttp.setRequestHeader("Content-Type", "application/json");    
                            xhttp.send(JSON.stringify(emailData));
//                            window.location.href = response.url;
                        }
                    }
                };

                xmlhttp.open("POST", "<%= request.getContextPath()%>/customer/add", true);
                console.log(JSON.stringify(formdata));
                xmlhttp.setRequestHeader("Content-type", "application/json");
                xmlhttp.send(formdata);
            }
        </script>

        <script>
            $(document).ready(function () {
                // Users can select usernames that have not been registered before by clicking on the dice
                $("#dice").on("click", function () {
                    // Generate random name with length 3 - 14
                    var randomNameLength = <%= (int) 3 + (Math.random() * 12)%>;

                    $.ajax({
                        url: "<%= request.getContextPath()%>/RandomNameGeneratorServlet", // send the request to the RandomNameGeneratorServlet
                        dataType: "json",
                        type: "GET",
                        data: {length: randomNameLength},
                        success: function (data) {
                            $("#user-name").val(data); // display the random username
                        }
                    });
                });

                // show and hide the password by clicking the eye icon
                $("#eye-1").on("click", function () {
                    $("#psd").attr("type", "text");
                    $("#eye-1").css("display", "none");
                    $("#eye-2").css("display", "block");
                });

                $("#eye-2").on("click", function () {
                    $("#psd").attr("type", "password");
                    $("#eye-1").css("display", "block");
                    $("#eye-2").css("display", "none");
                });

                $("#eye-3").on("click", function () {
                    $("#confirm-psd").attr("type", "text");
                    $("#eye-3").css("display", "none");
                    $("#eye-4").css("display", "block");
                });

                $("#eye-4").on("click", function () {
                    $("#confirm-psd").attr("type", "password");
                    $("#eye-3").css("display", "block");
                    $("#eye-4").css("display", "none");
                });
            });
        </script>
    </body>
</html>
