<%-- 
    Document   : ForgetPassword
    Created on : 23 Mar 2024, 12:19:05 pm
    Author     : zheng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="css/forget_password.css" rel="stylesheet" type="text/css"/>
        <script src="js/sign_up.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&family=Tilt+Neon&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;600;700;900&display=swap');
        </style>
        <title>MIStore</title>
    </head>
    <body>
        <div class="container">
            <form action="forget_password_ajax.php" method="post" id="form-1">
                <div class="heading">
                    <button class="back-btn"><a href="sign_in.php">&larr;</a></button>
                    <h1>Forgot Password</h1>
                </div>
                <p>Please enter your registered email address and we will send you an OTP to reset your password</p>
                <div class="psd-reset">
                    <input type="text" id="email" name="email" required />
                    <label for="email">Email Address<span class="star">*</span></label>
                    <div id="error_message_2"></div>
                </div>

                <div class="submit-btn">
                    <a href="sign_in.php">BACK</a>
                    <input type="button" name="submit" onclick="ajaxFunction();" value="SENT RESET EMAIL">
                </div>
            </form>
        </div>
    </body>

    <script>
        document.getElementById("email").addEventListener("blur", checkEmail);
        document.getElementById("email").addEventListener("input", checkEmail);

        function ajaxFunction() {
            var xmlhttp;
            var formdata = new FormData(document.getElementById("form-1"));

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
                    if (xmlhttp.responseText == "No email found. Please enter the valid email." || xmlhttp.responseText == "Please enter your email address." || xmlhttp.responseText == "The email address pattern is incorrect.") {
                        $("#error_message_2").text(xmlhttp.responseText).show();
                    } else {
                        window.location.href = "OTP.php"; // 跳转页面
                    }
                }
            };

            xhttp.open("POST", "<%= request.getContextPath()%>/email/forgetPassword", true);
            xhttp.setRequestHeader("Content-Type", "application/json");
            xhttp.send(formdata);
        }
    </script>
</html>
