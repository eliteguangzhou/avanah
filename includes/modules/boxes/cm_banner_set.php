<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class cm_banner_set {
    var $code = 'cm_banner_set';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function cm_banner_set() {
      $this->title = MODULE_BOXES_BANNER_SET_TITLE;
      $this->description = MODULE_BOXES_BANNER_SET_DESCRIPTION;
      $this->box_title = MODULE_BOXES_BANNER_SET_BOX_TITLE;

      if ( defined('MODULE_BOXES_BANNER_SET_STATUS') ) {
        $this->sort_order = MODULE_BOXES_BANNER_SET_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_BANNER_SET_STATUS == 'True');
        $this->pages = MODULE_BOXES_BANNER_SET_DISPLAY_PAGES;
        $this->group = 'box_under_header';
        $this->group = ((MODULE_BOXES_BANNER_SET_CONTENT_PLACEMENT == 'Under Header Block') ? 'box_under_header' : 'box_under_content');		
      }
    }

    function execute() {
	  global $oscTemplate;
	
	  if (($banner1 = tep_banner_exists('dynamic', BANNER_SET_GROUP_1)) || ($banner2 = tep_banner_exists('dynamic', BANNER_SET_GROUP_2)) || ($banner3 = tep_banner_exists('dynamic', BANNER_SET_GROUP_3)) || ($banner4 = tep_banner_exists('dynamic', BANNER_SET_GROUP_4)) ){
		  if (MODULE_BOXES_BANNER_SET_CONTENT_PLACEMENT == 'Under Content Block')	{
			  $extra = 'extra';
		  }
	  $data1 = '
	  			<div class="banner_set '.$extra.'"><div class="container_'.$oscTemplate->getGridContainerWidth().'"><ul>';
	  }
	  $execute = false;
	  
	  if ( ($banner1 = tep_banner_exists('dynamic', BANNER_SET_GROUP_1))){
        $data1 .= '<li>'.tep_display_banner('static', $banner1).$current_page.'</li>';
		$execute = true;		
	  }
	  if ( ($banner2 = tep_banner_exists('dynamic', BANNER_SET_GROUP_2))){
        $data1 .= '<li>'.tep_display_banner('static', $banner2).'</li>';
		$execute = true;		
	  }
	  if ( ($banner3 = tep_banner_exists('dynamic', BANNER_SET_GROUP_3)) ){
        $data1 .= '<li>'.tep_display_banner('static', $banner3).'</li>';
		$execute = true;		
	  }
	  if ( ($banner4 = tep_banner_exists('dynamic', BANNER_SET_GROUP_4)) ){
        $data1 .= '<li>'.tep_display_banner('static', $banner4).'</li>';
		$execute = true;		
	  }
	  	  	  
	  if (($banner1 = tep_banner_exists('dynamic', BANNER_SET_GROUP_1)) || ($banner2 = tep_banner_exists('dynamic', BANNER_SET_GROUP_2)) || ($banner3 = tep_banner_exists('dynamic', BANNER_SET_GROUP_3)) || ($banner4 = tep_banner_exists('dynamic', BANNER_SET_GROUP_4)) ){
		  
	  $data1 .= '</ul></div></div>';
	  }
	  
	  if($execute){
      	$oscTemplate->addBlock($data1, $this->group);
	  }
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_BANNER_SET_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Banner Content Module', 'MODULE_BOXES_BANNER_SET_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_BANNER_SET_CONTENT_PLACEMENT', 'Under Header Block', 'The module should be loaded in the header block only', '6', '1', 'tep_cfg_select_option(array(\'Under Header Block\', \'Under Content Block\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_BANNER_SET_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_BANNER_SET_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_BANNER_SET_STATUS', 'MODULE_BOXES_BANNER_SET_CONTENT_PLACEMENT', 'MODULE_BOXES_BANNER_SET_SORT_ORDER','MODULE_BOXES_BANNER_SET_DISPLAY_PAGES');
    }
  }
?>