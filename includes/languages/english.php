<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2007 osCommerce

  Released under the GNU General Public License
*/

// look in your $PATH_LOCALE/locale directory for available locales
// or type locale -a on the server.
// Examples:
// on RedHat try 'en_US'
// on FreeBSD try 'en_US.ISO_8859-1'
// on Windows try 'en', or 'English'
@setlocale(LC_TIME, 'en_US.ISO_8859-1');

define('DATE_FORMAT_SHORT', '%m/%d/%Y');  // this is used for strftime()
define('DATE_FORMAT_LONG', '%A %d %B, %Y'); // this is used for strftime()
define('DATE_FORMAT', 'm/d/Y'); // this is used for date()
define('DATE_TIME_FORMAT', DATE_FORMAT_SHORT . ' %H:%M:%S');
define('JQUERY_DATEPICKER_I18N_CODE', ''); // leave empty for en_US; see http://jqueryui.com/demos/datepicker/#localization
define('JQUERY_DATEPICKER_FORMAT', 'mm/dd/yy'); // see http://docs.jquery.com/UI/Datepicker/formatDate

////
// Return date in raw format
// $date should be in format mm/dd/yyyy
// raw date is in format YYYYMMDD, or DDMMYYYY
function tep_date_raw($date, $reverse = false) {
  if ($reverse) {
    return substr($date, 3, 2) . substr($date, 0, 2) . substr($date, 6, 4);
  } else {
    return substr($date, 6, 4) . substr($date, 0, 2) . substr($date, 3, 2);
  }
}

// if USE_DEFAULT_LANGUAGE_CURRENCY is true, use the following currency, instead of the applications default currency (used when changing language)
define('LANGUAGE_CURRENCY', 'EUR');

// Global entries for the <html> tag
define('HTML_PARAMS', 'dir="ltr" lang="en"');

// charset for web pages and emails
define('CHARSET', 'utf-8');

// page title
define('TITLE', STORE_NAME);

// header text in includes/header.php
define('HEADER_TITLE_CREATE_ACCOUNT', 'Create an Account');
define('HEADER_TITLE_MY_ACCOUNT', 'My Account');
define('HEADER_TITLE_CART_CONTENTS', 'Cart Contents');
define('HEADER_TITLE_CHECKOUT', 'Checkout');
define('HEADER_TITLE_TOP', 'Top');
define('HEADER_TITLE_CATALOG', 'Catalog');
define('HEADER_TITLE_LOGOFF', 'Log Off');
define('HEADER_TITLE_LOGIN', 'Log In');

// footer text in includes/footer.php
define('FOOTER_TEXT_REQUESTS_SINCE', 'requests since');

// text for gender
define('MALE', 'Male');
define('FEMALE', 'Female');
define('MALE_ADDRESS', 'Mr.');
define('FEMALE_ADDRESS', 'Ms.');

// text for date of birth example
define('DOB_FORMAT_STRING', 'mm/dd/yyyy');

// checkout procedure text
define('CHECKOUT_BAR_DELIVERY', 'Delivery Information');
define('CHECKOUT_BAR_PAYMENT', 'Payment Information');
define('CHECKOUT_BAR_CONFIRMATION', 'Confirmation');
define('CHECKOUT_BAR_FINISHED', 'Finished!');

// pull down default text
define('PULL_DOWN_DEFAULT', 'Please Select');
define('TYPE_BELOW', 'Type Below');

// javascript messages
define('JS_ERROR', 'Errors have occured during the process of your form.\n\nPlease make the following corrections:\n\n');

define('JS_REVIEW_TEXT', '* The \'Review Text\' must have at least ' . REVIEW_TEXT_MIN_LENGTH . ' characters.\n');
define('JS_REVIEW_RATING', '* You must rate the product for your review.\n');

define('JS_ERROR_NO_PAYMENT_MODULE_SELECTED', '* Please select a payment method for your order.\n');

define('JS_ERROR_SUBMITTED', 'This form has already been submitted. Please press Ok and wait for this process to be completed.');

define('ERROR_NO_PAYMENT_MODULE_SELECTED', 'Please select a payment method for your order.');

