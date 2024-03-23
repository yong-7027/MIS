/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// DOM Elements
const circles = document.querySelectorAll(".circle"),
        progressBar = document.querySelector(".indicator"),
        buttons = document.querySelectorAll("button");

let currentStep = 1;

// Function that updates the current step and updates the DOM
const updateSteps = (e) => {
    // Update current step based on the button clicked
    currentStep = e.target.id === "next" ? ++currentStep : --currentStep;
    console.log(currentStep);

    // Loop through all circles and add/remove "active" class based on their index and current step
    circles.forEach((circle, index) => {
        circle.classList[`${index < currentStep ? "add" : "remove"}`]("active");
    });
    
    // Update progress bar width based on current step
    progressBar.style.width = `${((currentStep - 1) / (circles.length - 1)) * 100}%`;
    
    // Check if current step is last step or first step and disable corresponding buttons
    if (currentStep === circles.length) {
        buttons[1].disabled = true;
    } else if (currentStep === 1) {
        buttons[0].disabled = true;
    } else {
        buttons.forEach((button) => (button.disabled = false));
    }
};


// Add click event listeners to all buttons
buttons.forEach(button => {
    button.addEventListener("click", updateSteps);
});