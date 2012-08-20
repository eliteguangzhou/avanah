<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class bm_product_social_bookmarks {
    var $code = 'bm_product_social_bookmarks';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function bm_product_social_bookmarks() {
      $this->title = MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_TITLE;
      $this->description = MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_DESCRIPTION;

      if ( defined('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS') ) {
        $this->sort_order = MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS == 'True');
		
		if	(MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT == 'Left Column')	{
			$this->group = 'boxes_column_left';
		}
		if	(MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT == 'Right Column')	{
			$this->group = 'boxes_column_right';
		}
		if	(MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT == 'Product Page')	{
			$this->group = 'box_info_page';
		}
		
      }
    }

    function execute() {
      global $HTTP_GET_VARS, $language, $oscTemplate, $width_ext;
	  
      if ( isset($HTTP_GET_VARS['products_id']) && defined('MODULE_SOCIAL_BOOKMARKS_INSTALLED') && tep_not_null(MODULE_SOCIAL_BOOKMARKS_INSTALLED) ) {
       $width_ext = PROD_INFO_IMAGE_WIDTH + PIC_MARG_W;
	    $sbm_array = explode(';', MODULE_SOCIAL_BOOKMARKS_INSTALLED);
		
        $social_bookmarks = array();

        foreach ( $sbm_array as $sbm ) {
          $class = substr($sbm, 0, strrpos($sbm, '.'));

          if ( !class_exists($class) ) {
            include(DIR_WS_LANGUAGES . $language . '/modules/social_bookmarks/' . $sbm);
            include(DIR_WS_MODULES . 'social_bookmarks/' . $class . '.php');
          }

          $sb = new $class();

          if ( $sb->isEnabled() ) {
            $social_bookmarks[] = $sb->getOutput();
          }
        }

        if ( !empty($social_bookmarks) ) {
          $data = '<div class="infoBoxWrapper" style="width:'.$width_ext.'px;">' . tep_draw_box_wrapper_top() .
                  '  <div class="infoBoxHeading prod_page">' . tep_draw_box_title_top() . MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_BOX_TITLE . tep_draw_box_title_bottom() . '</div>' .
                  '  <div class="infoBoxContents">' . tep_draw_box_content_top() .'' . implode(' ', $social_bookmarks) . '' . tep_draw_box_content_bottom() . '</div>'. "\n".
          		  '' . tep_draw_box_wrapper_bottom() . '</div>';

          $oscTemplate->addBlock($data, $this->group);
        }
      }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Social Bookmarks Module', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\', \'Product Page\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER');
    }
  }
?>
