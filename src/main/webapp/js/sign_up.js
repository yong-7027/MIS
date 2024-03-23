/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function checkUserName(){
    var input = document.getElementById("user-name").value;
    var error = document.getElementById("error_message_1");
        
    if(input === ""){
        error.innerText = "Please enter your user name.";
        error.style.display = "block";
    }
    else{
        error.style.display = "none";
    }
}

function checkEmail(){
    var input = document.getElementById("email").value;
    var pattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    var error = document.getElementById("error_message_2");
    
    if(input === ""){
        error.innerText = "Please enter your email address.";
        error.style.display = "block";
    }
    else{
        if(!pattern.test(input)){
            error.innerText = "The email address pattern is incorrect.";
            error.style.display = "block";
        }
        else{
            error.style.display = "none";
        }
    }
}

function checkPsd(){
    var input = document.getElementById("psd").value;
    var pattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()\-_=+{};:,.<>§~\|\/?]).{8,}$/;
    var error = document.getElementById("error_message_3");
    
    if(input === ""){
        error.innerText = "Please enter your password.";
        error.style.display = "block";
    }
    else{
        if(!pattern.test(input)){
            error.innerText = "Please refer to the below password policy.";
            error.style.display = "block";
        }
        else{
            error.style.display = "none";
        }
    }
}

function checkConfirmPsd(){
    var input = document.getElementById("confirm-psd").value; // string
    var psdmatch = document.getElementById("psd").value; // string
    var error = document.getElementById("error_message_4");
    
    if(input === ""){
        error.innerText = "Please confirm your password.";
        error.style.display = "block";
    }
    else{
        if(input !== psdmatch){  // compare string
            error.innerText = "The password do not match.";
            error.style.display = "block";
        }
        else{
            error.style.display = "none";
        }
    }
}

// When the user starts to type something inside the password field
function display() {
    var password = document.getElementById("psd").value;
    var letter = document.getElementById("letter");
    var capital = document.getElementById("capital");
    var number = document.getElementById("number");
    var length = document.getElementById("length");

    // Validate lowercase letters
    var lowerCaseLetters = /[a-z]/g;
    if(password.match(lowerCaseLetters)) {  
        letter.classList.remove("invalid");
        letter.classList.add("valid");
    } 
    else {
        letter.classList.remove("valid");
        letter.classList.add("invalid");
    }
    
    // Validate capital letters
    var upperCaseLetters = /[A-Z]/g;
    if(password.match(upperCaseLetters)) {  
        capital.classList.remove("invalid");
        capital.classList.add("valid");
    } 
    else {
        capital.classList.remove("valid");
        capital.classList.add("invalid");
    }
  
    // Validate numbers and special characters
    var numbers = /[0-9]/g;
    var specialcharacters = /[!@#$%^&*()\-_=+{};:,.<>§~\|\/?]/g;
    if(password.match(numbers) && password.match(specialcharacters)) {  
        number.classList.remove("invalid");
        number.classList.add("valid");
    }
    else {
        number.classList.remove("valid");
        number.classList.add("invalid");
    }
    
    // Validate length
    if(password.length >= 8) {
        length.classList.remove("invalid");
        length.classList.add("valid");
    } 
    else {
        length.classList.remove("valid");
        length.classList.add("invalid");
    }
}