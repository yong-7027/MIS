/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

/* Show Menu */
const showMenu = (toggleId, navId) =>{
    const toggle = document.getElementById(toggleId),
        nav = document.getElementById(navId);

    toggle.addEventListener('click', () =>{
        // The show-menu class will be removed if it exists in the class list 
        // of the nav element; if not, it will be added.
        
        // Add show-menu class to nav menu
        nav.classList.toggle('show-menu');  

        // Add show-icon to show and hide the menu icon
        toggle.classList.toggle('show-icon');
    });
};

showMenu('nav-toggle','nav-menu');

//const sunIcon = document.getElementById('sunIcon');
//const moonIcon = document.getElementById('moonIcon');
//
//function toggleIcon() {
//  // 切换两个图标的显示状态
//  sunIcon.style.display = sunIcon.style.display === 'none' ? 'block' : 'none';
//  moonIcon.style.display = moonIcon.style.display === 'none' ? 'block' : 'none';
//}