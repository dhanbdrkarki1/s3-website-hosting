const counters = document.querySelectorAll(".counter");
var i = 0;

function counterEffect() {
  const counterContainer = document.querySelector(".circles");
  const counterContainerPostion = counterContainer.getBoundingClientRect().top;
  const screenPostion = window.innerHeight / 1.8;
  console.log(counterContainerPostion);
  if (counterContainerPostion < screenPostion) {
    if (i != 1) {
      console.log("if statement");
      counters.forEach((counter) => {
        counter.innerText = "0";

        const updateCounter = () => {
          const target = +counter.getAttribute("data-target");
          const c = +counter.innerText;

          const increment = target / 200;

          if (c < target) {
            counter.innerText = `${Math.ceil(c + increment)}`;
            setTimeout(updateCounter, 10);
          } else {
            counter.innerText = target + "+";
          }
          i = 1;
        };
        updateCounter();
      });
    }
  }
}
window.addEventListener("scroll", counterEffect);
// ************ fade in effects ***********************

const heroTexts = document.querySelectorAll(".hero-text");
heroTexts.forEach((heroText) => {
  fadeIn(heroText);
});

function fadeIn(heroText) {
  heroText.classList.add("fade-in");
}

const cardsContainer = document.querySelector(".cards-container");
const welcomeText = document.querySelector(".welcome-text");
const recentPostContainer = document.querySelector(".recent__post__container");
const eventsContainer = document.querySelector(".events__container");
const donationForm = document.querySelector(".donation__form");
const teamContainer = document.querySelector(".team__container");
const teamCards = document.querySelector(".team-cards");
const footer = document.querySelector(".footer");

const elements = [
  cardsContainer,
  welcomeText,
  recentPostContainer,
  eventsContainer,
  donationForm,
  teamContainer,
  teamCards,
  footer,
];

elements.forEach((element) => {
  function scrollEffect() {
    var elementPostion = element.getBoundingClientRect().top;
    var screenPostion = window.innerHeight;

    if (elementPostion < screenPostion) {
      element.classList.add("fade-in");
    }
  }
  window.addEventListener("scroll", scrollEffect);
});
