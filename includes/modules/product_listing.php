<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/
?>

<?php
  $listing_split = new splitPageResults($listing_sql, MAX_DISPLAY_SEARCH_RESULTS, 'p.products_id');
?>

  

<?php
  if ( ($listing_split->number_of_rows > 0) && ( (PREV_NEXT_BAR_LOCATION == '1') || (PREV_NEXT_BAR_LOCATION == '3') ) ) {
?>

<?php echo tep_draw_result1_top(); ?>
       
        <div class="cl_both result_top_padd ofh">
        	<div class="fl_left result_left"><?php echo $listing_split->display_count(TEXT_DISPLAY_NUMBER_OF_PRODUCTS); ?></div>
            <div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $listing_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info', 'x', 'y'))); ?></div>
        </div>

<?php echo tep_draw_result1_bottom(); ?> 
	
<?php
  }
?>

<?php  
	$row = 0;
	$col = 0;
	

  for ($col_sort=0, $n=sizeof($column_list); $col_sort<$n; $col_sort++) {
    $lc_align = '';

    switch ($column_list[$col_sort]) {
      case 'PRODUCT_LIST_MODEL':
        $lc_text = TABLE_HEADING_MODEL;
        $lc_align = '';
        break;
      case 'PRODUCT_LIST_NAME':
        $lc_text = TABLE_HEADING_PRODUCTS;
        $lc_align = '';
        break;
      case 'PRODUCT_LIST_MANUFACTURER':
        $lc_text = TABLE_HEADING_MANUFACTURER;
        $lc_align = '';
        break;
      case 'PRODUCT_LIST_PRICE':
        $lc_text = TABLE_HEADING_PRICE;
        $lc_align = 'right';
        break;
      case 'PRODUCT_LIST_QUANTITY':
        $lc_text = TABLE_HEADING_QUANTITY;
        $lc_align = 'right';
        break;
      case 'PRODUCT_LIST_WEIGHT':
        $lc_text = TABLE_HEADING_WEIGHT;
        $lc_align = 'right';
        break;
      case 'PRODUCT_LIST_IMAGE':
        $lc_text = TABLE_HEADING_IMAGE;
        $lc_align = 'center';
        break;
      case 'PRODUCT_LIST_BUY_NOW':
        $lc_text = TABLE_HEADING_BUY_NOW;
        $lc_align = 'center';
        break;
    }

    if ( ($column_list[$col_sort] != 'PRODUCT_LIST_BUY_NOW') && ($column_list[$col_sort] != 'PRODUCT_LIST_IMAGE') ) {
      $lc_text = tep_create_sort_heading($HTTP_GET_VARS['sort'], $col_sort+1, $lc_text);
    }
  }


  if ($listing_split->number_of_rows > 0) {

  	$col_items = (MAX_DISPLAY_SEARCH_RESULTS_PER_ROW - 1);
	
  		if (($listing_split->number_of_rows) == (MAX_DISPLAY_SEARCH_RESULTS_PER_ROW - 2)) {
			$col_width = '100%';	
		}elseif (($listing_split->number_of_rows) == (MAX_DISPLAY_SEARCH_RESULTS_PER_ROW - 1)) {
			$col_width = '50%';	
		}elseif (($listing_split->number_of_rows) == (MAX_DISPLAY_SEARCH_RESULTS_PER_ROW - 0)) {
			$col_width = 'auto';	
		}else{
			$col_width = (int)(100 / ($col_items + 1)).'%';
		}
	$colspan = ((MAX_DISPLAY_SEARCH_RESULTS_PER_ROW * 2) - 1);

    $listing_query = tep_db_query($listing_split->sql_query);

	  $prod_list_contents .= '<div class="prods_content prods_table">';
    while ($listing = tep_db_fetch_array($listing_query)) {
	if (($col === 0) && ($row != 0)) {
	  $prod_list_contents .= '<ul><li class="prods_hseparator">'.tep_draw_separator('spacer.gif', '1', '1').'</li></ul>';
	} 
	if ($col === 0) {
      $prod_list_contents .= '<ul class="row row3" id="row-'.$row.'">';
   }else {
	  $prod_list_contents .= '<li class="prods_vseparator equal-height3">'.tep_draw_separator('spacer.gif', '1', '1').''; 
   }

      for ($col_sort=0, $n=sizeof($column_list); $col_sort<$n; $col_sort++) {
        switch ($column_list[$col_sort]) {
          case 'PRODUCT_LIST_MODEL':
            $p_model = '<tr>
							<td><b><font>'.TABLE_HEADING_MODEL.'&nbsp;:</font></b></td>
							<td align="right"><font>' . $listing['products_model'] . '</font></td>
						</tr>';
            break;
          case 'PRODUCT_LIST_NAME':
            if (isset($HTTP_GET_VARS['manufacturers_id']) && tep_not_null($HTTP_GET_VARS['manufacturers_id'])) {
            $p_name = $lc_text = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'manufacturers_id=' . $HTTP_GET_VARS['manufacturers_id'] . '&products_id=' . $listing['products_id']) . '">' . $listing['products_name'] . '</a></span>';
            } else {
            $p_name = $lc_text = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, ($cPath ? 'cPath=' . $cPath . '&' : '') . 'products_id=' . $listing['products_id']) . '">' . $listing['products_name'] . '</a></span>';
            }
            break;
          case 'PRODUCT_LIST_MANUFACTURER':
            $p_manufact = '<tr>
							<td><b><font>'.TABLE_HEADING_MANUFACTURER.'&nbsp;:</font></b></td>
							<td align="right"><font><a href="' . tep_href_link(FILENAME_DEFAULT, 'manufacturers_id=' . $listing['manufacturers_id']) . '">' . $listing['manufacturers_name'] . '</a></font></td>
						  </tr>';
            break;
          case 'PRODUCT_LIST_PRICE':
            if (tep_not_null($listing['specials_new_products_price'])) {
           $p_price = $lc_text = '<span class="productSpecialPrice un">' . $currencies->display_price($listing['specials_new_products_price'], tep_get_tax_rate($listing['products_tax_class_id'])) . '</span>
		   <del>' .  $currencies->display_price($listing['products_price'], tep_get_tax_rate($listing['products_tax_class_id'])) . '</del>';
            } else {
           $p_price = $lc_text = '<span class="productSpecialPrice">' . $currencies->display_price($listing['products_price'], tep_get_tax_rate($listing['products_tax_class_id'])) . '</span>';
            }
            break;
          case 'PRODUCT_LIST_QUANTITY':
            $p_qty = '	<tr>
							<td><b><font>'.TABLE_HEADING_QUANTITY.'&nbsp;:</font></b></td>
							<td align="right"><font>' . $listing['products_quantity'] . '</font></td>
						</tr>';
            break;
          case 'PRODUCT_LIST_WEIGHT':
            $p_weight = '<tr>
							<td><b><font>'.TABLE_HEADING_WEIGHT.'&nbsp;:</font></b></td>
							<td align="right"><font>' . $listing['products_weight'] . '</font></td>
						</tr>';
            break;
          case 'PRODUCT_LIST_IMAGE':
            if (isset($HTTP_GET_VARS['manufacturers_id'])  && tep_not_null($HTTP_GET_VARS['manufacturers_id'])) {
              $p_pic = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'manufacturers_id=' . $HTTP_GET_VARS['manufacturers_id'] . '&products_id=' . $listing['products_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $listing['products_image'], $listing['products_name'], (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';
            } else {
              $p_pic = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, ($cPath ? 'cPath=' . $cPath . '&' : '') . 'products_id=' . $listing['products_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $listing['products_image'], $listing['products_name'], (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';
            }
            break;
          case 'PRODUCT_LIST_BUY_NOW':
             $p_button =  $lc_text = '<a href="' . tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('action')) . 'action=buy_now&products_id=' . $listing['products_id']) . '">' . tep_image_button('button_buy_now1.gif', IMAGE_BUTTON_BUY_NOW) . '</a>';
            break;
        }
		
		$product_query = tep_db_query("select products_description, products_id from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id = '" . (int)$listing['products_id'] . "' and language_id = '" . (int)$languages_id . "'");
      	$product = tep_db_fetch_array($product_query);
       	$p_desc = ''.mb_substr(strip_tags($product['products_description']), 0, MAX_DESCR_LISTING, 'UTF-8').' ...';
		
	  if (PRODUCT_LIST_MODEL != 0 || PRODUCT_LIST_MANUFACTURER != 0 || PRODUCT_LIST_QUANTITY != 0 || PRODUCT_LIST_WEIGHT != 0) {
		$p_listing = '<table cellpadding="0" cellspacing="0" border="0" class="listing">'.$p_model.''.$p_manufact.'' . ''.$p_qty.'' . ''.$p_weight.'</table>';
		}
		
        $p_id = $listing['products_id'];
		
/*		$list_box_contents[$cur_row][] = array('align' => $lc_align,
                                               'params' => '',
                                               'text'  => $lc_text); */



	$p_details_text = '' .tep_draw_button2_top() . '<a href="' . tep_href_link('product_info.php?products_id='.$p_id) . '" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-triangle-1-e"></span><span class="ui-button-text">'.  IMAGE_BUTTON_DETAILS .'</span></a>' . tep_draw_button2_bottom().'';

	$p_buy_now_text = '' .tep_draw_button_top() . '<a href="'.tep_href_link("products_new.php","action=buy_now&products_id=".$p_id).'"  class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-priority-secondary" role="button"><span class="ui-button-icon-primary ui-icon ui-icon-cart"></span><span class="ui-button-text">'.  IMAGE_BUTTON_IN_CART .'</span></a>' . tep_draw_button_bottom().'';
		
		
		
      }
    $prod_list_contents .= '<li style="width:' . PRODS_BLOCK_WIDTH . 'px;" class="wrapper_prods equal-height3 hover">'. "\n".
				  '<div class="border_prods">'.
				  '		<div class="pic_padd wrapper_pic_div" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$p_pic.''.tep_draw_prod_pic_top().''.tep_draw_prod_pic_bottom().'</a></div>'. "\n".
				  '		<div class="prods_padd">'.				  				  	 
				 
				  '			<div class="name name_padd  equal-height">'.$p_name.'</div>'. "\n".
				  '			<div class="desc desc_padd">'.$p_desc.'</div>'. "\n".
				  '			<div class="listing_padd">'.$p_listing.'</div>'. "\n".
				  '			<h2 class="price price_padd"><b>'.PRICE. '</b>'.$p_price.'</h2>'. "\n".		
				  '			<div class="button__padd">'.$p_details_text.' '.$p_buy_now_text.'</div>'. "\n".
				  '		</div>'. "\n".				  
				  '</div>'. "\n";				  

    $col ++;
    if ($col > $col_items) {
      	$prod_list_contents .= '</ul>';
	  	$row ++;
      	$col = 0;
    }else{
		$prod_list_contents .= '</li>';	
	}
  }

	  $prod_list_contents .= '</div>';
