/*-------------------------------------------------------------------- 
*
* Created by Dexter (http://cssclub.ru)
*
--------------------------------------------------------------------*/
function equalHeights(element) {	
		var class_name = '.equal-height';
		var maxHeight = 0;	
		var maxItem = 0;
		var maxItem_adjust = 0;		

		element.find(class_name).each(function(i){	
			$(this).wrapInner('<div></div>');				
		});	
				
		function heightChecker(){			
			element.find(class_name).each(function(i){						
				if($(this).outerHeight() > maxHeight) { 
						maxHeight = $(this).outerHeight();
						maxItem = $(this);
						setHeight(maxHeight);
					}				
			});				
			
			maxItem_adjust = maxItem.outerHeight()-maxItem.height();
			if(maxHeight > (maxItem.children().height() + maxItem_adjust)){
					maxHeight = maxItem.children().height() + maxItem_adjust;
					setHeight(maxHeight);									
				}
				
		//	setTimeout(function(){heightChecker()}, 1000)			
		 }	
		 
		function setHeight(target){
			element.find(class_name).each(function(i){
						var adjust = $(this).outerHeight()-$(this).height();						
						if($.browser.msie && $.browser.version < 7.0){
								   $(this).css({'height': target - adjust });								   
							}
							else{
  								   $(this).css({'min-height': target - adjust });	
								}
					})
		  }
		
		heightChecker();
}
function equalHeights2(element) {	
		var class_name2 = '.equal-height2';
		var maxHeight2 = 0;	
		var maxItem2 = 0;
		var maxItem2_adjust = 0;		

		element.find(class_name2).each(function(j){	
			$(this).wrapInner('<div></div>');				
		});	
				
		function heightChecker2(){			
			element.find(class_name2).each(function(j){						
				if($(this).outerHeight() > maxHeight2) { 
						maxHeight2 = $(this).outerHeight();
						maxItem2 = $(this);
						setHeight2(maxHeight2);
					}				
			});				
			
			maxItem2_adjust = maxItem2.outerHeight()-maxItem2.height();
			if(maxHeight2 > (maxItem2.children().height() + maxItem2_adjust)){
					maxHeight2 = maxItem2.children().height() + maxItem2_adjust;
					setHeight2(maxHeight2);									
				}
				
		//	setTimeout(function(){heightChecker2()}, 1000)			
		 }	
		 
		function setHeight2(target){
			element.find(class_name2).each(function(j){
						var adjust2 = $(this).outerHeight()-$(this).height();						
						if($.browser.msie && $.browser.version < 7.0){
								   $(this).css({'height': target - adjust2 });								   
							}
							else{
  								   $(this).css({'min-height': target - adjust2 });	
								}
					})
		  }
		heightChecker2();		  
}		

		
		
