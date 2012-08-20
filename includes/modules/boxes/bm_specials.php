<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class bm_specials {
    var $code = 'bm_specials';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function bm_specials() {
      $this->title = MODULE_BOXES_SPECIALS_TITLE;
      $this->description = MODULE_BOXES_SPECIALS_DESCRIPTION;

      if ( defined('MODULE_BOXES_SPECIALS_STATUS') ) {
        $this->sort_order = MODULE_BOXES_SPECIALS_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_SPECIALS_STATUS == 'True');
        $this->pages = MODULE_BOXES_SPECIALS_DISPLAY_PAGES;
        $this->group = ((MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

    function execute() {
      global $HTTP_GET_VARS, $languages_id, $currencies, $oscTemplate;

      if (!isset($HTTP_GET_VARS['products_id'])) {
        if ($random_product = tep_random_select("select p.products_id, pd.products_name, p.products_price, p.products_tax_class_id, p.products_image, s.specials_new_products_price from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_SPECIALS . " s where p.products_status = '1' and p.products_id = s.products_id and pd.products_id = s.products_id and pd.language_id = '" . (int)$languages_id . "' and s.status = '1' order by s.specials_date_added desc limit " . MAX_RANDOM_SELECT_SPECIALS)) {
		
		$product_query = tep_db_query("select products_description, products_id from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id = '" . (int)$random_product['products_id'] . "' and language_id = '" . (int)$languages_id . "'");
		$product = tep_db_fetch_array($product_query);
		
    	$p_id = $random_product['products_id'];
		$name_prod = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id='.$p_id) . '">' . $random_product['products_name'] . '</a></span>';
		$pic_prod = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id='.$p_id) . '" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $random_product['products_image'], $random_product['products_name'], (BOX_IMAGE_WIDTH), (BOX_IMAGE_HEIGHT), ' style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"').'';
		$sp_price_1 = '<span class="productSpecialPrice fl_left">' . $currencies->display_price($random_product['specials_new_products_price'], tep_get_tax_rate($random_product['products_tax_class_id'])).'</span>';
		$sp_price_2 = '<del class="fl_right">' . $currencies->display_price($random_product['products_price'], tep_get_tax_rate($random_product['products_tax_class_id'])) . '</del>';
		$sp_price = ''.$sp_price_1.''.$sp_price_2.'';
		$p_desc =  mb_substr(strip_tags($product['products_description']), 0, MAX_DESCR_BOX, 'UTF-8').'...';
	
    	$p_details_text = '' .tep_draw_button2_top() . '<a href="' . tep_href_link('product_info.php?products_id='.$p_id) . '" id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-triangle-1-e"></span><span class="ui-button-text">'.  IMAGE_BUTTON_DETAILS .'</span></a>' . tep_draw_button2_bottom().'';

    	$p_buy_now_text = '' .tep_draw_button_top() . '<a href="'.tep_href_link("products_new.php","action=buy_now&products_id=".$p_id).'" id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-cart"></span><span class="ui-button-text">'.  IMAGE_BUTTON_IN_CART .'</span></a>' . tep_draw_button_bottom().'';
			
			
          $data = '<div class="infoBoxWrapper box2">' . tep_draw_box_wrapper_top() .
                  '  <div class="infoBoxHeading">' . tep_draw_box_title_top() . '<a href="' . tep_href_link(FILENAME_SPECIALS) . '">' . MODULE_BOXES_SPECIALS_BOX_TITLE . '</a>' . tep_draw_box_title_bottom() . '</div>' .
                  '  <div class="infoBoxContents hover">' . tep_draw_box_content_top() . 
				 
				  '		<div class="pic_padd wrapper_pic_div" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$pic_prod.''.tep_draw_box_pic_top().''.tep_draw_box_pic_bottom().'</a></div>'. "\n".
				  '		<div class="box-padd">'. "\n".
				  
			//	  '			<div class="desc desc_padd">'.$p_desc.'</div>'. "\n".
 				  '			<div class="name name_padd">'.$name_prod.'</div>'. "\n".			
				  '			<div class="price price_padd"><b>'.PRICE. '</b>'.$sp_price.'</div>'. "\n".
				// '			<div class="button__padd cl_both">'.$p_details_text.''.$p_buy_now_text.'</div>'. "\n".
				  '		</div>'. "\n".				  			  
				 '' . tep_draw_box_content_bottom() . '</div>'. "\n".
          		 '' . tep_draw_box_wrapper_bottom() . '</div>';

          $oscTemplate->addBlock($data, $this->group);
        }
      }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_SPECIALS_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Specials Module', 'MODULE_BOXES_SPECIALS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SPECIALS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_SPECIALS_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_SPECIALS_STATUS', 'MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT', 'MODULE_BOXES_SPECIALS_SORT_ORDER','MODULE_BOXES_SPECIALS_DISPLAY_PAGES');
    }
  }
?>
