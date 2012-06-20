<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require(DIR_WS_INCLUDES . 'counter.php');
?>


			<div class="footer">
<?php 
            if (($oscTemplate->hasBlocks('boxes_footer')))	{
?>        
        	<?php // echo $oscTemplate->getBlocks('boxes_footer'); ?>
           <p><?php echo FOOTER_TEXT_BODY; ?><b>&nbsp; <a href="<?php echo tep_href_link('privacy.php')?>"><?php echo ITEM_INFORMATION_PRIVACY?></a> &nbsp;&nbsp;|&nbsp;&nbsp;<a href="<?php echo tep_href_link('conditions.php')?>"><?php echo ITEM_INFORMATION_CONDITIONS?></a></b>
</p>
        	</div>   
<?php 
}
?>
<?php
  if ($banner = tep_banner_exists('dynamic', '468x50')) {
?>
        	<div class="grid_<?php echo $oscTemplate->getGridContainerWidth(); ?>" style="text-align: center; padding-bottom: 20px;">
          		<?php echo tep_display_banner('static', $banner); ?>
        	</div>
<?php
  }
?>
<script type="text/javascript">
$('.productListTable tr:nth-child(even)').addClass('alt');
</script>