define('CATEGORY_COMPANY', 'Company Details');
define('CATEGORY_PERSONAL', 'Your Personal Details');
define('CATEGORY_ADDRESS', 'Your Address');
define('CATEGORY_CONTACT', 'Your Contact Information');
define('CATEGORY_OPTIONS', 'Options');
define('CATEGORY_PASSWORD', 'Your Password');

define('ENTRY_COMPANY', 'Company Name:');
define('ENTRY_COMPANY_TEXT', '');
define('ENTRY_GENDER', 'Gender:');
define('ENTRY_GENDER_ERROR', 'Please select your Gender.');
define('ENTRY_GENDER_TEXT', '*');
define('ENTRY_FIRST_NAME', 'First Name:');
define('ENTRY_FIRST_NAME_ERROR', 'Your First Name must contain a minimum of ' . ENTRY_FIRST_NAME_MIN_LENGTH . ' characters.');
define('ENTRY_FIRST_NAME_TEXT', '*');
define('ENTRY_LAST_NAME', 'Last Name:');
define('ENTRY_LAST_NAME_ERROR', 'Your Last Name must contain a minimum of ' . ENTRY_LAST_NAME_MIN_LENGTH . ' characters.');
define('ENTRY_LAST_NAME_TEXT', '*');
define('ENTRY_DATE_OF_BIRTH', 'Date of Birth:');
define('ENTRY_DATE_OF_BIRTH_ERROR', 'Your Date of Birth must be in this format: MM/DD/YYYY (eg 05/21/1970)');
define('ENTRY_DATE_OF_BIRTH_TEXT', '* (eg. 05/21/1970)');
define('ENTRY_EMAIL_ADDRESS', 'E-Mail Address:');
define('ENTRY_EMAIL_ADDRESS_ERROR', 'Your E-Mail Address must contain a minimum of ' . ENTRY_EMAIL_ADDRESS_MIN_LENGTH . ' characters.');
define('ENTRY_EMAIL_ADDRESS_CHECK_ERROR', 'Your E-Mail Address does not appear to be valid - please make any necessary corrections.');
define('ENTRY_EMAIL_ADDRESS_ERROR_EXISTS', 'Your E-Mail Address already exists in our records - please log in with the e-mail address or create an account with a different address.');
define('ENTRY_EMAIL_ADDRESS_TEXT', '*');
define('ENTRY_STREET_ADDRESS', 'Street Address:');
define('ENTRY_STREET_ADDRESS_ERROR', 'Your Street Address must contain a minimum of ' . ENTRY_STREET_ADDRESS_MIN_LENGTH . ' characters.');
define('ENTRY_STREET_ADDRESS_TEXT', '*');
define('ENTRY_SUBURB', 'Suburb:');
define('ENTRY_SUBURB_TEXT', '');
define('ENTRY_POST_CODE', 'Post Code:');
define('ENTRY_POST_CODE_ERROR', 'Your Post Code must contain a minimum of ' . ENTRY_POSTCODE_MIN_LENGTH . ' characters.');
define('ENTRY_POST_CODE_TEXT', '*');
define('ENTRY_CITY', 'City:');
define('ENTRY_CITY_ERROR', 'Your City must contain a minimum of ' . ENTRY_CITY_MIN_LENGTH . ' characters.');
define('ENTRY_CITY_TEXT', '*');
define('ENTRY_STATE', 'State/Province:');
define('ENTRY_STATE_ERROR', 'Your State must contain a minimum of ' . ENTRY_STATE_MIN_LENGTH . ' characters.');
define('ENTRY_STATE_ERROR_SELECT', 'Please select a state from the States pull down menu.');
define('ENTRY_STATE_TEXT', '*');
define('ENTRY_COUNTRY', 'Country:');
define('ENTRY_COUNTRY_ERROR', 'You must select a country from the Countries pull down menu.');
define('ENTRY_COUNTRY_TEXT', '*');
define('ENTRY_TELEPHONE_NUMBER', 'Telephone Number:');
define('ENTRY_TELEPHONE_NUMBER_ERROR', 'Your Telephone Number must contain a minimum of ' . ENTRY_TELEPHONE_MIN_LENGTH . ' characters.');
define('ENTRY_TELEPHONE_NUMBER_TEXT', '*');
define('ENTRY_FAX_NUMBER', 'Fax Number:');
define('ENTRY_FAX_NUMBER_TEXT', '');
define('ENTRY_NEWSLETTER', 'Newsletter:');
define('ENTRY_NEWSLETTER_TEXT', '');
define('ENTRY_NEWSLETTER_YES', 'Subscribed');
define('ENTRY_NEWSLETTER_NO', 'Unsubscribed');
define('ENTRY_PASSWORD', 'Password:');
define('ENTRY_PASSWORD_ERROR', 'Your Password must contain a minimum of ' . ENTRY_PASSWORD_MIN_LENGTH . ' characters.');
define('ENTRY_PASSWORD_ERROR_NOT_MATCHING', 'The Password Confirmation must match your Password.');
define('ENTRY_PASSWORD_TEXT', '*');
define('ENTRY_PASSWORD_CONFIRMATION', 'Password Confirmation:');
define('ENTRY_PASSWORD_CONFIRMATION_TEXT', '*');
define('ENTRY_PASSWORD_CURRENT', 'Current Password:');
define('ENTRY_PASSWORD_CURRENT_TEXT', '*');
define('ENTRY_PASSWORD_CURRENT_ERROR', 'Your Password must contain a minimum of ' . ENTRY_PASSWORD_MIN_LENGTH . ' characters.');
define('ENTRY_PASSWORD_NEW', 'New Password:');
define('ENTRY_PASSWORD_NEW_TEXT', '*');
define('ENTRY_PASSWORD_NEW_ERROR', 'Your new Password must contain a minimum of ' . ENTRY_PASSWORD_MIN_LENGTH . ' characters.');
define('ENTRY_PASSWORD_NEW_ERROR_NOT_MATCHING', 'The Password Confirmation must match your new Password.');
define('PASSWORD_HIDDEN', '--HIDDEN--');

