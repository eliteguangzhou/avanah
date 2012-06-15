<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_PRODUCT_INFO);
  $tab_sel = tep_href_link(FILENAME_PRODUCT_INFO);  
  $current_page = FILENAME_PRODUCT_INFO;
  $product_check_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and pd.products_id = p.products_id and pd.language_id = '" . (int)$languages_id . "'");
  $product_check = tep_db_fetch_array($product_check_query);

  require(DIR_WS_INCLUDES . 'template_top.php');
?>
<?php echo tep_draw_content_top();?>
<?php
  if ($product_check['total'] < 1) {
?>
<?php echo tep_draw_title_top();?>
<h1><?php echo TEXT_PRODUCT_NOT_FOUND; ?></h1>
<?php echo tep_draw_title_bottom();?>

<div class="contentContainer">
  <div class="contentPadd">
      <div class="buttonSet">
        	<span class="fl_right"><?php echo tep_draw_button_top();?><?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'triangle-1-e', tep_href_link(FILENAME_DEFAULT)); ?><?php echo tep_draw_button_bottom();?></span>
      </div>
</div>
</div>
<?php
  } else {
    $product_info_query = tep_db_query("select p.products_id, pd.products_name, pd.products_description, p.products_model, p.products_quantity, p.products_image, pd.products_url, p.products_price, p.products_tax_class_id, p.products_date_added, p.products_date_available, p.manufacturers_id from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and pd.products_id = p.products_id and pd.language_id = '" . (int)$languages_id . "'");
    $product_info = tep_db_fetch_array($product_info_query);

    tep_db_query("update " . TABLE_PRODUCTS_DESCRIPTION . " set products_viewed = products_viewed+1 where products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and language_id = '" . (int)$languages_id . "'");

    if ($new_price = tep_get_products_special_price($product_info['products_id'])) {
      $products_price = ' <span class="productSpecialPrice fl_left">' . $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])) . '</span> <del class="fl_left">' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</del>';
    } else {
      $products_price = '<span class="productSpecialPrice">' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</span>';
    }

    if (tep_not_null($product_info['products_model'])) {
      $products_name = $product_info['products_name'] . '<br /><span class="smallText">[' . $product_info['products_model'] . ']</span>';
    } else {
      $products_name = $product_info['products_name'];
    }
?>

<?php echo tep_draw_form('cart_quantity', tep_href_link(FILENAME_PRODUCT_INFO, tep_get_all_get_params(array('action')) . 'action=add_product')); ?>

<?php
// add by Seaman   
	switch (tep_not_null($product_info['products_image'])) {
	case 0:
		if (($oscTemplate->hasBlocks('box_info_page')))	{
		$port_side = 'left_side_pic-1';	
		$starboard_side = 'right_side_pic-1';
		}else{
		$port_side = 'left_side_pic-0';
		$starboard_side = 'right_side_pic-0';
		}
		break;
	case 1:
		$port_side = 'left_side_pic-1';
		$starboard_side = 'right_side_pic-1';
		break;
	}   
// add by Seaman   
?>
<div class="contentContainer">
  <div class="contentPadd prods_info_page">
	<div class="prods_info decks big">
		<div class="forecastle">
		<ol class="masthead">
			  <li class="port_side <?php echo $port_side;?>">
