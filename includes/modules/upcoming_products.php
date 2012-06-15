<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  $expected_query = tep_db_query("select p.products_id, pd.products_name, products_date_available as date_expected from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where to_days(products_date_available) >= to_days(now()) and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by " . EXPECTED_PRODUCTS_FIELD . " " . EXPECTED_PRODUCTS_SORT . " limit " . MAX_DISPLAY_UPCOMING_PRODUCTS);
  if (tep_db_num_rows($expected_query) > 0) {
?>

<?php echo tep_draw_title_top();?>
<div>
  <h1 style="float: right;"><?php echo TABLE_HEADING_DATE_EXPECTED; ?></h1>
  <h1><?php echo TABLE_HEADING_UPCOMING_PRODUCTS; ?></h1>
</div>
<?php echo tep_draw_title_bottom();?>
    
<div class="contentContainer">
  <div class="contentPadd un">
  		<div class="contentInfoBlock">
      	<table border="0" width="100%" cellspacing="0" cellpadding="0" class="productListTable upcoming" >
<?php
    while ($expected = tep_db_fetch_array($expected_query)) {
      echo '        <tr>' . "\n" .
           '          <td><div class="name name_padd  equal-height"><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $expected['products_id']) . '">' . $expected['products_name'] . '</a></div></td>' . "\n" .
           '          <td align="right">' . tep_date_short($expected['date_expected']) . '</td>' . "\n" .
           '        </tr>' . "\n";
    }
?>

      </table>
      </div>
  </div>
</div>
<?php
  }
?>
