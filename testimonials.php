<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_CONDITIONS);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_CONDITIONS));

  require(DIR_WS_INCLUDES . 'template_top.php');
?>

<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE_TESTIMONIALS; ?></h1>
<?php echo tep_draw_title_bottom();?>

<div class="contentContainer">
  <div class="contentPadd txtPage">
  <div class="">
  <iframe width="560" height="315" src="http://www.youtube.com/embed/97il8Lz0YrI" frameborder="0" allowfullscreen></iframe>
  <iframe width="560" height="315" src="http://www.youtube.com/embed/Kp0HvCHOlSk" frameborder="0" allowfullscreen></iframe>
  <iframe width="560" height="315" src="http://www.youtube.com/embed/ooTk7JUC9ok" frameborder="0" allowfullscreen></iframe>
  <iframe width="560" height="315" src="http://www.youtube.com/embed/A83P-4th-ho" frameborder="0" allowfullscreen></iframe>
  <iframe width="560" height="315" src="http://www.youtube.com/embed/_WLxf8eb5aU" frameborder="0" allowfullscreen></iframe>
    <?php //echo TEXT_INFORMATION_TESTIMONIALS; ?>
  </div>

 
</div>
</div>

<?php echo tep_draw_content_bottom();?>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
