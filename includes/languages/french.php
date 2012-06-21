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
define('HTML_PARAMS', 'dir="ltr" lang="fr"');

// charset for web pages and emails
define('CHARSET', 'utf-8');

// page title
define('TITLE', STORE_NAME);

// header text in includes/header.php
define('HEADER_TITLE_CREATE_ACCOUNT', 'Cr&eacute;er un compte');
define('HEADER_TITLE_MY_ACCOUNT', 'Mon compte');
define('HEADER_TITLE_CART_CONTENTS', 'Cart Contents');
define('HEADER_TITLE_CHECKOUT', 'Checkout');
define('HEADER_TITLE_TOP', 'Top');
define('HEADER_TITLE_CATALOG', 'Catalogue');
define('HEADER_TITLE_LOGOFF', 'Se d&eacute;connecter');
define('HEADER_TITLE_LOGIN', 'Se connecter');

// footer text in includes/footer.php
define('FOOTER_TEXT_REQUESTS_SINCE', 'requests since');

// text for gender
define('MALE', 'Homme');
define('FEMALE', 'Femme');
define('MALE_ADDRESS', 'Mr.');
define('FEMALE_ADDRESS', 'Mmd.');

// text for date of birth example
define('DOB_FORMAT_STRING', 'mm/dd/yyyy');

// checkout procedure text
define('CHECKOUT_BAR_DELIVERY', 'Information de livraison');
define('CHECKOUT_BAR_PAYMENT', 'Information de paiment');
define('CHECKOUT_BAR_CONFIRMATION', 'Confirmation');
define('CHECKOUT_BAR_FINISHED', 'Fini!');

// pull down default text
define('PULL_DOWN_DEFAULT', 'Choisir');
define('TYPE_BELOW', 'Type Below');

// javascript messages
define('JS_ERROR', 'Une erreur est survenue lors du traitement du formulaire.');

define('JS_REVIEW_TEXT', '* The \'Review Text\' must have at least ' . REVIEW_TEXT_MIN_LENGTH . ' caract&egrave;res.\n');
define('JS_REVIEW_RATING', '* You must rate the product for your review.\n');

define('JS_ERROR_NO_PAYMENT_MODULE_SELECTED', '* Veuillez choisir une methode de paiement.\n');

define('JS_ERROR_SUBMITTED', 'Ce formulaire a d&eacute;j&agrave; &eacute;t&eacute; soumis. Veuillez cliquer sur Ok et attendre la fin du processus. ');

define('ERROR_NO_PAYMENT_MODULE_SELECTED', 'Veuillez choisir une methode de paiement.');

define('CATEGORY_COMPANY', 'Companie');
define('CATEGORY_PERSONAL', 'Vos donn&eacute;es personnelles');
define('CATEGORY_ADDRESS', 'Votre adresse');
define('CATEGORY_CONTACT', 'Contact');
define('CATEGORY_OPTIONS', 'Options');
define('CATEGORY_PASSWORD', 'Votre mot de passe');

