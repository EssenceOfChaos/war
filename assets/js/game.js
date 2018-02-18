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
  }
});
