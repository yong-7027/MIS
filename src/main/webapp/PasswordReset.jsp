<%-- 
    Document   : PasswordReset
    Created on : 28 Mar 2024, 9:23:14 pm
    Author     : zheng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://kit.fontawesome.com/8d6dbf3dd8.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <link href="css/sign_up.css" rel="stylesheet" type="text/css"/>
        <script src="js/sign_up.js" type="text/javascript"></script>
        
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@200;900&family=Tilt+Neon&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;900&display=swap');
            
            html::-webkit-scrollbar{
                width: 0.5rem;
                background-color: #020307;
            }

            html::-webkit-scrollbar-thumb{
                background-color: #38FFFC;
                border-radius: 5rem;
            }
            
            body{
                overflow: auto;
            }
            
            #container{
                margin-top: 130px;
                width: 50%;
            }
            
            .info{
                margin-bottom: 80px;
            }
            
            /* Animation */
            #container h1{
                opacity: 0;
                animation: fadeUp 0.8s ease-out forwards;
                animation-delay: 0.5s;
            }
            
            .row #child1{
                opacity: 0;
                animation: fadeUp 0.8s ease-out forwards;
                animation-delay: 0.8s;
            }

            .row #child2{
                opacity: 0;
                animation: fadeUp 0.8s ease-out forwards;
                animation-delay: 1.1s;
            }
            
            .form-submit input{
                opacity: 0;
                animation: fadeUp 0.8s ease-out forwards;
                animation-delay: 3.0s;
            }
            
            @media screen and (max-width: 1246px) {
                body{
                    height: 800px;
                }
                
                #container{
                    margin-top: 50px;
                }
            }
            
            @media screen and (max-width: 842px){
                body{
                    height: 840px;
                }
                
                #container{
                    margin-top: 0px;
                }
                
                .form-title{
                    font-size: 30px;
                }
            }
        </style>
        
        <title>MIStore</title>
    </head>
    
    <body>
        <div id="container">
            <h1 class="form-title">Reset Your Password</h1>
            
            <form action="" method="post" id="pass-reset-form">
            <div class="row">
                <div class="info" id="child1">
                    <input type="password" id="psd" name="psd" required />
                    <label for="psd">Enter new password<span class="star">*</span></label>
                    <i id="eye-1" class="fa-sharp fa-regular fa-eye-slash"></i>
                    <i id="eye-2" style="display: none" class="fa-regular fa-eye"></i>
                    <div id="error_message_3"></div>
                </div>
                
                <div class="info" id="child2">
                    <input type="password" id="confirm-psd" name="confirm-psd" required />
                    <label for="confirm-psd">Confirm new password<span class="star">*</span></label>
                    <i id="eye-3" class="fa-sharp fa-regular fa-eye-slash"></i>
                    <i id="eye-4" style="display: none" class="fa-regular fa-eye"></i>
                    <div id="error_message_4"></div>
                </div>
            </div>
                
            <div id="psd-requirements" >
                <p>Password must contain the following:</p>
                <div id="letter" class="invalid">A <span class="requirement">lowercase</span> letter</div>
                <div id="capital" class="invalid">A <span class="requirement">capital (uppercase)</span> letter</div>
                <div id="number" class="invalid">A <span class="requirement">number</span> and a <span class="requirement">symbol</span></div>
                <div id="length" class="invalid">Minimum <span class="requirement">8 characters</span></div>
            </div>
            
            <div class="form-submit" style="margin-bottom: 70px;">
                <input type="button" name="submit" id="btnSubmit" value="RESET PASSWORD" style="width: 100%;" onclick="ajaxFunction()" />
            </div>
            </form>
        </div>
        
        <script type="text/javascript">
            document.getElementById("psd").addEventListener("blur", checkPsd);
            document.getElementById("psd").addEventListener("input", checkPsd);
            document.getElementById("psd").addEventListener("keyup", display);
            document.getElementById("confirm-psd").addEventListener("blur", checkConfirmPsd);    
            document.getElementById("confirm-psd").addEventListener("input", checkConfirmPsd);   
            
            $("#eye-1").on("click", function(){
                $("#psd").attr("type", "text");
                $("#eye-1").css("display", "none");
                $("#eye-2").css("display", "block");
            });
            
            $("#eye-2").on("click", function(){
                $("#psd").attr("type", "password");
                $("#eye-1").css("display", "block");
                $("#eye-2").css("display", "none");
            });
            
            $("#eye-3").on("click", function(){
                $("#confirm-psd").attr("type", "text");
                $("#eye-3").css("display", "none");
                $("#eye-4").css("display", "block");
            });
            
            $("#eye-4").on("click", function(){
                $("#confirm-psd").attr("type", "password");
                $("#eye-3").css("display", "block");
                $("#eye-4").css("display", "none");
            });
        </script>
        
        <script>
            function ajaxFunction(){
                var xmlhttp;
                var formdata = new FormData(document.getElementById("pass-reset-form"));
            
                if(window.XMLHttpRequest)
                    xmlhttp = new XMLHttpRequest();
                else if(ActiveXObjext("Microsoft.XMLHTTP"))
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                else{
                    alert("Problem with your browser!");
                    return false;
                }
            
                // Create a function that will receive data from the server
                xmlhttp.onreadystatechange = function(){
                    if(xmlhttp.readyState === 4){
                        var response = JSON.parse(xmlhttp.responseText);
                    
                        if (response.password) {
                            $("#error_message_3").text(response.password).show();
                        }
                        if (response.confirm_pass) {
                            $("#error_message_4").text(response.confirm_pass).show();
                        }
                        if (response.url) {
                            window.location.href = response.url;
                        }
                    }    
                };
            
                xmlhttp.open("POST", "<%= request.getContextPath()%>/customer/passwordReset", true);
                xmlhttp.setRequestHeader("Content-type", "application/json");
                xmlhttp.send(formdata);
            }
        </script>
    </body>
</html>
