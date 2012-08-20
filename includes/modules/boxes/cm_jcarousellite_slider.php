<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  class cm_jcarousellite_slider {
    var $code = 'cm_jcarousellite_slider';
    var $group = 'boxes';
    var $title;
    var $description;
    var $sort_order;
    var $enabled = false;
    var $pages;	

    function cm_jcarousellite_slider() {
      $this->title = MODULE_BOXES_JCAROUSELLITE_SLIDER_TITLE;
      $this->description = MODULE_BOXES_JCAROUSELLITE_SLIDER_DESCRIPTION;

      if ( defined('MODULE_BOXES_JCAROUSELLITE_SLIDER_STATUS') ) {
        $this->sort_order = MODULE_BOXES_JCAROUSELLITE_SLIDER_SORT_ORDER;
        $this->enabled = (MODULE_BOXES_JCAROUSELLITE_SLIDER_STATUS == 'True');
        $this->pages = MODULE_BOXES_JCAROUSELLITE_SLIDER_DISPLAY_PAGES;
        $this->group = 'box_under_header';
      }
    }

    function execute() {
      global $HTTP_GET_VARS, $current_category_id, $languages_id, $oscTemplate;

      if (!isset($HTTP_GET_VARS['products_id'])) {
        if (isset($current_category_id) && ($current_category_id > 0)) {
          $best_sellers_query = tep_db_query("select distinct p.products_id, pd.products_description, p.products_image, p.products_model, p.products_price, p.products_tax_class_id, pd.products_name from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c, " . TABLE_CATEGORIES . " c where p.products_status = '1' and p.products_ordered > 0 and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' and p.products_id = p2c.products_id and p2c.categories_id = c.categories_id and '" . (int)$current_category_id . "' in (c.categories_id, c.parent_id) order by p.products_ordered desc, pd.products_name limit " . MAX_DISPLAY_BESTSELLERS_SLIDER);
        } else {
          $best_sellers_query = tep_db_query("select distinct p.products_id, pd.products_description, p.products_image, p.products_model, p.products_price, p.products_tax_class_id, pd.products_name from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_ordered > 0 and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by p.products_ordered desc, pd.products_name limit " . MAX_DISPLAY_BESTSELLERS_SLIDER);
        }

        if (tep_db_num_rows($best_sellers_query) >= MIN_DISPLAY_BESTSELLERS) {
          while ($best_sellers = tep_db_fetch_array($best_sellers_query)) {
/* ********************************* */
			$p_id = $best_sellers['products_id'];			 
			$name_prod = '<a class="name" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $best_sellers['products_id']) . '">' . $best_sellers['products_name'] . '</a>';
			$pic_prod = '<a class="pic" href="'.tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $best_sellers['products_id']).'" style="width:'.(BESTSELLERS_IMAGE_WIDTH).'px;height:'.(BESTSELLERS_IMAGE_HEIGHT).'px;">'.tep_image(DIR_WS_IMAGES . $best_sellers['products_image'], $best_sellers['products_name'], (BESTSELLERS_IMAGE_WIDTH), (BESTSELLERS_IMAGE_HEIGHT)).'</a>'; 
			$model_prod = '<a class="model" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $best_sellers['products_id']) . '">' . MODULE_BOXES_JCAROUSELLITE_SLIDER_TEXT . $best_sellers['products_model'] . '</a>';
			if (MAX_DESCR_BESTSELLERS != 0)	{
			$desc_prod = '<b class="desc" style=" width:'. (BESTSELLERS_IMAGE_WIDTH - 28) .'px;">'.mb_substr(strip_tags($best_sellers['products_description']), 0, MAX_DESCR_BESTSELLERS, 'UTF-8').'...</b>';
			$p_details_text = '' .tep_draw_button3_top() . '<div class="extra_name"  style="bottom:-161px;"><a href="' . tep_href_link('product_info.php?products_id='.$p_id) . '" id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-triangle-1-e"></span><span class="ui-button-text">'.  IMAGE_BUTTON_DETAILS .'</span></a></div>' . tep_draw_button3_bottom().'';
			}else{}
/* ********************************* */				

$count ++;				
$row_count = ROW_COUNT - 1;			
switch ($row_count) {
    case 0:
					$li = '<li>';
					$li2 = '</li>';	
        break;
    case 1:
				if ($count % 2 )	{
					$li = '<li>';
					$li2 = '';	
				}else{
					$li = '';
					$li2 = '</li>';

				}
	break;
}				
				
				
/* ********************************* */					
            $bestsellers_list .= $li.'<div class="wrapper">'. $pic_prod . $p_details_text.'</div>'. $li2;
          }
       //   $bestsellers_list .= '';

          $data = '
		  
		<div class="carousel-box">
		   <div class="inner">
			  	<div class="carousel"><ul class="thumb">'.$bestsellers_list.'</ul></div>
				<a href="#" class="prev"></a>
				<a href="#" class="next"></a>				   
		   </div>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){ 
				 $(\'.carousel\').jCarouselLite({
					  btnNext: \'.' . NEXT_JCAROUSELLITE . '\',
					  btnPrev: \'.' . PREV_JCAROUSELLITE . '\',
					  speed: ' . SPEED_JCAROUSELLITE . ',
					  circular: ' . CIRCULAR_JCAROUSELLITE . ',
					  visible: ' . VISIBLE_JCAROUSELLITE . ',
					  easing: \'' . EASING_JCAROUSELLITE . '\',
					  mouseWheel: ' . MOUSEWHEEL_JCAROUSELLITE . ',
					  auto: ' . AUTO_JCAROUSELLITE . ',
					  scroll: ' . SCROLL_JCAROUSELLITE . '
				 });

$("ul.thumb li").hover(function() {
	$(this).css({\'z-index\' : \'10\'}); /*Add a higher z-index value so this image stays on top*/ 
	$(this).find(\'img\').addClass("hover").stop() /* Add class of "hover", then stop animation queue buildup*/
		.animate({
			marginTop: \'-'.(BESTSELLERS_IMAGE_HEIGHT - 50) .'px\', /* The next 4 lines will vertically align this image */ 
			marginLeft: \'-'.(BESTSELLERS_IMAGE_WIDTH - 87) .'px\',
			top: \'50%\',
			left: \'50%\',
			width: \''.(BESTSELLERS_IMAGE_WIDTH * 1.25) .'px\', /* Set new width */
			height: \''.(BESTSELLERS_IMAGE_HEIGHT* 1.25) .'px\', /* Set new height */
			padding: \'0px\'
		}, 400); /* this value of "200" is the speed of how fast/slow this hover animates */

	} , function() {
	$(this).css({\'z-index\' : \'0\'}); /* Set z-index back to 0 */
	$(this).find(\'img\').removeClass("hover").stop()  /* Remove the "hover" class , then stop animation queue buildup*/
		.animate({
			marginTop: \'0\', /* Set alignment back to default */
			marginLeft: \'-115px\',
			top: \'15%\',
			left: \'50%\',
			width: \''.BESTSELLERS_IMAGE_WIDTH.'px\', /* Set width back to default */
			height: \''.BESTSELLERS_IMAGE_HEIGHT.'px\', /* Set height back to default */
			padding: \'0px\'
		}, 400);
});	
  $(".wrapper").hover(function()       {
	$(this).find(".extra_name").stop().animate({bottom:\'24\'},1100,\'easeOutBack\');
	}, function(){
	$(this).find(".extra_name").stop().animate({bottom:\'-161\'},1100,\'easeInBack\');
	})

});				
		</script>
		';

          $oscTemplate->addBlock($data, $this->group);
        }
      }
    }

    function isEnabled() {
    	return FALSE;
      return $this->enabled;
    }

    function check() {
      return defined('MODULE_BOXES_JCAROUSELLITE_SLIDER_STATUS');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Best Sellers Module', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_CONTENT_PLACEMENT', 'Right Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display in pages.', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', '6', '0','tep_cfg_select_pages(' , now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_BOXES_JCAROUSELLITE_SLIDER_STATUS', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_CONTENT_PLACEMENT', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_SORT_ORDER','MODULE_BOXES_JCAROUSELLITE_SLIDER_DISPLAY_PAGES');
    }
  }
?>
