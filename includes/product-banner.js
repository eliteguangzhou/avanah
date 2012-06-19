/**alert('dsfd');***/
$(document).ready(function (){
$(".container_36 li").hover(
  function () {
	$(this).css(
		"padding-top","10px"
	);
	console.log($(this).css("padding-top"));
  }, 
  function () {
	  $(this).css(
				"padding-top","20px"
			);
  }
);
}
);