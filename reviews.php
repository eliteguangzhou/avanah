<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_REVIEWS);
  $tab_sel = tep_href_link(FILENAME_REVIEWS);
  $current_page = FILENAME_REVIEWS;
  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_REVIEWS));

  require(DIR_WS_INCLUDES . 'template_top.php');
?>

<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE; ?></h1>
<?php echo tep_draw_title_bottom();?>

<?php
  $reviews_query_raw = "select r.reviews_id, left(rd.reviews_text, 100) as reviews_text, r.reviews_rating, r.date_added, p.products_id, pd.products_name, p.products_image, r.customers_name from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd, " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = r.products_id and r.reviews_id = rd.reviews_id and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' and rd.languages_id = '" . (int)$languages_id . "' and reviews_status = 1 order by r.reviews_id DESC";
  $reviews_split = new splitPageResults($reviews_query_raw, MAX_DISPLAY_NEW_REVIEWS);

  if ($reviews_split->number_of_rows > 0) {
    if ((PREV_NEXT_BAR_LOCATION == '1') || (PREV_NEXT_BAR_LOCATION == '3')) {
?>

<?php echo tep_draw_result1_top(); ?> 
       
        <div class="cl_both result_top_padd ofh">
        	<div class="fl_left result_left"><?php echo $reviews_split->display_count(TEXT_DISPLAY_NUMBER_OF_REVIEWS); ?></div>
            <div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $reviews_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info'))); ?></div>
        </div>

<?php echo tep_draw_result1_bottom(); ?> 

<?php
    }
?>

<div class="contentContainer page_reviews">
  <div class="contentPadd">

<?php
    $reviews_query = tep_db_query($reviews_split->sql_query);
    while ($reviews = tep_db_fetch_array($reviews_query)) {
?>

<?php
		$p_data = '<b>' . sprintf(TEXT_REVIEW_BY, tep_output_string_protected($reviews['customers_name'])) . '</b>&nbsp;' . sprintf(TEXT_REVIEW_DATE_ADDED, tep_date_long($reviews['date_added']));
	//	$p_data = '<span>' . TEXT_REVIEW_DATE_ADDED . '</span> ' . tep_date_long($reviews['date_added']) . '';
		$p_pic = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_REVIEWS_INFO, 'products_id=' . $reviews['products_id'] . '&reviews_id=' . $reviews['reviews_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $reviews['products_image'], $reviews['products_name'], (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';
		$p_name = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_REVIEWS_INFO, 'products_id=' . $reviews['products_id'] . '&reviews_id=' . $reviews['reviews_id']) . '">' . $reviews['products_name'] . '</a></span> ';
		
		$p_desc = ''.tep_break_string(tep_output_string_protected($reviews['reviews_text']), 60, '-<br />') . ((strlen($reviews['reviews_text']) >= 100) ? '...' : '') . '';
		$p_stars = '' . sprintf(TEXT_REVIEW_RATING, tep_image(DIR_WS_IMAGES . 'icons/stars_' . $reviews['reviews_rating'] . '.png', sprintf(TEXT_OF_5_STARS, $reviews['reviews_rating'])). '<span>', sprintf(TEXT_OF_5_STARS, $reviews['reviews_rating'])).'</span>';

?>
<div class="contentInfoText extra">
<?php
  	echo '
	
	<div class="prods_info decks hover">
		<div class="forecastle">
		<ol class="masthead">
			  <li class="port_side left_side4"><div class="pic_padd wrapper_pic_div fl_left" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$p_pic.''.tep_draw_prod_pic_top().''.tep_draw_prod_pic_bottom().'</a></div></li>
			  <li class="starboard_side bak4">
			  		<div class="info">
						<div class="data data_padd">'.$p_data.'</div>
						<h2 class="name name2_padd">'.$p_name.'</h2>
						<div class="stars stars_padd">'.$p_stars.'</div>
						<div class="desc desc_padd add">'.$p_desc.'</div>
						
					</div>
			  </li>
		</ol>
		</div>	
	</div>';
?>
  </div>

<?php
    }
?>
	</div>
</div>
<?php
    }else {
?>
<div class="contentContainer">
  <div class="contentPadd">

  <div class="">
    <?php echo TEXT_NO_REVIEWS; ?>
  </div>
  </div>  
</div>
<?php
  }

  if (($reviews_split->number_of_rows > 0) && ((PREV_NEXT_BAR_LOCATION == '2') || (PREV_NEXT_BAR_LOCATION == '3'))) {
?>

<?php echo tep_draw_result2_top(); ?> 
       
        <div class="cl_both result_bottom_padd ofh">
        	<div class="fl_left result_left"><?php echo $reviews_split->display_count(TEXT_DISPLAY_NUMBER_OF_REVIEWS); ?></div>
            <div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $reviews_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info'))); ?></div>
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
