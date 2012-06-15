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
            if (($oscTemplate->hasBlocks('box_bottom_content_set')))	{
?>
				<?php echo $oscTemplate->getBlocks('box_bottom_content_set'); ?>
<?php
			}
?>
<?php
			if ($current_page != FILENAME_DEFAULT)	{
?>
           

			</div> <!-- bodyContent //-->
<?php
  if ($oscTemplate->hasBlocks('boxes_column_left')) {
?>
                <div id="columnLeft" class="grid_<?php echo $oscTemplate->getGridColumnWidth(); ?> pull_<?php echo $oscTemplate->getGridContentWidth(); ?>">
                  <div><?php echo $oscTemplate->getBlocks('boxes_column_left'); ?></div>
                </div>
<?php 
}
?>

<?php
  if ($oscTemplate->hasBlocks('boxes_column_right')) {
?>

                <div id="columnRight" class="grid_<?php echo $oscTemplate->getGridColumnWidth(); ?>">
                  <div><?php echo $oscTemplate->getBlocks('boxes_column_right'); ?></div>
                </div>

<?php
  }
?>

    		</div>
    	</div>
<?php 
        	}
            if (($oscTemplate->hasBlocks('box_under_content')))	{
?>
				<?php echo $oscTemplate->getBlocks('box_under_content'); ?>
<?php
			}
			
            if (($oscTemplate->hasBlocks('box_above_footer')))	{
?>
        
    	<div class="row_4 ofh">     
        	<div class="container_<?php echo $oscTemplate->getGridContainerWidth(); ?>">
            	<div class="grid_<?php echo $oscTemplate->getGridContainerWidth(); ?>">
                	<div class="row_41">
                    	<?php echo $oscTemplate->getBlocks('box_above_footer'); ?>
                    </div>
                    <div class="row_42">     
                        <?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
                    </div> 
                </div>      
            </div>
       </div>
<?php
			}
?>                         
    
    
<!-- </div>
</div>		 bodyWrapper //-->
<?php echo $oscTemplate->getBlocks('footer_scripts'); ?>
</body>
<!--[if IE]>
  <link href="css/ie_style.css" rel="stylesheet" type="text/css" />
<![endif]-->
  <script type="text/javascript" src="ext/js/imagepreloader.js"></script>
  <script type="text/javascript">
		preloadImages([
			'images/user_menu.gif',
			'images/bg_list.png',
			'images/wrapper_pic.png',
			'images/wrapper_pic-act.png',
			'images/wrapper_pic_border.gif',
			'images/wrapper_pic_border-act.gif']);
	</script>
</html>
