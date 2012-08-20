<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License

  Discount Code 3.0
  http://high-quality-php-coding.com/
*/

  require('includes/application_top.php');

  $action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');

  if (tep_not_null($action)) {
    switch ($action) {
      case 'setflag':
        tep_db_query("update " . TABLE_DISCOUNT_CODES . " set status = '" . (int)$HTTP_GET_VARS['flag'] . "' where discount_codes_id = '" . (int)$HTTP_GET_VARS['dID'] . "' limit 1");

        tep_redirect(tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page']));
        break;
      case 'insert':
        if (!empty($HTTP_POST_VARS['discount_codes']) && !empty($HTTP_POST_VARS['discount_values'])) {
          $sql_data_array = array('products_id' => '',
                                  'categories_id' => '',
                                  'manufacturers_id' => '',
                                  'excluded_products_id' => '',
                                  'customers_id' => '',
                                  'orders_total' => '0',
                                  'order_info' => (int)$HTTP_POST_VARS['order_info'],
                                  'exclude_specials' => (int)$HTTP_POST_VARS['exclude_specials'],
                                  'discount_codes' => tep_db_prepare_input($HTTP_POST_VARS['discount_codes']),
                                  'discount_values' => tep_db_prepare_input($HTTP_POST_VARS['discount_values']),
                                  'minimum_order_amount' => tep_db_prepare_input($HTTP_POST_VARS['minimum_order_amount']),
                                  'expires_date' => empty($HTTP_POST_VARS['expires_date']) ? '0000-00-00' : tep_db_prepare_input($HTTP_POST_VARS['expires_date']),
                                  'number_of_use' => (int)$HTTP_POST_VARS['number_of_use'],
                                  'number_of_products' => 0);

          $error = true;
          if ((int)$HTTP_POST_VARS['applies_to'] == 1) {
            if (is_array($HTTP_POST_VARS['products_id']) && sizeof($HTTP_POST_VARS['products_id']) > 0) {
              $sql_data_array['products_id'] = implode(',', $HTTP_POST_VARS['products_id']);
              $error = false;
            }
          } elseif ((int)$HTTP_POST_VARS['applies_to'] == 2) {
            if (is_array($HTTP_POST_VARS['categories_id']) && sizeof($HTTP_POST_VARS['categories_id']) > 0) {
              $sql_data_array['categories_id'] = implode(',', $HTTP_POST_VARS['categories_id']);
              $error = false;
            }
          } elseif ((int)$HTTP_POST_VARS['applies_to'] == 3) {
            $sql_data_array['orders_total'] = 1; // total
            $error = false;
          } elseif ((int)$HTTP_POST_VARS['applies_to'] == 4) {
            if (is_array($HTTP_POST_VARS['manufacturers_id']) && sizeof($HTTP_POST_VARS['manufacturers_id']) > 0) {
              $sql_data_array['manufacturers_id'] = implode(',', $HTTP_POST_VARS['manufacturers_id']);
              $error = false;
            }
          } elseif ((int)$HTTP_POST_VARS['applies_to'] == 5) {
            $sql_data_array['orders_total'] = 2; // subtotal
            $error = false;
          }

          if ((int)$HTTP_POST_VARS['applies_to'] == 2 || (int)$HTTP_POST_VARS['applies_to'] == 4) {
            if (is_array($HTTP_POST_VARS['excluded_products_id']) && sizeof($HTTP_POST_VARS['excluded_products_id']) > 0) {
              $sql_data_array['excluded_products_id'] = implode(',', $HTTP_POST_VARS['excluded_products_id']);
            }
          }

          if ((int)$HTTP_POST_VARS['applies_to'] != 3 && !empty($HTTP_POST_VARS['number_of_products'])) {
            $sql_data_array['number_of_products'] = (int)$HTTP_POST_VARS['number_of_products'];
          }

          if (!empty($HTTP_POST_VARS['customers']) && $HTTP_POST_VARS['customers'] == 1) {
            if (is_array($HTTP_POST_VARS['customers_id']) && sizeof($HTTP_POST_VARS['customers_id']) > 0) {
              $sql_data_array['customers_id'] = implode(',', $HTTP_POST_VARS['customers_id']);
            }
          }

          if ($error == false) {
            if (empty($HTTP_GET_VARS['dID'])) {
              tep_db_perform(TABLE_DISCOUNT_CODES, $sql_data_array);
              $messageStack->add_session(SUCCESS_DISCOUNT_CODE_INSERTED, 'success');
            } else {
              tep_db_perform(TABLE_DISCOUNT_CODES, $sql_data_array, 'update', "discount_codes_id = '" . (int)$HTTP_GET_VARS['dID'] . "'");
              $messageStack->add_session(SUCCESS_DISCOUNT_CODE_UPDATED, 'success');
            }
            tep_redirect(tep_href_link(FILENAME_DISCOUNT_CODES));
          }
        }
        $action = 'new';
        break;
      case 'deleteconfirm':
        tep_db_query("delete from " . TABLE_CUSTOMERS_TO_DISCOUNT_CODES . " where discount_codes_id = '" . (int)$HTTP_GET_VARS['dID'] . "'");
        tep_db_query("delete from " . TABLE_DISCOUNT_CODES . " where discount_codes_id = '" . (int)$HTTP_GET_VARS['dID'] . "' limit 1");

        $messageStack->add_session(SUCCESS_DISCOUNT_CODE_REMOVED, 'success');

        tep_redirect(tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page']));
        break;
    }
  }

  require(DIR_WS_CLASSES . 'currencies.php');
  $currencies = new currencies();

  require(DIR_WS_INCLUDES . 'template_top.php');
?>

    <table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
            <td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
          </tr>
        </table></td>
      </tr>
<?php
  if ($action == 'new') {
    $dInfo = new objectInfo(array('products_id' => '',
                                  'categories_id' => '',
                                  'manufacturers_id' => '',
                                  'excluded_products_id' => '',
                                  'customers_id' => '',
                                  'orders_total' => '2',
                                  'order_info' => '',
                                  'exclude_specials' => '',
                                  'discount_codes' => substr(md5(uniqid(rand(), true)), 0, 8),
                                  'discount_values' => '',
                                  'minimum_order_amount' => '',
                                  'expires_date' => '',
                                  'number_of_orders' => '',
                                  'number_of_use' => '1',
                                  'number_of_products' => '1',
                                  'status' => ''));

    if (isset($HTTP_GET_VARS['dID'])) {
      $discount_code_query = tep_db_query("select dc.discount_codes_id, dc.products_id, dc.categories_id, dc.manufacturers_id, dc.excluded_products_id, dc.customers_id, dc.orders_total, dc.order_info, dc.exclude_specials, dc.discount_codes, dc.discount_values, dc.minimum_order_amount, dc.expires_date, dc.number_of_orders, dc.number_of_use, dc.number_of_products, dc.status from discount_codes dc where dc.discount_codes_id = '" . (int)$HTTP_GET_VARS['dID'] . "'");
      $discount_code = tep_db_fetch_array($discount_code_query);

      $dInfo->objectInfo($discount_code);

      if (!empty($discount_code['products_id'])) $dInfo->products_id = explode(',', $discount_code['products_id']);
      if (!empty($discount_code['categories_id'])) $dInfo->categories_id = explode(',', $discount_code['categories_id']);
      if (!empty($discount_code['manufacturers_id'])) $dInfo->manufacturers_id = explode(',', $discount_code['manufacturers_id']);
      if (!empty($discount_code['excluded_products_id'])) $dInfo->excluded_products_id = explode(',', $discount_code['excluded_products_id']);
      if (!empty($discount_code['customers_id'])) $dInfo->customers_id = explode(',', $discount_code['customers_id']);
      if ($discount_code['minimum_order_amount'] == '0.0000') $dInfo->minimum_order_amount = '';
      if ($discount_code['expires_date'] == '0000-00-00') $dInfo->expires_date = '';
      if ($discount_code['number_of_use'] == 0) $dInfo->number_of_use = '';
      if ($discount_code['number_of_products'] == 0) $dInfo->number_of_products = '';
    //} elseif (tep_not_null($HTTP_POST_VARS)) {
      //$dInfo->objectInfo($HTTP_POST_VARS);
    }

    $manufacturers_array = array();
    $manufacturers_query = tep_db_query("select manufacturers_id, manufacturers_name from " . TABLE_MANUFACTURERS . " order by manufacturers_name");
    while ($manufacturers = tep_db_fetch_array($manufacturers_query)) {
      $manufacturers_array[] = array('id' => $manufacturers['manufacturers_id'],
                                     'text' => $manufacturers['manufacturers_name']);
    }
?>

<script language="javascript">
function applies_to_onclick() {
  var a = document.new_discount_code.applies_to, b = document.getElementById("excluded_products_id"), c = document.getElementById("number_of_products"), d = document.getElementById("exclude_specials");
  for (var i = 0, n = a.length; i < n; i++) if (a[i].checked) { b.disabled = (a[i].value == 2 || a[i].value == 4 ? false : true); c.disabled = (a[i].value == 3 || a[i].value == 5 ? true : false); d.disabled = (a[i].value == 3 || a[i].value == 5 ? true : false) }
}
function customers_onclick() {
  var d = document.getElementById("customers"), e = document.getElementById("customers_id"); e.disabled = !d.checked;
}
function onload() {
  SetFocus();
  applies_to_onclick();
  customers_onclick();
}
</script>

      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <?php echo tep_draw_form('new_discount_code', FILENAME_DISCOUNT_CODES, (isset($HTTP_GET_VARS['page']) ? 'page=' . $HTTP_GET_VARS['page'] . '&' : '') . 'action=insert' . (isset($HTTP_GET_VARS['dID']) ? '&dID=' . (int)$HTTP_GET_VARS['dID'] : '')); ?><tr>
        <td><table border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td class="main"><?php echo TEXT_DISCOUNT_CODE; ?></td>
            <td class="main"><?php echo tep_draw_input_field('discount_codes', $dInfo->discount_codes, 'size="8"', true); ?></td>
            <td width="50"></td>
            <td class="main"><?php echo TEXT_NUMBER_OF_USE; ?></td>
            <td class="main"><?php echo tep_draw_input_field('number_of_use', $dInfo->number_of_use, 'size="4"'); ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo TEXT_DISCOUNT; ?></td>
            <td class="main"><?php echo tep_draw_input_field('discount_values', $dInfo->discount_values, 'size="8"', true); ?></td>
            <td></td>
            <td class="main"><?php echo TEXT_NUMBER_OF_PRODUCTS; ?></td>
            <td class="main"><?php echo tep_draw_input_field('number_of_products', $dInfo->number_of_products, 'size="4" id="number_of_products"'); ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo TEXT_MINIMUM_ORDER_AMOUNT; ?></td>
            <td class="main"><?php echo tep_draw_input_field('minimum_order_amount', $dInfo->minimum_order_amount, 'size="8"'); ?></td>
            <td></td>
            <td class="main" colspan="2"><?php echo '<label>' . tep_draw_checkbox_field('order_info', '1', $dInfo->order_info == 1) . '&nbsp;' . TEXT_ORDER_INFO . '</label>'; ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo TEXT_EXPIRY; ?></td>
            <td class="main"><?php echo tep_draw_input_field('expires_date', $dInfo->expires_date, 'id="expires_date" size="12"'); ?></td>
            <td></td>
            <td class="main" colspan="2"><?php echo '<label>' . str_replace('name="exclude_specials"', 'name="exclude_specials" id="exclude_specials"', tep_draw_checkbox_field('exclude_specials', '1', $dInfo->exclude_specials == 1)) . '&nbsp;' . TEXT_EXCLUDE_SPECIALS . '</label>'; ?></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td class="main"><?php echo TEXT_APPLIES_TO; ?></td>
            <td width="5"></td>
            <td class="main"><?php echo '<label>' . str_replace('<input type="radio"', '<input onclick="applies_to_onclick();" type="radio"', tep_draw_radio_field('applies_to', '5', $dInfo->orders_total == 2)) . '&nbsp;' . TEXT_ORDER_SUBTOTAL . '</label>'; ?></td>
            <td width="5"></td>
            <td class="main"><?php echo '<label>' . str_replace('<input type="radio"', '<input onclick="applies_to_onclick();" type="radio"', tep_draw_radio_field('applies_to', '3', $dInfo->orders_total == 1)) . '&nbsp;' . TEXT_ORDER_TOTAL . '</label>'; ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo '<label>' . str_replace('<input type="radio"', '<input onclick="applies_to_onclick();" type="radio"', tep_draw_radio_field('applies_to', '1', is_array($dInfo->products_id))) . '&nbsp;' . TEXT_PRODUCTS . '</label>'; ?></td>
            <td></td>
            <td class="main"><?php echo '<label>' . str_replace('<input type="radio"', '<input onclick="applies_to_onclick();" type="radio"', tep_draw_radio_field('applies_to', '2', is_array($dInfo->categories_id))) . '&nbsp;' . TEXT_CATEGORIES . '</label>'; ?></td>
            <td></td>
            <td class="main"><?php echo '<label>' . str_replace('<input type="radio"', '<input onclick="applies_to_onclick();" type="radio"', tep_draw_radio_field('applies_to', '4', is_array($dInfo->manufacturers_id))) . '&nbsp;' . TEXT_MANUFACTURERS . '</label>'; ?></td>
          </tr>
<?php
    $products_id = '';
    $products_query = tep_db_query("select p.products_id, pd.products_name, p.products_price, s.specials_new_products_price from (" . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd) left join " . TABLE_SPECIALS . " s on (p.products_id = s.products_id and s.status = '1' and ifnull(s.expires_date, now()) >= now()) where p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by products_name");
    while ($products = tep_db_fetch_array($products_query)) {
      $products_id .= '<option value="' . $products['products_id'] . '">' . $products['products_name'] . ' (' . (empty($products['specials_new_products_price']) ? '' : $currencies->format($products['specials_new_products_price']) . '/') . $currencies->format($products['products_price']) . ')</option>';
    }
    $products_id .= '</select>';

    $excluded_products_id = '<select name="excluded_products_id[]" size="10" multiple style="width: 280px;" id="excluded_products_id">' . $products_id;
    $products_id = '<select name="products_id[]" size="10" multiple style="width: 280px;">' . $products_id;

    if (is_array($dInfo->products_id)) {
      foreach ($dInfo->products_id as $v) {
        $products_id = str_replace('<option value="' . $v . '">', '<option value="' . $v . '" selected>', $products_id);
      }
    }

    if (is_array($dInfo->excluded_products_id)) {
      foreach ($dInfo->excluded_products_id as $v) {
        $excluded_products_id = str_replace('<option value="' . $v . '">', '<option value="' . $v . '" selected>', $excluded_products_id);
      }
    }

    $categories_id = str_replace('<select name="categories_id">', '<select name="categories_id[]" size="10" multiple style="width: 280px;">', tep_draw_pull_down_menu('categories_id', tep_get_category_tree('0', '', '0')));
    if (is_array($dInfo->categories_id)) {
      foreach ($dInfo->categories_id as $v) {
        $categories_id = str_replace('<option value="' . $v . '">', '<option value="' . $v . '" selected>', $categories_id);
      }
    }

    $manufacturers_id = str_replace('<select name="manufacturers_id">', '<select name="manufacturers_id[]" size="10" multiple style="width: 280px;">', tep_draw_pull_down_menu('manufacturers_id', $manufacturers_array));
    if (is_array($dInfo->manufacturers_id)) {
      foreach ($dInfo->manufacturers_id as $v) {
        $manufacturers_id = str_replace('<option value="' . $v . '">', '<option value="' . $v . '" selected>', $manufacturers_id);
      }
    }
?>
          <tr>
            <td class="main"><?php echo $products_id; ?></td>
            <td></td>
            <td class="main"><?php echo $categories_id; ?></td>
            <td></td>
            <td class="main"><?php echo $manufacturers_id; ?></td>
          </tr>
          <tr>
            <td></td>
            <td></td>
            <td class="main"><?php echo TEXT_EXCLUDED_PRODUCTS; ?></td>
            <td></td>
            <td class="main"><?php echo '<label>' . str_replace('<input type="checkbox"', '<input type="checkbox" id="customers" onclick="customers_onclick();"', tep_draw_checkbox_field('customers', '1', is_array($dInfo->customers_id))) . '&nbsp;' . TEXT_CUSTOMERS . '</label>'; ?></td>
          </tr>
          <tr>
            <td></td>
            <td></td>
            <td class="main"><?php echo $excluded_products_id; ?></td>
            <td></td>
<?php
    $customers_id = '<select name="customers_id[]" size="10" multiple style="width: 280px;" id="customers_id">';
    $customers_query = tep_db_query("select customers_id, concat(customers_lastname, ', ', customers_firstname, ' (', customers_email_address, ')') as customers_info from " . TABLE_CUSTOMERS . " order by customers_lastname, customers_firstname");
    while ($customers = tep_db_fetch_array($customers_query)) {
      $customers_id .= '<option value="' . $customers['customers_id'] . '">' . $customers['customers_info'] . '</option>';
    }
    $customers_id .= '</select>';

    if (is_array($dInfo->customers_id)) {
      foreach ($dInfo->customers_id as $v) {
        $customers_id = str_replace('<option value="' . $v . '">', '<option value="' . $v . '" selected>', $customers_id);
      }
    }
?>
            <td class="main"><?php echo $customers_id; ?></td>
          </tr>
        </table>

<script type="text/javascript">
$(document).ready(function() {
  $('#expires_date').datepicker({
    dateFormat: 'yy-mm-dd'
  });
});
</script>

        </td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
          <tr>
            <td class="smallText" align="right" valign="top" nowrap><?php echo tep_draw_button(IMAGE_SAVE, 'disk', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'close', tep_href_link(FILENAME_DISCOUNT_CODES, (isset($HTTP_GET_VARS['page']) ? 'page=' . $HTTP_GET_VARS['page'] . '&' : '') . (isset($HTTP_GET_VARS['dID']) ? 'dID=' . (int)$HTTP_GET_VARS['dID'] : ''))); ?></td>
          </tr>
        </table></td>
      </tr></form>
<?php
  } else {
?>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr class="dataTableHeadingRow">
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_DISCOUNT_CODE; ?></td>
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_APPLIES_TO; ?></td>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_DISCOUNT; ?></td>
                <td class="dataTableHeadingContent" align="center" alt="<?php echo TABLE_HEADING_MINIMUM_ORDER_AMOUNT_FULL; ?>" title=" <?php echo TABLE_HEADING_MINIMUM_ORDER_AMOUNT_FULL; ?> "><?php echo TABLE_HEADING_MINIMUM_ORDER_AMOUNT; ?></td>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_EXPIRY; ?></td>
                <td class="dataTableHeadingContent" align="center" alt="<?php echo TABLE_HEADING_NUMBER_OF_ORDERS_FULL; ?>" title=" <?php echo TABLE_HEADING_NUMBER_OF_ORDERS_FULL; ?> "><?php echo TABLE_HEADING_NUMBER_OF_ORDERS; ?></td>
                <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_STATUS; ?></td>
                <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_ACTION; ?>&nbsp;</td>
              </tr>
<?php
    $discount_codes_query_raw = "select dc.discount_codes_id, dc.products_id, dc.categories_id, dc.manufacturers_id, dc.excluded_products_id, dc.customers_id, dc.orders_total, dc.order_info, dc.exclude_specials, dc.discount_codes, dc.discount_values, dc.minimum_order_amount, dc.expires_date, dc.number_of_orders, dc.number_of_use, dc.number_of_products, dc.status from discount_codes dc order by dc.discount_codes_id desc";
    $discount_codes_split = new splitPageResults($HTTP_GET_VARS['page'], MAX_DISPLAY_SEARCH_RESULTS, $discount_codes_query_raw, $discount_codes_query_numrows);
    $discount_codes_query = tep_db_query($discount_codes_query_raw);
    while ($discount_codes = tep_db_fetch_array($discount_codes_query)) {
      $applies_to = '';
      if (!empty($discount_codes['orders_total'])) {
        if ($discount_codes['orders_total'] == 1) {
          $applies_to = TEXT_ORDER_TOTAL;
        } elseif ($discount_codes['orders_total'] == 2) {
          $applies_to = TEXT_ORDER_SUBTOTAL;
        }
      } elseif (!empty($discount_codes['products_id'])) {
        $applies_to = TEXT_PRODUCTS;
        $product_query = tep_db_query("select products_name from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id in (" . $discount_codes['products_id'] . ") and language_id = '" . (int)$languages_id . "' order by products_name");
        while ($product = tep_db_fetch_array($product_query)) {
          $applies_to .= (empty($applies_to) ? '' : '<br>') . $product['products_name'];
        }
      } elseif (!empty($discount_codes['categories_id'])) {
        $applies_to = TEXT_CATEGORIES;
        $category_query = tep_db_query("select c.categories_id from " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd where c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "' and c.categories_id in (" . $discount_codes['categories_id'] . ") order by c.parent_id, cd.categories_name");
        while ($category = tep_db_fetch_array($category_query)) {
          $applies_to .= (empty($applies_to) ? '' : '<br>') . tep_output_generated_category_path($category['categories_id']);
        }
      } else {
        $applies_to = TEXT_MANUFACTURERS;
        $manufacturer_query = tep_db_query("select manufacturers_name from " . TABLE_MANUFACTURERS . " where manufacturers_id in (" . $discount_codes['manufacturers_id'] . ") order by manufacturers_name");
        while ($manufacturer = tep_db_fetch_array($manufacturer_query)) {
          $applies_to .= (empty($applies_to) ? '' : '<br>') . $manufacturer['manufacturers_name'];
        }
      }
      if (!empty($discount_codes['excluded_products_id'])) {
        $applies_to .= '<br>' . TEXT_EXCLUDED_PRODUCTS;
        $product_query = tep_db_query("select products_name from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id in (" . $discount_codes['excluded_products_id'] . ") and language_id = '" . (int)$languages_id . "' order by products_name");
        while ($product = tep_db_fetch_array($product_query)) {
          $applies_to .= (empty($applies_to) ? '' : '<br>') . $product['products_name'];
        }
      }

      if ((!isset($HTTP_GET_VARS['dID']) || (isset($HTTP_GET_VARS['dID']) && ($HTTP_GET_VARS['dID'] == $discount_codes['discount_codes_id']))) && !isset($dInfo) && (substr($action, 0, 3) != 'new')) {
        $dInfo = new objectInfo($discount_codes);
      }

      if (isset($dInfo) && is_object($dInfo) && ($discount_codes['discount_codes_id'] == $dInfo->discount_codes_id)) {
        echo '              <tr id="defaultSelected" class="dataTableRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $dInfo->discount_codes_id) . '\'">' . "\n";
      } else {
        echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $discount_codes['discount_codes_id']) . '\'">' . "\n";
      }
?>
                <td class="dataTableContent"><?php echo $discount_codes['discount_codes']; ?></td>
                <td class="dataTableContent"><?php echo $applies_to; ?></td>
                <td class="dataTableContent" align="center"><?php echo strpos($discount_codes['discount_values'], '%') === false ? $currencies->format($discount_codes['discount_values']) : $discount_codes['discount_values']; ?>&nbsp;</td>
                <td class="dataTableContent" align="center"><?php echo $discount_codes['minimum_order_amount'] == '0.0000' ? '-' : $currencies->format($discount_codes['minimum_order_amount']); ?></td>
                <td class="dataTableContent" align="center"><?php echo $discount_codes['expires_date'] == '0000-00-00' ? '-' : tep_date_short($discount_codes['expires_date']); ?>&nbsp;</td>
                <td class="dataTableContent" align="center"><?php echo $discount_codes['number_of_orders']; ?></td>
                <td class="dataTableContent" align="right">
<?php
      if ($discount_codes['status'] == '1') {
        echo tep_image(DIR_WS_IMAGES . 'icon_status_green.gif', 'Active', 10, 10) . '&nbsp;&nbsp;<a href="' . tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $discount_codes['discount_codes_id'] . '&action=setflag&flag=0') . '">' . tep_image(DIR_WS_IMAGES . 'icon_status_red_light.gif', 'Set Inactive', 10, 10) . '</a>';
      } else {
        echo '<a href="' . tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $discount_codes['discount_codes_id'] . '&action=setflag&flag=1') . '">' . tep_image(DIR_WS_IMAGES . 'icon_status_green_light.gif', 'Set Active', 10, 10) . '</a>&nbsp;&nbsp;' . tep_image(DIR_WS_IMAGES . 'icon_status_red.gif', 'Inactive', 10, 10);
      }
?></td>
                <td class="dataTableContent" align="right"><?php if (isset($dInfo) && is_object($dInfo) && ($discount_codes['discount_codes_id'] == $dInfo->discount_codes_id)) { echo tep_image(DIR_WS_IMAGES . 'icon_arrow_right.gif', ''); } else { echo '<a href="' . tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $discount_codes['discount_codes_id']) . '">' . tep_image(DIR_WS_IMAGES . 'icon_info.gif', IMAGE_ICON_INFO) . '</a>'; } ?>&nbsp;</td>
              </tr>