?>

<div class="contentContainer page_un">
  <div class="contentPadd">
<?php
    echo $prod_list_contents;
?>
  </div>
</div>
<?php	
  } else {
?>
<div class="contentContainer">
  <div class="contentPadd txtPage">

    <p><?php echo TEXT_NO_PRODUCTS; ?></p>
</div></div>
<?php
  }
?>

<?php
  if ( ($listing_split->number_of_rows > 0) && ((PREV_NEXT_BAR_LOCATION == '2') || (PREV_NEXT_BAR_LOCATION == '3')) ) {
?>

<?php echo tep_draw_result2_top(); ?> 

        <div class="cl_both result_bottom_padd ofh">
        	<div class="fl_left result_left"><?php echo $listing_split->display_count(TEXT_DISPLAY_NUMBER_OF_PRODUCTS); ?></div>
            <div class="fl_right result_right"><?php echo TEXT_RESULT_PAGE . ' ' . $listing_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info', 'x', 'y'))); ?></div>
        </div>

<?php echo tep_draw_result2_bottom(); ?>

<?php
  }
?>
<script type="text/javascript">
        $(document).ready(function(){ 			
			 var row_list = $('.row');
			 row_list.each(function(){
				 new equalHeights($('#' + $(this).attr("id")));
			  });
			 var row_list3 = $('.row3');
			 row_list3.each(function(){
				 new equalHeights3($('#' + $(this).attr("id")));
			  });			 			 			  			  			  			  			   			  	
        })				     			  		 			 			  			  			  			  			   
</script>