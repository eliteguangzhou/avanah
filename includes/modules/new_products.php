<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/
?>
<?php
if ($first_page === true){
  if ( (!isset($new_products_category_id)) || ($new_products_category_id == '0') ) {
    $new_products_query = tep_db_query("select p.products_id, p.products_image, p.products_tax_class_id, pd.products_name, if(s.status, s.specials_new_products_price, p.products_price) as products_price from " . TABLE_PRODUCTS . " p left join " . TABLE_SPECIALS . " s on p.products_id = s.products_id, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by p.products_date_added desc limit " . MAX_DISPLAY_PRODUCTS_FIRST_PAGE);
  } else {
    $new_products_query = tep_db_query("select distinct p.products_id, p.products_image, p.products_tax_class_id, pd.products_name, if(s.status, s.specials_new_products_price, p.products_price) as products_price from " . TABLE_PRODUCTS . " p left join " . TABLE_SPECIALS . " s on p.products_id = s.products_id, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c, " . TABLE_CATEGORIES . " c where p.products_id = p2c.products_id and p2c.categories_id = c.categories_id and c.parent_id = '" . (int)$new_products_category_id . "' and p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by p.products_date_added desc limit " . MAX_DISPLAY_PRODUCTS_FIRST_PAGE);
  }
}else{
  if ( (!isset($new_products_category_id)) || ($new_products_category_id == '0') ) {
    $new_products_query = tep_db_query("select p.products_id, p.products_image, p.products_tax_class_id, pd.products_name, if(s.status, s.specials_new_products_price, p.products_price) as products_price from " . TABLE_PRODUCTS . " p left join " . TABLE_SPECIALS . " s on p.products_id = s.products_id, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by p.products_date_added desc limit " . MAX_DISPLAY_NEW_PRODUCTS);
  } else {
    $new_products_query = tep_db_query("select distinct p.products_id, p.products_image, p.products_tax_class_id, pd.products_name, if(s.status, s.specials_new_products_price, p.products_price) as products_price from " . TABLE_PRODUCTS . " p left join " . TABLE_SPECIALS . " s on p.products_id = s.products_id, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c, " . TABLE_CATEGORIES . " c where p.products_id = p2c.products_id and p2c.categories_id = c.categories_id and c.parent_id = '" . (int)$new_products_category_id . "' and p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by p.products_date_added desc limit " . MAX_DISPLAY_NEW_PRODUCTS);
  }
}
  $col = 0;
  $row = 0;
  
  if ($first_page == 0){  
  $col_items = (MAX_DISPLAY_NEW_PRODUCTS_PER_ROW - 1);
  $colspan = ((MAX_DISPLAY_NEW_PRODUCTS_PER_ROW * 2) - 1);
  }else{
  $col_items = (MAX_DISPLAY_NEW_PRODUCTS_PER_ROW_FIRST_PAGE - 1);
  $colspan = ((MAX_DISPLAY_NEW_PRODUCTS_PER_ROW_FIRST_PAGE * 2) - 1);
  }
  $col_width = (int)(100 / ($col_items + 1)).'%';

  $new_prods_content .= '<div class="prods_content prods_table">';
  while ($new_products = tep_db_fetch_array($new_products_query)) {
	if (($col === 0) && ($row != 0)) {
	  $new_prods_content .= '<ul><li class="prods_hseparator">'.tep_draw_separator('spacer.gif', '1', '1').'</li></ul>';
	} 
	if ($col === 0) {
      $new_prods_content .= '<ul class="row row3" id="row-'.$row.'">';
   }else {
	   $new_prods_content .= '<li class="prods_vseparator equal-height3">'.tep_draw_separator('spacer.gif', '1', '1').''; 
   }
// *************************************   
// *************************************
      $product_query = tep_db_query("select products_description, products_id from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id = '" . (int)$new_products['products_id'] . "' and language_id = '" . (int)$languages_id . "'");
      $product = tep_db_fetch_array($product_query);
	  $p_id = $new_products['products_id'];	
		  
	  $p_pic = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $new_products['products_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $new_products['products_image'], $new_products['products_name'], (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';
	  
	  $p_name = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $new_products['products_id']) . '">' . $new_products['products_name'] . '</a></span>';
	  
	//  $p_desc = ''.substr(strip_tags($product['products_description']), 0, MAX_DESCR_1).' ...';

	  $p_desc =  mb_substr(strip_tags($product['products_description']), 0, MAX_DESCR_MODUL_NEW_PRODS, 'UTF-8').'...';
	  
	  $p_price = '<span class="productSpecialPrice">' . $currencies->display_price($new_products['products_price'], tep_get_tax_rate($new_products['products_tax_class_id'])) . '</span>';
// *************************************  
	  $p_details_text = '' .tep_draw_button2_top() . '<a href="' . tep_href_link('product_info.php?products_id='.$p_id) . '" id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-triangle-1-e"></span><span class="ui-button-text">'.  IMAGE_BUTTON_DETAILS .'</span></a>' . tep_draw_button2_bottom().'';
	  $p_buy_now_text = '' .tep_draw_button_top() . '<a href="'.tep_href_link("products_new.php","action=buy_now&products_id=".$p_id).'" id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-cart"></span><span class="ui-button-text">'.  IMAGE_BUTTON_IN_CART .'</span></a>' . tep_draw_button_bottom().'';
// *************************************
// *************************************

    $new_prods_content .= '<li style="width:'.PRODS_BLOCK_WIDTH.'px;" class="wrapper_prods equal-height3 hover">'.
				  
				  '<div class="border_prods">'.
				  '		<div class="pic_padd wrapper_pic_div" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$p_pic.''.tep_draw_prod_pic_top().''.tep_draw_prod_pic_bottom().'</a></div>'. "\n".
				  '		<div class="prods_padd">'.				  				  	 
				 
				  '			<div class="name name_padd  equal-height">'.$p_name.'</div>'. "\n".
				  '			<div class="desc desc_padd">'.$p_desc.'</div>'. "\n".
				  '			<h2 class="price price_padd"><b>'.PRICE. '</b>'.$p_price.'</h2>'. "\n".		
				  '			<div class="button__padd">'.$p_details_text.' '.$p_buy_now_text.'</div>'. "\n".
				  '		</div>'. "\n".				  
				  '</div>'. "\n";				  

    $col ++;
    if ($col > $col_items) {
      	$new_prods_content .= '</ul>';
	  	$row ++;
      	$col = 0;
    }else{
		$new_prods_content .= '</li>';	
	}
  }

  $new_prods_content .= '</div>';
?>
<?php
			if ($current_page != FILENAME_DEFAULT)	{
?>

<?php echo tep_draw_title_top();?>
<h1 class="cl_both "><?php echo sprintf(TABLE_HEADING_NEW_PRODUCTS, strftime('%B')); ?></h1>
<?php echo tep_draw_title_bottom();?>
  <div class="contentPadd">
    <?php echo $new_prods_content; ?>
  </div>

<script type="text/javascript">
        $(document).ready(function(){ 			
			 var row_list = $('.row');
			 row_list.each(function(){
				 new equalHeights($('#' + $(this).attr("id")));
			  });			 			 			  			  			  			  			   
			 var row_list2 = $('.row2');
			 row_list2.each(function(){
				// console.log($(this))
				 new equalHeights2($('.sub_categories'));
			  });			 			 			  			  			  			  			   
			 var row_list3 = $('.row3');
			 row_list3.each(function(){
				 new equalHeights3($('#' + $(this).attr("id")));
			  });
			 var row_list5 = $('.row5');
			 row_list5.each(function(){
				 new equalHeights5($('.bestsellers_slider'));
			  });			 			 			  			  			  			  			   			 
			  			 			 			  			  			  			  			   
        })
</script>
 <?php 
			}
?>			