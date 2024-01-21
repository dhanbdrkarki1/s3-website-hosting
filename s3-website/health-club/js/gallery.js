const hiddenContainer = document.querySelector(".hidden-container");
const closeBtn = document.querySelector(".close-btn");
var popupImage = document.querySelector(".pop-up-image");
const images = document.querySelectorAll(".img");

images.forEach((image) => {
  image.addEventListener("click", () => {
    showImage(image);
  });
});

function showImage(image) {
  let imageSrc = image.getAttribute("data-image");
  popupImage.src = imageSrc;
  hiddenContainer.classList.add("show-image");
}

closeBtn.addEventListener("click", hideImage);

function hideImage() {
  hiddenContainer.classList.remove("show-image");
}