define('ENTRY_COMPANY', 'Nom de votre companie:');
define('ENTRY_COMPANY_TEXT', '');
define('ENTRY_GENDER', 'genre:');
define('ENTRY_GENDER_ERROR', 'Veuillez choisir votre genre.');
define('ENTRY_GENDER_TEXT', '*');
define('ENTRY_FIRST_NAME', 'Nom de famille:');
define('ENTRY_FIRST_NAME_ERROR', 'Votre nom de famille doit contenir au moins ' . ENTRY_FIRST_NAME_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_FIRST_NAME_TEXT', '*');
define('ENTRY_LAST_NAME', 'Pr&eacute;nom:');
define('ENTRY_LAST_NAME_ERROR', 'Votre pr&eacute;nom doit contenir au moins ' . ENTRY_LAST_NAME_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_LAST_NAME_TEXT', '*');
define('ENTRY_DATE_OF_BIRTH', 'Date de naissance:');
define('ENTRY_DATE_OF_BIRTH_ERROR', 'Votre date de naissance doit &ecirc;tre de ce format: MM/JJ/AAAA (ex 05/21/1970)');
define('ENTRY_DATE_OF_BIRTH_TEXT', '* MM/JJ/AAAA (ex. 05/21/1970)');
define('ENTRY_EMAIL_ADDRESS', 'E-Mail Adresse:');
define('ENTRY_EMAIL_ADDRESS_ERROR', 'Votre email doit contenir un minimum de ' . ENTRY_EMAIL_ADDRESS_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_EMAIL_ADDRESS_CHECK_ERROR', 'Votre email n\'est pas valide.');
define('ENTRY_EMAIL_ADDRESS_ERROR_EXISTS', 'Votre email est d&eacute;j&agrave; enregistr&eacute; sur notre site. Veuillez vous connecter ou cr&eacute;e un compte avec une autre adresse email.');
define('ENTRY_EMAIL_ADDRESS_TEXT', '*');
define('ENTRY_STREET_ADDRESS', 'Num&eacute;ro et nom de rue:');
define('ENTRY_STREET_ADDRESS_ERROR', 'Votre adresse doit contenir un minimum de ' . ENTRY_STREET_ADDRESS_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_STREET_ADDRESS_TEXT', '*');
define('ENTRY_SUBURB', 'Complement:');
define('ENTRY_SUBURB_TEXT', '');
define('ENTRY_POST_CODE', 'Code Postal:');
define('ENTRY_POST_CODE_ERROR', 'Votre code postal doit contenir un minimum ' . ENTRY_POSTCODE_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_POST_CODE_TEXT', '*');
define('ENTRY_CITY', 'Ville:');
define('ENTRY_CITY_ERROR', 'Votre ville doit contenir un minimum de ' . ENTRY_CITY_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_CITY_TEXT', '*');
define('ENTRY_STATE', 'R&eacute;gion:');
define('ENTRY_STATE_ERROR', 'Votre pays doit contenir un minimum de ' . ENTRY_STATE_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_STATE_ERROR_SELECT', 'Veuillez choisir un pays dans le menu deroulant.');
define('ENTRY_STATE_TEXT', '*');
define('ENTRY_COUNTRY', 'Pays:');
define('ENTRY_COUNTRY_ERROR', 'Vous devez s&eacute;lectionner.');
define('ENTRY_COUNTRY_TEXT', '*');
define('ENTRY_TELEPHONE_NUMBER', 'Num&eacute;ro de t&eacute;l&eacute;phone:');
define('ENTRY_TELEPHONE_NUMBER_ERROR', 'Votre t&eacute;l&eacute;phone doit contenir un minimum de ' . ENTRY_TELEPHONE_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_TELEPHONE_NUMBER_TEXT', '*');
define('ENTRY_FAX_NUMBER', 'Num&eacute;ro de fax:');
define('ENTRY_FAX_NUMBER_TEXT', '');
define('ENTRY_NEWSLETTER', 'Newsletter:');
define('ENTRY_NEWSLETTER_TEXT', '');
define('ENTRY_NEWSLETTER_YES', 'S\'inscrire');
define('ENTRY_NEWSLETTER_NO', 'Se d&eacutesinscrire');
define('ENTRY_PASSWORD', 'Mot de passe:');
define('ENTRY_PASSWORD_ERROR', 'Votre mot de passe doit contenir un minimun de ' . ENTRY_PASSWORD_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_PASSWORD_ERROR_NOT_MATCHING', 'Le mot de passe de confirmation ne correspond pas.');
define('ENTRY_PASSWORD_TEXT', '*');
define('ENTRY_PASSWORD_CONFIRMATION', 'Confirmatin du mot de passe:');
define('ENTRY_PASSWORD_CONFIRMATION_TEXT', '*');
define('ENTRY_PASSWORD_CURRENT', 'Mot de passe actuel:');
define('ENTRY_PASSWORD_CURRENT_TEXT', '*');
define('ENTRY_PASSWORD_CURRENT_ERROR', 'Votre mot de passe doit contenir un minimum de ' . ENTRY_PASSWORD_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_PASSWORD_NEW', 'Nouveau mot de passe:');
define('ENTRY_PASSWORD_NEW_TEXT', '*');
define('ENTRY_PASSWORD_NEW_ERROR', 'Votre nuoveau mot de passe doit contenir un minimum de ' . ENTRY_PASSWORD_MIN_LENGTH . ' caract&egrave;res.');
define('ENTRY_PASSWORD_NEW_ERROR_NOT_MATCHING', 'Les mot de passes ne correspondent pas.');
define('PASSWORD_HIDDEN', '--CACHE--');

define('FORM_REQUIRED_INFORMATION', '* Champs obligatoires');

// constants for use in tep_prev_next_display function
define('TEXT_RESULT_PAGE', 'Result Pages:');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> products)');
define('TEXT_DISPLAY_NUMBER_OF_ORDERS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> orders)');
define('TEXT_DISPLAY_NUMBER_OF_REVIEWS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> reviews)');
define('TEXT_DISPLAY_NUMBER_OF_PRODUCTS_NEW', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> new products)');
define('TEXT_DISPLAY_NUMBER_OF_SPECIALS', '<span>Displaying <strong>%d</strong> to <strong>%d</strong></span> (of <strong>%d</strong> specials)');

define('PREVNEXT_TITLE_FIRST_PAGE', 'Premiere page');
define('PREVNEXT_TITLE_PREVIOUS_PAGE', 'Page pr&eacute;c&eacute;dente');
define('PREVNEXT_TITLE_NEXT_PAGE', 'Page suivante');
define('PREVNEXT_TITLE_LAST_PAGE', 'Derniere page');
define('PREVNEXT_TITLE_PAGE_NO', 'Page %d');
define('PREVNEXT_TITLE_PREV_SET_OF_NO_PAGE', 'Previous Set of %d Pages');
define('PREVNEXT_TITLE_NEXT_SET_OF_NO_PAGE', 'Next Set of %d Pages');
define('PREVNEXT_BUTTON_FIRST', '&lt;&lt;FIRST');
define('PREVNEXT_BUTTON_PREV', '[&nbsp;<small>&lt;&lt;</small>&nbsp;<span>Prev</span>&nbsp;]');
define('PREVNEXT_BUTTON_NEXT', '[&nbsp;<span>Next</span>&nbsp;<small>&gt;&gt;</small>&nbsp;]');
define('PREVNEXT_BUTTON_LAST', 'LAST&gt;&gt;');

define('IMAGE_BUTTON_ADD_ADDRESS', 'Ajouter une adresse');
define('IMAGE_BUTTON_ADDRESS_BOOK', 'Carnet d\'adresse');
define('IMAGE_BUTTON_BACK', 'Retour');
define('IMAGE_BUTTON_BUY_NOW', 'Acheter');
define('IMAGE_BUTTON_CHANGE_ADDRESS', 'Changer l\'adresse');
define('IMAGE_BUTTON_CHECKOUT', 'Checkout');
define('IMAGE_BUTTON_CONFIRM_ORDER', 'Confirmer la commande');
define('IMAGE_BUTTON_CONTINUE', 'Continuer');
define('IMAGE_BUTTON_CONTINUE_SHOPPING', 'Continuer votre shopping');
define('IMAGE_BUTTON_DELETE', 'Supprimer');
define('IMAGE_BUTTON_EDIT_ACCOUNT', 'Editer votre compte');
define('IMAGE_BUTTON_HISTORY', 'Historique des commandes');
define('IMAGE_BUTTON_LOGIN', 'Se connecter');
define('IMAGE_BUTTON_IN_CART', 'Ajouter au panier');
define('IMAGE_BUTTON_NOTIFICATIONS', 'Notifications');
define('IMAGE_BUTTON_QUICK_FIND', 'Quick Find');
define('IMAGE_BUTTON_REMOVE_NOTIFICATIONS', 'Supprimer la notifications');
define('IMAGE_BUTTON_REVIEWS', 'Reviews');
define('IMAGE_BUTTON_SEARCH', 'Rechercher');
define('IMAGE_BUTTON_SHIPPING_OPTIONS', 'Options de livraison');
define('IMAGE_BUTTON_TELL_A_FRIEND', 'Partager &agrave; un ami(e)');
define('IMAGE_BUTTON_UPDATE', 'Mettre &agrave; jour');
define('IMAGE_BUTTON_UPDATE_CART', 'Mettre &agrave; jour votre panier');
define('IMAGE_BUTTON_WRITE_REVIEW', 'Write Review');

define('SMALL_IMAGE_BUTTON_DELETE', 'Supprimer');
define('SMALL_IMAGE_BUTTON_EDIT', 'Editer');
define('SMALL_IMAGE_BUTTON_VIEW', 'Voir');

define('ICON_ARROW_RIGHT', 'Plus');
define('ICON_CART', 'Dans votre panier');
define('ICON_ERROR', 'Erreur');
define('ICON_SUCCESS', 'Succes');
define('ICON_WARNING', 'Attention');

define('TEXT_GREETING_PERSONAL', '<strong>Welcome back <span class="greetUser">%s!</span></strong> Would you like to see which <a href="%s"><u>new products</u></a> are available to purchase?');
define('TEXT_GREETING_PERSONAL_RELOGON', '<small>If you are not %s, please <a href="%s"><u>log yourself in</u></a> with your account information.</small>');
define('TEXT_GREETING_GUEST', '<strong>Welcome <span class="greetUser">Guest!</span></strong> Would you like to <a href="%s"><u>log yourself in</u></a>? Or would you prefer to <a href="%s"><u>create an account</u></a>?');

define('TEXT_SORT_PRODUCTS', 'Sort products ');
define('TEXT_DESCENDINGLY', 'descendant');
define('TEXT_ASCENDINGLY', 'ascendant');
define('TEXT_BY', ' By ');

define('TEXT_REVIEW_BY', 'By %s');
define('TEXT_REVIEW_WORD_COUNT', '%s words');
define('TEXT_REVIEW_RATING', 'Rating: %s [%s]');
define('TEXT_REVIEW_DATE_ADDED', '<span>Date Added:</span> %s');
define('TEXT_NO_REVIEWS', 'There are currently no product reviews.');

define('TEXT_NO_NEW_PRODUCTS', 'Il n\'y a aucun produits.');

define('TEXT_UNKNOWN_TAX_RATE', 'Unknown tax rate');

define('TEXT_REQUIRED', '<span class="errorText">Required</span>');

define('ERROR_TEP_MAIL', '<font face="Verdana, Arial" size="2" color="#ff0000"><strong><small>TEP ERROR:</small> Cannot send the email through the specified SMTP server. Please check your php.ini setting and correct the SMTP server if necessary.</strong></font>');

define('TEXT_CCVAL_ERROR_INVALID_DATE', 'The expiry date entered for the credit card is invalid. Please check the date and try again.');
define('TEXT_CCVAL_ERROR_INVALID_NUMBER', 'The credit card number entered is invalid. Please check the number and try again.');
define('TEXT_CCVAL_ERROR_UNKNOWN_CARD', 'The first four digits of the number entered are: %s. If that number is correct, we do not accept that type of credit card. If it is wrong, please try again.');

define('FOOTER_TEXT_BODY', ' <a href="' . tep_href_link(FILENAME_DEFAULT) . '">' . STORE_NAME . '</a>&nbsp;&nbsp;  &copy; ' . date('Y'));
/* ## add by Seaman ####################################  */
define('ITEM_INFORMATION_PRIVACY', 'Privacy Notice');
define('ITEM_INFORMATION_CONDITIONS', 'Conditions d\'utilisation');
define('ITEM_INFORMATION_SHIPPING', 'Shipping &amp; Returns');
define('IMAGE_BUTTON_DETAILS', 'Details');
define('PRICE', 'Notre prix:&nbsp;&nbsp;');
define('PRICE2', 'Ancient prix:&nbsp;&nbsp;');
define('BACK_TO_TOP', 'Haut de page');
/* ## add by Seaman ####################################  */

/* aboutus */
define('MENU_TITLE_ABOUTUS', 'Qui sommes-nous');
define('HEADING_TITLE_ABOUTUS', 'QUI SOMMES-NOUS');
define('TEXT_INFORMATION_ABOUTUS', 'AVANAH Paris ™ est une marque de produits cosmétiques spécialisées dans les produits à base d\'or " Nano Gold Technology", également connu sous le nom NGT ™. 
<br/><br/>
Tout a été développé afin de proposer une alternative intelligente à la chirurgie esthétique coûteuse et douloureuse. Jugeant qu\'il y avait un besoin important nous a décidé de développer une gamme de produits utilisant les Nano Technologies à base d\'or (NGT ™).
<br/><br/>
Après le lancement réussi du Masque d\'origine 24kt Gold collagène, nous avons créé AVANAH Paris ™.
<br/><br/>
Nos principaux clients sont les professionnels du secteur des salons, spas et professionnels de la beauté. Nous travaillons en étroite collaboration avec eux et portons une attention particulière à leurs suggestions et remarques. 
<br/><br/>
Notre mission est de développer des produits qui aident à améliorer la qualité de nos vies à tous.');

/* DISTRIBUTORS */
define('MENU_TITLE_DISTRIBUTOR', 'Distributeurs');
define('HEADING_TITLE_DISTRIBUTOR', 'Devenir distributeur');
define('TEXT_INFORMATION_DISTRIBUTOR', 'Vous êtes distributeur de produits de beauté et recherchez une gamme de soins du visage pour compléter votre offre?<br/><br/>
 Vous souhaitez distribuer nos produits auprès des instituts de beauté de votre pays?<br/><br/>
Contactez nous à contact@avanah-paris.com, nous vous répondons dans les  48h/72h.<br/><br/>

Nous livrons dans le monde entier :
<table border="1"><tr>
<td>New York (USA)
Black Label
43 Exchange Place
New York, NY 10005
</td><td>
Vancouver (CANADA)
Innovative Therapeutic Technology
2028 Stephens Street
Vancouver, BC
</td><td>
Barcelona (SPAIN)
New Look Muntaner
C/ Muntaner 442
Barcelona, Spain 08006
</td></tr><tr><td>
Rio de Janeiro (BRAZIL)
Hôtel Santa Teresa
Rua Almirante Alexandrino 660
Santa Teresa 20241-260 Rio de Janeiro, RJ, Brazil 
</td><td>
Sicily (ITALY)
Verdura Golf & Spa Resort 
S.S. 115 Km 131 
92019 Sciacca  Sicily Italy
</td><td>
Moscow (RUSSIA)
Barvikha Hotel & Spa
Rublevo-Uspenskoye Shosse, 114/2, Moscow,  143083, Russie
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
define('MENU_TITLE_GOLD', 'Pourquoi L\'or ?');
define('HEADING_TITLE_GOLD', 'Pourquoi L\'or ?');
define('TEXT_INFORMATION_GOLD', 'à travers l\'histoire l\'or a été reconnue pour ses propriétés de luxe et embellir.<br/><br/>
Or colloïdal, aussi connu comme «nano-or», est une suspension de sous-micrométrique des particules d\'or dans un fluide invisible à l\'œil nu. Les qualités miraculeuses de nano-or étaient connus depuis le début des temps par les anciens, qui ont consacré énormément de temps et d\'énergie à l\'alchimie et l\'or colloïdal est connu comme un «élixir de vie."<br/><br/>
Les bénéfices anti-âge d\'or peut être retracée depuis 5000 années jusqu\'à les temps de Cléopâtre, qui a été dit de dormir avec un masque d\'or chaque nuit afin d\'améliorer la souplesse de son teint et de préserver sa luminosité naturelle.<br/><br/>
En la médecine chinoise antique, Or a été une clé pour les jeunes, des reines utilisées rouleaux de massage d\'or sur leur visage tous les jours. les faciaux d\'or ont également été<br/><br/>
utilisés dans la culture indienne ancienne et ont dit à raffermir la peau, lui donnant un éclat et en réduisant les rides. Dans La Rome antique les guerriers serait l\'utilisation des compresses d\'or sur leurs pieds pour accélérer la guérison des blessures reçues au combat.<br/><br/>
Sous l\'influence de l\'or la peau améliore et renforce, retrouve l\'élasticité et la fraîcheur, l\'amélioration de la réponse du corps naturel pour la cicatrisation et la régénération. Alors, pourquoi est l\'or si spécial?<br/><br/>
L\'or est connu pour avoir des propriétés antioxydantes,  il est un anti-inflammatoire et accélère le processus de guérison. Il est hypoallergénique. Une des propriétés les plus importantes de l\'or est qu\'il pénètre le niveau de kératine de la peau, en insérant les ingrédients actifs plus profondément dans le niveau de la peau et leur permettant de travailler plus vite en laissant un effet plus durable.<br/><br/>
Quand l\'or est en contact avec la peau, il stimule la circulation sanguine dans la région, en accélérant les processus cellulaires et en activant la régénération.<br/><br/>
Par ailleurs, l\'or est étroitement liée avec les électrons présents dans les cellules qui sont sensibles aux charges électriques; ces ions devient actif sous l\'influence de l\'oret les aider à recréer interrompre les connexions cellulaires. L\'or est bien réputé pour restaurer les propriétés d\'élasticité des tissus perdus. Or réduit également l\'apparition de dommages du soleil et les taches de vieillesse en ralentissant la sécrétion de mélanine.
Il est vraiment l\'un de l\'émerveillement de la nature et votre peau, il le mérite.');

/****contactus*******/
define('CONTACTUS_INTRO','Si vous souhaitez acheter ou distribuer nos produits, merci de nous envoyer un email à contact@avanah-paris.com ou remplir le formulaire ci-dessous : ');
?>