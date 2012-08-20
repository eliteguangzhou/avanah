<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_SPECIALS);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_SPECIALS));
  $tab_sel = tep_href_link(FILENAME_SPECIALS); 
  $current_page = FILENAME_SPECIALS;  
  
  require(DIR_WS_INCLUDES . 'template_top.php');
?>
<script type="text/javascript">
        $(document).ready(function(){ 			
			 var row_list = $('.row');
			 row_list.each(function(){
				 new equalHeights($('#' + $(this).attr("id")));
			  });
			 var row_list3 = $('.row3');
			 row_list3.each(function(){
				 new equalHeights3($('#' + $(this).attr("id")));
			  });			 			 			  			  			  			  			   			  				  
        })      
</script>
<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE; ?></h1>
<?php echo tep_draw_title_bottom();?>

<?php
  $specials_query_raw = "select p.products_id, pd.products_name, p.products_price, p.products_tax_class_id, p.products_image, s.specials_new_products_price from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_SPECIALS . " s where p.products_status = '1' and s.products_id = p.products_id and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' and s.status = '1' order by s.specials_date_added DESC";
  $specials_split = new splitPageResults($specials_query_raw, MAX_DISPLAY_SPECIAL_PRODUCTS);

  if (($specials_split->number_of_rows > 0) && ((PREV_NEXT_BAR_LOCATION == '1') || (PREV_NEXT_BAR_LOCATION == '3'))) {
?>

<?php echo tep_draw_result1_top(); ?> 
       
        <div class="cl_both result_top_padd ofh">
        	<div class="fl_left result_left"><?php echo $specials_split->display_count(TEXT_DISPLAY_NUMBER_OF_SPECIALS); ?></div>
            <div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $specials_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info', 'x', 'y'))); ?></div>
        </div>

<?php echo tep_draw_result1_bottom(); ?> 

<?php
  }
?>  
<div class="contentContainer page_un">
  <div class="contentPadd">
<?php
  $col = 0;
  $row = 0;
  
  $col_items = (MAX_DISPLAY_SPECIAL_PER_ROW -1);
  $colspan = ((MAX_DISPLAY_SPECIAL_PER_ROW * 2) - 1);  
  $col_width = (int)(100 / ($col_items + 1)).'%';
?>

<?php
	$specials_prods_content .= '<div class="prods_content">';
	$specials_query = tep_db_query($specials_split->sql_query);
    while ($specials = tep_db_fetch_array($specials_query)) {
	if (($col === 0) && ($row != 0)) {
	  $specials_prods_content .= '<ul><li class="prods_hseparator">'.tep_draw_separator('spacer.gif', '1', '1').'</li></ul>';
	} 
	if ($col === 0) {
      $specials_prods_content .= '<ul class="row row3" id="row-'.$row.'">';
   }else {
	  $specials_prods_content .= '<li class="prods_vseparator equal-height3">'.tep_draw_separator('spacer.gif', '1', '1').''; 
   }
// *************************************   
// *************************************
		
	$product_query = tep_db_query("select products_description, products_id from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id = '" . (int)$specials['products_id'] . "' and language_id = '" . (int)$languages_id . "'");
	$product = tep_db_fetch_array($product_query);
	$p_id = $product['products_id'];
		
    $row++;
// *************************************
// *************************************
  	$p_pic = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $specials['products_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $specials['products_image'], $specials['products_name'], (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';
  	$p_name = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $specials['products_id']) . '">' . $specials['products_name'] . '</a></span>';
	$p_desc =  mb_substr(strip_tags($product['products_description']), 0, MAX_DESCR_SPECIALS, 'UTF-8').'...';
  	$p_price = '<span class="productSpecialPrice">' . $currencies->display_price($specials['specials_new_products_price'], tep_get_tax_rate($specials['products_tax_class_id'])) . '</span>
		   <del class="fl_right">' . $currencies->display_price($specials['products_price'], tep_get_tax_rate($specials['products_tax_class_id'])) . '</del>';
// *************************************  
    $p_details_text = '' .tep_draw_button2_top() . '<a href="' . tep_href_link('product_info.php?products_id='.$p_id) . '" id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-triangle-1-e"></span><span class="ui-button-text">'.  IMAGE_BUTTON_DETAILS .'</span></a>' . tep_draw_button2_bottom().'';

    $p_buy_now_text = '' .tep_draw_button_top() . '<a href="'.tep_href_link("products_new.php","action=buy_now&products_id=".$p_id).'" id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-cart"></span><span class="ui-button-text">'.  IMAGE_BUTTON_IN_CART .'</span></a>' . tep_draw_button_bottom().'';

// *************************************
// *************************************

    $specials_prods_content .= '<li style="width:' . PRODS_BLOCK_WIDTH . 'px;" class="wrapper_prods equal-height3 hover">'. "\n".
				  '<div class="border_prods">'.
				  
				  '<div class="pic_padd wrapper_pic_div" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$p_pic.''.tep_draw_prod_pic_top().''.tep_draw_prod_pic_bottom().'</a></div>'. "\n".
				  '<div class="prods_padd">'.				  				  	 
				 
				  '		<div class="name name_padd  equal-height">'.$p_name.'</div>'. "\n".
				  '		<div class="desc desc_padd">'.$p_desc.'</div>'. "\n".
				  '		<h2 class="price price_padd"><b>'.PRICE. '</b>'.$p_price.'</h2>'. "\n".		
				  '		<div class="button__padd">'.$p_details_text.' '.$p_buy_now_text.'</div>'. "\n".
				  '</div>'. "\n".				  
				  '</div>'. "\n";				  
				 

    $col ++;

	
    if ($col > $col_items) {
       $specials_prods_content .= '</ul>';
	   $row ++;
       $col = 0;
    }else{
	   $specials_prods_content .= '</li>';	
  }
}
  $specials_prods_content .= '</div>';
  echo $specials_prods_content;
?>
  </div>
</div>

<?php
  if (($specials_split->number_of_rows > 0) && ((PREV_NEXT_BAR_LOCATION == '2') || (PREV_NEXT_BAR_LOCATION == '3'))) {
?>

<?php echo tep_draw_result2_top(); ?> 
       
        <div class="cl_both result_bottom_padd ofh">
        	<div class="fl_left result_left"><?php echo $specials_split->display_count(TEXT_DISPLAY_NUMBER_OF_SPECIALS); ?></div>
            <div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $specials_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info', 'x', 'y'))); ?></div>
        </div>

<?php echo tep_draw_result2_bottom(); ?> 

<?php
  }
?>

<?php echo tep_draw_content_bottom();?>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
