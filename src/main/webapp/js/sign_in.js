/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function checkUserName(){
    var input = document.getElementById("user-name").value;
    var error = document.getElementById("error-message-1");
        
    if(input === ""){
        error.innerText = "Please enter your username.";
        error.style.display = "block";
    }
    else{
        error.style.display = "none";
    }
}

function checkPsd(){
    var input = document.getElementById("psd").value;
    var error = document.getElementById("error-message-2");
    
    if(input === ""){
        error.innerText = "Please enter your password.";
        error.style.display = "block";
    }
    else{
        error.style.display = "none";
    }
}