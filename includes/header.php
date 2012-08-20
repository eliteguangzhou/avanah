<?php
/*
 $Id$

 osCommerce, Open Source E-Commerce Solutions
 http://www.oscommerce.com

 Copyright (c) 2010 osCommerce

 Released under the GNU General Public License
 */

if ($messageStack->size('header') > 0) {
	echo '<div class="grid_24">' . $messageStack->output('header') . '</div>';
}

?>

<div id="header"
	class="container_<?php echo $oscTemplate->getGridContainerWidth(); ?>">
	<!---->
	<div class="grid_<?php echo $oscTemplate->getGridContainerWidth(); ?>">



	<?php
	if (($oscTemplate->hasBlocks('box_header_cart')))	{
		?>
		<!-- 	<div class="box_header_cart">		
        			<?php echo $oscTemplate->getBlocks('box_header_cart'); ?>
			</div>             -->
        			<?php
	}
	if (($oscTemplate->hasBlocks('box_header_user_menu')))	{
		?>
		<div class="box_header_user_menu">
		<?php echo $oscTemplate->getBlocks('box_header_user_menu');
	}
	if (($oscTemplate->hasBlocks('boxes_header_search')))	{
		echo $oscTemplate->getBlocks('boxes_header_search');
	}
	if (($oscTemplate->hasBlocks('boxes_header')))	{
		//echo $oscTemplate->getBlocks('boxes_header');

	}
	?>

		</div>
	</div>


	<?php
	if (isset($HTTP_GET_VARS['error_message']) && tep_not_null($HTTP_GET_VARS['error_message'])) {
		?>
	<table border="0" width="100%" cellspacing="0" cellpadding="2">
		<tr class="headerError">
			<td class="headerError"><?php echo htmlspecialchars(stripslashes(urldecode($HTTP_GET_VARS['error_message']))); ?>
			</td>
		</tr>
	</table>
	<?php
	}

	if (isset($HTTP_GET_VARS['info_message']) && tep_not_null($HTTP_GET_VARS['info_message'])) {
		?>
	<table border="0" width="100%" cellspacing="0" cellpadding="2">
		<tr class="headerInfo">
			<td class="headerInfo"><?php echo htmlspecialchars(stripslashes(urldecode($HTTP_GET_VARS['info_message']))); ?>
			</td>
		</tr>
	</table>
	<?php
	}
	?>