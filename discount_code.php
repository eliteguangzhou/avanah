<?php
/*
  Discount Code 3.1.1
  http://high-quality-php-coding.com/
*/

  require('includes/application_top.php');

  $discount = 0;
  if (MODULE_ORDER_TOTAL_DISCOUNT_STATUS == 'true' && !empty($HTTP_SERVER_VARS['HTTP_X_REQUESTED_WITH']) && $HTTP_SERVER_VARS['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
    include(DIR_WS_CLASSES . 'order.php');
    $order = new order;

    include(DIR_WS_MODULES . 'order_total/ot_discount.php');
    $ot_discount = new ot_discount;
    $ot_discount->process();
  }

  tep_session_close();

  echo $discount > 0 ? 1 : 0;
  exit();
?>