<?php
    }
?>
              <tr>
                <td colspan="8"><table border="0" width="100%" cellspacing="0" cellpadding="2">
                  <tr>
                    <td class="smallText" valign="top"><?php echo $discount_codes_split->display_count($discount_codes_query_numrows, MAX_DISPLAY_SEARCH_RESULTS, $HTTP_GET_VARS['page'], TEXT_DISPLAY_NUMBER_OF_DISCOUNT_CODES); ?></td>
                    <td class="smallText" align="right"><?php echo $discount_codes_split->display_links($discount_codes_query_numrows, MAX_DISPLAY_SEARCH_RESULTS, MAX_DISPLAY_PAGE_LINKS, $HTTP_GET_VARS['page']); ?></td>
                  </tr>
                  <tr>
                    <td class="smallText" align="right" colspan="2"><?php echo tep_draw_button(IMAGE_NEW_DISCOUNT_CODE, 'plus', tep_href_link(FILENAME_DISCOUNT_CODES, 'action=new')); ?></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
<?php
  $heading = array();
  $contents = array();
  switch ($action) {
    case 'delete':
      $heading[] = array('text' => '<strong>' . $dInfo->discount_codes . '</strong>');

      $contents = array('form' => tep_draw_form('discount_codes', FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $dInfo->discount_codes_id . '&action=deleteconfirm'));
      $contents[] = array('text' => TEXT_INFO_DELETE_INTRO);
      $contents[] = array('align' => 'center', 'text' => '<br />' . tep_draw_button(IMAGE_DELETE, 'trash', null, 'primary') . tep_draw_button(IMAGE_CANCEL, 'close', tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $HTTP_GET_VARS['dID'])));
      break;
    default:
      if (is_object($dInfo)) {
        $heading[] = array('text' => '<strong>' . $dInfo->discount_codes . '</strong>');

        $contents[] = array('align' => 'center', 'text' => tep_draw_button(IMAGE_EDIT, 'document', tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $dInfo->discount_codes_id . '&action=new')) . tep_draw_button(IMAGE_DELETE, 'trash', tep_href_link(FILENAME_DISCOUNT_CODES, 'page=' . $HTTP_GET_VARS['page'] . '&dID=' . $dInfo->discount_codes_id . '&action=delete')));
        $contents[] = array('text' => '<br />');
        if ($dInfo->order_info == 1) $contents[] = array('text' => tep_image(DIR_WS_ICONS . 'tick.gif', TABLE_HEADING_ORDER_INFO_FULL) . '&nbsp;' . TABLE_HEADING_ORDER_INFO_FULL);
        if ($dInfo->exclude_specials == 1) $contents[] = array('text' => tep_image(DIR_WS_ICONS . 'tick.gif', TEXT_EXCLUDE_SPECIALS) . '&nbsp;' . TEXT_EXCLUDE_SPECIALS);
        if ($dInfo->number_of_use != 0) $contents[] = array('text' => TABLE_HEADING_NUMBER_OF_USE . ' ' . $dInfo->number_of_use);
        if ($dInfo->number_of_products != 0) $contents[] = array('text' => TABLE_HEADING_NUMBER_OF_PRODUCTS . ' ' . $dInfo->number_of_products);
        if (!empty($dInfo->customers_id)) {
          $select_string = '';
          $customers_query = tep_db_query("select concat(customers_lastname, ', ', customers_firstname, ' (', customers_email_address, ')') as customers_info from " . TABLE_CUSTOMERS . " where customers_id in (" . $dInfo->customers_id . ") order by customers_lastname, customers_firstname");
          while ($customers = tep_db_fetch_array($customers_query)) {
            $select_string .= (empty($select_string) ? '' : '<br>') . $customers['customers_info'];
          }
          if (!empty($select_string)) {
            $contents[] = array('text' => '<br />' . TEXT_INFO_CUSTOMERS . '<br />' . $select_string);
          }
        }
      }
      break;
  }

  if ( (tep_not_null($heading)) && (tep_not_null($contents)) ) {
    echo '            <td width="25%" valign="top">' . "\n";

    $box = new box;
    echo $box->infoBox($heading, $contents);

    echo '            </td>' . "\n";
  }
?>
          </tr>
        </table></td>
      </tr>
<?php
  }
?>
    </table>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
