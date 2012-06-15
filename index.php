<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

// the following cPath references come from application_top.php
  $category_depth = 'top';
  if (isset($cPath) && tep_not_null($cPath)) {
    $categories_products_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_TO_CATEGORIES . " where categories_id = '" . (int)$current_category_id . "'");
    $categories_products = tep_db_fetch_array($categories_products_query);
    if ($categories_products['total'] > 0) {
      $category_depth = 'products'; // display products
    } else {
      $category_parent_query = tep_db_query("select count(*) as total from " . TABLE_CATEGORIES . " where parent_id = '" . (int)$current_category_id . "'");
      $category_parent = tep_db_fetch_array($category_parent_query);
      if ($category_parent['total'] > 0) {
        $category_depth = 'nested'; // navigate through the categories
      } else {
        $category_depth = 'products'; // category has no products, but display the 'no products' message
      }
    }
  }

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_DEFAULT);
?>

<?php
  if ($category_depth == 'nested') {
  $tab_sel = tep_href_link(FILENAME_CATEGORIES_NESTED);
  $current_page = FILENAME_CATEGORIES_NESTED;
  require(DIR_WS_INCLUDES . 'template_top.php');
  
  include(FILENAME_CATEGORIES_NESTED); 
?>

<?php
  } elseif ($category_depth == 'products' || isset($HTTP_GET_VARS['manufacturers_id'])) {
  $tab_sel = tep_href_link(FILENAME_CATEGORIES_LISTING);
  $current_page = FILENAME_CATEGORIES_LISTING;
  require(DIR_WS_INCLUDES . 'template_top.php');

  include(FILENAME_CATEGORIES_LISTING);
?>  

<?php
  } else { // default page
  $tab_sel = tep_href_link(FILENAME_DEFAULT);
  $current_page = FILENAME_DEFAULT;
  require(DIR_WS_INCLUDES . 'template_top.php');

  $first_page = true;
?>
<?php echo tep_draw_content_top();?>
<div class="none">
<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE; ?></h1>
<?php echo tep_draw_title_bottom();?><br />
</div >

<div class="contentContainer">
<?php
    include(DIR_WS_MODULES . FILENAME_NEW_PRODUCTS);
    include(DIR_WS_MODULES . FILENAME_UPCOMING_PRODUCTS);
?>

</div>
<?php echo tep_draw_content_bottom();?>
<?php
  }

  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