<?php
    if (tep_not_null($product_info['products_image'])) {
      $pi_query = tep_db_query("select image, htmlcontent from " . TABLE_PRODUCTS_IMAGES . " where products_id = '" . (int)$product_info['products_id'] . "' order by sort_order");
?>	  
<?php
          if (tep_db_num_rows($pi_query) > 0) {
?>
        <div id="piGal" class="hover">
          	<ul class="relative">
<?php
        $pi_counter = 0;
        while ($pi = tep_db_fetch_array($pi_query)) {
          $pi_counter++;
          $pi_entry = '        <li class="wrapper_pic_div"><a href="';
		  $pi_entry .= tep_href_link(DIR_WS_IMAGES . $pi['image']);
		  $pi_entry .= '" target="_blank" rel="fancybox" title="' . $pi['htmlcontent'] . '" class="prods_pic_bg" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $pi['image'], $pi['htmlcontent'], (PROD_INFO_IMAGE_WIDTH), (PROD_INFO_IMAGE_HEIGHT), ' style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . ''.tep_draw_prod_pic_info_top().''.tep_draw_prod_pic_info_bottom().'</a>';
          $pi_entry .= '</li>';
          echo $pi_entry;
        }
?>
          	</ul>
        </div>
<?php
// add by Seaman
 	if	(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W2 != PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H2){
		$coeff = ((PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H2)/(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W2));	
	}else{
		$coeff = 1;
	}
// add by Seaman	
?>      
    <script type="text/javascript">
    $(function(){
	var myWidth = <?php echo (($pi_counter > 1) ? '66' : '0'); ?>;
	var myHeight = myWidth * <?php echo $coeff;?>;
		$('#piGal ul').bxGallery({
		  maxwidth: '<?php echo (PROD_INFO_IMAGE_WIDTH + PIC_MARG_W); ?>',
		  maxheight: '<?php echo (PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H); ?>',
		  thumbwidth: myWidth,
		  thumbheight: myHeight,
		  thumbcontainer: <?php echo (PROD_INFO_IMAGE_WIDTH + PIC_MARG_W + 10); ?>,
		  load_image: 'ext/jquery/bxGallery/spinner.gif'
    })
        });
    </script>
<?php
          } else {
			  if (tep_not_null($product_info['products_image'])) {
?>
   			 	<div style="width:<?php echo (PROD_INFO_IMAGE_WIDTH + 10); ?>px;" class="hover">
          <?php echo '<div id="piGal" class="wrapper_pic_div fl_left" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;"><a class="prods_pic_bg" href="' . tep_href_link(DIR_WS_IMAGES . $product_info['products_image']) . '" target="_blank" rel="fancybox">' . tep_image(DIR_WS_IMAGES . $product_info['products_image'], addslashes($product_info['products_name']), (PROD_INFO_IMAGE_WIDTH), (PROD_INFO_IMAGE_HEIGHT), ' style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"', '', '') . ''.tep_draw_prod_pic_info_top().''.tep_draw_prod_pic_info_bottom().'</a></div>'; ?>
        
    			</div>
<?php
// add by Seaman
			  }
		}				  
    echo '<script type="text/javascript">
    $("#piGal a[rel^=\'fancybox\']").fancybox({
      cyclic: true
    });
    </script>';
			  
	if (($oscTemplate->hasBlocks('box_info_page')))	{
		$width_ext = PROD_INFO_IMAGE_WIDTH + PIC_MARG_W;
?>
				<div class="bookmarks">
<?php echo $oscTemplate->getBlocks('box_info_page');?>
				</div>		
<?php				

// add by Seaman
}
?>
<?php
        }
?>
              </li>
			  <li class="starboard_side <?php echo $starboard_side;?>">
<?php
// add by Seaman   
   if ($product_check['total'] >= 1) {
      include (DIR_WS_INCLUDES . 'products_next_previous.php');
   }
// add by Seaman
?>              
    				<div class="info">
<?php
        if ($product_info['products_date_available'] > date('Y-m-d H:i:s')) {
?>
                        <div class="data data_padd small_title"><?php echo sprintf(TEXT_DATE_AVAILABLE, tep_date_long($product_info['products_date_available'])); ?></div>
<?php
        }else{
?>		
                        <div class="data data_padd small_title"><?php echo sprintf(TEXT_DATE_ADDED, tep_date_long($product_info['products_date_added'])); ?></div>
<?php    	
        }
?>
                        <br /><h2><?php echo $products_name; ?></h2>
                        <h2 class="price"><?php echo '<b>'.PRICE. '</b>'.$products_price; ?></h2>
