<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class bm_reviews {
    var $code = 'bm_reviews';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function bm_reviews() {
      $this->title = MODULE_BOXES_REVIEWS_TITLE;
      $this->description = MODULE_BOXES_REVIEWS_DESCRIPTION;

      if ( defined('MODULE_BOXES_REVIEWS_STATUS') ) {
        $this->sort_order = MODULE_BOXES_REVIEWS_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_REVIEWS_STATUS == 'True');
        $this->pages = MODULE_BOXES_REVIEWS_DISPLAY_PAGES;
        $this->group = ((MODULE_BOXES_REVIEWS_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

    function execute() {
      global $languages_id, $HTTP_GET_VARS, $currencies, $oscTemplate;

      $random_select = "select r.reviews_id, r.reviews_rating, p.products_id, p.products_image, pd.products_name from " . TABLE_REVIEWS . " r, " . TABLE_REVIEWS_DESCRIPTION . " rd, " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = r.products_id and r.reviews_id = rd.reviews_id and rd.languages_id = '" . (int)$languages_id . "' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' and r.reviews_status = 1";
      if (isset($HTTP_GET_VARS['products_id'])) {
        $random_select .= " and p.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "'";
      }
      $random_select .= " order by r.reviews_id desc limit " . MAX_RANDOM_SELECT_REVIEWS;
      $random_product = tep_random_select($random_select);

      $reviews_box_contents = '';

      if ($random_product) {
// display random review box
        $rand_review_query = tep_db_query("select reviews_text as reviews_text from " . TABLE_REVIEWS_DESCRIPTION . " where reviews_id = '" . (int)$random_product['reviews_id'] . "' and languages_id = '" . (int)$languages_id . "'");
        $rand_review = tep_db_fetch_array($rand_review_query);
		$p_id = $random_product['products_id'];
		$r_id = $random_product['reviews_id'];
		
		$rand_review_text =  ''.mb_substr(strip_tags($rand_review['reviews_text']), 0, MAX_DESCR_BOX, 'UTF-8').'...';
		
		$name_prod = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id='.$p_id) . '">'.$random_product['products_name'].'</a></span>';
		$pic_prod = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_REVIEWS_INFO, 'products_id=' . $p_id . '&reviews_id=' . $r_id) . '" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $random_product['products_image'], $random_product['products_name'], (BOX_IMAGE_WIDTH), (BOX_IMAGE_HEIGHT), ' style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';
       
	    $reviews_box_contents .= 
				  '<div class="infoBoxContents hover">' . tep_draw_box_content_top(). "\n" . 
				  
				  '		<div class="pic_padd wrapper_pic_div" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$pic_prod.''.tep_draw_box_pic_top().''.tep_draw_box_pic_bottom().'</a></div>'. "\n".
				  '		<div class="box-padd">'. "\n".
				  '			<div class="name name_padd">'.$name_prod.'</div>'. "\n".
				  '		<div class="desc desc_padd">'.$rand_review_text.'</div>'. "\n".
				  '		<div class="stars_padd">' . tep_image(DIR_WS_IMAGES . 'icons/stars_' . $random_product['reviews_rating'] . '.png' , sprintf(MODULE_BOXES_REVIEWS_BOX_TEXT_OF_5_STARS, $random_product['reviews_rating'])) . '</div>'. "\n".				  
				  '		</div>'. "\n".				  

			      '' . tep_draw_box_content_bottom() . '</div>';
				  
      } elseif (isset($HTTP_GET_VARS['products_id'])) {

// display 'write a review' box
        $reviews_box_contents .= '<div class="infoBoxContents">' . tep_draw_box_content_top() . '
		<a class="box_icon" href="' . tep_href_link(FILENAME_PRODUCT_REVIEWS_WRITE, 'products_id=' . $HTTP_GET_VARS['products_id']) . '">' . tep_image(DIR_WS_IMAGES . 'icons/box_write_review.png', IMAGE_BUTTON_WRITE_REVIEW) . '</a><a href="' . tep_href_link(FILENAME_PRODUCT_REVIEWS_WRITE, 'products_id=' . $HTTP_GET_VARS['products_id']) . '">' . MODULE_BOXES_REVIEWS_BOX_WRITE_REVIEW .'</a>'
		. tep_draw_box_content_bottom() . '</div>';
      } else {

// display 'no reviews' box
        $reviews_box_contents .= '<div class="infoBoxContents">' . tep_draw_box_content_top() . '' . MODULE_BOXES_REVIEWS_BOX_NO_REVIEWS . '' . tep_draw_box_content_bottom() . '</div>';
      }

      $data = '<div class="infoBoxWrapper box2">' . tep_draw_box_wrapper_top() .
              '  <div class="infoBoxHeading"><a href="' . tep_href_link(FILENAME_REVIEWS) . '">' . tep_draw_box_title_top() . MODULE_BOXES_REVIEWS_BOX_TITLE . tep_draw_box_title_bottom() . '</a></div>' .
              '  ' . $reviews_box_contents .
          	  '' . tep_draw_box_wrapper_bottom() . '</div>';


      $oscTemplate->addBlock($data, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_REVIEWS_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Reviews Module', 'MODULE_BOXES_REVIEWS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_REVIEWS_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_REVIEWS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_REVIEWS_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_REVIEWS_STATUS', 'MODULE_BOXES_REVIEWS_CONTENT_PLACEMENT', 'MODULE_BOXES_REVIEWS_SORT_ORDER','MODULE_BOXES_REVIEWS_DISPLAY_PAGES');
    }
  }
?>