define('FORM_REQUIRED_INFORMATION', '* Required information');

// constants for use in tep_prev_next_display function
define('TEXT_RESULT_PAGE', 'Result Pages:');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> products)');
define('TEXT_DISPLAY_NUMBER_OF_ORDERS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> orders)');
define('TEXT_DISPLAY_NUMBER_OF_REVIEWS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> reviews)');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS_NEW', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> new products)');
define('TEXT_DISPLAY_NUMBER_OF_SPECIALS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> specials)');

define('PREVNEXT_TITLE_FIRST_PAGE', 'First Page');
define('PREVNEXT_TITLE_PREVIOUS_PAGE', 'Previous Page');
define('PREVNEXT_TITLE_NEXT_PAGE', 'Next Page');
define('PREVNEXT_TITLE_LAST_PAGE', 'Last Page');
define('PREVNEXT_TITLE_PAGE_NO', 'Page %d');
define('PREVNEXT_TITLE_PREV_SET_OF_NO_PAGE', 'Previous Set of %d Pages');
define('PREVNEXT_TITLE_NEXT_SET_OF_NO_PAGE', 'Next Set of %d Pages');
define('PREVNEXT_BUTTON_FIRST', '&lt;&lt;FIRST');
define('PREVNEXT_BUTTON_PREV', '[&nbsp;<small>&lt;&lt;</small>&nbsp;<span>Prev</span>&nbsp;]');
define('PREVNEXT_BUTTON_NEXT', '[&nbsp;<span>Next</span>&nbsp;<small>&gt;&gt;</small>&nbsp;]');
define('PREVNEXT_BUTTON_LAST', 'LAST&gt;&gt;');