<?php
        $products_attributes_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$HTTP_GET_VARS['products_id'] . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "'");
        $products_attributes = tep_db_fetch_array($products_attributes_query);
        if ($products_attributes['total'] > 0) {
?>
                    <div class="options">
                        <p class="options-title"><?php echo TEXT_PRODUCT_OPTIONS; ?></p>
                        <ul class="ofh">
<?php
                      $products_options_name_query = tep_db_query("select distinct popt.products_options_id, popt.products_options_name from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$HTTP_GET_VARS['products_id'] . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "' order by popt.products_options_name");
                      while ($products_options_name = tep_db_fetch_array($products_options_name_query)) {
                        $products_options_array = array();
                        $products_options_query = tep_db_query("select pov.products_options_values_id, pov.products_options_values_name, pa.options_values_price, pa.price_prefix from " . TABLE_PRODUCTS_ATTRIBUTES . " pa, " . TABLE_PRODUCTS_OPTIONS_VALUES . " pov where pa.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and pa.options_id = '" . (int)$products_options_name['products_options_id'] . "' and pa.options_values_id = pov.products_options_values_id and pov.language_id = '" . (int)$languages_id . "'");
                        while ($products_options = tep_db_fetch_array($products_options_query)) {
                          $products_options_array[] = array('id' => $products_options['products_options_values_id'], 'text' => $products_options['products_options_values_name']);
                          if ($products_options['options_values_price'] != '0') {
                            $products_options_array[sizeof($products_options_array)-1]['text'] .= ' (' . $products_options['price_prefix'] . $currencies->display_price($products_options['options_values_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) .') ';
                          }
                        }
    
                        if (is_string($HTTP_GET_VARS['products_id']) && isset($cart->contents[$HTTP_GET_VARS['products_id']]['attributes'][$products_options_name['products_options_id']])) {
                          $selected_attribute = $cart->contents[$HTTP_GET_VARS['products_id']]['attributes'][$products_options_name['products_options_id']];
                        } else {
                          $selected_attribute = false;
                        }
?>
                        		<li class="fl_left"><label><?php echo $products_options_name['products_options_name'] . ':'; ?></label><?php echo tep_draw_pull_down_menu('id[' . $products_options_name['products_options_id'] . ']', $products_options_array, $selected_attribute); ?></li>
<?php
          }
?>
                            </ul>
                        </div>
<?php
        }
?>
            			<div class="desc desc_padd"><?php echo stripslashes($product_info['products_description']); ?></div>
    
<?php
        $reviews_query = tep_db_query("select count(*) as count from " . TABLE_REVIEWS . " where products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and reviews_status = 1");
        $reviews = tep_db_fetch_array($reviews_query);
?>
    
                        <div class="buttonSet">
                            <span class="buttonAction"><?php echo tep_draw_button2_top();?><?php echo tep_draw_button(IMAGE_BUTTON_REVIEWS . (($reviews['count'] > 0) ? ' (' . $reviews['count'] . ')' : ''), 'comment', tep_href_link(FILENAME_PRODUCT_REVIEWS, tep_get_all_get_params())); ?><?php echo tep_draw_button2_bottom();?></span>
                
                            <div class="fl_right" align="right"><?php echo tep_draw_button_top();?><?php echo tep_draw_hidden_field('products_id', $product_info['products_id']) . tep_draw_button(IMAGE_BUTTON_IN_CART, 'cart', null, 'primary'); ?><?php echo tep_draw_button_bottom();?></div>
                        </div>
        			</div> 
              </li>
		</ol>
		</div>	
	</div>
    
    </div>
</div>
<?php
    if ((USE_CACHE == 'true') && empty($SID)) {
      echo tep_cache_also_purchased(3600);
    } else {
      include(DIR_WS_MODULES . FILENAME_ALSO_PURCHASED_PRODUCTS);
    }
?>
</form>
<?php
  }
?>
<?php echo tep_draw_content_bottom();?>
<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>