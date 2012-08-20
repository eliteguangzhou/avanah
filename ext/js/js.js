$(function(){
	$('.contentPadd h3').first().addClass('first_h3');
	$('.contentPadd.loginPage h3').addClass('first_h3');
	$('.contentInfoText, .contentInfoBlock').last().addClass('marg-bottom');
	$('.loginPage .contentInfoText').addClass('marg-top');
	
	$('.cart th').last().css('border-right','0px');
	$('.cart_prods').css('border-width','0px 1px 1px 0px');
	$('.cart_update').css('border-width','0px 1px 1px 0px');
	$('.cart_price').css('border-width','0px 0px 1px 0px');	
	$('.cart_total td:nth-child(2)').css('border-width','0px 1px 0px 0px');
	$('.desc p').first().css('padding-top','0px');
	
	$('ul').each(function (ul) {
	$(this).find('li').first().addClass('first');
	$(this).find('li').last().addClass('last');
	});	
	
	$('.prods_content').each(function (div) {
	$(this).find('ul.row').first().addClass('first');
	$(this).find('ul.row').last().addClass('last');	
	});
	
	$('.breadcrumb').each(function (breadcrumb) {
	$(this).find('a').last().addClass('last');	
	});
	
});
$(function(){
	var keeper=$('.wrapper_pic_div'),
		zoomPic=$('.wrapper_pic_zoom, ').css({opacity:0})
	keeper
	 .bind('mouseenter',function(){
	  zoomPic
		.stop()
		.animate({opacity:1})
		
	 })
	 .bind('mouseleave',function(){
		zoomPic
			.stop()
			.animate({opacity:0})
	 })	

})
$(document).ready(function(){
	// hide #back-top first
	$("#back-top").hide();
	// fade in #back-top
	$(function () {
		$(window).scroll(function () {
			if ($(this).scrollTop() > 100) {
				$('#back-top').fadeIn();
			} else {
				$('#back-top').fadeOut();
			}
		});
		// scroll body to 0px on click
		$('#back-top a').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});
	});

});
$(function atload(){
	$("#piGal").css('visibility','visible');
	window.onload=atload;
});


