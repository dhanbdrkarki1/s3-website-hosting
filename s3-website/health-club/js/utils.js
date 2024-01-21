// goto top btn
var goto_top_btn = document.getElementById("goto-Top");
window.onscroll = () => {onPageScroll()};

function onPageScroll() {
if (document.body.scrollTop > 360 || document.documentElement.scrollTop > 360) {
    goto_top_btn.style.display = "block";
    } 
else {
    goto_top_btn.style.display = "none";
    }
}

function backToTop() {
    window.scroll({
    top: 0, 
    behavior: 'smooth' 
    });
}

// Question and Answer in about us page
// var questions = document.querySelectorAll(".question");
// questions.forEach(question => {
//     question.addEventListener("click", function(){
//         this.classList.toggle("active");
//         var answer = this.nextElementSibling;
//         answer.classList.toggle("show-answer");
//         console.log("clicked")
//     });
// });


// practice

const questionTitles = document.querySelectorAll(".question-title");
const questions = document.querySelector(".question");
questionTitles.forEach(item => {
    console.log(item)
    item.addEventListener("click", ()=>{
        // console.log(item.firstElementChild.classList)
        questionTitles.forEach(question => {
            if (question !== item){
                console.log("hello")
                question.classList.remove("show-answer")
                question.firstElementChild.classList.remove("active");
            }
        })
        // toggling button
        item.firstElementChild.classList.toggle("active");
        item.classList.toggle("show-answer")
        console.log("clicked")
    });
});


// for playing video
const blogVideo = document.querySelector('.blog_posts_row');
const videos = document.querySelectorAll('.video');

videos.forEach(video => {
    video.addEventListener("click", ()=> {
        var popupVideo = document.createElement("div");
        popupVideo.setAttribute("id","popup_video");
        blogVideo.appendChild(popupVideo);
        
        var closeVideo = document.createElement("span");
        closeVideo.setAttribute("class","close-video");
        closeVideo.innerHTML = "&times";
        popupVideo.appendChild(closeVideo);
        
        var vid = document.createElement("video");
        popupVideo.appendChild(vid);
        vid.setAttribute("src",video.getAttribute('src'));
        vid.controls = true;
        vid.autoplay = true;
        vid.setAttribute("class", "video");

        // closing video
        closeVideo.addEventListener("click", () => {
            popupVideo.remove();
        });
        
        
    });
});
