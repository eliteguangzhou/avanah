<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License
*/

  class tableBox {
    var $table_border = '0';
    var $table_width = '100%';
    var $table_cellspacing = '0';
    var $table_cellpadding = '2';
    var $table_parameters = ' class="class_table"';
    var $table_row_parameters = '';
    var $table_data_parameters = '';

// class constructor
    function tableBox($contents, $direct_output = false) {
      $tableBox_string = '<table border="' . tep_output_string($this->table_border) . '" width="' . tep_output_string($this->table_width) . '" cellspacing="' . tep_output_string($this->table_cellspacing) . '" cellpadding="' . tep_output_string($this->table_cellpadding) . '"';
      if (tep_not_null($this->table_parameters)) $tableBox_string .= ' ' . $this->table_parameters;
      $tableBox_string .= '>' . "\n";

      for ($i=0, $n=sizeof($contents); $i<$n; $i++) {
        if (isset($contents[$i]['form']) && tep_not_null($contents[$i]['form'])) $tableBox_string .= $contents[$i]['form'] . "\n";
        $tableBox_string .= '  <tr';
        if (tep_not_null($this->table_row_parameters)) $tableBox_string .= ' ' . $this->table_row_parameters;
        if (isset($contents[$i]['params']) && tep_not_null($contents[$i]['params'])) $tableBox_string .= ' ' . $contents[$i]['params'];
        $tableBox_string .= '>' . "\n";

        if (isset($contents[$i][0]) && is_array($contents[$i][0])) {
          for ($x=0, $n2=sizeof($contents[$i]); $x<$n2; $x++) {
            if (isset($contents[$i][$x]['text']) && tep_not_null($contents[$i][$x]['text'])) {
              $tableBox_string .= '    <td';
              if (isset($contents[$i][$x]['align']) && tep_not_null($contents[$i][$x]['align'])) $tableBox_string .= ' align="' . tep_output_string($contents[$i][$x]['align']) . '"';
              if (isset($contents[$i][$x]['params']) && tep_not_null($contents[$i][$x]['params'])) {
                $tableBox_string .= ' ' . $contents[$i][$x]['params'];
              } elseif (tep_not_null($this->table_data_parameters)) {
                $tableBox_string .= ' ' . $this->table_data_parameters;
              }
              $tableBox_string .= '>';
              if (isset($contents[$i][$x]['form']) && tep_not_null($contents[$i][$x]['form'])) $tableBox_string .= $contents[$i][$x]['form'];
              $tableBox_string .= $contents[$i][$x]['text'];
              if (isset($contents[$i][$x]['form']) && tep_not_null($contents[$i][$x]['form'])) $tableBox_string .= '</form>';
              $tableBox_string .= '</td>' . "\n";
            }
          }
        } else {
          $tableBox_string .= '    <td';
          if (isset($contents[$i]['align']) && tep_not_null($contents[$i]['align'])) $tableBox_string .= ' align="' . tep_output_string($contents[$i]['align']) . '"';
          if (isset($contents[$i]['params']) && tep_not_null($contents[$i]['params'])) {
            $tableBox_string .= ' ' . $contents[$i]['params'];
          } elseif (tep_not_null($this->table_data_parameters)) {
            $tableBox_string .= ' ' . $this->table_data_parameters;
          }
          $tableBox_string .= '>' . $contents[$i]['text'] . '</td>' . "\n";
        }

        $tableBox_string .= '  </tr>' . "\n";
        if (isset($contents[$i]['form']) && tep_not_null($contents[$i]['form'])) $tableBox_string .= '</form>' . "\n";
      }

      $tableBox_string .= '</table>' . "\n";

      if ($direct_output == true) echo $tableBox_string;

      return $tableBox_string;
    }
  }

  class infoBox extends tableBox {
    function infoBox($contents) {
      $info_box_contents = array();
      $info_box_contents[] = array('text' => $this->infoBoxContents($contents));
      $this->table_cellpadding = '1';
      $this->table_parameters = 'class="infoBox"';
      $this->tableBox($info_box_contents, true);
    }

    function infoBoxContents($contents) {
      $this->table_cellpadding = '3';
      $this->table_parameters = 'class="infoBoxContents"';
      $info_box_contents = array();
      $info_box_contents[] = array(array('text' => tep_draw_separator('pixel_trans.gif', '100%', '1')));
      for ($i=0, $n=sizeof($contents); $i<$n; $i++) {
        $info_box_contents[] = array(array('align' => (isset($contents[$i]['align']) ? $contents[$i]['align'] : ''),
                                           'form' => (isset($contents[$i]['form']) ? $contents[$i]['form'] : ''),
                                           'params' => 'class="boxText"',
                                           'text' => (isset($contents[$i]['text']) ? $contents[$i]['text'] : '')));
      }
      $info_box_contents[] = array(array('text' => tep_draw_separator('pixel_trans.gif', '100%', '1')));
      return $this->tableBox($info_box_contents);
    }
  }

  class infoBoxHeading extends tableBox {
    function infoBoxHeading($contents, $left_corner = true, $right_corner = true, $right_arrow = false) {
      $this->table_cellpadding = '0';

      if ($left_corner == true) {
        $left_corner = tep_image(DIR_WS_IMAGES . 'infobox/corner_left.gif');
      } else {
        $left_corner = tep_image(DIR_WS_IMAGES . 'infobox/corner_right_left.gif');
      }
      if ($right_arrow == true) {
        $right_arrow = '<a href="' . $right_arrow . '">' . tep_image(DIR_WS_IMAGES . 'infobox/arrow_right.gif', ICON_ARROW_RIGHT) . '</a>';
      } else {
        $right_arrow = '';
      }
      if ($right_corner == true) {
        $right_corner = $right_arrow . tep_image(DIR_WS_IMAGES . 'infobox/corner_right.gif');
      } else {
        $right_corner = $right_arrow . tep_draw_separator('pixel_trans.gif', '11', '14');
      }

      $info_box_contents = array();
      $info_box_contents[] = array(array('params' => 'height="14" class="infoBoxHeading"',
                                         'text' => $left_corner),
                                   array('params' => 'width="100%" height="14" class="infoBoxHeading"',
                                         'text' => $contents[0]['text']),
                                   array('params' => 'height="14" class="infoBoxHeading" nowrap',
                                         'text' => $right_corner));

      $this->tableBox($info_box_contents, true);
    }
  }

  class contentBox extends tableBox {
    function contentBox($contents) {
      $info_box_contents = array();
      $info_box_contents[] = array('text' => $this->contentBoxContents($contents));
      $this->table_cellpadding = '1';
      $this->table_parameters = 'class="infoBox"';
      $this->tableBox($info_box_contents, true);
    }

    function contentBoxContents($contents) {
      $this->table_cellpadding = '4';
      $this->table_parameters = 'class="infoBoxContents"';
      return $this->tableBox($contents);
    }
  }

  class contentBoxHeading extends tableBox {
    function contentBoxHeading($contents) {
      $this->table_width = '100%';
      $this->table_cellpadding = '0';

      $info_box_contents = array();
      $info_box_contents[] = array(array('params' => 'height="14" class="infoBoxHeading"',
                                         'text' => tep_image(DIR_WS_IMAGES . 'infobox/corner_left.gif')),
                                   array('params' => 'height="14" class="infoBoxHeading" width="100%"',
                                         'text' => $contents[0]['text']),
                                   array('params' => 'height="14" class="infoBoxHeading"',
                                         'text' => tep_image(DIR_WS_IMAGES . 'infobox/corner_right_left.gif')));

      $this->tableBox($info_box_contents, true);
    }
  }

  class errorBox extends tableBox {
    function errorBox($contents) {
      $this->table_data_parameters = 'class="errorBox"';
      $this->tableBox($contents, true);
    }
  }

  class productListingBox extends tableBox {
    function productListingBox($contents) {
      $this->table_parameters = 'class="productListing"';
      $this->tableBox($contents, true);
    }
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_title_top()
  {
  return $table = 	'<div class="title-t"><div class="title-b"><div class="title-icon"></div>';
					
  }
// **********************************************************************************************
function tep_draw_title_bottom()
  {
  return $table =  	'</div></div>';
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_result1_top()
  {
   return $table = '<div class="result result1_top"><div class="result1_bottom">'. "\n";
  }
// **********************************************************************************************
function tep_draw_result1_bottom()
	{
   return $table = '</div></div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_result2_top()
  {
   return $table = '<div class="result result2_top"><div class="result2_bottom">'. "\n";
  }
// **********************************************************************************************
function tep_draw_result2_bottom()
	{
   return $table = '</div></div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_button_top()
  {
  return $table = 	'<div class="button_content button_content2"><div class="button bg_button"><div class="button-t">';
					
  }
// **********************************************************************************************
function tep_draw_button_bottom()
  {
  return $table =  	'</div></div></div>';
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_button2_top()
  {
  return $table = 	'<div class="button_content button_content22"><div class="button bg_button"><div class="button-t">';
					
  }
// **********************************************************************************************
function tep_draw_button2_bottom()
  {
  return $table =  	'</div></div></div>';
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_menu_top()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
function tep_draw_menu_bottom()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_fmenu_top()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
function tep_draw_fmenu_bottom()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_content_top()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
function tep_draw_content_bottom()
  {
  return $table = ''. "\n";
  }
// ********************************************************************************************** 
// BOXES
// **********************************************************************************************
  function tep_draw_box_wrapper_top()
  {
  return $table = 	
  '<div class="box_wrapper">';
  }
// **********************************************************************************************
function tep_draw_box_wrapper_bottom()
  {
  return $table = '</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_box_title_top()
  {
  return $table = 	
  '<div class="title-icon"></div>';
  }
// **********************************************************************************************
function tep_draw_box_title_bottom()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_box_content_top()
  {
  return $table = 	
  '';
  }
// **********************************************************************************************
function tep_draw_box_content_bottom()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_box_list_top()
  {
  return $table = 	
  '<div class="list_bg"></div>';
  }
// **********************************************************************************************
function tep_draw_box_list_bottom()
  {
  return $table = ''. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function  tep_draw_prod_pic_top()
  {
  return $table = '
			<div class="wrapper_pic_t" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
				<div class="wrapper_pic_r" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
					<div class="wrapper_pic_b" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
						<div class="wrapper_pic_l" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
							<div class="wrapper_pic_tl" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
								<div class="wrapper_pic_tr" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
									<div class="wrapper_pic_bl" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
										<div class="wrapper_pic_br" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n";
  }
// **********************************************************************************************
  function  tep_draw_prod_pic_bottom()
  {
   return $table = '</div>'. "\n".'
									</div>'. "\n".'
								</div>'. "\n".'
							</div>'. "\n".'
						</div>'. "\n".'
					</div>'. "\n".'
				</div>'. "\n".'
			</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function  tep_draw_prod_pic2_top()
  {
  return $table = '
			<div class="wrapper_pic_t" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
				<div class="wrapper_pic_r" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
					<div class="wrapper_pic_b" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
						<div class="wrapper_pic_l" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
							<div class="wrapper_pic_tl" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
								<div class="wrapper_pic_tr" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
									<div class="wrapper_pic_bl" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
										<div class="wrapper_pic_br" style="width:'.(FIRST_PAGE_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(FIRST_PAGE_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n";
  }
// **********************************************************************************************
  function  tep_draw_prod_pic2_bottom()
  {
   return $table = '</div>'. "\n".'
									</div>'. "\n".'
								</div>'. "\n".'
							</div>'. "\n".'
						</div>'. "\n".'
					</div>'. "\n".'
				</div>'. "\n".'
			</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function  tep_draw_prod_pic_cart_top()
  {
  return $table = '
			<div class="wrapper_pic_t" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
				<div class="wrapper_pic_r" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
					<div class="wrapper_pic_b" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
						<div class="wrapper_pic_l" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
							<div class="wrapper_pic_tl" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
								<div class="wrapper_pic_tr" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
									<div class="wrapper_pic_bl" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
										<div class="wrapper_pic_br" style="width:'.(CART_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(CART_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n";
  }
// **********************************************************************************************
  function  tep_draw_prod_pic_cart_bottom()
  {
   return $table = '</div>'. "\n".'
									</div>'. "\n".'
								</div>'. "\n".'
							</div>'. "\n".'
						</div>'. "\n".'
					</div>'. "\n".'
				</div>'. "\n".'
			</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function  tep_draw_prod_pic3_top()
  {
  return $table = '
			<div class="wrapper_pic_t" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
				<div class="wrapper_pic_r" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
					<div class="wrapper_pic_b" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
						<div class="wrapper_pic_l" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
							<div class="wrapper_pic_tl" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
								<div class="wrapper_pic_tr" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
									<div class="wrapper_pic_bl" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
										<div class="wrapper_pic_br" style="width:'.(SUBCATEGORY_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SUBCATEGORY_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n";
  }
// **********************************************************************************************
  function  tep_draw_prod_pic3_bottom()
  {
   return $table = '</div>'. "\n".'
									</div>'. "\n".'
								</div>'. "\n".'
							</div>'. "\n".'
						</div>'. "\n".'
					</div>'. "\n".'
				</div>'. "\n".'
			</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function  tep_draw_box_pic_top()
  {
  return $table = '
			<div class="wrapper_pic_t" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
				<div class="wrapper_pic_r" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
					<div class="wrapper_pic_b" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
						<div class="wrapper_pic_l" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
							<div class="wrapper_pic_tl" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
								<div class="wrapper_pic_tr" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
									<div class="wrapper_pic_bl" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
										<div class="wrapper_pic_br" style="width:'.(BOX_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(BOX_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n";
  }
// **********************************************************************************************
  function  tep_draw_box_pic_bottom()
  {
   return $table = '</div>'. "\n".'
									</div>'. "\n".'
								</div>'. "\n".'
							</div>'. "\n".'
						</div>'. "\n".'
					</div>'. "\n".'
				</div>'. "\n".'
			</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function  tep_draw_prod_pic_info_top()
  {
  return $table = '
			<div class="wrapper_pic_t" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
				<div class="wrapper_pic_r" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
					<div class="wrapper_pic_b" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
						<div class="wrapper_pic_l" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
							<div class="wrapper_pic_tl" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
								<div class="wrapper_pic_tr" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
									<div class="wrapper_pic_bl" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
										<div class="wrapper_pic_br" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n".'
											<div class="wrapper_pic_zoom" style="width:'.(PROD_INFO_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(PROD_INFO_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n";
  }
// **********************************************************************************************
  function  tep_draw_prod_pic_info_bottom()
  {
   return $table = '</div>'. "\n".'
										</div>'. "\n".'   
									</div>'. "\n".'
								</div>'. "\n".'
							</div>'. "\n".'
						</div>'. "\n".'
					</div>'. "\n".'
				</div>'. "\n".'
			</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function  tep_draw_pic2_top()
  {
  return $table = '
			<div class="wrapper_pic_t" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;">'. "\n".'
				<div class="wrapper_pic_r" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;">'. "\n".'
					<div class="wrapper_pic_b" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;">'. "\n".'
						<div class="wrapper_pic_l" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;">'. "\n".'
							<div class="wrapper_pic_tl" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;">'. "\n".'
								<div class="wrapper_pic_tr" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;">'. "\n".'
									<div class="wrapper_pic_bl" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W2).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H2).'px;">'. "\n".'
										<div class="wrapper_pic_br" style="width:'.(SMALL_IMAGE_WIDTH + PIC_MARG_W).'px;height:'.(SMALL_IMAGE_HEIGHT + PIC_MARG_H).'px;">'. "\n";
  }
// **********************************************************************************************
  function  tep_draw_pic2_bottom()
  {
   return $table = '</div>'. "\n".'
									</div>'. "\n".'
								</div>'. "\n".'
							</div>'. "\n".'
						</div>'. "\n".'
					</div>'. "\n".'
				</div>'. "\n".'
			</div>'. "\n";
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_button_header_top()
  {
  return $table = 	'<div class="button-t">';
					
  }
// **********************************************************************************************
function tep_draw_button_header_bottom()
  {
  return $table =  	'</div>';
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_button_header_search_top()
  {
  return $table = 	'<div class="button_header button_header4"><div class="button bg_button"><div class="button-t">';
					
  }
// **********************************************************************************************
function tep_draw_button_header_search_bottom()
  {
  return $table =  	'</div></div></div>';
  }
// **********************************************************************************************
// **********************************************************************************************
  function tep_draw_button3_top()
  {
  return $table = 	'<div class="button_content button_content3"><div class="button bg_button"><div class="button-t">';
					
  }
// **********************************************************************************************
function tep_draw_button3_bottom()
  {
  return $table =  	'</div></div></div>';
  }
// **********************************************************************************************
?>
