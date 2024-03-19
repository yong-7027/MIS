/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

const container = document.querySelector('.icons');
const originalIcon = document.querySelector('.original-icon');
const hoverIcon = document.querySelector('.hover-icon');

container.addEventListener('mouseover', () => {
    hoverIcon.classList.add('appear');
    setTimeout(() => {
        originalIcon.classList.add('hide');
    }, 270); // 等待过渡结束后隐藏
});

container.addEventListener('mouseleave', () => {
    originalIcon.classList.add('appear');
    setTimeout(() => {
        hoverIcon.classList.add('hide');
    }, 270); // 等待过渡结束后隐藏
});