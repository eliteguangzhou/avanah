<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require("includes/application_top.php");

  if ($cart->count_contents() > 0) {
    include(DIR_WS_CLASSES . 'payment.php');
    $payment_modules = new payment;
  }

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_SHOPPING_CART);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_SHOPPING_CART));
  $tab_sel = tep_href_link(FILENAME_SHOPPING_CART);  
  $current_page = FILENAME_SHOPPING_CART;
  require(DIR_WS_INCLUDES . 'template_top.php');
?>

<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE; ?></h1>
<?php echo tep_draw_title_bottom();?>

<?php
  if ($cart->count_contents() > 0) {
?>

<?php echo tep_draw_form('cart_quantity', tep_href_link(FILENAME_SHOPPING_CART, 'action=update_product')); ?>

<div class="contentContainer page_cart">
 <!-- <h2><?php /*echo TABLE_HEADING_PRODUCTS;*/ ?></h2>-->
  <div class="contentPadd">

<?php
    $any_out_of_stock = 0;
    $products = $cart->get_products();
    for ($i=0, $n=sizeof($products); $i<$n; $i++) {
// Push all attributes information in an array
      if (isset($products[$i]['attributes']) && is_array($products[$i]['attributes'])) {
        while (list($option, $value) = each($products[$i]['attributes'])) {
          echo tep_draw_hidden_field('id[' . $products[$i]['id'] . '][' . $option . ']', $value);
          $attributes = tep_db_query("select popt.products_options_name, poval.products_options_values_name, pa.options_values_price, pa.price_prefix
                                      from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_OPTIONS_VALUES . " poval, " . TABLE_PRODUCTS_ATTRIBUTES . " pa
                                      where pa.products_id = '" . (int)$products[$i]['id'] . "'
                                       and pa.options_id = '" . (int)$option . "'
                                       and pa.options_id = popt.products_options_id
                                       and pa.options_values_id = '" . (int)$value . "'
                                       and pa.options_values_id = poval.products_options_values_id
                                       and popt.language_id = '" . (int)$languages_id . "'
                                       and poval.language_id = '" . (int)$languages_id . "'");
          $attributes_values = tep_db_fetch_array($attributes);

          $products[$i][$option]['products_options_name'] = $attributes_values['products_options_name'];
          $products[$i][$option]['options_values_id'] = $value;
          $products[$i][$option]['products_options_values_name'] = $attributes_values['products_options_values_name'];
          $products[$i][$option]['options_values_price'] = $attributes_values['options_values_price'];
          $products[$i][$option]['price_prefix'] = $attributes_values['price_prefix'];
        }
      }
    }
	$row = 0;
	echo '     	<table border="0" cellspacing="0" cellpadding="0" class="prods_content cart">'.
						'<tr>'.
							'<th class="th1">'.TABLE_HEADING_PRODUCTS.'</th>'.
							'<th>'.TABLE_HEADING_QUANTITY.'</th>'.
							'<th class="th3">'.TABLE_HEADING_TOTAL.'</th>'.
						'</tr>';
    for ($i=0, $n=sizeof($products); $i<$n; $i++) {
      
		if ($row != 0) {
	echo '     			<tr><td colspan="3" class="cart_hseparator">'.tep_draw_separator('spacer.gif', '1', '1').'</td></tr>';
}	 

      $products_name = '<tr class="row" id="row-' . $row . '">';
					   
      $products_name .=  '  <td class="cart_prods" align="center">  
					   			<table border="0" cellspacing="0" cellpadding="0" class="hover">
									<tr><td colspan="2"><div class="name name_padd equal-height"><span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $products[$i]['id']) . '">' . $products[$i]['name'] . '</a></span></div></td></tr>
									<tr>
										<td align="center" style="width:100%;"><div class="pic_padd wrapper_pic_div" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;"><a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $products[$i]['id']) . '" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image('/includes/languages/'.$language . '/images/' .  $products[$i]['image'], $products[$i]['name'], (CART_IMAGE_WIDTH), (CART_IMAGE_HEIGHT), ' style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;""') . ''.tep_draw_prod_pic_cart_top().''.tep_draw_prod_pic_cart_bottom().'</a><div></td>';
										

      if (STOCK_CHECK == 'true') {
        $stock_check = tep_check_stock($products[$i]['id'], $products[$i]['quantity']);
        if (tep_not_null($stock_check)) {
          $any_out_of_stock = 1;

          $products_name .= $stock_check;
        }
      }
      
	  $products_options = '';
	  if (isset($products[$i]['attributes']) && is_array($products[$i]['attributes'])) {
        reset($products[$i]['attributes']);
		
        $products_options = 	'<div class="cart_products_options">';		
       while (list($option, $value) = each($products[$i]['attributes'])) {

          $products_options .= '<i> - ' .$products[$i][$option]['products_options_name'] . ':&nbsp;&nbsp;' . $products[$i][$option]['products_options_values_name'] . '</i><br />';
        }
        
		
		$products_options .= 	'</div>';			
      }
										
      $products_name .=  				'<td>'.$products_options.'</td>
									</tr>
								</table>
							</td>'.
							'<td class="cart_update"><div class="name name_padd equal-height">&nbsp;</div>' . tep_draw_input_field('cart_quantity[]', $products[$i]['quantity'], 'size="6"').'
									<div class="buttonSet">
											'. tep_draw_hidden_field('products_id[]', $products[$i]['id']).''.tep_draw_button_top() . '' . tep_draw_button(IMAGE_BUTTON_UPDATE, 'refresh') .'' .tep_draw_button_bottom() . '<br /><br /><br /><br />
											' .tep_draw_button_top() . '<a id="tdb1" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" href="' . tep_href_link(FILENAME_SHOPPING_CART, 'products_id=' . $products[$i]['id'] . '&action=remove_product') . '"><span class="ui-button-icon-primary ui-icon ui-icon-trash"></span><span class="ui-button-text">'.TABLE_HEADING_REMOVE.'</span></a>' .tep_draw_button_bottom() . '
									</div></td>'.
											
							'<td class="cart_price"><div class="name name_padd equal-height">&nbsp;</div><span class="productSpecialPrice">' . $currencies->display_price($products[$i]['final_price'], tep_get_tax_rate($products[$i]['tax_class_id']), $products[$i]['quantity']) . '</span></td>';
      $products_name .= 
                        '  </tr>';
	
	   echo  $products_name ;
	   

      echo '      ';
	  $row ++;
    }
?>
		<tr class="cart_total">
        	<td>&nbsp;</td>
            <td><?php echo SUB_TITLE_SUB_TOTAL; ?></td>
            <td class="productSpecialPrice"><?php echo $currencies->format($cart->show_total()); ?></td>
        </tr>
            <?php 
            include(DIR_WS_CLASSES . 'order.php');
    $order = new order;
        include(DIR_WS_MODULES . 'order_total/ot_discount.php');
                $ot_discount = new ot_discount;
                $ot_discount->process();
            global $discount;
            
            if ($sess_discount_code){
            echo '<tr class="cart_total"><td>&nbsp;</td><td>';
            echo $ot_discount->output[0]['title'].'</td>';
            echo '<td >-'.$ot_discount->output[0]['text'].'</td>';
            echo '<pre>';
          //  print_r($order);
            echo '</pre>';
            
            echo '</tr>';
            }
            ?>
            <tr class="cart_total">
                <td>&nbsp;</td>
                <td  >
                    <?php echo SHIPPING_COST; ?>
                </td>
                <td class="productSpecialPrice">
                <?php 
                $total_weight = $cart->show_weight();
  $total_count = $cart->count_contents();
                // load all enabled shipping modules
  require(DIR_WS_CLASSES . 'shipping.php');
  $shipping_modules = new shipping;
       if (!tep_session_is_registered('shipping')) tep_session_register('shipping');

    if ( (tep_count_shipping_modules() > 0) || ($free_shipping == true) ) {
      if ( (isset($HTTP_POST_VARS['shipping'])) && (strpos($HTTP_POST_VARS['shipping'], '_')) ) {
        $shipping = $HTTP_POST_VARS['shipping'];

        list($module, $method) = explode('_', $shipping);
        if ( is_object($$module) || ($shipping == 'free_free') ) {
          if ($shipping == 'free_free') {
            $quote[0]['methods'][0]['title'] = FREE_SHIPPING_TITLE;
            $quote[0]['methods'][0]['cost'] = '0';
          } else {
            $quote = $shipping_modules->quote($method, $module);
          }
          if (isset($quote['error'])) {
            tep_session_unregister('shipping');
          } else {
            if ( (isset($quote[0]['methods'][0]['title'])) && (isset($quote[0]['methods'][0]['cost'])) ) {
              $shipping = array('id' => $shipping,
                                'title' => (($free_shipping == true) ?  $quote[0]['methods'][0]['title'] : $quote[0]['module'] . ' (' . $quote[0]['methods'][0]['title'] . ')'),
                                'cost' => $quote[0]['methods'][0]['cost']);

              tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, '', 'SSL'));
            }
          }
        } else {
          tep_session_unregister('shipping');
        }
      }
    }
   $quotes = $shipping_modules->quote();
   $shipping_t = $quotes[0]['methods'][0]['cost'];