function equalHeights3(element) {	
		var class_name3 = '.equal-height3';
		var maxHeight3 = 0;	
		var maxItem3 = 0;
		var maxItem3_adjust = 0;		

		element.find(class_name3).each(function(j){	
			$(this).wrapInner('<div></div>');				
		});	
				
		function heightChecker3(){			
			element.find(class_name3).each(function(j){						
				if($(this).outerHeight() > maxHeight3) { 
						maxHeight3 = $(this).outerHeight();
						maxItem3 = $(this);
						setHeight(maxHeight3);
					}				
			});				
			
			maxItem3_adjust = maxItem3.outerHeight()-maxItem3.height();
			if(maxHeight3 > (maxItem3.children().height() + maxItem3_adjust)){
					maxHeight3 = maxItem3.children().height() + maxItem3_adjust;
					setHeight(maxHeight3);									
				}
				
		//	setTimeout(function(){heightChecker3()}, 1000)			
		 }	
		 
		function setHeight(target){
			element.find(class_name3).each(function(j){
						var adjust3 = $(this).outerHeight()-$(this).height();						
						if($.browser.msie && $.browser.version < 7.0){
								   $(this).css({'height': target - adjust3 });								   
							}
							else{
  								   $(this).css({'min-height': target - adjust3 });	
								}
					})
		  }
		
		heightChecker3();
}
function equalHeights_box(element) {	
		var class_name_box = '.equal-height-box';
		var maxHeight_box = 0;	
		var maxItem_box = 0;
		var maxItem_box_adjust = 0;		

		element.find(class_name_box).each(function(j){	
			$(this).wrapInner('<div></div>');				
		});	
				
		function heightChecker_box(){			
			element.find(class_name_box).each(function(j){						
				if($(this).outerHeight() > maxHeight_box) { 
						maxHeight_box = $(this).outerHeight();
						maxItem_box = $(this);
						setHeight(maxHeight_box);
					}				
			});				
			
			maxItem_box_adjust = maxItem_box.outerHeight()-maxItem_box.height();
			if(maxHeight_box > (maxItem_box.children().height() + maxItem_box_adjust)){
					maxHeight_box = maxItem_box.children().height() + maxItem_box_adjust;
					setHeight(maxHeight_box);									
				}
				
		//	setTimeout(function(){heightChecker_box()}, 1000)			
		 }	
		 
		function setHeight(target){
			element.find(class_name_box).each(function(j){
						var adjust_box = $(this).outerHeight()-$(this).height();						
						if($.browser.msie && $.browser.version < 7.0){
								   $(this).css({'height': target - adjust_box });								   
							}
							else{
  								   $(this).css({'min-height': target - adjust_box });	
								}
					})
		  }
		
		heightChecker_box();
		
}
function equalHeights4(element) {	
		var class_name4 = '.equal-height-price';
		var maxHeight4 = 0;	
		var maxItem4 = 0;
		var maxItem4_adjust = 0;		

		element.find(class_name4).each(function(j){	
			$(this).wrapInner('<div></div>');				
		});	
				
		function heightChecker4(){			
			element.find(class_name4).each(function(j){						
				if($(this).outerHeight() > maxHeight4) { 
						maxHeight4 = $(this).outerHeight();
						maxItem4 = $(this);
						setHeight(maxHeight4);
					}				
			});				
			
			maxItem4_adjust = maxItem4.outerHeight()-maxItem4.height();
			if(maxHeight4 > (maxItem4.children().height() + maxItem4_adjust)){
					maxHeight4 = maxItem4.children().height() + maxItem4_adjust;
					setHeight(maxHeight4);									
				}
				
		//	setTimeout(function(){heightChecker4()}, 1000)			
		 }	
		 
		function setHeight(target){
			element.find(class_name4).each(function(j){
						var adjust4 = $(this).outerHeight()-$(this).height();						
						if($.browser.msie && $.browser.version < 7.0){
								   $(this).css({'height': target - adjust4 });								   
							}
							else{
  								   $(this).css({'min-height': target - adjust4 });	
								}
					})
		  }
		
		heightChecker4();
}
function equalHeights5(element) {	
		var class_name5 = '.equal-height5';
		var maxHeight5 = 0;	
		var maxItem5 = 0;
		var maxItem5_adjust = 0;		

		element.find(class_name5).each(function(j){	
			$(this).wrapInner('<div></div>');				
		});	
				
		function heightChecker5(){			
			element.find(class_name5).each(function(j){						
				if($(this).outerHeight() > maxHeight5) { 
						maxHeight5 = $(this).outerHeight();
						maxItem5 = $(this);
						setHeight5(maxHeight5);
					}				
			});				
			
			maxItem5_adjust = maxItem5.outerHeight()-maxItem5.height();
			if(maxHeight5 > (maxItem5.children().height() + maxItem5_adjust)){
					maxHeight5 = maxItem5.children().height() + maxItem5_adjust;
					setHeight5(maxHeight5);									
				}
				
		//	setTimeout(function(){heightChecker5()}, 1000)			
		 }	
		 
		function setHeight5(target){
			element.find(class_name5).each(function(j){
						var adjust5 = $(this).outerHeight()-$(this).height();						
						if($.browser.msie && $.browser.version < 7.0){
								   $(this).css({'height': target - adjust5 });								   
							}
							else{
  								   $(this).css({'min-height': target - adjust5 });	
								}
					})
		  }
		heightChecker5();		  
}		
