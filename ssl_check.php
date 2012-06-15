<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_SSL_CHECK);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_SSL_CHECK));

  require(DIR_WS_INCLUDES . 'template_top.php');
?>

<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE; ?></h1>
<?php echo tep_draw_title_bottom();?>

<div class="contentContainer">
  <div class="contentPadd">
  <div class="">
    <div style="float:right; width:40%; margin-left:17px;">
      <h3 class="first_h3"><?php echo BOX_INFORMATION_HEADING; ?></h3>

      <div class="contentInfoText marg-bottom">
        <?php echo BOX_INFORMATION; ?>
      </div>
    </div>

    <?php echo TEXT_INFORMATION; ?>
  </div>
  </div>

  <div class="buttonSet">
    <span class="buttonAction"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'triangle-1-e', tep_href_link(FILENAME_LOGIN)); ?><?php echo tep_draw_button_bottom();?></span>
  </div>
</div>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