define('IMAGE_BUTTON_ADD_ADDRESS', 'Add Address');
define('IMAGE_BUTTON_ADDRESS_BOOK', 'Address Book');
define('IMAGE_BUTTON_BACK', 'Back');
define('IMAGE_BUTTON_BUY_NOW', 'Buy Now');
define('IMAGE_BUTTON_CHANGE_ADDRESS', 'Change Address');
define('IMAGE_BUTTON_CHECKOUT', 'Checkout');
define('IMAGE_BUTTON_CONFIRM_ORDER', 'Confirm Order');
define('IMAGE_BUTTON_CONTINUE', 'Continue');
define('IMAGE_BUTTON_CONTINUE_SHOPPING', 'Continue Shopping');
define('IMAGE_BUTTON_DELETE', 'Delete');
define('IMAGE_BUTTON_EDIT_ACCOUNT', 'Edit Account');
define('IMAGE_BUTTON_HISTORY', 'Order History');
define('IMAGE_BUTTON_LOGIN', 'Sign In');
define('IMAGE_BUTTON_IN_CART', 'Add&nbsp;to&nbsp;Cart');
define('IMAGE_BUTTON_NOTIFICATIONS', 'Notifications');
define('IMAGE_BUTTON_QUICK_FIND', 'Quick Find');
define('IMAGE_BUTTON_REMOVE_NOTIFICATIONS', 'Remove Notifications');
define('IMAGE_BUTTON_REVIEWS', 'Reviews');
define('IMAGE_BUTTON_SEARCH', 'Search');
define('IMAGE_BUTTON_SHIPPING_OPTIONS', 'Shipping Options');
define('IMAGE_BUTTON_TELL_A_FRIEND', 'Tell a Friend');
define('IMAGE_BUTTON_UPDATE', 'Update');
define('IMAGE_BUTTON_UPDATE_CART', 'Update Cart');
define('IMAGE_BUTTON_WRITE_REVIEW', 'Write Review');

define('SMALL_IMAGE_BUTTON_DELETE', 'Delete');
define('SMALL_IMAGE_BUTTON_EDIT', 'Edit');
define('SMALL_IMAGE_BUTTON_VIEW', 'View');

define('ICON_ARROW_RIGHT', 'more');
define('ICON_CART', 'In Cart');
define('ICON_ERROR', 'Error');
define('ICON_SUCCESS', 'Success');
define('ICON_WARNING', 'Warning');

define('TEXT_GREETING_PERSONAL', '<strong>Welcome back <span class="greetUser">%s!</span></strong> Would you like to see which <a href="%s"><u>new products</u></a> are available to purchase?');
define('TEXT_GREETING_PERSONAL_RELOGON', '<small>If you are not %s, please <a href="%s"><u>log yourself in</u></a> with your account information.</small>');
define('TEXT_GREETING_GUEST', '<strong>Welcome <span class="greetUser">Guest!</span></strong> Would you like to <a href="%s"><u>log yourself in</u></a>? Or would you prefer to <a href="%s"><u>create an account</u></a>?');

define('TEXT_SORT_PRODUCTS', 'Sort products ');
define('TEXT_DESCENDINGLY', 'descendingly');
define('TEXT_ASCENDINGLY', 'ascendingly');
define('TEXT_BY', ' By ');

define('TEXT_REVIEW_BY', 'By %s');
define('TEXT_REVIEW_WORD_COUNT', '%s words');
define('TEXT_REVIEW_RATING', 'Rating: %s [%s]');
define('TEXT_REVIEW_DATE_ADDED', '<span>Date Added:</span> %s');
define('TEXT_NO_REVIEWS', 'There are currently no product reviews.');

define('TEXT_NO_NEW_PRODUCTS', 'There are currently no products.');

define('TEXT_UNKNOWN_TAX_RATE', 'Unknown tax rate');

define('TEXT_REQUIRED', '<span class="errorText">Required</span>');

define('ERROR_TEP_MAIL', '<font face="Verdana, Arial" size="2" color="#ff0000"><strong><small>TEP ERROR:</small> Cannot send the email through the specified SMTP server. Please check your php.ini setting and correct the SMTP server if necessary.</strong></font>');

define('TEXT_CCVAL_ERROR_INVALID_DATE', 'The expiry date entered for the credit card is invalid. Please check the date and try again.');
define('TEXT_CCVAL_ERROR_INVALID_NUMBER', 'The credit card number entered is invalid. Please check the number and try again.');
define('TEXT_CCVAL_ERROR_UNKNOWN_CARD', 'The first four digits of the number entered are: %s. If that number is correct, we do not accept that type of credit card. If it is wrong, please try again.');

