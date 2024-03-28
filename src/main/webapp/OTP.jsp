<%-- 
    Document   : OTP
    Created on : 24 Mar 2024, 7:30:02 pm
    Author     : zheng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="../css/OTP.css" rel="stylesheet" type="text/css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&family=Tilt+Neon&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;600;700;900&display=swap');
        </style>
        <title>GRC Cinema</title>
    </head>
    <body>
<!--        <?php    
            if(isset($_SESSION['status'])){
                echo "<script>";
                echo "alert('" . $_SESSION['status'] . "')";
                echo "</script>";
                unset($_SESSION['status']);
            }
        ?>-->
        <h1>OTP Verification</h1>
        <p>code has been send to the email</p>
        
<!--        <?php
        // display the error message
        if(isset($_POST['submit'])){
            if(!empty($error)){
                echo "<ul class='error'>";
                foreach($error as $value){
                    echo "<li>$value</li>";
                    }
                echo "</ul><br />";
            }
        }
        ?>-->
        
<form action="<%= request.getContextPath()%>/customer/verifyOtp" method="POST" id="otp-submit">
            <div class="otp-box">
                <input type="text" maxlength="1" />
                <input type="text" maxlength="1" />
                <input type="text" maxlength="1" class="space" />
                <input type="text" maxlength="1" />
                <input type="text" maxlength="1" />
                <input type="text" maxlength="1" />
            </div>
            <input type="hidden" name="otp" id="otp" />
            <div class="info">
                <div id="countdown"></div>
                <input class="submit-btn" type="submit" name="resend" value="Resend OTP" />
            </div>
            <div class="btn">
                <input style="display: none" type="submit" name="submit" id="verify-btn" value="Verify" />
            </div>
        </form>
        
        <!-- OTP key in -->
        <script type="text/javascript">
            const inputs = document.querySelectorAll(".otp-box input");
            
            inputs.forEach((input, index) => {
               input.dataset.index = index; // 为每个 input 设置自定义属性 ‘data-index’ 
               input.addEventListener("paste", handleOtppaste);
               input.addEventListener("keyup", handleOtp);
            });
            
            // handle copy and paste OTP
            function handleOtppaste(e){
                const data = e.clipboardData.getData("text"); // clipboardData - containing the currently copied or cut data | text - only text type data is obtained
                const value = data.split(""); // split the copied or cut data
                if(value.length === inputs.length){
                    inputs.forEach((input, index) => (input.value = value[index]));
                    submit();
                }
            }
            
            // handle key in OTP
            function handleOtp(e){
                const input = e.target; // e.target - target element of the event
                let value = input.value;
                input.value = ""; // clear the entered value in the box
                input.value = value ? value[0] : ""; // conditional-if
                
                let fieldIndex = input.dataset.index; // 读取索引
                if(value.length > 0 && fieldIndex < inputs.length - 1){ // determine if there is already a value entered in the input box and the current 
                    input.nextElementSibling.focus();                   // input box is not the last input box                
                }
                if(e.key === "Backspace" && fieldIndex > 0){
                    input.previousElementSibling.focus();
                }
                if(fieldIndex == inputs.length - 1){
                    submit(); // call the submit function
                }
            }
            
            function submit(){
                //let otp = "";
                var otp = document.getElementById("otp").value;
                inputs.forEach((input) => {
                    otp += input.value;
                });                
                document.getElementById("otp").value = otp; // 赋值
                document.getElementById("verify-btn").click(); // submit the form
            }
        </script>
        
        <!-- Countdown -->
        <script type="text/javascript">
            window.onload = function(){
                // Get the expiration message from local storage, if it exists
                var expirationMessage = localStorage.getItem('otpExpirationMessage');
                
                // If there is an expiration message, display it
                if (expirationMessage) {
                    document.getElementById("countdown").innerText = expirationMessage;
                }  
            };
            
            // Set the expiration time in milliseconds (1 minutes from now)
            var expirationTime = <%= request.getSession().getAttribute("OtpTime") + 60 * 1000; %> ;
            
            // Update the countdown timer every second
            var countdown = setInterval(function(){
                // Get the current time
                var currentTime = Date.now();
                
                // Calculate the time difference between the expiration time and the current time
                var timeDiff = expirationTime - currentTime;
                
                // Check if the time has expired
                if(timeDiff <= 0){
                    clearInterval(countdown);
                    return;
                }
                
                // Calculate the minutes and seconds remaining
                var minutes = Math.floor(timeDiff / 1000 / 60);
                var seconds = Math.floor((timeDiff / 1000) % 60);
                
                var timeRemaining = minutes + " : " + (seconds < 10 ? "0" : "") + seconds;
                
                document.getElementById("countdown").innerText = "Your code will expire in " + timeRemaining + ".";
                
                // Check if the OTP code is expired
                if (minutes === 0 && seconds === 0) {
                // Save the expiration message in local storage
                    localStorage.setItem('otpExpirationMessage', 'Your code is expired. Please click the resend OTP.');
                } 
                else {
                // Clear the expiration message from local storage
                    localStorage.removeItem('otpExpirationMessage');
                }
                
                var expirationMessage = localStorage.getItem('otpExpirationMessage');
                
                if (expirationMessage) {
                    document.getElementById("countdown").innerText = expirationMessage;
                }  
            });
        </script>
    </body>
</html>
