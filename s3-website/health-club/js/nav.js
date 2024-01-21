const navContainer = document.querySelector("nav");
const dropdown = document.querySelector(".dropdown");
const hamburger = document.querySelector(".hamburger");
const navLinks = document.querySelectorAll(".nav-link");
const pagesBtn = document.querySelector(".pages-btn");
const blogBtn = document.querySelector(".blog-btn");
const pagesDropdown = document.querySelector("#pages-dropdown");
const blogDropdown = document.querySelector("#blog-dropdown");

console.log(pagesBtn);
console.log(blogBtn);

// // for pages button
function showPagesDropdown() {
  pagesDropdown.classList.toggle("show-hidden-navlinks");
  blogDropdown.classList.remove("show-hidden-navlinks");
}

//for blog button
function showBlogDropdown() {
  blogDropdown.classList.toggle("show-hidden-navlinks");
  pagesDropdown.classList.remove("show-hidden-navlinks");
}

pagesBtn.addEventListener("click", showPagesDropdown);
blogBtn.addEventListener("click", showBlogDropdown);


// if user click outside the dropdown, hide it
window.onclick = event => {
  pagesBtn.classList.add("drop-btn");
  blogBtn.classList.add("drop-btn");
  console.log(event.target);
  if (!event.target.matches('.drop-btn')){
    var dropDown = document.querySelectorAll(".nav-links");
    console.log(dropDown)
    dropDown.forEach(item => {
      if (item.classList.contains("show-hidden-navlinks")){
        item.classList.remove("show-hidden-navlinks");
        console.log("removed")
      }
    })
  }
}

// js for hamburger menu

function showDropDown() {
  dropdown.classList.toggle("show-dropdown");
  dropdown.classList.toggle("expand-dropdown-height");
}

function hideNav() {
  dropdown.classList.remove("show-dropdown");
  dropdown.classList.remove("expand-dropdown-height");
  ul.classList.remove("show-hidden-navlinks");
}

navLinks.forEach((navLink) => {
  navLink.addEventListener("click", hideNav);
});

hamburger.addEventListener("click", showDropDown);

function navBarBoxShadow() {
  let navPosition = navContainer.offsetHeight;
  let windowPosition = window.pageYOffset;

  if (navPosition <= windowPosition) {
    navContainer.classList.add("nav-box-shadow");
  } else if (navPosition >= windowPosition) {
    navContainer.classList.remove("nav-box-shadow");
  } else {
    return;
  }
}

window.addEventListener("scroll", navBarBoxShadow);
