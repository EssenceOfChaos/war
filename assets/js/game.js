/*jshint esversion: 6 */

import socket from './socket';

$(function() {
	let ul = $('#war-game');
	if (ul.length) {
		var id = ul.data('id');
		var topic = 'games:' + id;

		// Channel
		let channel = socket.channel('game:*', {});
		channel
			.join()
			.receive('ok', data => {
				console.log('Joined game channel');
			})
			.receive('error', resp => {
				console.log('Unable to join topic', topic);
			});

		$('#next-card').click(function() {
			console.log("The 'next card' button has been clicked");
			channel.push('next_card');
		});
	}
});
