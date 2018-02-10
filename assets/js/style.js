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
});

/* Define API endpoints once globally */
// $.fn.api.settings.api = {
//     "get followers": "/followers/{id}?results={count}",
//     "create user": "/create",
//     "add user": "/add/{id}",
//     "follow user": "/follow/{id}",
//     search: "/search/?query={value}"
// };

// // translates '/follow/{id}' to 'follow/22'
// $(".follow.button").api({
//     action: "follow user",
//     urlData: {
//         id: 22
//     }
// });