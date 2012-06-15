<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  if (isset($HTTP_GET_VARS['reviews_id']) && tep_not_null($HTTP_GET_VARS['reviews_id']) && isset($HTTP_GET_VARS['products_id']) && tep_not_null($HTTP_GET_VARS['products_id'])) {
    $review_check_query = tep_db_query("select count(*) as total from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd where r.reviews_id = '" . (int)$HTTP_GET_VARS['reviews_id'] . "' and r.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and r.reviews_id = rd.reviews_id and rd.languages_id = '" . (int)$languages_id . "' and r.reviews_status = 1");
    $review_check = tep_db_fetch_array($review_check_query);

    if ($review_check['total'] < 1) {
      tep_redirect(tep_href_link(FILENAME_PRODUCT_REVIEWS, tep_get_all_get_params(array('reviews_id'))));
    }
  } else {
    tep_redirect(tep_href_link(FILENAME_PRODUCT_REVIEWS, tep_get_all_get_params(array('reviews_id'))));
  }

  tep_db_query("update " . TABLE_REVIEWS . " set reviews_read = reviews_read+1 where reviews_id = '" . (int)$HTTP_GET_VARS['reviews_id'] . "'");

  $review_query = tep_db_query("select rd.reviews_text, r.reviews_rating, r.reviews_id, r.customers_name, r.date_added, r.reviews_read, p.products_id, p.products_price, p.products_tax_class_id, p.products_image, p.products_model, pd.products_name from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd, " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where r.reviews_id = '" . (int)$HTTP_GET_VARS['reviews_id'] . "' and r.reviews_id = rd.reviews_id and rd.languages_id = '" . (int)$languages_id . "' and r.products_id = p.products_id and p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '". (int)$languages_id . "'");
  $review = tep_db_fetch_array($review_query);

  if ($new_price = tep_get_products_special_price($review['products_id'])) {
    $products_price = '<span class="productSpecialPrice fl_left">' . $currencies->display_price($new_price, tep_get_tax_rate($review['products_tax_class_id'])) . '</span> <del class="fl_left">' . $currencies->display_price($review['products_price'], tep_get_tax_rate($review['products_tax_class_id'])) . '</del>';
  } else {
    $products_price = '<span class="productSpecialPrice">' . $currencies->display_price($review['products_price'], tep_get_tax_rate($review['products_tax_class_id'])) . '</span>';
  }

  if (tep_not_null($review['products_model'])) {
    $products_name = $review['products_name'] . '<br /><span class="smallText">[' . $review['products_model'] . ']</span>';
  } else {
    $products_name = $review['products_name'];
  }

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_PRODUCT_REVIEWS_INFO);
  $tab_sel = tep_href_link(FILENAME_REVIEWS);
  $current_page = FILENAME_REVIEWS;
  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_PRODUCT_REVIEWS, tep_get_all_get_params()));

  require(DIR_WS_INCLUDES . 'template_top.php');
?>

<?php echo tep_draw_content_top();?>


<div class="contentContainer page_reviews">
<div class="contentPadd un">
<?php
// add by Seaman
  	if ((tep_not_null($review['products_image']) == 0) && ($oscTemplate->hasBlocks('box_info_page') == 1)) {
		$port_side = 'left_side1';
		$middle = 'bak1';
		$starboard_side = 'right_side1';
  	}
	if ((tep_not_null($review['products_image']) == 0) && ($oscTemplate->hasBlocks('box_info_page') == 0))	{
		$port_side = 'left_side2';
		$middle = 'bak2';
		$starboard_side = 'right_side2';
	}
	if ((tep_not_null($review['products_image']) == 1) && ($oscTemplate->hasBlocks('box_info_page') == 1))	{
		$port_side = 'left_side3';
		$middle = 'bak3';
		$starboard_side = 'right_side3';
	}
	if ((tep_not_null($review['products_image']) == 1) && ($oscTemplate->hasBlocks('box_info_page') == 0))	{
		$port_side = 'left_side4';
		$middle = 'bak4';
		$starboard_side = 'right_side4';
	}
// add by Seaman	
?>

	<div class="prods_info decks">
		<div class="forecastle">
		<ol class="masthead hover">
			  <li class="port_side <?php echo $port_side;?>">
<?php
  	if (tep_not_null($review['products_image'])) {
?>		              
    <?php echo ''. "\n".
				'<div class="pic_padd wrapper_pic_div fl_left hover" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;"><a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $review['products_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $review['products_image'], addslashes($review['products_name']), (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . ''.tep_draw_prod_pic_top().''.tep_draw_prod_pic_bottom().'</a></div>'. "\n"; ?>
<?php
  	}
?>
              </li>              
			  <li class="bak <?php echo $middle;?>">
                <div class="info3">
            
                    <h2 class="name name2_padd"><?php echo $products_name; ?></h2>
                    <h2 class="price price2_padd"><?php echo '<b>' .PRICE. '</b>' . $products_price; ?></h2>
            
                    <div class="buttonSet"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_IN_CART, 'cart', tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('action')) . 'action=buy_now')); ?><?php echo tep_draw_button_bottom();?></div>
                    
                 </div>   
              </li>
			  <li class="starboard_side <?php echo $starboard_side;?>">              
<?php

	if (($oscTemplate->hasBlocks('box_info_page')))	{
?>
                    <div class="bookmarks">
                        <?php echo $oscTemplate->getBlocks('box_info_page');?>
                    </div>
<?php
  	}
?>
</li>		
<?php		
// add by Seaman
?>        
		</ol>
		</div>	
	</div>


  <div class="clear"></div><br />
  <div class="grid_">
  		<div class="contentInfoText prods_info extra">
        
            <div class="data data_add">
                <div><b><?php echo sprintf(TEXT_REVIEW_BY, tep_output_string_protected($review['customers_name'])); ?></b></div>
                <?php echo sprintf(TEXT_REVIEW_DATE_ADDED, tep_date_long($review['date_added'])); ?>
            </div>
    		<div class="desc desc_padd"><?php echo tep_break_string(nl2br(tep_output_string_protected($review['reviews_text'])), 60, '-<br />') . '</div>'.
			'<div class="stars stars_padd">' . sprintf(TEXT_REVIEW_RATING, tep_image(DIR_WS_IMAGES . 'icons/stars_' . $review['reviews_rating'] . '.png', sprintf(TEXT_OF_5_STARS, $review['reviews_rating'])).'<span>', sprintf(TEXT_OF_5_STARS, $review['reviews_rating'])) . '</span>'; ?></div>

  		</div>
        
      <div class="buttonSet">
            <span class="buttonAction"><?php echo tep_draw_button2_top();?><?php echo tep_draw_button(IMAGE_BUTTON_BACK, 'triangle-1-w', tep_href_link(FILENAME_PRODUCT_REVIEWS, tep_get_all_get_params(array('reviews_id')))); ?><?php echo tep_draw_button2_bottom();?></span>
            <div class="fl_right" align="right"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_WRITE_REVIEW, 'comment', tep_href_link(FILENAME_PRODUCT_REVIEWS_WRITE, tep_get_all_get_params(array('reviews_id'))), 'primary'); ?><?php echo tep_draw_button_bottom();?></div>
      </div>
        
	</div>  

</div>
</div>

<?php echo tep_draw_content_bottom();?>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
