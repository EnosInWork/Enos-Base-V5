var audioPlayer = null;
window.addEventListener('message', function(e) {
	// console.log(JSON.stringify(e))
    if (e.data.playsong == 'true') {
  		
	  if (audioPlayer != null) {
		audioPlayer.pause();
		audioPlayer.currentTime = 0;
	  }
	  audioPlayer = new Audio("./sound/Rf"+e.data.songname+".ogg");
	  audioPlayer.volume = 0.3;

	  audioPlayer.play();
	}
});