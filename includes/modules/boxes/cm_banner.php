<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class cm_banner {
    var $code = 'cm_banner';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function cm_banner() {
      $this->title = MODULE_BOXES_BANNER_COLUMN_TITLE;
      $this->description = MODULE_BOXES_BANNER_COLUMN_DESCRIPTION;
      $this->box_title = MODULE_BOXES_BANNER_COLUMN_BOX_TITLE;

      if ( defined('MODULE_BOXES_BANNER_COLUMN_STATUS') ) {
        $this->sort_order = MODULE_BOXES_BANNER_COLUMN_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_BANNER_COLUMN_STATUS == 'True');
		$this->pages = MODULE_BOXES_BEST_SELLERS_DISPLAY_PAGES;
        $this->group = ((MODULE_BOXES_BANNER_COLUMN_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

    function execute() {
	  global $oscTemplate;
	  
	  $data = '';
	  $execute = false;
	  if($banner5 = tep_banner_exists('dynamic', BANNER_GROUP_5)){
        $data .= '<div class="banner_side">'.tep_display_banner('static', $banner5).'</div>';
		$execute = true;
      }
	  if($execute){
      	$oscTemplate->addBlock($data, $this->group);
	  }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_BANNER_COLUMN_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Banner Column Module', 'MODULE_BOXES_BANNER_COLUMN_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_BANNER_COLUMN_CONTENT_PLACEMENT', 'Left Column', 'The module should be loaded in the footer block only', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_BANNER_COLUMN_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_BANNER_COLUMN_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");	  
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_BANNER_COLUMN_STATUS', 'MODULE_BOXES_BANNER_COLUMN_CONTENT_PLACEMENT', 'MODULE_BOXES_BANNER_COLUMN_SORT_ORDER', 'MODULE_BOXES_BANNER_COLUMN_DISPLAY_PAGES');
    }
  }
?>