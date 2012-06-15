<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2011 osCommerce

  Released under the GNU General Public License
*/

  class cm_welcome {
    var $code = 'cm_welcome';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function cm_welcome() {
      $this->title = MODULE_BOXES_WELCOME_TITLE;
      $this->description = MODULE_BOXES_WELCOME_DESCRIPTION;
      $this->box_title = MODULE_BOXES_WELCOME_BOX_TITLE;

      if ( defined('MODULE_BOXES_WELCOME_STATUS') ) {
        $this->sort_order = MODULE_BOXES_WELCOME_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_WELCOME_STATUS == 'True');
        $this->pages = MODULE_BOXES_WELCOME_DISPLAY_PAGES;
        $this->group = 'box_welcome';
      }
    }

    function execute() {
	  global $oscTemplate;

	  $execute = false;
	  if (tep_not_null(MODULE_BOXES_WELCOME_BOX_TEXT_MAIN))	{
        $data = '<div class="welcome">'.MODULE_BOXES_WELCOME_BOX_TEXT_MAIN.'</div>';
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
      return defined('MODULE_BOXES_WELCOME_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Banner Header Module', 'MODULE_BOXES_WELCOME_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_WELCOME_CONTENT_PLACEMENT', 'Content Block', 'The module should be loaded in the content block only', '6', '1', 'tep_cfg_select_option(array(\'Content Block\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_WELCOME_SORT_ORDER', '9060', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_WELCOME_DISPLAY_PAGES', 'index.php', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");	  
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_WELCOME_STATUS', 'MODULE_BOXES_WELCOME_CONTENT_PLACEMENT', 'MODULE_BOXES_WELCOME_SORT_ORDER', 'MODULE_BOXES_WELCOME_DISPLAY_PAGES');
    }
  }
?>