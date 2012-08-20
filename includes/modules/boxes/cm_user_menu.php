<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class cm_user_menu {
    var $code = 'cm_user_menu';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function cm_user_menu() {
      $this->title = MODULE_BOXES_USER_MENU_TITLE;
      $this->description = MODULE_BOXES_USER_MENU_DESCRIPTION;

      if ( defined('MODULE_BOXES_USER_MENU_STATUS') ) {
        $this->sort_order = MODULE_BOXES_USER_MENU_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_USER_MENU_STATUS == 'True');
        $this->pages = MODULE_BOXES_USER_MENU_DISPLAY_PAGES;
        $this->group = 'box_header_user_menu';
      }
    }

    function execute() {
      global $oscTemplate, $current_page;
	  
		if ($current_page == (FILENAME_ADVANCED_SEARCH))
		{
		$button_act5 = " act";
		$button_act6 = $button_act7 = $button_act8 = "";
		}		
		if (($current_page == (FILENAME_LOGIN)) 
			|| ($current_page == (FILENAME_LOGOFF))
		){
		$button_act6 = " act";
		$button_act5 = $button_act7 = $button_act8 = "";
		}
		if (($current_page == (FILENAME_CREATE_ACCOUNT))
			|| ($current_page == (FILENAME_CREATE_ACCOUNT_SUCCESS))
			|| ($current_page == (FILENAME_ACCOUNT))
			|| ($current_page == (FILENAME_ACCOUNT_PASSWORD))
			|| ($current_page == (FILENAME_ACCOUNT_NOTIFICATIONS))
			|| ($current_page == (FILENAME_ACCOUNT_NEWSLETTERS))
			|| ($current_page == (FILENAME_ACCOUNT_HISTORY))
			|| ($current_page == (FILENAME_ACCOUNT_HISTORY_INFO))
			|| ($current_page == (FILENAME_ACCOUNT_EDIT)))
		{
		$button_act7 = " act";
		$button_act6 = $button_act5 = $button_act8 = "";
		}
		if ($current_page == (FILENAME_SHIPPING))
		{
		$button_act8 = " act";
		$button_act6 = $button_act7 = $button_act5 = "";
		}		
		if (tep_session_is_registered('customer_id')) { 
		
		$login_link = tep_href_link('logoff.php');
		$login_title= MODULE_BOXES_USER_MENU_BOX_TITLE_LOGOFF;
		} else{ 
		$login_link = tep_href_link('login.php');
		$login_title= MODULE_BOXES_USER_MENU_BOX_TITLE_LOGIN;
		} 			  
		if (tep_session_is_registered('customer_id')) { 
		
		$acc_link = tep_href_link('account.php');
		$acc_title= MODULE_BOXES_USER_MENU_BOX_MY_ACCOUNT;
		} else{ 
		$acc_link = tep_href_link('create_account.php');
		$acc_title= MODULE_BOXES_USER_MENU_BOX_CREATE_ACCOUNT;
		} 
		
      $data = '
				  <ul class="user_menu">'.
					'<li class="'.$button_act6.'"><a href="'.$login_link.'">'.tep_draw_button_header_top().'<span>'.$login_title.'</span>'.tep_draw_button_header_bottom().'</a></li>'.
					'<li class="'.$button_act7.'"><a href="' .$acc_link. '">'.tep_draw_button_header_top().'<span>'.$acc_title.'</span>'.tep_draw_button_header_bottom().'</a></li>'.
					'<li class="'.$button_act8.'"><a href="' . tep_href_link(FILENAME_SHIPPING) . '">'.tep_draw_button_header_top().'<span>'.MODULE_BOXES_USER_MENU_BOX_SHIPPING.'</span>'.tep_draw_button_header_bottom().'</a></li>'.
					'<li class="'.$button_act5.'"><a href="' . tep_href_link(FILENAME_ADVANCED_SEARCH) . '">'.tep_draw_button_header_top().'<span>'.MODULE_BOXES_USER_MENU_BOX_ADVANCED_SEARCH.'</span>'.tep_draw_button_header_bottom().'</a></li>'.
				  '</ul>
			  ';

      $oscTemplate->addBlock($data, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_USER_MENU_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Information Module', 'MODULE_BOXES_USER_MENU_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_USER_MENU_CONTENT_PLACEMENT', 'Header Block', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Header Block\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_USER_MENU_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_USER_MENU_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_USER_MENU_STATUS', 'MODULE_BOXES_USER_MENU_CONTENT_PLACEMENT', 'MODULE_BOXES_USER_MENU_SORT_ORDER','MODULE_BOXES_USER_MENU_DISPLAY_PAGES');
    }
  }
?>
