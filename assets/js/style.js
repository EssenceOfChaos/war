/*jshint esversion: 6 */
// navbar - indicate active page
document.addEventListener("DOMContentLoaded", function() {
    if (window.location.pathname == "/") {
        let home = document.getElementById("home");
        home.className += " active";
    } else if (window.location.pathname == "/info") {
        let info = document.getElementById("info");
        info.className += " active";
    }

    $("#progress-bar").progress();
});
console.log("baseJS is now executing...");
console.log("URI path is " + window.location.pathname);

$(document).ready(function() {
    // create sidebar and attach to menu open
    $(".ui.sidebar").sidebar("attach events", ".toc.item");
    $(".ui.secondary.button").click(function() {
        console.log("Secondary Button Clicked!");
    });
});

/* Define API endpoints once globally */
$.fn.api.settings.api = {
    "next card": "/game-in-progress",
    search: "/search/?query={value}"
};