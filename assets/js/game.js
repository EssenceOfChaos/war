/*jshint esversion: 6 */

import socket from "./socket";

$(function() {
  let ul = $("#war-game");
  if (ul.length) {
    var id = ul.data("id");
    var topic = "games:" + id;

    // Join the topic
    let channel = socket.channel(topic, {});
    channel
      .join()
      .receive("ok", data => {
        console.log("Joined topic", topic);
      })
      .receive("error", resp => {
        console.log("Unable to join topic", topic);
      });

    $("#next-card").click(function() {
      console.log("The 'next card' button has been clicked");
      channel.push("next_card");
    });

    // channel.on("new_msg") => () {
    //   let user_card = document.getElementById("user_card");

    // });
  }
});
