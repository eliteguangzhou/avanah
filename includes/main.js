
$(document).ready(function() {
	//loop{
	loop();
	//}
 })
var loop = function (){
    $(".img_front").each(function(index) {
        $(this).hide();
        $(this).delay(4000 * index).fadeIn(4000).fadeOut();
    });
    setTimeout(loop,8000);
}