<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  if (isset($HTTP_GET_VARS['products_id'])) {
    $orders_query = tep_db_query("select p.products_id, p.products_image from " . TABLE_ORDERS_PRODUCTS . " opa, " . TABLE_ORDERS_PRODUCTS . " opb, " . TABLE_ORDERS . " o, " . TABLE_PRODUCTS . " p where opa.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and opa.orders_id = opb.orders_id and opb.products_id != '" . (int)$HTTP_GET_VARS['products_id'] . "' and opb.products_id = p.products_id and opb.orders_id = o.orders_id and p.products_status = '1' group by p.products_id order by o.date_purchased desc limit " . MAX_DISPLAY_ALSO_PURCHASED);
    $num_products_ordered = tep_db_num_rows($orders_query);
    if ($num_products_ordered >= MIN_DISPLAY_ALSO_PURCHASED) {

  $col = 0;
  $row = 0;
  
  $col_items = (MAX_DISPLAY_ALSO_PURCHASED_PRODUCTS_PER_ROW - 1);
  $col_width = (int)(100 / ($col_items)).'%';
	  
	  
	  $also_pur_prods_content = '<div class="prods_content">';

      while ($orders = tep_db_fetch_array($orders_query)) {
		if (($col === 0) && ($row != 0)) {
		  $also_pur_prods_content .= '<ul><li class="prods_hseparator">'.tep_draw_separator('spacer.gif', '1', '1').'</li></ul>';
		} 
		if ($col === 0) {
		  $also_pur_prods_content .= '<ul class="row row3" id="row-'.$row.'">';
	   }else {
		   $also_pur_prods_content .= '<li class="prods_vseparator equal-height3">'.tep_draw_separator('spacer.gif', '1', '1').''; // 
	   }
// *************************************   
// *************************************
	  $orders['products_name'] = tep_get_products_name($orders['products_id']);
	  $p_id = $new_products['products_id'];	
		  
	  $p_pic = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $orders['products_id']) . '" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $orders['products_image'], $orders['products_name'], (SMALL_IMAGE_WIDTH), (SMALL_IMAGE_HEIGHT), ' style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';
	  
	  $p_name = '<span><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $orders['products_id']) . '">' . $orders['products_name'] . '</a></span>';
	  
	  
// *************************************   
// *************************************
		 $also_pur_prods_content .= '<li style="width:' . PRODS_BLOCK_WIDTH . 'px;" class="wrapper_prods un equal-height3 hover">'.
				  '<div class="border_prods">'.
				  '		<div class="pic_padd wrapper_pic_div" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$p_pic.''.tep_draw_prod_pic_top().''.tep_draw_prod_pic_bottom().'</a></div>'. "\n".

				  '		<div class="prods_padd">'.				  
				  '			<div class="name name_padd  equal-height">'.$p_name.'</div>'. "\n".
				  '		</div>'. "\n".				  				  	
				  '</div>'. "\n";				  			  
	'';

    $col ++;
    if ($col > $col_items) {
      	$also_pur_prods_content .= '</ul>';
	  	$row ++;
      	$col = 0;
    }else{
		$also_pur_prods_content .= '</li>';	
	}
  }

  $also_pur_prods_content .= '</div>';
		 
?>

<?php echo tep_draw_title_top();?>
<h1><?php echo TEXT_ALSO_PURCHASED_PRODUCTS; ?></h1>
<?php echo tep_draw_title_bottom();?>

<div class="contentContainer">
	<div class="contentPadd">
			<?php echo $also_pur_prods_content; ?>
	</div>
</div>            
<?php
    }
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