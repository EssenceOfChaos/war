// navbar - indicate active page
document.addEventListener("DOMContentLoaded", function() {
    if (window.location.pathname == "/") {
        let home = document.getElementById("home");
        home.className += " active";
    } else if (window.location.pathname == "/info") {
        let info = document.getElementById("info");
        info.className += " active";
    }
});
console.log("baseJS is now executing...");
console.log("URI path is " + window.location.pathname);