echo $currencies->format(tep_add_tax($quotes[0]['methods'][0]['cost'], (isset($quotes[0]['tax']) ? $quotes[0]['tax'] : 0))) . tep_draw_hidden_field('shipping', $quotes[0]['id'] . '_' . $quotes[0]['methods'][0]['id']); 
 $v = $order->info['shipping_cost'];
 $order->info['shipping_cost'] = $shipping_t;
 $order->info['total'] += ($shipping_t - $v);
  ?>
                </td>
             </tr>
            <tr class="cart_total2">
                <td>&nbsp;</td>
                <td class="cart_total2_title" >
                    <?php echo TOTAL; ?>
                </td>
                <td  class="productSpecialPrice">
                <?php 
                    echo $currencies->format(tep_add_tax($order->info['total'],0));
    ?>
                </td>
             </tr>
    </table>
    
    
    <br/>
  <!--  <div class="prods_hseparator"><?php /*echo tep_draw_separator('spacer.gif', '1', '1');*/?></div> -->
<?php
  // Discount Code 3.1.1 - start
  if (MODULE_ORDER_TOTAL_DISCOUNT_STATUS == 'true') {
?>
  <h3><?php echo TEXT_DISCOUNT_CODE; ?></h3>
  <div class="contentText">
    <table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="middle" height="25"><?php echo tep_draw_input_field('discount_code', $sess_discount_code, 'id="discount_code" size="10"'); ?></td>
        <td width="5"></td>
        <td valign="middle"><div id="discount_code_status"></div></td>
      </tr>
    </table>
  </div>
<?php
  }
  // Discount Code 3.1.1 - end
