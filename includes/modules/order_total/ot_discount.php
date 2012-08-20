<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License

  Discount Code 3.0
  http://high-quality-php-coding.com/
*/

  class ot_discount {
    var $title, $output;

    function ot_discount() {
      $this->code = 'ot_discount';
      $this->title = MODULE_ORDER_TOTAL_DISCOUNT_TITLE;
      $this->description = MODULE_ORDER_TOTAL_DISCOUNT_DESCRIPTION;
      $this->enabled = ((MODULE_ORDER_TOTAL_DISCOUNT_STATUS == 'true') ? true : false);
      $this->sort_order = MODULE_ORDER_TOTAL_DISCOUNT_SORT_ORDER;

      $this->output = array();
    }

    function process() {
      global $order, $currencies, $customer_id, $discount, $sess_discount_code, $tax_discount;
      $discount = 0;
      $tax_discount = array();

      if (!empty($sess_discount_code)) {
        $check_query = tep_db_query("select count(*) as total, dc.number_of_use from " . TABLE_DISCOUNT_CODES . " dc, " . TABLE_CUSTOMERS_TO_DISCOUNT_CODES . " c2dc where dc.discount_codes_id = c2dc.discount_codes_id and dc.discount_codes = '" . tep_db_input($sess_discount_code) . "' and c2dc.customers_id = '" . (int)$customer_id . "' group by c2dc.customers_id limit 1");
        if (tep_db_num_rows($check_query) == 0) {
          $check['number_of_use'] = 0;
        } else {
          $check = tep_db_fetch_array($check_query);
        }
        if (($check['number_of_use'] == 0 ? 1 : ($check['total'] < $check['number_of_use'] ? 1 : 0)) == 1) {
          $check_query = tep_db_query("select dc.products_id, dc.categories_id, dc.manufacturers_id, dc.excluded_products_id, dc.customers_id, dc.orders_total, dc.order_info, dc.exclude_specials, dc.discount_values, dc.number_of_products from " . TABLE_DISCOUNT_CODES . " dc where dc.discount_codes = '" . tep_db_input($sess_discount_code) . "' and if(dc.expires_date = '0000-00-00', date_format(date_add(now(), interval 1 day), '%Y-%m-%d'), dc.expires_date) >= date_format(now(), '%Y-%m-%d') and dc.minimum_order_amount <= " . $order->info['total'] . " and dc.status = '1' limit 1");
          if (tep_db_num_rows($check_query)) {
            $check = tep_db_fetch_array($check_query);
            $order_info = $check['order_info'];

            if (!empty($check['customers_id'])) {
              $customers = explode(',', $check['customers_id']);
            } else {
              $customers = array($customer_id);
            }

            if (in_array($customer_id, $customers)) {
              if (!empty($check['products_id']) || !empty($check['categories_id']) || !empty($check['manufacturers_id'])) {

                $products = array();
                if (!empty($check['products_id'])) {
                  $products = explode(',', $check['products_id']);
                } elseif (!empty($check['categories_id'])) {
                  $product_query = tep_db_query("select products_id from " . TABLE_PRODUCTS_TO_CATEGORIES . " where categories_id in (" . $check['categories_id'] . ")" . (empty($check['excluded_products_id']) ? '' : " and products_id not in (" . $check['excluded_products_id'] . ")"));
                  while ($product = tep_db_fetch_array($product_query)) {
                    $products[] = $product['products_id'];
                  }
                } elseif (!empty($check['manufacturers_id'])) {
                  $product_query = tep_db_query("select products_id from " . TABLE_PRODUCTS . " where manufacturers_id in (" . $check['manufacturers_id'] . ")" . (empty($check['excluded_products_id']) ? '' : " and products_id not in (" . $check['excluded_products_id'] . ")"));
                  while ($product = tep_db_fetch_array($product_query)) {
                    $products[] = $product['products_id'];
                  }
                }

                if ((int)$check['exclude_specials'] == 1) {
                  $specials = array();
                  $product_query = tep_db_query("select p.products_id from " . TABLE_PRODUCTS . " p, " . TABLE_SPECIALS . " s where p.products_id = s.products_id and s.status = '1' and ifnull(s.expires_date, now()) >= now()");
                  while ($product = tep_db_fetch_array($product_query)) {
                    $specials[] = $product['products_id'];
                  }
                  if (sizeof($specials) > 0) {
                    $products = array_diff($products, $specials);
                  }
                }

                $k = $check['number_of_products'];
                for ($i = 0, $n = sizeof($order->products); $i < $n; $i++) {
                  if (in_array(tep_get_prid($order->products[$i]['id']), $products)) {

                    if (empty($check['number_of_products'])) {
                      $products_discount = (strpos($check['discount_values'], '%') === false ? $check['discount_values'] * $order->products[$i]['qty'] : $order->products[$i]['final_price'] * str_replace('%', '', $check['discount_values']) / 100 * $order->products[$i]['qty']);
                    } else {
                      if ($k >= $order->products[$i]['qty']) {
                        $products_discount = (strpos($check['discount_values'], '%') === false ? $check['discount_values'] * $order->products[$i]['qty'] : $order->products[$i]['final_price'] * str_replace('%', '', $check['discount_values']) / 100 * $order->products[$i]['qty']);
                        $k -= $order->products[$i]['qty'];
                      } else {
                        $products_discount = (strpos($check['discount_values'], '%') === false ? $check['discount_values'] * $k : $order->products[$i]['final_price'] * str_replace('%', '', $check['discount_values']) / 100 * $k);
                        $k = 0;
                      }
                    }

                    if (!empty($order->products[$i]['tax'])) {
                      $tax_discount[$order->products[$i]['tax_description']] += $products_discount * $order->products[$i]['tax'] / 100;
                    }

                    $discount += $products_discount;
                  }
                }

              } elseif (!empty($check['orders_total'])) {
                if ($check['orders_total'] == 1) {
                  $discount = (strpos($check['discount_values'], '%') === false ? $check['discount_values'] : $order->info['total'] * str_replace('%', '', $check['discount_values']) / 100);
                } elseif ($check['orders_total'] == 2) {
                  $discount = (strpos($check['discount_values'], '%') === false ? $check['discount_values'] : $order->info['subtotal'] * str_replace('%', '', $check['discount_values']) / 100);
                }
              }
            }

          }
        }
      }

      if (!empty($discount)) {
      
        $order->info['total'] -= array_sum($tax_discount);
        $order->info['total'] -= $discount;

        $this->output[] = array('title' => TEXT_DISCOUNT . (!empty($order_info) ? ' (' . $sess_discount_code . ')' : '') . ':',
                                'text' => '<span class="productSpecialPrice">' . $currencies->format($discount, true, $order->info['currency'], $order->info['currency_value']) . '</span>',
                                'value' => $discount);
      }
    }

    function check() {
      if (!isset($this->_check)) {
        $check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_ORDER_TOTAL_DISCOUNT_STATUS'");
        $this->_check = tep_db_num_rows($check_query);
      }

      return $this->_check;
    }

    function keys() {
      return array('MODULE_ORDER_TOTAL_DISCOUNT_STATUS', 'MODULE_ORDER_TOTAL_DISCOUNT_SORT_ORDER');
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Display Discount', 'MODULE_ORDER_TOTAL_DISCOUNT_STATUS', 'true', 'Do you want to display the discount value?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ORDER_TOTAL_DISCOUNT_SORT_ORDER', '2', 'Sort order of display.', '6', '2', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }
  }
?>
