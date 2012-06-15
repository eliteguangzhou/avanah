<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_SHIPPING);
  $tab_sel = tep_href_link(FILENAME_SHIPPING);
  $current_page = FILENAME_SHIPPING;
  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_SHIPPING));

  require(DIR_WS_INCLUDES . 'template_top.php');
?>

<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE; ?></h1>
<?php echo tep_draw_title_bottom();?>

<div class="contentContainer">
  <div class="contentPadd txtPage">
  <div class="">
    <?php echo TEXT_INFORMATION; ?>
  </div>

  <div class="buttonSet fl_right" align="right">
    <span class="buttonAction"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'triangle-1-e', tep_href_link(FILENAME_DEFAULT)); ?><?php echo tep_draw_button_bottom();?></span>
  </div>
</div>
</div>

<?php echo tep_draw_content_bottom();?>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
