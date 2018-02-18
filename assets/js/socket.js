/*jshint esversion: 6 */

import { Socket, Presence } from "phoenix";

// Socket
// let user = document.getElementById("current_user").innerText;
let token = $("meta[name=channel_token]").attr("content");
let socket = new Socket("/socket", {
  params: {
    token: token
    // user: user
  },
  logger: (kind, msg, data) => {
    console.log(`${kind}: ${msg}`, data);
  }
});

socket.connect();

// Presence
let presences = {};

function renderOnlineUsers(presences) {
  let response = "";

  Presence.list(presences, (id, { metas: [first, ...rest] }) => {
    let count = rest.length + 1;
    response += `
      <br><strong>${first.username}</strong> (count: ${count})
      <br>
      `;
  });

  document.querySelector("#UserList").innerHTML = response;
}

// Channel
let channel = socket.channel("room:lobby", {});

channel
  .join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => {
    console.log("Unable to join", resp);
  });

channel.on("presence_state", state => {
  presences = Presence.syncState(presences, state);
  renderOnlineUsers(presences);
});

channel.on("presence_diff", diff => {
  presences = Presence.syncDiff(presences, diff);
  renderOnlineUsers(presences);
});

export default socket;
