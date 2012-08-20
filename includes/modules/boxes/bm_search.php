<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class bm_search {
    var $code = 'bm_search';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;

    function bm_search() {
      $this->title = MODULE_BOXES_SEARCH_TITLE;
      $this->description = MODULE_BOXES_SEARCH_DESCRIPTION;

      if ( defined('MODULE_BOXES_SEARCH_STATUS') ) {
        $this->sort_order = MODULE_BOXES_SEARCH_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_SEARCH_STATUS == 'True');

        $this->group = ((MODULE_BOXES_SEARCH_CONTENT_PLACEMENT == 'Left Column') ? 'boxes_column_left' : 'boxes_column_right');
      }
    }

    function execute() {
      global $oscTemplate;
			  
      $data = '<div class="infoBoxWrapper">' . tep_draw_box_wrapper_top() .
              '  <div class="infoBoxHeading">' . tep_draw_box_title_top() . MODULE_BOXES_SEARCH_BOX_TITLE . tep_draw_box_title_bottom() . '</div>' .
              '  <div class="infoBoxContents">' . tep_draw_box_content_top() . ' 
			  '. tep_draw_form('quick_find', tep_href_link(FILENAME_ADVANCED_SEARCH_RESULT, '', 'NONSSL', false), 'get') .'
			  '. tep_draw_input_field('keywords', MODULE_BOXES_SEARCH_BOX_TITLE, 'size="10" maxlength="30" class="input" onblur="if(this.value==\'\') this.value=\'' . MODULE_BOXES_SEARCH_BOX_TITLE . '\'" onfocus="if(this.value ==\'' . MODULE_BOXES_SEARCH_BOX_TITLE . '\' ) this.value=\'\'"') . '' . tep_hide_session_id() .  '
							<div class="ofh">
								<div class="fl_left text_search">' . MODULE_BOXES_SEARCH_BOX_TEXT . '</div>
								<div class="fl_right button_search">' . tep_hide_session_id() . tep_image_submit('button_quick_find.png', BOX_HEADING_SEARCH,'') . '</div>
								
							</div>
							<div align="right" class="advserch"><a href="' . tep_href_link(FILENAME_ADVANCED_SEARCH) . '">' . MODULE_BOXES_SEARCH_BOX_ADVANCED_SEARCH . '</a></div>'.
              '    </form>' . 
			  '' . tep_draw_box_content_bottom() . '</div>'. "\n".
          	  '' . tep_draw_box_wrapper_bottom() . '</div>';
			  
			  

      $oscTemplate->addBlock($data, $this->group);
    }

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_SEARCH_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Search Module', 'MODULE_BOXES_SEARCH_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SEARCH_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SEARCH_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_SEARCH_STATUS', 'MODULE_BOXES_SEARCH_CONTENT_PLACEMENT', 'MODULE_BOXES_SEARCH_SORT_ORDER');
    }
  }
?>
