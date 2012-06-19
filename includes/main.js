$(document).ready(function() {
	//loop{
	loop();
	//}
})
function loop() {
	var images = $(".img_front");
	var i = 0;

	$('#image'+i).fadeIn(1500);
	i++;
	setInterval(function(){
		images.hide();
		$('#image'+i).fadeIn(1500);
		i++;
		if (i == images.length) {
            i=0;
        }
	}, 2000);
}