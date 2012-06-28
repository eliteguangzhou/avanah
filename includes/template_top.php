<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  $oscTemplate->buildBlocks();

  if (!$oscTemplate->hasBlocks('boxes_column_left')) {
    $oscTemplate->setGridContentWidth($oscTemplate->getGridContentWidth() + $oscTemplate->getGridColumnWidth());
  }

  if (!$oscTemplate->hasBlocks('boxes_column_right')) {
    $oscTemplate->setGridContentWidth($oscTemplate->getGridContentWidth() + $oscTemplate->getGridColumnWidth());
  }
?>
<!DOCTYPE html>
<html <?php echo HTML_PARAMS; ?>><head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>" />
<title><?php echo tep_output_string_protected($oscTemplate->getTitle()); ?></title>
<base href="<?php echo (($request_type == 'SSL') ? HTTPS_SERVER : HTTP_SERVER) . DIR_WS_CATALOG; ?>" />
<link rel="stylesheet" type="text/css" href="ext/jquery/ui/redmond/jquery-ui-1.8.6-osc.css" />
<script type="text/javascript" src="ext/jquery/jquery-1.4.3.min.js"></script>
<script type="text/javascript" src="ext/jquery/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="ext/jquery/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="ext/jquery/ui/jquery-ui-1.8.6.min.js"></script>
<script type="text/javascript" src="includes/product-banner.js"></script>
<script type="text/javascript" src="includes/main.js"></script>

<?php
  if (tep_not_null(JQUERY_DATEPICKER_I18N_CODE)) {
?>
<script type="text/javascript" src="ext/jquery/ui/i18n/jquery.ui.datepicker-<?php echo JQUERY_DATEPICKER_I18N_CODE; ?>.js"></script>
<script type="text/javascript">
$.datepicker.setDefaults($.datepicker.regional['<?php echo JQUERY_DATEPICKER_I18N_CODE; ?>']);
</script>
<?php
  }
?>
<script type="text/javascript" src="ext/jquery/bxGallery/jquery.bxGallery.1.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="ext/jquery/fancybox/jquery.fancybox-1.3.4.css" />
<script type="text/javascript" src="ext/jquery/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="ext/jquery/jquery.equalheights.js"></script>
<script type="text/javascript" src="ext/js/jcarousellite.js"></script>
<script type="text/javascript" src="ext/js/js.js"></script>
	<script type="text/javascript" src="ext/jquery/jqtransformplugin/jquery.jqtransform.js" ></script>
	<script language="javascript">
		$(function(){
			$('.custom_select form').jqTransform({imgPath:'jqtransformplugin/img/'});
		});
	</script>
<link rel="stylesheet" type="text/css" href="ext/960gs/<?php echo ((stripos(HTML_PARAMS, 'dir="rtl"') !== false) ? 'rtl_' : ''); ?>972_12_col.css" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="css/constants.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/style_boxes.css">
<link rel="stylesheet" type="text/css" href="css/css3.css">
<link rel="stylesheet" type="text/css" href="css/buttons.css">
<link rel="stylesheet" type="text/css" href="css/jcarousellite.css">
<link rel="stylesheet" type="text/css" href="css/jcarousellite.css.php">
<link href='http://fonts.googleapis.com/css?family=Nixie+One' rel='stylesheet' type='text/css'>
<?php require(DIR_WS_INCLUDES . 'pie_css.php');?>
<?php echo $oscTemplate->getBlocks('header_tags'); ?>
</head>
<body>
<p id="back-top" style="display: block;"><a href="#top"><span></span><?php echo BACK_TO_TOP;?></a></p>
<!-- bodyWrapper 
<div id="bodyWrapper" class="bg_body">
  	<div class="wrapper-padd"> -->
  	
    	<div class="row_1 ofh">        
				<?php require(DIR_WS_INCLUDES . 'header.php'); ?>

				<?php $customer_name = tep_session_is_registered('customer_id') ? ucfirst($_SESSION['customer_last_name']) .' '.ucfirst($_SESSION['customer_first_name']) : ''; ?>
                 <span id="login_header"><?php echo $customer_name ? HEADER_HELLO . ' ' . $customer_name . '<br />'.
'<a class="banner_login" href="'.tep_href_link('logoff.php').'">'.HEADER_LOGOUT.'</a>' : '<a class="banner_login" href="'.tep_href_link('login.php').'">'.HEADER_LOGIN.'</a>';
?></td>
</span>
                <a class="logo" href="<?php echo tep_href_link(FILENAME_DEFAULT);?>"><?php echo tep_image(DIR_WS_IMAGES.'store_logo.png', STORE_NAME, '', '', '')?></a>
                
                
<?php
            if (($oscTemplate->hasBlocks('boxes_menu')))	{
?>	
			<div class="boxes_menu">
                <div class="container_<?php echo $oscTemplate->getGridContainerWidth(); ?>">
                    <div class="grid_<?php echo $oscTemplate->getGridContainerWidth(); ?>">
        			<?php echo $oscTemplate->getBlocks('boxes_menu'); ?>
                    </div>                    
                </div>            
			</div>            
<?php
			}
?>    
<?php 
if (  $current_page == FILENAME_DEFAULT){
?>
<div id="main_image_background">
<img src="includes/languages/french/images/banner1.jpg" class="img_front" id="image0">
<img src="includes/languages/french/images/banner2.jpg" class="img_front" id="image1">
<img src="includes/languages/french/images/banner3.jpg" class="img_front" id="image2">
</div>

<?php 
}
?>

<?php 
            if (($oscTemplate->hasBlocks('box_under_header')))	{
?>
				<?php echo $oscTemplate->getBlocks('box_under_header'); ?>
<?php
			}
?>

        </div>
        
		<?php require(DIR_WS_INCLUDES . 'extra_row.php');?> 
<?php
			if ($current_page != FILENAME_DEFAULT)	{
?>
                                      
    	<div class="row_3 ofh"> 
            <div class="container_<?php echo $oscTemplate->getGridContainerWidth(); ?>">
            	<div id="bodyContent" class="grid_<?php echo $oscTemplate->getGridContentWidth(); ?> <?php echo ($oscTemplate->hasBlocks('boxes_column_left') ? 'push_' . $oscTemplate->getGridColumnWidth() : ''); ?> ">
<?php
			}
?>
