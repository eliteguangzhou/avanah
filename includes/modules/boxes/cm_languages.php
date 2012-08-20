<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class cm_languages {
    var $code = 'cm_languages';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function cm_languages() {
      $this->title = MODULE_BOXES_LANGUAGES_HEADER_FOOTER_TITLE;
      $this->description = MODULE_BOXES_LANGUAGES_HEADER_FOOTER_DESCRIPTION;

      if ( defined('MODULE_BOXES_LANGUAGES_HEADER_FOOTER_STATUS') ) {
        $this->sort_order = MODULE_BOXES_LANGUAGES_HEADER_FOOTER_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_LANGUAGES_HEADER_FOOTER_STATUS == 'True');
        $this->pages = MODULE_BOXES_LANGUAGES_HEADER_FOOTER_DISPLAY_PAGES;
        $this->group = ((MODULE_BOXES_LANGUAGES_HEADER_FOOTER_CONTENT_PLACEMENT == 'Above Footer Block') ? 'box_above_footer' : 'boxes_header');	
      }
    }

    function execute() {
      global $PHP_SELF, $lng, $request_type, $oscTemplate;

      if (substr(basename($PHP_SELF), 0, 8) != 'checkout') {
if (!isset($lng) || (isset($lng) && !is_object($lng))) {
include(DIR_WS_CLASSES . 'language.php');
$lng = new language;
}
$languages_string = '';
reset($lng->catalog_languages);
$i = 0; 
while (list($key, $value) = each($lng->catalog_languages)) {
if ($i)  $languages_string .= tep_image(DIR_WS_IMAGES.'spacer.gif','','','',' class="languages_img"');
$languages_string .= '<a href="' . tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('language', 'currency')) . 'language=' . $key, $request_type) . '">' . tep_image(DIR_WS_LANGUAGES . $value['directory'] . '/images/' . $value['image'], $value['name'],'','','') . '</a>';
$i++;
}

          $data = '<div class="box_languages">' .
		  		  '		<div class="languages">' .
                  '  	<label class="fl_left">'. MODULE_BOXES_LANGUAGES_HEADER_FOOTER_BOX_TITLE.': </label>' .
                  '' . $languages_string  . '' .
          		  '		</div>' .
				  '</div>';

          $oscTemplate->addBlock($data, $this->group);
    }
	}

    function isEnabled() {
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_LANGUAGES_HEADER_FOOTER_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Languages Module', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_CONTENT_PLACEMENT', 'Above Footer Block', 'Should the module be loaded in the header or footer?', '6', '1', 'tep_cfg_select_option(array(\'Above Footer Block\', \'Header Block\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_LANGUAGES_HEADER_FOOTER_STATUS', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_CONTENT_PLACEMENT', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_SORT_ORDER','MODULE_BOXES_LANGUAGES_HEADER_FOOTER_DISPLAY_PAGES');
    }
  }
?>
