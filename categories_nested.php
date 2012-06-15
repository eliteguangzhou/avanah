<?php
	$category_query = tep_db_query("select cd.categories_name, c.categories_image from " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd where c.categories_id = '" . (int)$current_category_id . "' and cd.categories_id = '" . (int)$current_category_id . "' and cd.language_id = '" . (int)$languages_id . "'");
    $category = tep_db_fetch_array($category_query);
if	(TITLE_PIC == 'true'){	
	if	($category['categories_image'] !=''){  $pis = ''. tep_image(DIR_WS_IMAGES . $category['categories_image'], $category['categories_name'], HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT).''; }
}
?>

<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<div class="title_pic"><?php echo $pis ?></div><h1><?php echo $category['categories_name']; ?></h1>
<?php echo tep_draw_title_bottom();?>

<div class="contentContainer">
    
<?php
    if (isset($cPath) && strpos('_', $cPath)) {
// check to see if there are deeper categories within the current category
      $category_links = array_reverse($cPath_array);
      for($i=0, $n=sizeof($category_links); $i<$n; $i++) {
        $categories_query = tep_db_query("select count(*) as total from " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd where c.parent_id = '" . (int)$category_links[$i] . "' and c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "'");
        $categories = tep_db_fetch_array($categories_query);
        if ($categories['total'] < 1) {
			$categories_row = $categories['total'];
          // do nothing, go through the loop
        } else {
          $categories_query = tep_db_query("select c.categories_id, cd.categories_name, c.categories_image, c.parent_id from " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd where c.parent_id = '" . (int)$category_links[$i] . "' and c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "' order by sort_order, cd.categories_name");
          break; // we've found the deepest category the customer is in
        }
      }
    } else {
      $categories_query = tep_db_query("select c.categories_id, cd.categories_name, c.categories_image, c.parent_id from " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd where c.parent_id = '" . (int)$current_category_id . "' and c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "' order by sort_order, cd.categories_name");
    }

    $number_of_categories = tep_db_num_rows($categories_query);

    $rows = 0;
	
  	$col = 0;
  	$row = 0;
 //   $col_items = (MAX_DISPLAY_CATEGORIES_PER_ROW - 1);
  
    $prods_content = '
	<div class="prods_content">'. "\n";	
			  $prods_content .= '	<ul class="sub_categories row2">'. "\n";	
    while ($categories = tep_db_fetch_array($categories_query)) {
      $rows++;
      $cPath_new = tep_get_path($categories['categories_id']);
	  $p_name = '<span><a href="' . tep_href_link(FILENAME_DEFAULT, $cPath_new) . '">' . $categories['categories_name'] . '</a></span>';
	  $p_pic = '<a class="prods_pic_bg" href="' . tep_href_link(FILENAME_DEFAULT, $cPath_new) . '" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">' . tep_image(DIR_WS_IMAGES . $categories['categories_image'], $categories['categories_name'], (SUBCATEGORY_IMAGE_WIDTH), (SUBCATEGORY_IMAGE_HEIGHT), ' style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H2).'px;margin:'.PIC_MARG_T.'px '.PIC_MARG_R.'px '.PIC_MARG_B.'px '.PIC_MARG_L.'px;"') . '';	  

	   $prods_content .= 
	   '		<li class="wrapper_prods hover" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;">'. "\n".
	   '				<div class="pic_padd wrapper_pic_div" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'.$p_pic.''.tep_draw_prod_pic3_top().''.tep_draw_prod_pic3_bottom().'</a></div>'. "\n".
				  '		<div class="box-padd ofh">'. "\n".					
	   '					<div class="name name_padd equal-height2">'.$p_name.'</div>'. "\n".
				  '		</div>'. "\n".		   	   
	   '		</li>'. "\n";

    }
	   $prods_content .= '	</ul>'. "\n";	
	   
	   $prods_content .= '</div>';
// needed for the new products module shown below
    $new_products_category_id = $current_category_id;
?>
      <div class="contentPadd sub">
        <?php echo $prods_content; ?>
      </div>
</div>
<div class="row_line"></div>      
<?php echo tep_draw_content_bottom();?>
<?php echo tep_draw_content_top();?>     
  
<?php include(DIR_WS_MODULES . 'new_products.php'); ?>

<?php echo tep_draw_content_bottom();?>