?>

<?php
    if ($any_out_of_stock == 1) {
      if (STOCK_ALLOW_CHECKOUT == 'true') {
?>

    <p class="stockWarning" align="center"><?php echo OUT_OF_STOCK_CAN_CHECKOUT; ?></p>

<?php
      } else {
?>

    <p class="stockWarning" align="center"><?php echo OUT_OF_STOCK_CANT_CHECKOUT; ?></p>

<?php
      }
    }
?>

	<div class="prods_hseparator"><?php echo tep_draw_separator('spacer.gif', '1', '1');?></div>
		<div class="cl_both ofh cart_total buttonSet">
        
        	<div class="fl_left"><?php echo tep_draw_button2_top();?><?php echo tep_draw_button(IMAGE_BUTTON_CHECKOUT, 'triangle-1-e', tep_href_link(FILENAME_CHECKOUT_SHIPPING, '', 'SSL'), 'primary'); ?><?php echo tep_draw_button2_bottom();?></div>
<?php
    		$initialize_checkout_methods = $payment_modules->checkout_initialization_method();

    		if (!empty($initialize_checkout_methods)) {
?>
<?php
      		reset($initialize_checkout_methods);
     		while (list(, $value) = each($initialize_checkout_methods)) {
?>
   			
             <p class="fl_left or"><span class="ui-button-text">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo TEXT_ALTERNATIVE_CHECKOUT_METHODS; ?></span></p>
             <p class="fl_left"><?php echo $value; ?></p>
<?php
      }
    }
?>
    		
  		</div>
  </div>
</div>

</form>

<?php
  } else {
?>

<div class="contentContainer page_cart">
  <div class="contentPadd txtPage">
    <?php echo TEXT_CART_EMPTY; ?><br /><br />
    <div class="buttonSet fl_right"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'triangle-1-e', tep_href_link(FILENAME_DEFAULT)); ?><?php echo tep_draw_button_bottom();?></div>
  </div>
</div>

<?php
  }
?>
<script type="text/javascript">
        $(document).ready(function(){ 			
			 var row_list = $('.row');
			 row_list.each(function(){
				 new equalHeights($('#' + $(this).attr("id")));
			  });			 			 			  			  			  			  			   
        })  
        <?php
  // Discount Code 3.1.1 - start
  if (MODULE_ORDER_TOTAL_DISCOUNT_STATUS == 'true') {
?>
$(document).ready(function() {
var a = 0;
discount_code_process();
$('#discount_code').blur(function() { if (a == 0) discount_code_process(); a = 0 });
$("#discount_code").keypress(function(event) { if (event.which == 13) { event.preventDefault(); a = 1; discount_code_process() } });
function discount_code_process() { if ($("#discount_code").val() != "") { $("#discount_code").attr("readonly", "readonly"); $("#discount_code_status").empty().append('<?php echo tep_image(DIR_WS_ICONS . 'dc_progress.gif'); ?>'); $.post("discount_code.php", { discount_code: $("#discount_code").val() }, function(data) { data == 1 ? $("#discount_code_status").empty().append('<?php echo tep_image(DIR_WS_ICONS . 'dc_success.gif'); ?>') : $("#discount_code_status").empty().append('<?php echo tep_image(DIR_WS_ICONS . 'dc_failed.gif'); ?>'); $("#discount_code").removeAttr("readonly") }); } }
});
<?php
  }
  // Discount Code 3.1.1 - end
?>
</script>
<?php echo tep_draw_content_bottom();?>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
