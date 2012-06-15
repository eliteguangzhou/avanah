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
if (($oscTemplate->hasBlocks('box_welcome')) || ($current_page != FILENAME_DEFAULT))	{
?>

    	<div class="row_2 ofh"> 
            <div class="container_<?php echo $oscTemplate->getGridContainerWidth(); ?>"> 
                  <div class="grid_<?php echo $oscTemplate->getGridContainerWidth(); ?>">

<?php
            if (($oscTemplate->hasBlocks('box_welcome')))	{
?>	
			<?php echo $oscTemplate->getBlocks('box_welcome'); ?>
<?php
			}
?>
<?php
			if ($current_page != FILENAME_DEFAULT)	{
?>

            <div class="breadcrumb"><?php echo '&nbsp;&nbsp;' . $breadcrumb->trail(' &raquo; '); ?></div>
<?php
			}
?>                  
 				</div>
            </div>
		</div>        
<?php
}
?>                  
