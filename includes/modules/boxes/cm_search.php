<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class cm_search {
    var $code = 'cm_search';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function cm_search() {
      $this->title = MODULE_BOXES_SEARCH_HEADER_TITLE;
      $this->description = MODULE_BOXES_SEARCH_HEADER_DESCRIPTION;

      if ( defined('MODULE_BOXES_SEARCH_HEADER_STATUS') ) {
        $this->sort_order = MODULE_BOXES_SEARCH_HEADER_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_SEARCH_HEADER_STATUS == 'True');
        $this->pages = MODULE_BOXES_SEARCH_HEADER_DISPLAY_PAGES;
        $this->group = ((MODULE_BOXES_LANGUAGES_SEARCH_HEADER_CONTENT_PLACEMENT == 'Above Footer Block') ? 'boxes_header' : 'box_above_footer');	
      }
    }

    function execute() {
      global $oscTemplate, $language;

      $data = '<div class="search ofh">' . tep_draw_box_wrapper_top() ."\n".
			  tep_draw_form('quick_find', tep_href_link(FILENAME_ADVANCED_SEARCH_RESULT, '', 'NONSSL', false), 'get') ."\n".
			  '  	<label class="fl_left">'.MODULE_BOXES_SEARCH_HEADER_BOX_TITLE.': </label>' ."\n".
	  		  '	 	<div class="input-width fl_left">'."\n".
              ' 		<div class="width-setter">'."\n".			  
			  	 	tep_draw_input_field('keywords', MODULE_BOXES_SEARCH_HEADER_BOX_INPUT, 'size="10" maxlength="300" class="go fl_left" onblur="if(this.value==\'\') this.value=\'' . MODULE_BOXES_SEARCH_HEADER_BOX_INPUT . '\'" onfocus="if(this.value ==\'' . MODULE_BOXES_SEARCH_HEADER_BOX_INPUT . '\' ) this.value=\'\'"') . '' . tep_hide_session_id() ."\n".  
			  '	  		</div>' ."\n".
			  '	   	</div>' ."\n".
			  '		'.tep_image_submit('button_header_search.gif', '', ' class="button_header_search fl_left"').'' ."\n".
			//  '		<div class="fl_left"><a href="' . tep_href_link(FILENAME_ADVANCED_SEARCH) . '">'.tep_draw_button_header_search_top().'<span class="ui-button-text">'.MODULE_BOXES_ITEM_ADVANCED_SEARCH.'</span>'.tep_draw_button_header_search_bottom().'</a></div>' ."\n".
              '</form>' ."\n". 			  
			  '' . tep_draw_box_wrapper_bottom() . '</div>'."\n";
			  
			  

      $oscTemplate->addBlock($data, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_SEARCH_HEADER_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Search Module', 'MODULE_BOXES_SEARCH_HEADER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SEARCH_HEADER_CONTENT_PLACEMENT', 'Above Footer Block', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Above Footer Block\', \'Header Block\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SEARCH_HEADER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_SEARCH_HEADER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");	  
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_SEARCH_HEADER_STATUS', 'MODULE_BOXES_SEARCH_HEADER_CONTENT_PLACEMENT', 'MODULE_BOXES_SEARCH_HEADER_SORT_ORDER', 'MODULE_BOXES_SEARCH_HEADER_DISPLAY_PAGES');
    }
  }
?>
