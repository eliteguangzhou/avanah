<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  if (!isset($HTTP_GET_VARS['products_id']) || !is_numeric($HTTP_GET_VARS['products_id'])) {
    tep_redirect(tep_href_link(FILENAME_REVIEWS));
  }

  $product_info_query = tep_db_query("select p.products_id, p.products_model, p.products_image, p.products_price, p.products_tax_class_id, pd.products_name from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "'");
  if (!tep_db_num_rows($product_info_query)) {
    tep_redirect(tep_href_link(FILENAME_REVIEWS));
  } else {
    $product_info = tep_db_fetch_array($product_info_query);
  }

  if ($new_price = tep_get_products_special_price($product_info['products_id'])) {
    $products_price = '<span class="productSpecialPrice fl_left">' . $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])) . '</span><del>' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</del>';
  } else {
    $products_price = '<span class="productSpecialPrice">' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</span>';
  }

  if (tep_not_null($product_info['products_model'])) {
    $products_name = $product_info['products_name'] . '<br /><span class="smallText">[' . $product_info['products_model'] . ']</span>';
  } else {
    $products_name = $product_info['products_name'];
  }

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_PRODUCT_REVIEWS);
  $tab_sel = tep_href_link(FILENAME_REVIEWS);
  $current_page = FILENAME_REVIEWS;
  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_PRODUCT_REVIEWS, tep_get_all_get_params()));

  require(DIR_WS_INCLUDES . 'template_top.php');
?>


<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<div>
  <h1 style="float: right;"><?php echo $products_price; ?></h1>
  <h1><?php echo $products_name; ?></h1>
</div>
<?php echo tep_draw_title_bottom();?>
<?php
  if ($messageStack->size('product_reviews') > 0) { 
    echo $messageStack->output('product_reviews');
  }
// add by Seaman   
	switch (tep_not_null($product_info['products_image'])) {
	case 0:
		$port_side = 'left_side_pic-0';
		$starboard_side = 'right_side_pic-0';
		break;
	case 1:
		$port_side = 'left_side_pic-1';
		$starboard_side = 'right_side_pic-1';
		break;
	}   
// add by Seaman     
?>
<div class="contentContainer page_reviews">
  <div class="contentPadd">

	<div class="prods_info decks">
		<div class="forecastle">
		<ol class="masthead">
			  <li class="port_side <?php echo $port_side;?>">

							<?php
                              if (tep_not_null($product_info['products_image'])) {
                            ?>
                            
        
                                <?php echo '<div class="pic_padd wrapper_pic_div fl_left hover" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;"><a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $product_info['products_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $product_info['products_image'], addslashes($product_info['products_name']), (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . ''.tep_draw_prod_pic_top().''.tep_draw_prod_pic_bottom().'</a></div>'; ?>
                            
                                <br class="cl_both" />
                                <div class="buttonSet"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_IN_CART, 'cart', tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('action')) . 'action=buy_now')); ?><?php echo tep_draw_button_bottom();?></div>
       
                            
                            <?php
                              }
                            ?>
			  </li>  
<?php
  $reviews_query_raw = "select r.reviews_id, left(rd.reviews_text, 100) as reviews_text, r.reviews_rating, r.date_added, r.customers_name from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd where r.products_id = '" . (int)$product_info['products_id'] . "' and r.reviews_id = rd.reviews_id and rd.languages_id = '" . (int)$languages_id . "' and r.reviews_status = 1 order by r.reviews_id desc";
  $reviews_split = new splitPageResults($reviews_query_raw, MAX_DISPLAY_NEW_REVIEWS);
?>


<?php              
  if ($reviews_split->number_of_rows > 0) {
?>
			  <li class="starboard_side <?php echo $starboard_side;?>">
              		<div class="info2">
							<?php	  
								if ((PREV_NEXT_BAR_LOCATION == '1') || (PREV_NEXT_BAR_LOCATION == '3')) {
							?>

							<div class="result_un">
							<?php echo tep_draw_result1_top(); ?> 
								   
									<div class="cl_both result_top_padd ofh">
										<div class="fl_left result_left"><?php echo $reviews_split->display_count(TEXT_DISPLAY_NUMBER_OF_REVIEWS); ?></div>
										<div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $reviews_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info'))); ?></div>
									</div>
							
							<?php echo tep_draw_result1_bottom(); ?> 
							</div>
							<?php
								}
							?>
                            
                            
                            
							<?php
                                $reviews_query = tep_db_query($reviews_split->sql_query);
                                while ($reviews = tep_db_fetch_array($reviews_query)) {
                            ?>
                            <div class="prods_info">
                              <h3>
                                
                                <span><?php echo '<a href="' . tep_href_link(FILENAME_PRODUCT_REVIEWS_INFO, 'products_id=' . $product_info['products_id'] . '&reviews_id=' . $reviews['reviews_id']) . '">' . sprintf(TEXT_REVIEW_BY, tep_output_string_protected($reviews['customers_name'])) . '</a>'; ?></span>
                                <?php echo sprintf(TEXT_REVIEW_DATE_ADDED, tep_date_long($reviews['date_added'])); ?>
                              </h3>
                            
                              <div class="contentInfoText extra">
                                <?php echo tep_break_string(tep_output_string_protected($reviews['reviews_text']), 60, '-<br />') . ((strlen($reviews['reviews_text']) >= 100) ? '..' : '') . '<br /><br />
								
								<div class="stars stars_padd">' . sprintf(TEXT_REVIEW_RATING, tep_image(DIR_WS_IMAGES . 'icons/stars_' . $reviews['reviews_rating'] . '.png', sprintf(TEXT_OF_5_STARS, $reviews['reviews_rating'])).'<span>', sprintf(TEXT_OF_5_STARS, $reviews['reviews_rating'])) . '</span></div>'; ?>
                              </div>
                            </div>
                            <?php
                                }
                            ?>
                            
							<?php
                              if (($reviews_split->number_of_rows > 0) && ((PREV_NEXT_BAR_LOCATION == '2') || (PREV_NEXT_BAR_LOCATION == '3'))) {
                            ?>
                            <div class="result_un">
                            <?php echo tep_draw_result2_top(); ?>        
                                    <div class="cl_both result_bottom_padd ofh">
                                        <div class="fl_left result_left"><?php echo $reviews_split->display_count(TEXT_DISPLAY_NUMBER_OF_REVIEWS); ?></div>
                                        <div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $reviews_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info'))); ?></div>
                                    </div>
                            <?php echo tep_draw_result2_bottom(); ?> 
                            </div>
                            <?php
                              }
                            ?> 
              		</div>
			  </li>	                                                
                            
<?php	
  } else {
?>
			  <li class="starboard_side">
              		<div class="info2"><?php echo TEXT_NO_REVIEWS; ?></div>
			  </li>		
<?php
  }
?>
              		
    
		</ol>
		</div>	
	</div>
    
	<br class="cl_both fs_lh" />
    
 	<div class="buttonSet">
    	<span class="buttonAction"><?php echo tep_draw_button2_top();?><?php echo tep_draw_button(IMAGE_BUTTON_BACK, 'triangle-1-w', tep_href_link(FILENAME_PRODUCT_INFO, tep_get_all_get_params())); ?><?php echo tep_draw_button2_bottom();?></span>

    	<div class="fl_right" align="right"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_WRITE_REVIEW, 'comment', tep_href_link(FILENAME_PRODUCT_REVIEWS_WRITE, tep_get_all_get_params()), 'primary'); ?><?php echo tep_draw_button_bottom();?></div>
  </div>
  
  </div>
</div>

<?php echo tep_draw_content_bottom();?>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
