// navbar - indicate active page
document.addEventListener("DOMContentLoaded", function() {
    if (window.location.pathname == "/") {
        home = document.getElementById("home");
        home.className += " active";
    } else if (window.location.pathname == "/info") {
        info = document.getElementById("info");
        info.className += " active";
    }
});
console.log("baseJS is now executing...");
console.log("URI path is " + window.location.pathname);