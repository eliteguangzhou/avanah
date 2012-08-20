/**alert('dsfd');***/
$(document).ready(function (){
$(".banner_set  li").hover(
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