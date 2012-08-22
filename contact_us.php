<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2010 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_CONTACT_US);
  $tab_sel = tep_href_link(FILENAME_CONTACT_US); 
  $current_page = FILENAME_CONTACT_US; 

  if (isset($HTTP_GET_VARS['action']) && ($HTTP_GET_VARS['action'] == 'send') && isset($HTTP_POST_VARS['formid']) && ($HTTP_POST_VARS['formid'] == $sessiontoken)) {
    $error = false;

    $name = tep_db_prepare_input($HTTP_POST_VARS['name']);
    $email_address = tep_db_prepare_input($HTTP_POST_VARS['email']);
    $enquiry = tep_db_prepare_input($HTTP_POST_VARS['enquiry']);

    if (!tep_validate_email($email_address)) {
      $error = true;

      $messageStack->add('contact', ENTRY_EMAIL_ADDRESS_CHECK_ERROR);
    }

    $actionRecorder = new actionRecorder('ar_contact_us', (tep_session_is_registered('customer_id') ? $customer_id : null), $name);
    if (!$actionRecorder->canPerform()) {
      $error = true;

      $actionRecorder->record(false);

      $messageStack->add('contact', sprintf(ERROR_ACTION_RECORDER, (defined('MODULE_ACTION_RECORDER_CONTACT_US_EMAIL_MINUTES') ? (int)MODULE_ACTION_RECORDER_CONTACT_US_EMAIL_MINUTES : 15)));
    }

    if ($error == false) {
      tep_mail(STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS, EMAIL_SUBJECT, $enquiry, $name, $email_address);

      $actionRecorder->record();

      tep_redirect(tep_href_link(FILENAME_CONTACT_US, 'action=success'));
    }
  }

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_CONTACT_US));

  require(DIR_WS_INCLUDES . 'template_top.php');
?>
<?php echo tep_draw_content_top();?>

<?php echo tep_draw_title_top();?>
<h1><?php echo HEADING_TITLE; ?></h1>
<?php echo tep_draw_title_bottom();?>

<?php
  if ($messageStack->size('contact') > 0) {
    echo $messageStack->output('contact');
  }
  if (isset($HTTP_GET_VARS['action']) && ($HTTP_GET_VARS['action'] == 'success')) {
?>
<div class="contentContainer">
  <div class="contentPadd txtPage">
      <?php echo TEXT_SUCCESS; ?>

      <div class="buttonSet">
        <span class="fl_right"><?php echo tep_draw_button_top()?><?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'triangle-1-e', tep_href_link(FILENAME_DEFAULT)); ?><?php echo tep_draw_button_bottom()?></span>
      </div>

  </div>
</div>
<?php
  } else {
?>
<?php echo CONTACTUS_INTRO; ?>
<?php echo tep_draw_form('contact_us', tep_href_link(FILENAME_CONTACT_US, 'action=send'), 'post', '', true); ?>
<div class="contentContainer">
<div class="contentPadd txtPage">

            <table border="0" width="100%" cellspacing="0" cellpadding="0">
              <tr>
                <td class="fieldKey"><div class="crosspiece95"></div><?php echo ENTRY_NAME; ?></td>
                <td class="fieldValue" width="100%"><?php echo tep_draw_input_field('name', '', 'class="input"'); ?></td>
              </tr>
              <tr>
                <td class="fieldKey"><?php echo ENTRY_EMAIL; ?></td>
                <td class="fieldValue"><?php echo tep_draw_input_field('email', '', 'class="input"'); ?></td>
              </tr>
              <tr>
                <td class="fieldKey" valign="top"><?php echo ENTRY_ENQUIRY; ?></td>
                <td class="fieldValue"><?php echo tep_draw_textarea_field('enquiry', 'soft', 50, 15); ?></td>
              </tr>
              
            </table>

      <div class="buttonSet">
        <span class="fl_right"><?php echo tep_draw_button_top()?><?php echo tep_draw_button(IMAGE_BUTTON_CONTINUE, 'triangle-1-e', null, 'primary'); ?><?php echo tep_draw_button_bottom()?></span>
      </div>
          
</div>
</div>
</form>
<?php
  }
echo '<div id="end_contact">' . INTRO_END . '</div>';
  ?>

<?php echo tep_draw_content_bottom();?>

<?php
  require(DIR_WS_INCLUDES . 'template_bottom.php');
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