define('FOOTER_TEXT_BODY', ' <a href="' . tep_href_link(FILENAME_DEFAULT) . '">' . STORE_NAME . '</a>&nbsp;&nbsp;  &copy; ' . date('Y'));
/* ## add by Seaman ####################################  */
define('ITEM_INFORMATION_PRIVACY', 'Privacy Notice');
define('ITEM_INFORMATION_CONDITIONS', 'Conditions of Use');
define('ITEM_INFORMATION_SHIPPING', 'Shipping &amp; Returns');
define('IMAGE_BUTTON_DETAILS', 'Details');
define('PRICE', 'Our Price:&nbsp;&nbsp;');
define('PRICE2', 'Old Price:&nbsp;&nbsp;');
define('BACK_TO_TOP', 'Back to Top');
/* ## add by Seaman ####################################  */

/* aboutus */
define('MENU_TITLE_ABOUTUS', 'About us');
define('HEADING_TITLE_ABOUTUS', 'About us');
define('TEXT_INFORMATION_ABOUTUS', 'AVANAH Paris™ is a cosmetic brand specialized in Nano Gold Technology, also known as NGT™. 
<br/><br/>
A lengthy search for a smart alternative to costly and painful cosmetic surgery turned up with no reliable options. Realizing there was a desperate need for a safe, cost effective solution to cosmetic surgery, our colleague and ourselves decided to develop state-of-the-art techniques for providing Nano Gold Technologies (NGT™) to consumers.
<br/><br/>
After the successful launch of the Original 24KT Gold Collagen Mask, we set forth to create AVANAH Paris™.
<br/><br/>
We exclusively catered to the professional sector of salons, spas and beauty professionals to get a real feel for the needs of their clients. We immediately began to get positive feedback from the results of our masks and we knew exactly where we wanted to go from there. Extremely excited about the results we decided to plan and launch a complete 24KT line in 2010.
<br/><br/>
Our mission is to develop and introduce new, safe, more affordable, and eco-friendly NGT™ products that will help improve the quality of all our lives. Our unique anti-aging skin care products restore a natural youthful glow and a smoother, suppler appearance. AVANAH Paris™ helps bring back the nourishment your skin needs to be healthier and function more effectively.');

/* DISTRIBUTORS */
define('MENU_TITLE_DISTRIBUTOR', 'Become a distributor');
define('HEADING_TITLE_DISTRIBUTOR', 'Become a distributor');
define('TEXT_INFORMATION_DISTRIBUTOR', 'If you are interested in becoming a distributor in your area, please send us an email :  <b>contact@avanah-paris.com</b> <br/><br/>
One of our sales agents will contact you shortly with distributor guidelines and requirements.<br/><br/>
<b>We ship world wide :</b>
<table  border="1" style="text-align:center;"><tr>
<td style="width:33%;">
<b>New York (USA)</b><br/>
Black Label<br/>
43 Exchange Place<br/>
New York, NY 10005
</td><td style="width:33%;">
<b>Vancouver (CANADA)</b><br/>
Innovative Therapeutic Technology<br/>
2028 Stephens Street<br/>
Vancouver, BC
</td><td style="width:33%;">
<b>Barcelona (SPAIN)</b><br/>
New Look Muntaner<br/>
C/ Muntaner 442<br/>
Barcelona, Spain 08006
</td></tr><tr><td>
<b>Rio de Janeiro (BRAZIL)</b><br/>
Hôtel Santa Teresa<br/>
Rua Almirante Alexandrino 660<br/>
Santa Teresa 20241-260
<br/>Rio de Janeiro, RJ, Brazil 
</td><td>
<b>Sicily (ITALY)</b><br/>
Verdura Golf & Spa Resort <br/>
S.S. 115 Km 131 <br/>
92019 Sciacca  Sicily Italy
</td><td>
<b>Moscow (RUSSIA)</b><br/>
Barvikha Hotel & Spa<br/>
Rublevo-Uspenskoye Shosse, 114/2
<br/>Moscow,  143083, Russie<br/>
</td></tr></table>
');
 


/**TESTIMONIALS **/
define('MENU_TITLE_TESTIMONIALS', 'Videos');
define('HEADING_TITLE_TESTIMONIALS', 'Videos');
define('TEXT_INFORMATION_TESTIMONIALS', 'It’s the best beauty treatment around!  My skin is tighter, more resilient, my pores are minimized and the best part is… it doesn’t burn!  I have sensitive skin so a lot of anti-aging products burn my skin and I wind up looking worse!  I also love how the gold flecks stay in your skin hours after the application!<br/>
- Alicia Gentile, Hollywood Hott<br/><br/>
I love it!! I gave myself a peel last night and used the AVANAH Paris mask and had great results, my skin looks flawless right now. Love, love, love it!! This was my great find at the show. :)<br/>
- Becca, Bella Skin Care at The Ivy House<br/><br/>
I am honestly astonished at how well the under eye treatments work. It\'s like buying back 10 years...<br/>
- Kate Buckley');

/* why gold*/
define('MENU_TITLE_GOLD', 'Why gold ?');
define('HEADING_TITLE_GOLD', 'Why gold ?');
define('TEXT_INFORMATION_GOLD', 'The anti-aging benefits of gold can be traced back 5,000 years to Cleopatra, who was said to sleep in a gold face mask every night to enhance the suppleness of her complexion and preserve its natural luminosity.
In addition to antioxidant and antimicrobial powers, gold is praised for its purported ability to ward off UV damage, tighten lax skin and reduce the appearance of discoloration. 
Throughout history, gold has been recognized for its luxurious and beautifying properties. Historians have long maintained that Cleopatra used pure gold as a tool to maintain youthful skin by reportedly sleeping in a gold mask every night. In ancient Rome, gold salves were used for the treatment of a variety of skin problems. In ancient Chinese medicine gold was a key to youth, as the queen of the Ch’ing dynasty used a gold massage roller on her face every day.  These gold facials are also being touted as being based on the ancient Indian healing art of Ayurveda and are said to firm the skin, give it a glow and reduce wrinkles.
Gold-based facial spa treatments may be found in California, Georgia, Texas, New York, and New Jersey with prices starting at $175 for a sixty minute treatment.  The benefits of gold reportedly include:
Gold slows down collagen depletion and the breakdown of elastin to prevent sagging skin. It stimulates cellular growth of the basal layer to regenerate healthy, firm skin cells and provide a tightening effect.
Reduces the Appearance of Fine Lines and Wrinkles.
Reduces the Appearance of Sun Damage and Age Spots: Since 1929 Gold has been successfully used to treat rheumatoid arthritis by reducing inflammation. Gold\'s anti-inflammatory properties also decrease skin inflammation, thereby slowing down melanin secretion and reducing age spots.
Gold fights off damaging free radicals to help prevent premature aging of the skin.
The alchemists in the 15th century considered gold a favorable remedy for most ills and prepared many substances with it.
In Renaissance Venice, the double function of gold as medicine and as a symbol of riches was combined in the custom of serving gold-covered, sugared almonds after the meal in order to strengthen the heart and protect against rheumatism.
During Visconti\'s reign in Milan, gold and spices were blended with unpleasant things which needed to be swallowed in order to make them more appetizing.
 Embellishing foods with gold is a centuries old tradition that originated in the East, where it served as a symbol of hospitality and wealth. Gold on food and drink was also considered a symbol of respect for special guests at your table.');



/****contactus*******/
define('CONTACTUS_INTRO','If you are interested in buying or becoming a distributor of our products, send us an email <b>contact@avanah-paris.com</b> or complete the form below : ');

/*login/logout*/
define('HEADER_LOGIN','Login');
define('HEADER_HELLO','Hello');
define('HEADER_LOGOUT','Logout');

// Discount Code 3.1.1 - start
define('TEXT_DISCOUNT', 'Discount');
define('TEXT_DISCOUNT_CODE', 'Discount Code');
// Discount Code 3.1.1 - end
?>