# $Id$
#
# osCommerce, Open Source E-Commerce Solutions
# http://www.oscommerce.com
#
# Copyright (c) 2008 osCommerce
#
# Released under the GNU General Public License
#
# NOTE: * Please make any modifications to this file by hand!
#       * DO NOT use a mysqldump created file for new changes!
#       * Please take note of the table structure, and use this
#         structure as a standard for future modifications!
#       * Any tables you add here should be added in admin/backup.php
#         and in catalog/install/includes/functions/database.php
#       * To see the 'diff'erence between MySQL databases, use
#         the mysqldiff perl script located in the extras
#         directory of the 'catalog' module.
#       * Comments should be like these, full line comments.
#         (don't use inline comments)

DROP TABLE IF EXISTS action_recorder;
CREATE TABLE action_recorder (
  id int NOT NULL auto_increment,
  module varchar(255) NOT NULL,
  user_id int,
  user_name varchar(255),
  identifier varchar(255) NOT NULL,
  success char(1),
  date_added datetime NOT NULL,
  PRIMARY KEY (id),
  KEY idx_action_recorder_module (module),
  KEY idx_action_recorder_user_id (user_id),
  KEY idx_action_recorder_identifier (identifier),
  KEY idx_action_recorder_date_added (date_added)
);

DROP TABLE IF EXISTS address_book;
CREATE TABLE address_book (
   address_book_id int NOT NULL auto_increment,
   customers_id int NOT NULL,
   entry_gender char(1),
   entry_company varchar(255),
   entry_firstname varchar(255) NOT NULL,
   entry_lastname varchar(255) NOT NULL,
   entry_street_address varchar(255) NOT NULL,
   entry_suburb varchar(255),
   entry_postcode varchar(255) NOT NULL,
   entry_city varchar(255) NOT NULL,
   entry_state varchar(255),
   entry_country_id int DEFAULT '0' NOT NULL,
   entry_zone_id int DEFAULT '0' NOT NULL,
   PRIMARY KEY (address_book_id),
   KEY idx_address_book_customers_id (customers_id)
);

DROP TABLE IF EXISTS address_format;
CREATE TABLE address_format (
  address_format_id int NOT NULL auto_increment,
  address_format varchar(128) NOT NULL,
  address_summary varchar(48) NOT NULL,
  PRIMARY KEY (address_format_id)
);

DROP TABLE IF EXISTS administrators;
CREATE TABLE administrators (
  id int NOT NULL auto_increment,
  user_name varchar(255) binary NOT NULL,
  user_password varchar(60) NOT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS banners;
CREATE TABLE banners (
  banners_id int NOT NULL auto_increment,
  banners_title varchar(64) NOT NULL,
  banners_url varchar(255) NOT NULL,
  banners_image varchar(64) NOT NULL,
  banners_group varchar(255) NOT NULL,
  banners_html_text text,
  expires_impressions int(7) DEFAULT '0',
  expires_date datetime DEFAULT NULL,
  date_scheduled datetime DEFAULT NULL,
  date_added datetime NOT NULL,
  date_status_change datetime DEFAULT NULL,
  status int(1) DEFAULT '1' NOT NULL,
  PRIMARY KEY (banners_id),
  KEY idx_banners_group (banners_group)
);

DROP TABLE IF EXISTS banners_history;
CREATE TABLE banners_history (
  banners_history_id int NOT NULL auto_increment,
  banners_id int NOT NULL,
  banners_shown int(5) NOT NULL DEFAULT '0',
  banners_clicked int(5) NOT NULL DEFAULT '0',
  banners_history_date datetime NOT NULL,
  PRIMARY KEY (banners_history_id),
  KEY idx_banners_history_banners_id (banners_id)
);

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
   categories_id int NOT NULL auto_increment,
   categories_image varchar(64),
   parent_id int DEFAULT '0' NOT NULL,
   sort_order int(3),
   date_added datetime,
   last_modified datetime,
   PRIMARY KEY (categories_id),
   KEY idx_categories_parent_id (parent_id)
);

DROP TABLE IF EXISTS categories_description;
CREATE TABLE categories_description (
   categories_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   categories_name varchar(255) NOT NULL,
   PRIMARY KEY (categories_id, language_id),
   KEY idx_categories_name (categories_name)
);

DROP TABLE IF EXISTS configuration;
CREATE TABLE configuration (
  configuration_id int NOT NULL auto_increment,
  configuration_title varchar(255) NOT NULL,
  configuration_key varchar(255) NOT NULL,
  configuration_value text NOT NULL,
  configuration_description varchar(255) NOT NULL,
  configuration_group_id int NOT NULL,
  sort_order int(5) NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  use_function varchar(255) NULL,
  set_function varchar(255) NULL,
  PRIMARY KEY (configuration_id)
);

DROP TABLE IF EXISTS configuration_group;
CREATE TABLE configuration_group (
  configuration_group_id int NOT NULL auto_increment,
  configuration_group_title varchar(64) NOT NULL,
  configuration_group_description varchar(255) NOT NULL,
  sort_order int(5) NULL,
  visible int(1) DEFAULT '1' NULL,
  PRIMARY KEY (configuration_group_id)
);

DROP TABLE IF EXISTS counter;
CREATE TABLE counter (
  startdate char(8),
  counter int(12)
);

DROP TABLE IF EXISTS counter_history;
CREATE TABLE counter_history (
  month char(8),
  counter int(12)
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  countries_id int NOT NULL auto_increment,
  countries_name varchar(255) NOT NULL,
  countries_iso_code_2 char(2) NOT NULL,
  countries_iso_code_3 char(3) NOT NULL,
  address_format_id int NOT NULL,
  PRIMARY KEY (countries_id),
  KEY IDX_COUNTRIES_NAME (countries_name)
);

DROP TABLE IF EXISTS currencies;
CREATE TABLE currencies (
  currencies_id int NOT NULL auto_increment,
  title varchar(32) NOT NULL,
  code char(3) NOT NULL,
  symbol_left varchar(12),
  symbol_right varchar(12),
  decimal_point char(1),
  thousands_point char(1),
  decimal_places char(1),
  value float(13,8),
  last_updated datetime NULL,
  PRIMARY KEY (currencies_id),
  KEY idx_currencies_code (code)
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
   customers_id int NOT NULL auto_increment,
   customers_gender char(1),
   customers_firstname varchar(255) NOT NULL,
   customers_lastname varchar(255) NOT NULL,
   customers_dob datetime DEFAULT '0000-00-00 00:00:00' NOT NULL,
   customers_email_address varchar(255) NOT NULL,
   customers_default_address_id int,
   customers_telephone varchar(255) NOT NULL,
   customers_fax varchar(255),
   customers_password varchar(60) NOT NULL,
   customers_newsletter char(1),
   PRIMARY KEY (customers_id),
   KEY idx_customers_email_address (customers_email_address)
);

DROP TABLE IF EXISTS customers_basket;
CREATE TABLE customers_basket (
  customers_basket_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  products_id tinytext NOT NULL,
  customers_basket_quantity int(2) NOT NULL,
  final_price decimal(15,4),
  customers_basket_date_added char(8),
  PRIMARY KEY (customers_basket_id),
  KEY idx_customers_basket_customers_id (customers_id)
);

DROP TABLE IF EXISTS customers_basket_attributes;
CREATE TABLE customers_basket_attributes (
  customers_basket_attributes_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  products_id tinytext NOT NULL,
  products_options_id int NOT NULL,
  products_options_value_id int NOT NULL,
  PRIMARY KEY (customers_basket_attributes_id),
  KEY idx_customers_basket_att_customers_id (customers_id)
);

DROP TABLE IF EXISTS customers_info;
CREATE TABLE customers_info (
  customers_info_id int NOT NULL,
  customers_info_date_of_last_logon datetime,
  customers_info_number_of_logons int(5),
  customers_info_date_account_created datetime,
  customers_info_date_account_last_modified datetime,
  global_product_notifications int(1) DEFAULT '0',
  PRIMARY KEY (customers_info_id)
);

DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
  languages_id int NOT NULL auto_increment,
  name varchar(32)  NOT NULL,
  code char(2) NOT NULL,
  image varchar(64),
  directory varchar(32),
  sort_order int(3),
  PRIMARY KEY (languages_id),
  KEY IDX_LANGUAGES_NAME (name)
);


DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
  manufacturers_id int NOT NULL auto_increment,
  manufacturers_name varchar(32) NOT NULL,
  manufacturers_image varchar(64),
  date_added datetime NULL,
  last_modified datetime NULL,
  PRIMARY KEY (manufacturers_id),
  KEY IDX_MANUFACTURERS_NAME (manufacturers_name)
);

DROP TABLE IF EXISTS manufacturers_info;
CREATE TABLE manufacturers_info (
  manufacturers_id int NOT NULL,
  languages_id int NOT NULL,
  manufacturers_url varchar(255) NOT NULL,
  url_clicked int(5) NOT NULL default '0',
  date_last_click datetime NULL,
  PRIMARY KEY (manufacturers_id, languages_id)
);

DROP TABLE IF EXISTS newsletters;
CREATE TABLE newsletters (
  newsletters_id int NOT NULL auto_increment,
  title varchar(255) NOT NULL,
  content text NOT NULL,
  module varchar(255) NOT NULL,
  date_added datetime NOT NULL,
  date_sent datetime,
  status int(1),
  locked int(1) DEFAULT '0',
  PRIMARY KEY (newsletters_id)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  orders_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  customers_name varchar(255) NOT NULL,
  customers_company varchar(255),
  customers_street_address varchar(255) NOT NULL,
  customers_suburb varchar(255),
  customers_city varchar(255) NOT NULL,
  customers_postcode varchar(255) NOT NULL,
  customers_state varchar(255),
  customers_country varchar(255) NOT NULL,
  customers_telephone varchar(255) NOT NULL,
  customers_email_address varchar(255) NOT NULL,
  customers_address_format_id int(5) NOT NULL,
  delivery_name varchar(255) NOT NULL,
  delivery_company varchar(255),
  delivery_street_address varchar(255) NOT NULL,
  delivery_suburb varchar(255),
  delivery_city varchar(255) NOT NULL,
  delivery_postcode varchar(255) NOT NULL,
  delivery_state varchar(255),
  delivery_country varchar(255) NOT NULL,
  delivery_address_format_id int(5) NOT NULL,
  billing_name varchar(255) NOT NULL,
  billing_company varchar(255),
  billing_street_address varchar(255) NOT NULL,
  billing_suburb varchar(255),
  billing_city varchar(255) NOT NULL,
  billing_postcode varchar(255) NOT NULL,
  billing_state varchar(255),
  billing_country varchar(255) NOT NULL,
  billing_address_format_id int(5) NOT NULL,
  payment_method varchar(255) NOT NULL,
  cc_type varchar(20),
  cc_owner varchar(255),
  cc_number varchar(32),
  cc_expires varchar(4),
  last_modified datetime,
  date_purchased datetime,
  orders_status int(5) NOT NULL,
  orders_date_finished datetime,
  currency char(3),
  currency_value decimal(14,6),
  PRIMARY KEY (orders_id),
  KEY idx_orders_customers_id (customers_id)
);

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  orders_products_id int NOT NULL auto_increment,
  orders_id int NOT NULL,
  products_id int NOT NULL,
  products_model varchar(12),
  products_name varchar(64) NOT NULL,
  products_price decimal(15,4) NOT NULL,
  final_price decimal(15,4) NOT NULL,
  products_tax decimal(7,4) NOT NULL,
  products_quantity int(2) NOT NULL,
  PRIMARY KEY (orders_products_id),
  KEY idx_orders_products_orders_id (orders_id),
  KEY idx_orders_products_products_id (products_id)
);

DROP TABLE IF EXISTS orders_status;
CREATE TABLE orders_status (
   orders_status_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   orders_status_name varchar(32) NOT NULL,
   public_flag int DEFAULT '1',
   downloads_flag int DEFAULT '0',
   PRIMARY KEY (orders_status_id, language_id),
   KEY idx_orders_status_name (orders_status_name)
);

DROP TABLE IF EXISTS orders_status_history;
CREATE TABLE orders_status_history (
   orders_status_history_id int NOT NULL auto_increment,
   orders_id int NOT NULL,
   orders_status_id int(5) NOT NULL,
   date_added datetime NOT NULL,
   customer_notified int(1) DEFAULT '0',
   comments text,
   PRIMARY KEY (orders_status_history_id),
   KEY idx_orders_status_history_orders_id (orders_id)
);

DROP TABLE IF EXISTS orders_products_attributes;
CREATE TABLE orders_products_attributes (
  orders_products_attributes_id int NOT NULL auto_increment,
  orders_id int NOT NULL,
  orders_products_id int NOT NULL,
  products_options varchar(32) NOT NULL,
  products_options_values varchar(32) NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY (orders_products_attributes_id),
  KEY idx_orders_products_att_orders_id (orders_id)
);

DROP TABLE IF EXISTS orders_products_download;
CREATE TABLE orders_products_download (
  orders_products_download_id int NOT NULL auto_increment,
  orders_id int NOT NULL default '0',
  orders_products_id int NOT NULL default '0',
  orders_products_filename varchar(255) NOT NULL default '',
  download_maxdays int(2) NOT NULL default '0',
  download_count int(2) NOT NULL default '0',
  PRIMARY KEY  (orders_products_download_id),
  KEY idx_orders_products_download_orders_id (orders_id)
);

DROP TABLE IF EXISTS orders_total;
CREATE TABLE orders_total (
  orders_total_id int unsigned NOT NULL auto_increment,
  orders_id int NOT NULL,
  title varchar(255) NOT NULL,
  text varchar(255) NOT NULL,
  value decimal(15,4) NOT NULL,
  class varchar(32) NOT NULL,
  sort_order int NOT NULL,
  PRIMARY KEY (orders_total_id),
  KEY idx_orders_total_orders_id (orders_id)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  products_id int NOT NULL auto_increment,
  products_quantity int(4) NOT NULL,
  products_model varchar(12),
  products_image varchar(256),
  products_price decimal(15,4) NOT NULL,
  products_date_added datetime NOT NULL,
  products_last_modified datetime,
  products_date_available datetime,
  products_weight decimal(5,2) NOT NULL,
  products_status tinyint(1) NOT NULL,
  products_tax_class_id int NOT NULL,
  manufacturers_id int NULL,
  products_ordered int NOT NULL default '0',
  PRIMARY KEY (products_id),
  KEY idx_products_model (products_model),
  KEY idx_products_date_added (products_date_added)
);

DROP TABLE IF EXISTS products_attributes;
CREATE TABLE products_attributes (
  products_attributes_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  options_id int NOT NULL,
  options_values_id int NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY (products_attributes_id),
  KEY idx_products_attributes_products_id (products_id)
);

DROP TABLE IF EXISTS products_attributes_download;
CREATE TABLE products_attributes_download (
  products_attributes_id int NOT NULL,
  products_attributes_filename varchar(255) NOT NULL default '',
  products_attributes_maxdays int(2) default '0',
  products_attributes_maxcount int(2) default '0',
  PRIMARY KEY  (products_attributes_id)
);

DROP TABLE IF EXISTS products_description;
CREATE TABLE products_description (
  products_id int NOT NULL auto_increment,
  language_id int NOT NULL default '1',
  products_name varchar(255) NOT NULL default '',
  products_description text,
  products_url varchar(255) default NULL,
  products_viewed int(5) default '0',
  PRIMARY KEY  (products_id,language_id),
  KEY products_name (products_name)
);

DROP TABLE IF EXISTS products_images;
CREATE TABLE products_images (
  id int NOT NULL auto_increment,
  products_id int NOT NULL,
  image varchar(256),
  htmlcontent text,
  sort_order int NOT NULL,
  PRIMARY KEY (id),
  KEY products_images_prodid (products_id)
);

DROP TABLE IF EXISTS products_notifications;
CREATE TABLE products_notifications (
  products_id int NOT NULL,
  customers_id int NOT NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (products_id, customers_id)
);

DROP TABLE IF EXISTS products_options;
CREATE TABLE products_options (
  products_options_id int NOT NULL default '0',
  language_id int NOT NULL default '1',
  products_options_name varchar(32) NOT NULL default '',
  PRIMARY KEY  (products_options_id,language_id)
);

DROP TABLE IF EXISTS products_options_values;
CREATE TABLE products_options_values (
  products_options_values_id int NOT NULL default '0',
  language_id int NOT NULL default '1',
  products_options_values_name varchar(64) NOT NULL default '',
  PRIMARY KEY  (products_options_values_id,language_id)
);

DROP TABLE IF EXISTS products_options_values_to_products_options;
CREATE TABLE products_options_values_to_products_options (
  products_options_values_to_products_options_id int NOT NULL auto_increment,
  products_options_id int NOT NULL,
  products_options_values_id int NOT NULL,
  PRIMARY KEY (products_options_values_to_products_options_id)
);

DROP TABLE IF EXISTS products_to_categories;
CREATE TABLE products_to_categories (
  products_id int NOT NULL,
  categories_id int NOT NULL,
  PRIMARY KEY (products_id,categories_id)
);

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  reviews_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  customers_id int,
  customers_name varchar(255) NOT NULL,
  reviews_rating int(1),
  date_added datetime,
  last_modified datetime,
  reviews_status tinyint(1) NOT NULL default '0',
  reviews_read int(5) NOT NULL default '0',
  PRIMARY KEY (reviews_id),
  KEY idx_reviews_products_id (products_id),
  KEY idx_reviews_customers_id (customers_id)
);

DROP TABLE IF EXISTS reviews_description;
CREATE TABLE reviews_description (
  reviews_id int NOT NULL,
  languages_id int NOT NULL,
  reviews_text text NOT NULL,
  PRIMARY KEY (reviews_id, languages_id)
);

DROP TABLE IF EXISTS sec_directory_whitelist;
CREATE TABLE sec_directory_whitelist (
  id int NOT NULL auto_increment,
  directory varchar(255) NOT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  sesskey varchar(32) NOT NULL,
  expiry int(11) unsigned NOT NULL,
  value text NOT NULL,
  PRIMARY KEY (sesskey)
);

DROP TABLE IF EXISTS specials;
CREATE TABLE specials (
  specials_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  specials_new_products_price decimal(15,4) NOT NULL,
  specials_date_added datetime,
  specials_last_modified datetime,
  expires_date datetime,
  date_status_change datetime,
  status int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (specials_id),
  KEY idx_specials_products_id (products_id)
);

DROP TABLE IF EXISTS tax_class;
CREATE TABLE tax_class (
  tax_class_id int NOT NULL auto_increment,
  tax_class_title varchar(32) NOT NULL,
  tax_class_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (tax_class_id)
);

DROP TABLE IF EXISTS tax_rates;
CREATE TABLE tax_rates (
  tax_rates_id int NOT NULL auto_increment,
  tax_zone_id int NOT NULL,
  tax_class_id int NOT NULL,
  tax_priority int(5) DEFAULT 1,
  tax_rate decimal(7,4) NOT NULL,
  tax_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (tax_rates_id)
);

DROP TABLE IF EXISTS geo_zones;
CREATE TABLE geo_zones (
  geo_zone_id int NOT NULL auto_increment,
  geo_zone_name varchar(32) NOT NULL,
  geo_zone_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (geo_zone_id)
);

DROP TABLE IF EXISTS whos_online;
CREATE TABLE whos_online (
  customer_id int,
  full_name varchar(255) NOT NULL,
  session_id varchar(128) NOT NULL,
  ip_address varchar(15) NOT NULL,
  time_entry varchar(14) NOT NULL,
  time_last_click varchar(14) NOT NULL,
  last_page_url text NOT NULL
);

DROP TABLE IF EXISTS zones;
CREATE TABLE zones (
  zone_id int NOT NULL auto_increment,
  zone_country_id int NOT NULL,
  zone_code varchar(32) NOT NULL,
  zone_name varchar(255) NOT NULL,
  PRIMARY KEY (zone_id),
  KEY idx_zones_country_id (zone_country_id)
);

DROP TABLE IF EXISTS zones_to_geo_zones;
CREATE TABLE zones_to_geo_zones (
   association_id int NOT NULL auto_increment,
   zone_country_id int NOT NULL,
   zone_id int NULL,
   geo_zone_id int NULL,
   last_modified datetime NULL,
   date_added datetime NOT NULL,
   PRIMARY KEY (association_id),
   KEY idx_zones_to_geo_zones_country_id (zone_country_id)
);
################################################
# data
# 1 - Default, 2 - USA, 3 - Spain, 4 - Singapore, 5 - Germany
INSERT INTO address_format VALUES (1, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country','$city / $country');
INSERT INTO address_format VALUES (2, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country','$city, $state / $country');
INSERT INTO address_format VALUES (3, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country','$state / $country');
INSERT INTO address_format VALUES (4, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO address_format VALUES (5, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country','$city / $country');
################################################
#
INSERT INTO banners VALUES (21, 'Banner1 for Banner Set', 'product_info.php?products_id=3', 'banners/banner_02_1.jpg', 'banner-group-1', '', 0, null, null, now(), null, 1);
#INSERT INTO banners VALUES (22, 'Banner2 for Banner Set', 'product_info.php?products_id=7', 'banners/banner_02_2.jpg', 'banner-group-1', '', 0, null, null, now(), null, 1);
#
INSERT INTO banners VALUES (31, 'Banner3 for Banner Set', 'product_info.php?products_id=12', 'banners/banner_03_1.jpg', 'banner-group-2', '', 0, null, null, now(), null, 1);
#INSERT INTO banners VALUES (32, 'Banner4 for Banner Set', 'product_info.php?products_id=10', 'banners/banner_03_2.jpg', 'banner-group-2', '', 0, null, null, now(), null, 1);
#
INSERT INTO banners VALUES (41, 'Banner5 for Banner Set', 'product_info.php?products_id=14', 'banners/banner_04_1.jpg', 'banner-group-3', '', 0, null, null, now(), null, 1);
#INSERT INTO banners VALUES (42, 'Banner6 for Banner Set', 'product_info.php?products_id=11', 'banners/banner_04_2.jpg', 'banner-group-3', '', 0, null, null, now(), null, 1);
#
INSERT INTO banners VALUES (51, 'Banner7 for Banner Set', 'product_info.php?products_id=19', 'banners/banner_05_1.jpg', 'banner-group-4', '', 0, null, null, now(), null, 1);
#INSERT INTO banners VALUES (52, 'Banner8 for Banner Set', 'product_info.php?products_id=31', 'banners/banner_05_2.jpg', 'banner-group-4', '', 0, null, null, now(), null, 1);
#
INSERT INTO banners VALUES (61, 'Banner9 for Banner Column', 'product_info.php?products_id=15', 'banners/banner_06_1.jpg', 'banner-group-5', '', 0, null, null, now(), null, 1);
INSERT INTO banners VALUES (62, 'Banner10 for Banner Column', 'product_info.php?products_id=17', 'banners/banner_06_2.jpg', 'banner-group-5', '', 0, null, null, now(), null, 1);
#
INSERT INTO banners VALUES (100, 'osCommerce', 'http://www.oscommerce.com', 'banners/oscommerce.gif', '468x50', '', 0, null, null, now(), null, 0);
################################################
#
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Banner group 1', 'BANNER_SET_GROUP_1', 'banner-group-1', 'Group of Banners Set for banner-group-1', '17', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Banner group 2', 'BANNER_SET_GROUP_2', 'banner-group-2', 'Group of Banners Set for banner-group-2', '17', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Banner group 3', 'BANNER_SET_GROUP_3', 'banner-group-3', 'Group of Banners Set for banner-group-3', '17', '0', now());
#
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Banner group 4', 'BANNER_SET_GROUP_4', 'banner-group-4', 'Group of Banners Set for banner-group-4', '17', '0', now());
#
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Banner group 5', 'BANNER_GROUP_5', 'banner-group-5', 'Group of Banners Set for banner-group-5', '17', '0', now());
################################################
INSERT INTO categories VALUES ('1', NULL, '0', '1', NULL, NULL);
INSERT INTO categories VALUES ('2', NULL, '0', '2', NULL, NULL);
INSERT INTO categories VALUES ('3', NULL, '0', '3', NULL, NULL);
INSERT INTO categories VALUES ('4', NULL, '0', '4', NULL, NULL);
INSERT INTO categories VALUES ('5', NULL, '0', '5', NULL, NULL);
INSERT INTO categories VALUES ('6', NULL, '0', '6', NULL, NULL);
INSERT INTO categories VALUES ('7', NULL, '0', '7', NULL, NULL);
INSERT INTO categories VALUES ('8', NULL, '0', '8', NULL, NULL);
INSERT INTO categories VALUES ('9', NULL, '0', '9', NULL, NULL);
INSERT INTO categories VALUES ('10', NULL, '0', '10', NULL, NULL);
########################
INSERT INTO categories VALUES ('11', 'products/sub_1.png', '18', '11', NULL, NULL);
INSERT INTO categories VALUES ('12', 'products/sub_2.png', '18', '12', NULL, NULL);
INSERT INTO categories VALUES ('13', 'products/sub_3.png', '18', '13', NULL, NULL);
INSERT INTO categories VALUES ('14', 'products/sub_4.png', '2', '14', NULL, NULL);
INSERT INTO categories VALUES ('15', 'products/sub_5.png', '2', '15', NULL, NULL);
INSERT INTO categories VALUES ('16', 'products/sub_6.png', '18', '16', NULL, NULL);
INSERT INTO categories VALUES ('17', 'products/sub_7.png', '18', '17', NULL, NULL);
INSERT INTO categories VALUES ('18', 'products/sub_8.png', '2', '18', NULL, NULL);
INSERT INTO categories VALUES ('19', 'products/sub_9.png', '2', '19', NULL, NULL);
INSERT INTO categories VALUES ('20', 'products/sub_10.png', '18', '20', NULL, NULL);
INSERT INTO categories VALUES ('21', 'products/sub_11.png', '18', '21', NULL, NULL);
INSERT INTO categories VALUES ('22', 'products/sub_12.png', '18', '22', NULL, NULL);
INSERT INTO categories VALUES ('23', 'products/sub_13.png', '2', '23', NULL, NULL);
################################################
################################################
INSERT INTO categories_description VALUES ( '1', '1', 'Alexander McQueen');
INSERT INTO categories_description VALUES ( '2', '1', 'Alyssa Ashley');
INSERT INTO categories_description VALUES ( '3', '1', 'Andy Roddick');
INSERT INTO categories_description VALUES ( '4', '1', 'Azzaro');
INSERT INTO categories_description VALUES ( '5', '1', 'Benetton');
INSERT INTO categories_description VALUES ( '6', '1', 'Cacharel');
INSERT INTO categories_description VALUES ( '7', '1', 'Dana');
INSERT INTO categories_description VALUES ( '8', '1', 'Elizabeth Arden');
INSERT INTO categories_description VALUES ( '9', '1', 'Ghost');
INSERT INTO categories_description VALUES ( '10', '1', 'Harajuku Lovers');
########################
INSERT INTO categories_description VALUES ( '11', '1', 'Justo elementum');
INSERT INTO categories_description VALUES ( '12', '1', 'Accumsan quisque ');
INSERT INTO categories_description VALUES ( '13', '1', 'Nisi convallis');
INSERT INTO categories_description VALUES ( '14', '1', 'Risus a vestibulum');
INSERT INTO categories_description VALUES ( '15', '1', 'Auisque proin');
INSERT INTO categories_description VALUES ( '16', '1', 'Lacus ultrices');
########################
INSERT INTO categories_description VALUES ( '17', '1', 'Sed varius');
INSERT INTO categories_description VALUES ( '18', '1', 'Morbi nisl sem');
INSERT INTO categories_description VALUES ( '19', '1', 'Vestibulum a risus');
INSERT INTO categories_description VALUES ( '20', '1', 'Varius sed');
INSERT INTO categories_description VALUES ( '21', '1', 'Proin auisque');
INSERT INTO categories_description VALUES ( '22', '1', 'Convallis nisi');
INSERT INTO categories_description VALUES ( '23', '1', 'Elementum justo');
################################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Name', 'STORE_NAME', 'Perfume', 'The name of my store', '1', '1', now());
## add by Seaman ##############################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Width of the block of a product</b>', 'PRODS_BLOCK_WIDTH', '220', 'The pixel width of the block of a product', '3', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">New Products Module on first page</b>', 'MAX_DISPLAY_PRODUCTS_FIRST_PAGE', '6', 'How many products display in first page', '3', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '6', 'Maximum number of New Products to display in a category', '3', '3', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '6', 'Amount of products to list', '3', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '6', 'Maximum number of new products to display in new products page', '3', '11', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '6', 'Maximum number of products on special to display', '3', '14', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the \'This Customer Also Purchased\' box', '3', '19', now());
## add by Seaman ##############################################
## add by Seaman ##############################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">New Products Module To List Per Row on First Page</b>', 'MAX_DISPLAY_NEW_PRODUCTS_PER_ROW_FIRST_PAGE', '3', 'How many New Products Module to list per row on first page', '3', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">New Products Module To List Per Row</b>', 'MAX_DISPLAY_NEW_PRODUCTS_PER_ROW', '3', 'How many New Products Module to list per row', '3', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Search Results To List Per Row</b>', 'MAX_DISPLAY_SEARCH_RESULTS_PER_ROW', '3', 'How many Search Results to list per row', '3', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Special Products To List Per Row</b>', 'MAX_DISPLAY_SPECIAL_PER_ROW', '3', 'How many Special Products to list per row', '3', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Also Purchased To List Per Row</b>', 'MAX_DISPLAY_ALSO_PURCHASED_PRODUCTS_PER_ROW', '3', 'How many Also Purchased to list per row', '3', '20', now());
## add by Seaman ##############################################
## add by Seaman ##############################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">New Products Module Length of Description</b>', 'MAX_DESCR_MODUL_NEW_PRODS', '30', 'Length of Description  in a New Products Module', '3', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Search Results Length of Description</b>', 'MAX_DESCR_LISTING', '50', 'Length of Description  in a Search Results', '3', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">New Products Listing Length of Description</b>', 'MAX_DESCR_PRODS_NEW', '250', 'Length of Description  in a New Products Listing', '3', '12', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Special Products Length of Description</b>', 'MAX_DESCR_SPECIALS', '50', 'Length of Description  in a Special Products', '3', '16', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Side Box Length of Description</b>', 'MAX_DESCR_BOX', '40', 'Length of Description  in a Side Box', '3', '35', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Bestsellers Length of Description</b>', 'MAX_DESCR_BESTSELLERS', '60', 'Length of Description  in a Bestsellers', '3', '36', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Bestsellers Length of Description in Slider</b>', 'MAX_DESCR_BESTSELLERS_UNDER_HEADER', '60', 'Length of Description  in a Slider Bestsellers', '3', '28', now());
## add by Seaman ##############################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Small Image Width', 'SMALL_IMAGE_WIDTH', '191', 'The pixel width of small images', '4', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Small Image Height', 'SMALL_IMAGE_HEIGHT', '172', 'The pixel height of small images', '4', '4', now());
## add by Seaman ##############################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Box Image Width</b>', 'BOX_IMAGE_WIDTH', '191', 'The pixel width of heading images', '4', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Box Image Height</b>', 'BOX_IMAGE_HEIGHT', '172', 'The pixel height of heading images', '4', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Subcategory Image Width</b>', 'SUBCATEGORY_IMAGE_WIDTH', '124', 'The pixel width of subcategory images', '4', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Subcategory Image Height</b>', 'SUBCATEGORY_IMAGE_HEIGHT', '124', 'The pixel height of subcategory images', '4', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Shopping Cart Image Width</b>', 'CART_IMAGE_WIDTH', '191', 'The pixel width of shopping cart images', '4', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Shopping Cart Image Height</b>', 'CART_IMAGE_HEIGHT', '172', 'The pixel height of shopping cart images', '4', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Product Info Image Width</b>', 'PROD_INFO_IMAGE_WIDTH', '220', 'The pixel width of product info images', '4', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Product Info Image Height</b>', 'PROD_INFO_IMAGE_HEIGHT', '198', 'The pixel height of product info images', '4', '12', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Image Category in Title Width</b>', 'HEADING_IMAGE_WIDTH', '44', 'The pixel width of heading images', '4', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Image Category in Title Height</b>', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', '4', '16', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('<b class="add-by-seaman">Show Image Category in Title</b>', 'TITLE_PIC', 'true', 'true - Show Image Category in Title</br>false - Hidden Image Category in Title', '4', '14', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
## add by Seaman ##############################################
## add by Seaman ##############################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('<b class="add-by-seaman">Effect</b>', 'EASING_JCAROUSELLITE', 'easeInOutElastic', 'You can specify any easing effect', '16', '1', 'tep_cfg_select_option(array(\'linear\', \'swing\', \'easeInQuad\', \'easeOutQuad\', \'easeInOutQuad\', \'easeInCubic\', \'easeOutCubic\', \'easeInOutCubic\', \'easeInQuart\', \'easeOutQuart\', \'easeInOutQuart\', \'easeInQuint\', \'easeOutQuint\', \'easeInOutQuint\', \'easeInSine\', \'easeOutSine\', \'easeInOutSine\', \'easeInExpo\', \'easeOutExpo\', \'easeInOutExpo\', \'easeInCirc\', \'easeOutCirc\', \'easeInOutCirc\', \'easeInElastic\', \'easeOutElastic\', \'easeInOutElastic\', \'easeInBack\', \'easeOutBack\', \'easeInOutBack\', \'easeInBounce\', \'easeOutBounce\', \'easeInOutBounce\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Speed</b>', 'SPEED_JCAROUSELLITE', '1000', 'Specifying a speed will slow-down or speed-up the sliding speed of your carousel. Try it out with different speeds like 800, 600, 1500 etc. Providing 0, will remove the slide effect.', '16', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Auto</b>', 'AUTO_JCAROUSELLITE', '7000', 'As of version 0.4.0, the carousel can auto-scroll as well. This is enabled by specifying a millisecond value to this option. The value you specify is the amount of time between 2 consecutive slides. The default is null, and that disables auto-scrolling. Specify this value and watch your carousel magically scroll.', '16', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Scroll</b>', 'SCROLL_JCAROUSELLITE', '1', 'As of version 0.4.0, you can specify the number of items to scroll when you click the next or prev buttons. Ofcourse, this applies to the mouse-wheel and auto-scroll as well. For example, scroll:2 will scroll 2 items at a time. ', '16', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Visible</b>', 'VISIBLE_JCAROUSELLITE', '9.4', 'This specifies the number of items visible at all times within the carousel. The default is 9. You are even free to experiment with real numbers. Eg: "9.5" will have 9 items fully visible and the last item half visible. This gives you the effect of showing the user that there are more images to the right.', '16', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('<b class="add-by-seaman">MouseWheel</b>', 'MOUSEWHEEL_JCAROUSELLITE', 'false', 'As of version 0.4.0, the navigation buttons are no more needed to enjoy the carousel. The mouse-wheel itself can be used for navigation. To achieve this, 2 things should be done. First, include the mousewheel plugin (checkout the installation section). Second, set "true" for this option. That\'s it, now you will be able to navigate your carousel using the mouse wheel. Using buttons and mouse-wheel are not mutually exclusive. You can still have buttons for navigation as well. They complement each other. To use both together, just supply the btnNext/btnPrev options. ', '16', '6', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('<b class="add-by-seaman">Circular</b>', 'CIRCULAR_JCAROUSELLITE', 'true', 'Setting it to true enables circular navigation. This means, if you click "next" after you reach the last element, you will automatically slide to the first element and vice versa. If you set circular to false, then if you click on the "next" button after you reach the last element, you will stay in the last element itself and similarly for "previous" button and first element.', '16', '7', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">PrevText</b>', 'PREV_JCAROUSELLITE', 'prev', 'Selector for the "Previous" button. The navigation buttons - both prev and next - need not be as part of the carousel "div" itself, but it can be if you want it to. Where ever you decide to place those buttons in the HTML structure, an appropriate jQuery selector for the "previous" button should be provided as the value for this option.', '16', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">NextText</b>', 'NEXT_JCAROUSELLITE', 'next', 'Selector for the "Previous" button. The navigation buttons - both prev and next - need not be as part of the carousel "div" itself, but it can be if you want it to. Where ever you decide to place those buttons in the HTML structure, an appropriate jQuery selector for the "previous" button should be provided as the value for this option.', '16', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Best Sellers items</b>', 'MAX_DISPLAY_BESTSELLERS_SLIDER', '18', 'Maximum number of best sellers to display in carousel', '16', '14', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('<b class="add-by-seaman">Count of Rows</b>', 'ROW_COUNT', '1', 'Quantity of rows of a Carousel', '16', '13', 'tep_cfg_select_option(array(\'2\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Carousel Image Width<b>', 'BESTSELLERS_IMAGE_WIDTH', '228', 'The pixel width of Carousel images', '16', '14', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Carousel Image Height<b>', 'BESTSELLERS_IMAGE_HEIGHT', '206', 'The pixel height of Carousel images', '16', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Bestsellers Length of Description</b>', 'MAX_DESCR_BESTSELLERS', '60', 'Length of Description  in a Bestsellers', '16', '16', now());
## add by Seaman ##############################################
## add by Seaman ##############################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Search Results at admin pages</b>', 'MAX_DISPLAY_SEARCH_RESULTS_ADMIN', '50', 'Display search results at admin pages', '3', '37', now());
## add by Seaman ##############################################
################################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Owner', 'STORE_OWNER', 'Harald Ponce de Leon', 'The name of my store owner', '1', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'root@localhost', 'The e-mail address of my store owner', '1', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail From', 'EMAIL_FROM', 'osCommerce <root@localhost>', 'The e-mail address used in (sent) e-mails', '1', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country', 'STORE_COUNTRY', '223', 'The country my store is located in <br /><br /><strong>Note: Please remember to update the store zone.</strong>', '1', '6', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Zone', 'STORE_ZONE', '18', 'The zone my store is located in', '1', '7', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', '1', '8', 'tep_cfg_select_option(array(\'asc\', \'desc\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', '1', '9', 'tep_cfg_select_option(array(\'products_name\', \'date_expected\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language\'s currency when it is changed', '1', '10', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', '1', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Search-Engine Safe URLs', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', '1', '12', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', '1', '14', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', '1', '15', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', '1', '17', 'tep_cfg_select_option(array(\'and\', \'or\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Address and Phone', 'STORE_NAME_ADDRESS', 'Store Name\nAddress\nCountry\nPhone', 'This is the Store Name, Address and Phone used on printable documents and displayed online', '1', '18', 'tep_cfg_textarea(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Show Category Counts', 'SHOW_COUNTS', 'false', 'Count recursively how many products are in each category', '1', '19', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', '1', '20', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'false', 'Display prices with tax included (true) or add the tax at the end (false)', '1', '21', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
################################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', '2', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', '2', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', '2', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', '2', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', '2', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', '2', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', '2', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', '2', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', '2', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', '2', '10', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', '2', '11', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', '2', '12', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', '2', '13', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', '2', '14', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', '2', '15', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the \'This Customer Also Purchased\' box', '2', '16', now());
################################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', '3', '12', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', '3', '17', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', '3', '21', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', '3', '22', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', '3', '23', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '3', 'Maximum number of new reviews to display', '3', '24', now());
################################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', '3', '25', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', '3', '26', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '4', 'Maximum number of best sellers to display', '3', '27', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('<b class="add-by-seaman">Best Sellers in Slider</b>', 'MAX_DISPLAY_BESTSELLERS_UNDER_HEADER', '24', 'Maximum number of best sellers in Slider to display', '3', '27', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', '3', '30', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Products Expected', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Maximum number of products expected to display', '3', '29', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', '3', '31', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', '3', '32', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Product Quantities In Shopping Cart', 'MAX_QTY_IN_CART', '99', 'Maximum number of product quantities that can be added to the shopping cart (0 for no limit)', '3', '34', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', '4', '13', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', '4', '14', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', '5', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', '5', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', '5', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', '5', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', '5', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php;paypal_express.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cod.php;paypal_express.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ACTION_RECORDER_INSTALLED', 'ar_admin_login.php;ar_contact_us.php;ar_tell_a_friend.php', 'List of action recorder module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_SOCIAL_BOOKMARKS_INSTALLED', 'sb_email.php;sb_facebook.php;sb_twitter.php;sb_google_buzz.php;sb_digg.php;sb_google_plus.php', 'List of social bookmark module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES ('Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '5.00', 'The shipping cost for all orders using this shipping method.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', '6', '0', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', '6', '0', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', '6', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, date_added) VALUES ('Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', '6', '4', 'currencies->format', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', '6', '5', 'tep_cfg_select_option(array(\'national\', \'international\', \'both\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '3', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', '6', '1','tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '4', 'Sort order of display.', '6', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_CONTACT_US_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Minimum Minutes Per E-Mail', 'MODULE_ACTION_RECORDER_TELL_A_FRIEND_EMAIL_MINUTES', '15', 'Minimum number of minutes to allow 1 e-mail to be sent (eg, 15 for 1 e-mail every 15 minutes)', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Minutes', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_MINUTES', '5', 'Number of minutes to allow login attempts to occur.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Allowed Attempts', 'MODULE_ACTION_RECORDER_ADMIN_LOGIN_ATTEMPTS', '3', 'Number of login attempts to allow within the specified period.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable E-Mail Module', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_STATUS', 'True', 'Do you want to allow products to be shared through e-mail?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_EMAIL_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Facebook Module', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_STATUS', 'True', 'Do you want to allow products to be shared through Facebook?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_FACEBOOK_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Twitter Module', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_STATUS', 'True', 'Do you want to allow products to be shared through Twitter?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_TWITTER_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Google Buzz Module', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_BUZZ_STATUS', 'True', 'Do you want to allow products to be shared through Google Buzz?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_BUZZ_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Digg Module', 'MODULE_SOCIAL_BOOKMARKS_DIGG_STATUS', 'True', 'Do you want to allow products to be shared through Digg?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_DIGG_SORT_ORDER', '50', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
############################################################################################
## add by Seaman ################################# sb_google_plus.php MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS
############################################################################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Google Buzz Module', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_STATUS', 'True', 'Do you want to allow products to be shared through Google +1?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SOCIAL_BOOKMARKS_GOOGLE_PLUS_SORT_ORDER', '60', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
## add by Seaman ###########################################################################
############################################################################################
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', '7', '1', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', '7', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', '7', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', '7', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', '7', '5', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', '8', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER', '5', 'Do you want to display the Product Manufacturer Name?', '8', '2', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Model', 'PRODUCT_LIST_MODEL', '6', 'Do you want to display the Product Model?', '8', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', '8', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Price', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price', '8', '5', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '7', 'Do you want to display the Product Quantity?', '8', '6', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Weight', 'PRODUCT_LIST_WEIGHT', '8', 'Do you want to display the Product Weight?', '8', '7', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Buy Now column', 'PRODUCT_LIST_BUY_NOW', '4', 'Do you want to display the Buy Now column?', '8', '8', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', '8', '9', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '3', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', '8', '10', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', '9', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', '9', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', '9', '3', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', '9', '4', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', '9', '5', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', '10', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', '10', '3', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', '10', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log', '10', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Cache', 'USE_CACHE', 'false', 'Use caching features', '11', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Cache Directory', 'DIR_FS_CACHE', '/tmp/', 'The directory where the cached files are saved', '11', '2', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', '12', '1', 'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', '12', '2', 'tep_cfg_select_option(array(\'LF\', \'CRLF\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', '12', '3', 'tep_cfg_select_option(array(\'true\', \'false\'),', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', '12', '4', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', '12', '5', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', '13', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', '13', '2', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expiry delay (days)' ,'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', '13', '3', '', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Maximum number of downloads' ,'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', '13', '4', '', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', '14', '1', 'tep_cfg_select_option(array(\'true\', \'false\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', '14', '2', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp', 'If sessions are file based, store them in this directory.', '15', '1', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', '15', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', '15', '3', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', '15', '4', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', '15', '5', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'True', 'Prevent known spiders from starting a session.', '15', '6', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Recreate Session', 'SESSION_RECREATE', 'True', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', '15', '7', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
## ##
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Last Update Check Time', 'LAST_UPDATE_CHECK_TIME', '', 'Last time a check for new versions of osCommerce was run', '6', '0', now());
## #################################
INSERT INTO configuration_group VALUES ('1', 'My Store', 'General information about my store', '1', '1');
INSERT INTO configuration_group VALUES ('2', 'Minimum Values', 'The minimum values for functions / data', '2', '1');
INSERT INTO configuration_group VALUES ('3', 'Maximum Values', 'The maximum values for functions / data', '3', '1');
INSERT INTO configuration_group VALUES ('4', 'Images', 'Image parameters', '4', '1');
INSERT INTO configuration_group VALUES ('5', 'Customer Details', 'Customer account configuration', '5', '1');
INSERT INTO configuration_group VALUES ('6', 'Module Options', 'Hidden from configuration', '6', '0');
INSERT INTO configuration_group VALUES ('7', 'Shipping/Packaging', 'Shipping options available at my store', '7', '1');
INSERT INTO configuration_group VALUES ('8', 'Product Listing', 'Product Listing    configuration options', '8', '1');
INSERT INTO configuration_group VALUES ('9', 'Stock', 'Stock configuration options', '9', '1');
INSERT INTO configuration_group VALUES ('10', 'Logging', 'Logging configuration options', '10', '1');
INSERT INTO configuration_group VALUES ('11', 'Cache', 'Caching configuration options', '11', '1');
INSERT INTO configuration_group VALUES ('12', 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', '12', '1');
INSERT INTO configuration_group VALUES ('13', 'Download', 'Downloadable products options', '13', '1');
INSERT INTO configuration_group VALUES ('14', 'GZip Compression', 'GZip compression options', '14', '1');
INSERT INTO configuration_group VALUES ('15', 'Sessions', 'Session options', '15', '1');
## add by Seaman ##############################################
INSERT INTO configuration_group VALUES ('16', '<b>jCarousellite Slider</b>', 'jCarousellite Slider', '16', '1');
INSERT INTO configuration_group VALUES ('17', '<b>Banners Layout</b>', 'Banners position options', '17', '1');
## add by Seaman ##############################################
## #################################
INSERT INTO countries VALUES (1,'Afghanistan','AF','AFG','1');
INSERT INTO countries VALUES (2,'Albania','AL','ALB','1');
INSERT INTO countries VALUES (3,'Algeria','DZ','DZA','1');
INSERT INTO countries VALUES (4,'American Samoa','AS','ASM','1');
INSERT INTO countries VALUES (5,'Andorra','AD','AND','1');
INSERT INTO countries VALUES (6,'Angola','AO','AGO','1');
INSERT INTO countries VALUES (7,'Anguilla','AI','AIA','1');
INSERT INTO countries VALUES (8,'Antarctica','AQ','ATA','1');
INSERT INTO countries VALUES (9,'Antigua and Barbuda','AG','ATG','1');
INSERT INTO countries VALUES (10,'Argentina','AR','ARG','1');
INSERT INTO countries VALUES (11,'Armenia','AM','ARM','1');
INSERT INTO countries VALUES (12,'Aruba','AW','ABW','1');
INSERT INTO countries VALUES (13,'Australia','AU','AUS','1');
INSERT INTO countries VALUES (14,'Austria','AT','AUT','5');
INSERT INTO countries VALUES (15,'Azerbaijan','AZ','AZE','1');
INSERT INTO countries VALUES (16,'Bahamas','BS','BHS','1');
INSERT INTO countries VALUES (17,'Bahrain','BH','BHR','1');
INSERT INTO countries VALUES (18,'Bangladesh','BD','BGD','1');
INSERT INTO countries VALUES (19,'Barbados','BB','BRB','1');
INSERT INTO countries VALUES (20,'Belarus','BY','BLR','1');
INSERT INTO countries VALUES (21,'Belgium','BE','BEL','1');
INSERT INTO countries VALUES (22,'Belize','BZ','BLZ','1');
INSERT INTO countries VALUES (23,'Benin','BJ','BEN','1');
INSERT INTO countries VALUES (24,'Bermuda','BM','BMU','1');
INSERT INTO countries VALUES (25,'Bhutan','BT','BTN','1');
INSERT INTO countries VALUES (26,'Bolivia','BO','BOL','1');
INSERT INTO countries VALUES (27,'Bosnia and Herzegowina','BA','BIH','1');
INSERT INTO countries VALUES (28,'Botswana','BW','BWA','1');
INSERT INTO countries VALUES (29,'Bouvet Island','BV','BVT','1');
INSERT INTO countries VALUES (30,'Brazil','BR','BRA','1');
INSERT INTO countries VALUES (31,'British Indian Ocean Territory','IO','IOT','1');
INSERT INTO countries VALUES (32,'Brunei Darussalam','BN','BRN','1');
INSERT INTO countries VALUES (33,'Bulgaria','BG','BGR','1');
INSERT INTO countries VALUES (34,'Burkina Faso','BF','BFA','1');
INSERT INTO countries VALUES (35,'Burundi','BI','BDI','1');
INSERT INTO countries VALUES (36,'Cambodia','KH','KHM','1');
INSERT INTO countries VALUES (37,'Cameroon','CM','CMR','1');
INSERT INTO countries VALUES (38,'Canada','CA','CAN','1');
INSERT INTO countries VALUES (39,'Cape Verde','CV','CPV','1');
INSERT INTO countries VALUES (40,'Cayman Islands','KY','CYM','1');
INSERT INTO countries VALUES (41,'Central African Republic','CF','CAF','1');
INSERT INTO countries VALUES (42,'Chad','TD','TCD','1');
INSERT INTO countries VALUES (43,'Chile','CL','CHL','1');
INSERT INTO countries VALUES (44,'China','CN','CHN','1');
INSERT INTO countries VALUES (45,'Christmas Island','CX','CXR','1');
INSERT INTO countries VALUES (46,'Cocos (Keeling) Islands','CC','CCK','1');
INSERT INTO countries VALUES (47,'Colombia','CO','COL','1');
INSERT INTO countries VALUES (48,'Comoros','KM','COM','1');
INSERT INTO countries VALUES (49,'Congo','CG','COG','1');
INSERT INTO countries VALUES (50,'Cook Islands','CK','COK','1');
INSERT INTO countries VALUES (51,'Costa Rica','CR','CRI','1');
INSERT INTO countries VALUES (52,'Cote D\'Ivoire','CI','CIV','1');
INSERT INTO countries VALUES (53,'Croatia','HR','HRV','1');
INSERT INTO countries VALUES (54,'Cuba','CU','CUB','1');
INSERT INTO countries VALUES (55,'Cyprus','CY','CYP','1');
INSERT INTO countries VALUES (56,'Czech Republic','CZ','CZE','1');
INSERT INTO countries VALUES (57,'Denmark','DK','DNK','1');
INSERT INTO countries VALUES (58,'Djibouti','DJ','DJI','1');
INSERT INTO countries VALUES (59,'Dominica','DM','DMA','1');
INSERT INTO countries VALUES (60,'Dominican Republic','DO','DOM','1');
INSERT INTO countries VALUES (61,'East Timor','TP','TMP','1');
INSERT INTO countries VALUES (62,'Ecuador','EC','ECU','1');
INSERT INTO countries VALUES (63,'Egypt','EG','EGY','1');
INSERT INTO countries VALUES (64,'El Salvador','SV','SLV','1');
INSERT INTO countries VALUES (65,'Equatorial Guinea','GQ','GNQ','1');
INSERT INTO countries VALUES (66,'Eritrea','ER','ERI','1');
INSERT INTO countries VALUES (67,'Estonia','EE','EST','1');
INSERT INTO countries VALUES (68,'Ethiopia','ET','ETH','1');
INSERT INTO countries VALUES (69,'Falkland Islands (Malvinas)','FK','FLK','1');
INSERT INTO countries VALUES (70,'Faroe Islands','FO','FRO','1');
INSERT INTO countries VALUES (71,'Fiji','FJ','FJI','1');
INSERT INTO countries VALUES (72,'Finland','FI','FIN','1');
INSERT INTO countries VALUES (73,'France','FR','FRA','1');
INSERT INTO countries VALUES (74,'France, Metropolitan','FX','FXX','1');
INSERT INTO countries VALUES (75,'French Guiana','GF','GUF','1');
INSERT INTO countries VALUES (76,'French Polynesia','PF','PYF','1');
INSERT INTO countries VALUES (77,'French Southern Territories','TF','ATF','1');
INSERT INTO countries VALUES (78,'Gabon','GA','GAB','1');
INSERT INTO countries VALUES (79,'Gambia','GM','GMB','1');
INSERT INTO countries VALUES (80,'Georgia','GE','GEO','1');
INSERT INTO countries VALUES (81,'Germany','DE','DEU','5');
INSERT INTO countries VALUES (82,'Ghana','GH','GHA','1');
INSERT INTO countries VALUES (83,'Gibraltar','GI','GIB','1');
INSERT INTO countries VALUES (84,'Greece','GR','GRC','1');
INSERT INTO countries VALUES (85,'Greenland','GL','GRL','1');
INSERT INTO countries VALUES (86,'Grenada','GD','GRD','1');
INSERT INTO countries VALUES (87,'Guadeloupe','GP','GLP','1');
INSERT INTO countries VALUES (88,'Guam','GU','GUM','1');
INSERT INTO countries VALUES (89,'Guatemala','GT','GTM','1');
INSERT INTO countries VALUES (90,'Guinea','GN','GIN','1');
INSERT INTO countries VALUES (91,'Guinea-bissau','GW','GNB','1');
INSERT INTO countries VALUES (92,'Guyana','GY','GUY','1');
INSERT INTO countries VALUES (93,'Haiti','HT','HTI','1');
INSERT INTO countries VALUES (94,'Heard and Mc Donald Islands','HM','HMD','1');
INSERT INTO countries VALUES (95,'Honduras','HN','HND','1');
INSERT INTO countries VALUES (96,'Hong Kong','HK','HKG','1');
INSERT INTO countries VALUES (97,'Hungary','HU','HUN','1');
INSERT INTO countries VALUES (98,'Iceland','IS','ISL','1');
INSERT INTO countries VALUES (99,'India','IN','IND','1');
INSERT INTO countries VALUES (100,'Indonesia','ID','IDN','1');
INSERT INTO countries VALUES (101,'Iran (Islamic Republic of)','IR','IRN','1');
INSERT INTO countries VALUES (102,'Iraq','IQ','IRQ','1');
INSERT INTO countries VALUES (103,'Ireland','IE','IRL','1');
INSERT INTO countries VALUES (104,'Israel','IL','ISR','1');
INSERT INTO countries VALUES (105,'Italy','IT','ITA','1');
INSERT INTO countries VALUES (106,'Jamaica','JM','JAM','1');
INSERT INTO countries VALUES (107,'Japan','JP','JPN','1');
INSERT INTO countries VALUES (108,'Jordan','JO','JOR','1');
INSERT INTO countries VALUES (109,'Kazakhstan','KZ','KAZ','1');
INSERT INTO countries VALUES (110,'Kenya','KE','KEN','1');
INSERT INTO countries VALUES (111,'Kiribati','KI','KIR','1');
INSERT INTO countries VALUES (112,'Korea, Democratic People\'s Republic of','KP','PRK','1');
INSERT INTO countries VALUES (113,'Korea, Republic of','KR','KOR','1');
INSERT INTO countries VALUES (114,'Kuwait','KW','KWT','1');
INSERT INTO countries VALUES (115,'Kyrgyzstan','KG','KGZ','1');
INSERT INTO countries VALUES (116,'Lao People\'s Democratic Republic','LA','LAO','1');
INSERT INTO countries VALUES (117,'Latvia','LV','LVA','1');
INSERT INTO countries VALUES (118,'Lebanon','LB','LBN','1');
INSERT INTO countries VALUES (119,'Lesotho','LS','LSO','1');
INSERT INTO countries VALUES (120,'Liberia','LR','LBR','1');
INSERT INTO countries VALUES (121,'Libyan Arab Jamahiriya','LY','LBY','1');
INSERT INTO countries VALUES (122,'Liechtenstein','LI','LIE','1');
INSERT INTO countries VALUES (123,'Lithuania','LT','LTU','1');
INSERT INTO countries VALUES (124,'Luxembourg','LU','LUX','1');
INSERT INTO countries VALUES (125,'Macau','MO','MAC','1');
INSERT INTO countries VALUES (126,'Macedonia, The Former Yugoslav Republic of','MK','MKD','1');
INSERT INTO countries VALUES (127,'Madagascar','MG','MDG','1');
INSERT INTO countries VALUES (128,'Malawi','MW','MWI','1');
INSERT INTO countries VALUES (129,'Malaysia','MY','MYS','1');
INSERT INTO countries VALUES (130,'Maldives','MV','MDV','1');
INSERT INTO countries VALUES (131,'Mali','ML','MLI','1');
INSERT INTO countries VALUES (132,'Malta','MT','MLT','1');
INSERT INTO countries VALUES (133,'Marshall Islands','MH','MHL','1');
INSERT INTO countries VALUES (134,'Martinique','MQ','MTQ','1');
INSERT INTO countries VALUES (135,'Mauritania','MR','MRT','1');
INSERT INTO countries VALUES (136,'Mauritius','MU','MUS','1');
INSERT INTO countries VALUES (137,'Mayotte','YT','MYT','1');
INSERT INTO countries VALUES (138,'Mexico','MX','MEX','1');
INSERT INTO countries VALUES (139,'Micronesia, Federated States of','FM','FSM','1');
INSERT INTO countries VALUES (140,'Moldova, Republic of','MD','MDA','1');
INSERT INTO countries VALUES (141,'Monaco','MC','MCO','1');
INSERT INTO countries VALUES (142,'Mongolia','MN','MNG','1');
INSERT INTO countries VALUES (143,'Montserrat','MS','MSR','1');
INSERT INTO countries VALUES (144,'Morocco','MA','MAR','1');
INSERT INTO countries VALUES (145,'Mozambique','MZ','MOZ','1');
INSERT INTO countries VALUES (146,'Myanmar','MM','MMR','1');
INSERT INTO countries VALUES (147,'Namibia','NA','NAM','1');
INSERT INTO countries VALUES (148,'Nauru','NR','NRU','1');
INSERT INTO countries VALUES (149,'Nepal','NP','NPL','1');
INSERT INTO countries VALUES (150,'Netherlands','NL','NLD','1');
INSERT INTO countries VALUES (151,'Netherlands Antilles','AN','ANT','1');
INSERT INTO countries VALUES (152,'New Caledonia','NC','NCL','1');
INSERT INTO countries VALUES (153,'New Zealand','NZ','NZL','1');
INSERT INTO countries VALUES (154,'Nicaragua','NI','NIC','1');
INSERT INTO countries VALUES (155,'Niger','NE','NER','1');
INSERT INTO countries VALUES (156,'Nigeria','NG','NGA','1');
INSERT INTO countries VALUES (157,'Niue','NU','NIU','1');
INSERT INTO countries VALUES (158,'Norfolk Island','NF','NFK','1');
INSERT INTO countries VALUES (159,'Northern Mariana Islands','MP','MNP','1');
INSERT INTO countries VALUES (160,'Norway','NO','NOR','1');
INSERT INTO countries VALUES (161,'Oman','OM','OMN','1');
INSERT INTO countries VALUES (162,'Pakistan','PK','PAK','1');
INSERT INTO countries VALUES (163,'Palau','PW','PLW','1');
INSERT INTO countries VALUES (164,'Panama','PA','PAN','1');
INSERT INTO countries VALUES (165,'Papua New Guinea','PG','PNG','1');
INSERT INTO countries VALUES (166,'Paraguay','PY','PRY','1');
INSERT INTO countries VALUES (167,'Peru','PE','PER','1');
INSERT INTO countries VALUES (168,'Philippines','PH','PHL','1');
INSERT INTO countries VALUES (169,'Pitcairn','PN','PCN','1');
INSERT INTO countries VALUES (170,'Poland','PL','POL','1');
INSERT INTO countries VALUES (171,'Portugal','PT','PRT','1');
INSERT INTO countries VALUES (172,'Puerto Rico','PR','PRI','1');
INSERT INTO countries VALUES (173,'Qatar','QA','QAT','1');
INSERT INTO countries VALUES (174,'Reunion','RE','REU','1');
INSERT INTO countries VALUES (175,'Romania','RO','ROM','1');
INSERT INTO countries VALUES (176,'Russian Federation','RU','RUS','1');
INSERT INTO countries VALUES (177,'Rwanda','RW','RWA','1');
INSERT INTO countries VALUES (178,'Saint Kitts and Nevis','KN','KNA','1');
INSERT INTO countries VALUES (179,'Saint Lucia','LC','LCA','1');
INSERT INTO countries VALUES (180,'Saint Vincent and the Grenadines','VC','VCT','1');
INSERT INTO countries VALUES (181,'Samoa','WS','WSM','1');
INSERT INTO countries VALUES (182,'San Marino','SM','SMR','1');
INSERT INTO countries VALUES (183,'Sao Tome and Principe','ST','STP','1');
INSERT INTO countries VALUES (184,'Saudi Arabia','SA','SAU','1');
INSERT INTO countries VALUES (185,'Senegal','SN','SEN','1');
INSERT INTO countries VALUES (186,'Seychelles','SC','SYC','1');
INSERT INTO countries VALUES (187,'Sierra Leone','SL','SLE','1');
INSERT INTO countries VALUES (188,'Singapore','SG','SGP', '4');
INSERT INTO countries VALUES (189,'Slovakia (Slovak Republic)','SK','SVK','1');
INSERT INTO countries VALUES (190,'Slovenia','SI','SVN','1');
INSERT INTO countries VALUES (191,'Solomon Islands','SB','SLB','1');
INSERT INTO countries VALUES (192,'Somalia','SO','SOM','1');
INSERT INTO countries VALUES (193,'South Africa','ZA','ZAF','1');
INSERT INTO countries VALUES (194,'South Georgia and the South Sandwich Islands','GS','SGS','1');
INSERT INTO countries VALUES (195,'Spain','ES','ESP','3');
INSERT INTO countries VALUES (196,'Sri Lanka','LK','LKA','1');
INSERT INTO countries VALUES (197,'St. Helena','SH','SHN','1');
INSERT INTO countries VALUES (198,'St. Pierre and Miquelon','PM','SPM','1');
INSERT INTO countries VALUES (199,'Sudan','SD','SDN','1');
INSERT INTO countries VALUES (200,'Suriname','SR','SUR','1');
INSERT INTO countries VALUES (201,'Svalbard and Jan Mayen Islands','SJ','SJM','1');
INSERT INTO countries VALUES (202,'Swaziland','SZ','SWZ','1');
INSERT INTO countries VALUES (203,'Sweden','SE','SWE','1');
INSERT INTO countries VALUES (204,'Switzerland','CH','CHE','1');
INSERT INTO countries VALUES (205,'Syrian Arab Republic','SY','SYR','1');
INSERT INTO countries VALUES (206,'Taiwan','TW','TWN','1');
INSERT INTO countries VALUES (207,'Tajikistan','TJ','TJK','1');
INSERT INTO countries VALUES (208,'Tanzania, United Republic of','TZ','TZA','1');
INSERT INTO countries VALUES (209,'Thailand','TH','THA','1');
INSERT INTO countries VALUES (210,'Togo','TG','TGO','1');
INSERT INTO countries VALUES (211,'Tokelau','TK','TKL','1');
INSERT INTO countries VALUES (212,'Tonga','TO','TON','1');
INSERT INTO countries VALUES (213,'Trinidad and Tobago','TT','TTO','1');
INSERT INTO countries VALUES (214,'Tunisia','TN','TUN','1');
INSERT INTO countries VALUES (215,'Turkey','TR','TUR','1');
INSERT INTO countries VALUES (216,'Turkmenistan','TM','TKM','1');
INSERT INTO countries VALUES (217,'Turks and Caicos Islands','TC','TCA','1');
INSERT INTO countries VALUES (218,'Tuvalu','TV','TUV','1');
INSERT INTO countries VALUES (219,'Uganda','UG','UGA','1');
INSERT INTO countries VALUES (220,'Ukraine','UA','UKR','1');
INSERT INTO countries VALUES (221,'United Arab Emirates','AE','ARE','1');
INSERT INTO countries VALUES (222,'United Kingdom','GB','GBR','1');
INSERT INTO countries VALUES (223,'United States','US','USA', '2');
INSERT INTO countries VALUES (224,'United States Minor Outlying Islands','UM','UMI','1');
INSERT INTO countries VALUES (225,'Uruguay','UY','URY','1');
INSERT INTO countries VALUES (226,'Uzbekistan','UZ','UZB','1');
INSERT INTO countries VALUES (227,'Vanuatu','VU','VUT','1');
INSERT INTO countries VALUES (228,'Vatican City State (Holy See)','VA','VAT','1');
INSERT INTO countries VALUES (229,'Venezuela','VE','VEN','1');
INSERT INTO countries VALUES (230,'Viet Nam','VN','VNM','1');
INSERT INTO countries VALUES (231,'Virgin Islands (British)','VG','VGB','1');
INSERT INTO countries VALUES (232,'Virgin Islands (U.S.)','VI','VIR','1');
INSERT INTO countries VALUES (233,'Wallis and Futuna Islands','WF','WLF','1');
INSERT INTO countries VALUES (234,'Western Sahara','EH','ESH','1');
INSERT INTO countries VALUES (235,'Yemen','YE','YEM','1');
INSERT INTO countries VALUES (236,'Yugoslavia','YU','YUG','1');
INSERT INTO countries VALUES (237,'Zaire','ZR','ZAR','1');
INSERT INTO countries VALUES (238,'Zambia','ZM','ZMB','1');
INSERT INTO countries VALUES (239,'Zimbabwe','ZW','ZWE','1');
## #################################
INSERT INTO currencies VALUES (1,'U.S. Dollar','USD','$','','.',',','2','1.0000', now());
INSERT INTO currencies VALUES (2,'Euro','EUR','','&euro;','.',',','2','1.0000', now());
## #################################
INSERT INTO languages VALUES (1,'English','en','icon.gif','english',1);
## #################################
INSERT INTO manufacturers VALUES (1,'Example-1','', now(), null);
INSERT INTO manufacturers VALUES (2,'Example-2','', now(), null);
INSERT INTO manufacturers VALUES (3,'Example-3','', now(), null);
INSERT INTO manufacturers VALUES (4,'Example-4','', now(), null);
## #################################
INSERT INTO manufacturers_info VALUES (1, 1, 'http://www.example-1.com', 0, null);
INSERT INTO manufacturers_info VALUES (2, 1, 'http://www.example-2.com', 0, null);
INSERT INTO manufacturers_info VALUES (3, 1, 'http://www.example-3.com', 0, null);
INSERT INTO manufacturers_info VALUES (4, 1, 'http://www.example-4.com', 0, null);
## #################################
INSERT INTO orders_status VALUES ( '1', '1', 'Pending', '1', '0');
INSERT INTO orders_status VALUES ( '2', '1', 'Processing', '1', '1');
INSERT INTO orders_status VALUES ( '3', '1', 'Delivered', '1', '1');
################################################################################################
################################################################################################
INSERT INTO products_description VALUES (1,1,'Andy Warhol Lexington Avenue (EDP, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (2,1,'Andy Warhol Union Square (EDP, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (3,1,'ANNICK GOUTAL Eau d\'Hadrien for Him (EDT, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (4,1,'ANNICK GOUTAL Ninfeo Mio (EDT, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (5,1,'ANNICK GOUTAL Ninfeo Mio for Men (EDT, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (6,1,'Astor Place (EDP, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (7,1,'Attimo (EDP, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (8,1,'Burberry Sport for Women (EDT, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (9,1,'Bvlgari(EDT, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (10,1,'Calyx Exhilarating Fragrance (EDP, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
#######
INSERT INTO products_description VALUES (11,1,'Chantecaille Kalimantan Perfume','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (12,1,'Clinique Happy for Men After Shave Set','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (13,1,'Eau de Sisley','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (14,1,'EMILIO PUCCI Collection','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (15,1,'ESTEE LAUDER For Men Cologne Spray (100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (16,1,'ESTEE LAUDER Intuition Eau de Parfum Spray (100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (17,1,'ESTEE LAUDER Knowing Eau de Parfum Spray (75ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (18,1,'ESTEE LAUDER Private Collection Amber Ylang Ylang Parfum Spray (30ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (19,1,'ESTEE LAUDER Sensuous (EDP,100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (20,1,'Fan di Fendi (EDP, 30ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
#######
INSERT INTO products_description VALUES (21,1,'GERLAIN Habit Rouge Set','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (22,1,'GUCCI Guilty (EDT, 75ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (23,1,'Harrods Rose (EDP, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (24,1,'Harvest 2009 Ange au Demon Gift Set','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (25,1,'High Line (EDP, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (26,1,'MARC JACOBS Lola Collection','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (27,1,'Ormonde Man (EDP, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (28,1,'Ormonde Sampaquita (Parfum, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (29,1,'Pour Homme Blue Label (EDT, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (30,1,'Sensuous Noir (EDP, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
#######
INSERT INTO products_description VALUES (31,1,'Shalimar by Jade Jagger (EDP, 30ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (32,1,'SISLEY Eau de Campagne (EDT, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (33,1,'SISLEY Eau du Soir (EDP, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (34,1,'SISLEY Eau Du Soir Limited Edition Black (EDP, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (35,1,'SISLEY Eau Du Soir Limited Edition White (EDP, 100ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (36,1,'SISLEY Soir de Lune (EDP, 100ml) 1.png','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (37,1,'Success is a Job in New York (EDP, 50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (38,1,'Tom Ford Amber Absolute Decanter (250ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (39,1,'Tom Ford Amber Absolute Eau de Parfum Spray (50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (40,1,'Tom Ford White Suede Parfum Spray (50ml)','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
#######
INSERT INTO products_description VALUES (41,1,'Angel Edp 75ml Refillable Spray','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (42,1,'Burberry Summer For Women Edt 50ml','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (43,1,'Rock \'n Rose Pret A Porter Edt 50m','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (44,1,'Flora By Gucci Edp 75ml Spray','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (45,1,'Jennifer Aniston Edp 30ml Spray','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (46,1,'Lola Edp 50ml Gift Set','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (47,1,'Gucci Guilty Edt 30ml Spray','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (48,1,'Boss Bottled Night Edt 50ml Gift Set','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (49,1,'Lady Million Edp 50ml Spray','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (50,1,'GOLD BOUQUET For Women','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (51,1,'APPARITION EXOTIC GREEN','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (52,1,'HALLOWEEN For Women','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (53,1,'BEBE For Women By BEBE','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (54,1,'ACQUA DI GIOIA For Women','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
INSERT INTO products_description VALUES (55,1,'BORN WILD For Women','<p>Laoreet dolore magnaorem ipsum dolor ser adipiscing elit, sed diam non aliquam neque. Fusce venenatis blandit lorem eu malesuada. Maecenas bibendum, <b>ante sed semper tincidunt</b>, nibh ante condimentum justo, rutrum mattis nulla elit vitae massa. Sed a metus diam, porttitor varius dui. Nullam non leo ut lacus scelerisque sollicitudin quis at orci. Nulla suscipit elementum justo, et pharetra dolor ultricies eu. <em>Donec eget justo <b>nec turpis</b> malesuada</em> dignissim pellentesque ac massa. Donec eu erat nunc. Nunc convallis nisi sed velit <a href="#">sodales vestibulum</a> egestas mattis enim. Quisque placerat ultrices fermentum. Aenean mollis convallis ante, sed faucibus erat tempor non crasre.</p> 
<p>Fusce eu sapien eget dolor sodales tempor eu eget lectus. Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus. In ut tellus ut velit consectetur vulputate. Cras sagittis rutrum mauris, non iaculis turpis ullam.</p>','',0);
################################################################################################
################################################################################################
INSERT INTO products VALUES (1,32,'Model 0001','products/andy_warhol_lexington_avenue_edp_100ml_1.png',299.99, now(),null,null,23.00,1,1,1,0);
INSERT INTO products VALUES (2,32,'Model 0002','products/andy_warhol_union_square_edp_100ml_1.png',499.99, now(),null,null,23.00,1,1,2,0);
INSERT INTO products VALUES (3,28,'Model 0003','products/annick_goutal_eau_d_hadrien_for_him_edt_100ml_1.png',49.99, now(),null,null,7.00,1,1,2,0);
INSERT INTO products VALUES (4,13,'Model 0004','products/annick_goutal_ninfeo_mio_edt_50ml_1.png',42.00, now(),null,null,23.00,1,1,2,0);
INSERT INTO products VALUES (5,17,'Model 0005','products/annick_goutal_ninfeo_mio_for_men_edt_100ml_1.png',35.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (6,10,'Model 0006','products/astor_place_edp_50ml_1.png',39.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (7,10,'Model 0007','products/attimo_edp_50ml_1.png',34.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (8,10,'Model 0008','products/burberry_sport_for_women_edt_50ml_1.png',35.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (9,10,'Model 0009','products/bvlgari_edt_100ml_1.png',29.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (10,10,'Model 0010','products/calyx_exhilarating_fragrance_edp_50ml_1.png',29.99, now(),null,null,7.00,1,1,1,111);
#
INSERT INTO products VALUES (11,10,'Model 0011','products/chantecaille_kalimantan_perfume_1.png',29.99, now(),null,null,7.00,1,1,1,110);
INSERT INTO products VALUES (12,10,'Model 0012','products/clinique_happy_for_men_after_shave_set_1.png',39.99, now(),null,null,7.00,1,1,2,109);
INSERT INTO products VALUES (13,10,'Model 0013','products/eau_de_sisley_1.png',34.99, now(),null,null,7.00,1,1,2,108);
INSERT INTO products VALUES (14,10,'Model 0014','products/emilio_pucci_collection_1.png',32.00, now(),null,null,7.00,1,1,2,107);
INSERT INTO products VALUES (15,10,'Model 0015','products/estee_lauder_for_men_cologne_spray_100ml_1.png',35.00, now(),null,null,7.00,1,1,2,106);
INSERT INTO products VALUES (16,10,'Model 0016','products/estee_lauder_intuition_eau_de_parfum_spray_100ml_1.png',38.99, now(),null,null,7.00,1,1,3,112);
INSERT INTO products VALUES (17,10,'Model 0017','products/estee_lauder_knowing_eau_de_parfum_spray_75ml_1.png',39.99, now(),null,null,7.00,1,1,3,113);
INSERT INTO products VALUES (18,10,'Model 0018','products/estee_lauder_private_collection_amber_ylang_ylang_parfum_spray_30ml_1.png',42.00, now(),null,null,7.00,1,1,3,114);
INSERT INTO products VALUES (19,10,'Model 0019','products/estee_lauder_sensuous_edp_100ml_1.png',49.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (20,10,'Model 0020','products/fan_di_fendi_edp_30ml_1.png',54.99, now(),null,null,7.00,1,1,1,0);
#
INSERT INTO products VALUES (21,16,'Model 0021','products/gerlain_habit_rouge_set_1.png',79.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (22,13,'Model 0022','products/gucci_guilty_edt_75ml_1.png',89.99, now(),null,null,7.00,1,1,2,0);
INSERT INTO products VALUES (23,16,'Model 0023','products/harrods_rose_edp_100ml_1.png',99.99, now(),null,null,10.00,1,1,2,0);
INSERT INTO products VALUES (24,17,'Model 0024','products/harvest_2009_ange_au_demon_gift_set_1.png',90.00, now(),null,null,8.00,1,1,2,0);
INSERT INTO products VALUES (25,16,'Model 0025','products/high_line_edp_100ml_1.png',69.99, now(),null,null,8.00,1,1,3,0);
INSERT INTO products VALUES (26,10,'Model 0026','products/marc_jacobs_lola_collection_1.png',64.95, now(),null,null,8.00,1,1,3,0);
INSERT INTO products VALUES (27,40,'Model 0027','products/ormonde_man_edp_50ml_1.png',499.99, now(),null,null,45.00,1,1,3,0);
INSERT INTO products VALUES (28,10,'Model 0028','products/ormonde_sampaquita_parfum_50ml_1.png',35.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (29,10,'Model 0029','products/pour_homme_blue_label_edt_100ml_1.png',119.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (30,10,'Model 0030','products/sensuous_noir_edp_50ml_1.png',29.99, now(),null,null,7.00,1,1,1,0);
#
INSERT INTO products VALUES (31,32,'Model 0031','products/shalimar_by_jade_jagger_edp_30ml_1.png',299.99, now(),null,null,23.00,1,1,1,0);
INSERT INTO products VALUES (32,32,'Model 0032','products/sisley_eau_de_campagne_edt_100ml_1.png',499.99, now(),null,null,23.00,1,1,2,0);
INSERT INTO products VALUES (33,54,'Model 0003','products/sisley_eau_du_soir_edp_100ml_1.png',49.99, now(),null,null,7.00,1,1,2,0);
INSERT INTO products VALUES (34,13,'Model 0034','products/sisley_eau_du_soir_limited_edition_black_edp_100ml_1.png',42.00, now(),null,null,23.00,1,1,2,0);
INSERT INTO products VALUES (35,17,'Model 0035','products/sisley_eau_du_soir_limited_edition_white_edp_100ml_1.png',35.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (36,10,'Model 0036','products/sisley_soir_de_lune_edp_100ml_1.png',39.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (37,10,'Model 0037','products/success_is_a_job_in_new_york_edp_50ml_1.png',34.99, now(),null,null,7.00,1,1,3,0);
INSERT INTO products VALUES (38,10,'Model 0038','products/tom_ford_amber_absolute_decanter_250ml_1.png',35.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (39,10,'Model 0039','products/tom_ford_amber_absolute_eau_de_parfum_spray_50ml_1.png',29.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (40,10,'Model 0040','products/tom_ford_white_suede_parfum_spray_50ml_1.png',29.99, now(),null,null,7.00,1,1,1,0);
#
INSERT INTO products VALUES (41,32,'Model 0041','products/041.png',299.99, now(),null,null,23.00,1,1,1,115);
INSERT INTO products VALUES (42,32,'Model 0042','products/042.png',499.99, now(),null,null,23.00,1,1,2,104);
INSERT INTO products VALUES (43,28,'Model 0043','products/043.png',49.99, now(),null,null,7.00,1,1,2,103);
INSERT INTO products VALUES (44,13,'Model 0044','products/044.png',42.00, now(),null,null,23.00,1,1,2,120);
INSERT INTO products VALUES (45,17,'Model 0045','products/045.png',35.99, now(),null,null,7.00,1,1,1,119);
INSERT INTO products VALUES (46,10,'Model 0046','products/046.png',39.99, now(),null,null,7.00,1,1,1,118);
INSERT INTO products VALUES (47,10,'Model 0047','products/047.png',34.99, now(),null,null,7.00,1,1,1,117);
INSERT INTO products VALUES (48,10,'Model 0048','products/048.png',35.99, now(),null,null,7.00,1,1,1,116);
INSERT INTO products VALUES (49,10,'Model 0049','products/049.png',29.99, now(),null,null,7.00,1,1,1,105);
#
INSERT INTO products VALUES (50,10,'Model 0050','products/050.png',29.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (51,10,'Model 0051','products/051.png',29.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (52,10,'Model 0052','products/052.png',29.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (53,10,'Model 0053','products/053.png',29.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (54,10,'Model 0054','products/054.png',29.99, now(),null,null,7.00,1,1,1,0);
INSERT INTO products VALUES (55,10,'Model 0055','products/055.png',29.99, now(),null,null,7.00,1,1,1,0);
################################################################################################
## #################################
INSERT INTO products_images VALUES (1,1,'products/andy_warhol_lexington_avenue_edp_100ml_1.png','Nulla suscipit elementum justo',1);
INSERT INTO products_images VALUES (2,1,'products/andy_warhol_lexington_avenue_edp_100ml_2.png','Quisque placerat ultrices',2);
INSERT INTO products_images VALUES (3,1,'products/andy_warhol_lexington_avenue_edp_100ml_3.png','Proin consequat tellus non velit viverra a tempor nibh tincidunt. Donec elit augue, adipiscing vitae sollicitudin vitae, luctus vitae lectus',3);

INSERT INTO products_images VALUES (4,2,'products/andy_warhol_union_square_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (5,2,'products/andy_warhol_union_square_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (6,2,'products/andy_warhol_union_square_edp_100ml_3.png',null,3);

INSERT INTO products_images VALUES (7,3,'products/annick_goutal_eau_d_hadrien_for_him_edt_100ml_1.png',null,1);
INSERT INTO products_images VALUES (8,3,'products/annick_goutal_eau_d_hadrien_for_him_edt_100ml_2.png',null,2);
INSERT INTO products_images VALUES (9,3,'products/annick_goutal_eau_d_hadrien_for_him_edt_100ml_3.png',null,3);

INSERT INTO products_images VALUES (10,4,'products/annick_goutal_ninfeo_mio_edt_50ml_1.png',null,1);
INSERT INTO products_images VALUES (11,4,'products/annick_goutal_ninfeo_mio_edt_50ml_2.png',null,2);
INSERT INTO products_images VALUES (12,4,'products/annick_goutal_ninfeo_mio_edt_50ml_3.png',null,3);

INSERT INTO products_images VALUES (13,5,'products/annick_goutal_ninfeo_mio_for_men_edt_100ml_1.png',null,1);
INSERT INTO products_images VALUES (14,5,'products/annick_goutal_ninfeo_mio_for_men_edt_100ml_2.png',null,2);
INSERT INTO products_images VALUES (15,5,'products/annick_goutal_ninfeo_mio_for_men_edt_100ml_3.png',null,3);
##
INSERT INTO products_images VALUES (16,6,'products/astor_place_edp_50ml_1.png',null,1);
INSERT INTO products_images VALUES (17,6,'products/astor_place_edp_50ml_2.png',null,2);
INSERT INTO products_images VALUES (18,6,'products/astor_place_edp_50ml_3.png',null,3);

INSERT INTO products_images VALUES (19,7,'products/attimo_edp_50ml_1.png',null,1);
INSERT INTO products_images VALUES (20,7,'products/attimo_edp_50ml_2.png',null,2);
INSERT INTO products_images VALUES (21,7,'products/attimo_edp_50ml_3.png',null,3);

INSERT INTO products_images VALUES (22,8,'products/burberry_sport_for_women_edt_50ml_1.png',null,1);
INSERT INTO products_images VALUES (23,8,'products/burberry_sport_for_women_edt_50ml_2.png',null,2);
INSERT INTO products_images VALUES (24,8,'products/burberry_sport_for_women_edt_50ml_3.png',null,3);

INSERT INTO products_images VALUES (25,9,'products/bvlgari_edt_100ml_1.png',null,1);
INSERT INTO products_images VALUES (26,9,'products/bvlgari_edt_100ml_2.png',null,2);
INSERT INTO products_images VALUES (27,9,'products/bvlgari_edt_100ml_3.png',null,3);

INSERT INTO products_images VALUES (28,10,'products/calyx_exhilarating_fragrance_edp_50ml_1.png',null,1);
INSERT INTO products_images VALUES (29,10,'products/calyx_exhilarating_fragrance_edp_50ml_2.png',null,2);
INSERT INTO products_images VALUES (30,10,'products/calyx_exhilarating_fragrance_edp_50ml_3.png',null,3);
##
INSERT INTO products_images VALUES (31,11,'products/chantecaille_kalimantan_perfume_1.png',null,1);
INSERT INTO products_images VALUES (32,11,'products/chantecaille_kalimantan_perfume_2.png',null,2);
INSERT INTO products_images VALUES (33,11,'products/chantecaille_kalimantan_perfume_3.png',null,3);

INSERT INTO products_images VALUES (34,12,'products/clinique_happy_for_men_after_shave_set_1.png',null,1);
INSERT INTO products_images VALUES (35,12,'products/clinique_happy_for_men_after_shave_set_2.png',null,2);
INSERT INTO products_images VALUES (36,12,'products/clinique_happy_for_men_after_shave_set_3.png',null,3);

INSERT INTO products_images VALUES (37,13,'products/eau_de_sisley_1.png',null,1);
INSERT INTO products_images VALUES (38,13,'products/eau_de_sisley_2.png',null,2);
INSERT INTO products_images VALUES (39,13,'products/eau_de_sisley_3.png',null,3);

INSERT INTO products_images VALUES (40,14,'products/emilio_pucci_collection_1.png',null,1);
INSERT INTO products_images VALUES (41,14,'products/emilio_pucci_collection_2.png',null,2);
INSERT INTO products_images VALUES (42,14,'products/emilio_pucci_collection_3.png',null,3);

INSERT INTO products_images VALUES (43,15,'products/estee_lauder_for_men_cologne_spray_100ml_1.png',null,1);
INSERT INTO products_images VALUES (44,15,'products/estee_lauder_for_men_cologne_spray_100ml_2.png',null,2);
INSERT INTO products_images VALUES (45,15,'products/estee_lauder_for_men_cologne_spray_100ml_3.png',null,3);
##
INSERT INTO products_images VALUES (46,16,'products/estee_lauder_intuition_eau_de_parfum_spray_100ml_1.png',null,1);
INSERT INTO products_images VALUES (47,16,'products/estee_lauder_intuition_eau_de_parfum_spray_100ml_2.png',null,2);
INSERT INTO products_images VALUES (48,16,'products/estee_lauder_intuition_eau_de_parfum_spray_100ml_3.png',null,3);

INSERT INTO products_images VALUES (49,17,'products/estee_lauder_knowing_eau_de_parfum_spray_75ml_1.png',null,1);
INSERT INTO products_images VALUES (50,17,'products/estee_lauder_knowing_eau_de_parfum_spray_75ml_2.png',null,2);
INSERT INTO products_images VALUES (51,17,'products/estee_lauder_knowing_eau_de_parfum_spray_75ml_3.png',null,3);

INSERT INTO products_images VALUES (52,18,'products/estee_lauder_private_collection_amber_ylang_ylang_parfum_spray_30ml_1.png',null,1);
INSERT INTO products_images VALUES (53,18,'products/estee_lauder_private_collection_amber_ylang_ylang_parfum_spray_30ml_2.png',null,2);
INSERT INTO products_images VALUES (54,18,'products/estee_lauder_private_collection_amber_ylang_ylang_parfum_spray_30ml_3.png',null,3);

INSERT INTO products_images VALUES (55,19,'products/estee_lauder_sensuous_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (56,19,'products/estee_lauder_sensuous_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (57,19,'products/estee_lauder_sensuous_edp_100ml_3.png',null,3);

INSERT INTO products_images VALUES (58,20,'products/fan_di_fendi_edp_30ml_1.png',null,1);
INSERT INTO products_images VALUES (59,20,'products/fan_di_fendi_edp_30ml_2.png',null,2);
INSERT INTO products_images VALUES (60,20,'products/fan_di_fendi_edp_30ml_3.png',null,3);
##
INSERT INTO products_images VALUES (61,21,'products/gerlain_habit_rouge_set_1.png',null,1);
INSERT INTO products_images VALUES (62,21,'products/gerlain_habit_rouge_set_2.png',null,2);
INSERT INTO products_images VALUES (63,21,'products/gerlain_habit_rouge_set_3.png',null,3);

INSERT INTO products_images VALUES (64,22,'products/gucci_guilty_edt_75ml_1.png',null,1);
INSERT INTO products_images VALUES (65,22,'products/gucci_guilty_edt_75ml_2.png',null,2);
INSERT INTO products_images VALUES (66,22,'products/gucci_guilty_edt_75ml_3.png',null,3);

INSERT INTO products_images VALUES (67,23,'products/harrods_rose_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (68,23,'products/harrods_rose_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (69,23,'products/harrods_rose_edp_100ml_3.png',null,3);

INSERT INTO products_images VALUES (70,24,'products/harvest_2009_ange_au_demon_gift_set_1.png',null,1);
INSERT INTO products_images VALUES (71,24,'products/harvest_2009_ange_au_demon_gift_set_2.png',null,2);
INSERT INTO products_images VALUES (72,24,'products/harvest_2009_ange_au_demon_gift_set_3.png',null,3);

INSERT INTO products_images VALUES (73,25,'products/high_line_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (74,25,'products/high_line_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (75,25,'products/high_line_edp_100ml_3.png',null,3);
##
INSERT INTO products_images VALUES (76,26,'products/marc_jacobs_lola_collection_1.png',null,1);
INSERT INTO products_images VALUES (77,26,'products/marc_jacobs_lola_collection_2.png',null,2);
INSERT INTO products_images VALUES (78,26,'products/marc_jacobs_lola_collection_3.png',null,3);

INSERT INTO products_images VALUES (79,27,'products/ormonde_man_edp_50ml_1.png',null,1);
INSERT INTO products_images VALUES (80,27,'products/ormonde_man_edp_50ml_2.png',null,2);
INSERT INTO products_images VALUES (81,27,'products/ormonde_man_edp_50ml_3.png',null,3);

INSERT INTO products_images VALUES (82,28,'products/ormonde_sampaquita_parfum_50ml_1.png',null,1);
INSERT INTO products_images VALUES (83,28,'products/ormonde_sampaquita_parfum_50ml_2.png',null,2);
INSERT INTO products_images VALUES (84,28,'products/ormonde_sampaquita_parfum_50ml_3.png',null,3);

INSERT INTO products_images VALUES (85,29,'products/pour_homme_blue_label_edt_100ml_1.png',null,1);
INSERT INTO products_images VALUES (86,29,'products/pour_homme_blue_label_edt_100ml_2.png',null,2);
INSERT INTO products_images VALUES (87,29,'products/pour_homme_blue_label_edt_100ml_3.png',null,3);

INSERT INTO products_images VALUES (88,30,'products/sensuous_noir_edp_50ml_1.png',null,1);
INSERT INTO products_images VALUES (89,30,'products/sensuous_noir_edp_50ml_2.png',null,2);
INSERT INTO products_images VALUES (90,30,'products/sensuous_noir_edp_50ml_3.png',null,3);
##
INSERT INTO products_images VALUES (91,31,'products/shalimar_by_jade_jagger_edp_30ml_1.png',null,1);
INSERT INTO products_images VALUES (92,31,'products/shalimar_by_jade_jagger_edp_30ml_2.png',null,2);
INSERT INTO products_images VALUES (93,31,'products/shalimar_by_jade_jagger_edp_30ml_3.png',null,3);

INSERT INTO products_images VALUES (94,32,'products/sisley_eau_de_campagne_edt_100ml_1.png',null,1);
INSERT INTO products_images VALUES (95,32,'products/sisley_eau_de_campagne_edt_100ml_2.png',null,2);
INSERT INTO products_images VALUES (96,32,'products/sisley_eau_de_campagne_edt_100ml_3.png',null,3);

INSERT INTO products_images VALUES (97,33,'products/sisley_eau_du_soir_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (98,33,'products/sisley_eau_du_soir_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (99,33,'products/sisley_eau_du_soir_edp_100ml_3.png',null,3);

INSERT INTO products_images VALUES (100,34,'products/sisley_eau_du_soir_limited_edition_black_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (101,34,'products/sisley_eau_du_soir_limited_edition_black_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (102,34,'products/sisley_eau_du_soir_limited_edition_black_edp_100ml_3.png',null,3);

INSERT INTO products_images VALUES (103,35,'products/sisley_eau_du_soir_limited_edition_white_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (104,35,'products/sisley_eau_du_soir_limited_edition_white_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (105,35,'products/sisley_eau_du_soir_limited_edition_white_edp_100ml_3.png',null,3);
##
INSERT INTO products_images VALUES (106,36,'products/sisley_soir_de_lune_edp_100ml_1.png',null,1);
INSERT INTO products_images VALUES (107,36,'products/sisley_soir_de_lune_edp_100ml_2.png',null,2);
INSERT INTO products_images VALUES (108,36,'products/sisley_soir_de_lune_edp_100ml_3.png',null,3);

INSERT INTO products_images VALUES (109,37,'products/success_is_a_job_in_new_york_edp_50ml_1.png',null,1);
INSERT INTO products_images VALUES (110,37,'products/success_is_a_job_in_new_york_edp_50ml_2.png',null,2);
INSERT INTO products_images VALUES (111,37,'products/success_is_a_job_in_new_york_edp_50ml_3.png',null,3);

INSERT INTO products_images VALUES (112,38,'products/tom_ford_amber_absolute_decanter_250ml_1.png',null,1);
INSERT INTO products_images VALUES (113,38,'products/tom_ford_amber_absolute_decanter_250ml_2.png',null,2);
INSERT INTO products_images VALUES (114,38,'products/tom_ford_amber_absolute_decanter_250ml_3.png',null,3);

INSERT INTO products_images VALUES (115,39,'products/tom_ford_amber_absolute_eau_de_parfum_spray_50ml_1.png',null,1);
INSERT INTO products_images VALUES (116,39,'products/tom_ford_amber_absolute_eau_de_parfum_spray_50ml_2.png',null,2);
INSERT INTO products_images VALUES (117,39,'products/tom_ford_amber_absolute_eau_de_parfum_spray_50ml_3.png',null,3);

INSERT INTO products_images VALUES (118,40,'products/tom_ford_white_suede_parfum_spray_50ml_1.png',null,1);
INSERT INTO products_images VALUES (119,40,'products/tom_ford_white_suede_parfum_spray_50ml_2.png',null,2);
INSERT INTO products_images VALUES (120,40,'products/tom_ford_white_suede_parfum_spray_50ml_3.png',null,3);
################################################################################################
################################################################################################
INSERT INTO `products_attributes` VALUES(1, 1, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(2, 1, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(3, 1, 2, 4, 15.0000, '-');
INSERT INTO `products_attributes` VALUES(4, 1, 1, 1, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(5, 1, 1, 7, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(6, 1, 2, 8, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(7, 2, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(8, 2, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(9, 2, 2, 4, 15.0000, '-');
INSERT INTO `products_attributes` VALUES(10, 2, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(11, 2, 1, 7, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(12, 2, 2, 8, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(13, 3, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(14, 3, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(15, 3, 1, 1, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(16, 3, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(17, 3, 2, 8, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(18, 3, 2, 4, 20.0000, '-');
INSERT INTO `products_attributes` VALUES(19, 4, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(20, 4, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(21, 4, 1, 7, 30.0000, '+');
INSERT INTO `products_attributes` VALUES(22, 4, 2, 4, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(23, 4, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(24, 4, 2, 8, 100.0000, '');
INSERT INTO `products_attributes` VALUES(25, 5, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(26, 5, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(27, 5, 1, 1, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(28, 5, 1, 7, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(29, 5, 2, 8, 30.0000, '+');
INSERT INTO `products_attributes` VALUES(30, 5, 2, 4, 10.0000, '-');
INSERT INTO `products_attributes` VALUES(31, 6, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(32, 6, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(33, 6, 1, 7, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(34, 6, 1, 1, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(35, 6, 2, 8, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(36, 6, 2, 4, 15.0000, '-');
INSERT INTO `products_attributes` VALUES(37, 7, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(38, 7, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(39, 7, 1, 7, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(40, 7, 1, 1, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(41, 7, 2, 8, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(42, 7, 2, 4, 20.0000, '-');
INSERT INTO `products_attributes` VALUES(43, 8, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(44, 8, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(45, 8, 1, 7, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(46, 8, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(47, 8, 2, 8, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(48, 8, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(49, 9, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(50, 9, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(51, 9, 1, 7, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(52, 9, 1, 1, 40.0000, '+');
INSERT INTO `products_attributes` VALUES(53, 9, 2, 8, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(54, 9, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(55, 10, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(56, 10, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(57, 10, 1, 7, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(58, 10, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(59, 10, 2, 8, 40.0000, '+');
INSERT INTO `products_attributes` VALUES(60, 10, 2, 4, 20.0000, '-');
INSERT INTO `products_attributes` VALUES(61, 11, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(62, 11, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(63, 11, 1, 7, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(64, 11, 1, 1, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(65, 11, 2, 8, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(66, 11, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(67, 12, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(68, 12, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(69, 12, 1, 7, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(70, 12, 1, 1, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(71, 12, 2, 8, 30.0000, '+');
INSERT INTO `products_attributes` VALUES(72, 12, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(73, 13, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(74, 13, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(75, 13, 1, 7, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(76, 13, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(77, 13, 2, 8, 30.0000, '+');
INSERT INTO `products_attributes` VALUES(78, 13, 2, 4, 10.0000, '-');
INSERT INTO `products_attributes` VALUES(79, 14, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(80, 14, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(81, 14, 1, 7, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(82, 14, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(83, 14, 2, 8, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(84, 14, 2, 4, 10.0000, '-');
INSERT INTO `products_attributes` VALUES(85, 15, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(86, 15, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(87, 15, 1, 7, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(88, 15, 1, 1, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(89, 15, 2, 8, 25.0000, '+');
INSERT INTO `products_attributes` VALUES(90, 15, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(91, 16, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(92, 16, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(93, 16, 1, 7, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(94, 16, 1, 1, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(95, 16, 2, 8, 25.0000, '+');
INSERT INTO `products_attributes` VALUES(96, 16, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(97, 17, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(98, 17, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(99, 17, 1, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(100, 17, 1, 1, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(101, 17, 2, 8, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(102, 17, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(103, 18, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(104, 18, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(105, 18, 1, 7, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(106, 18, 1, 1, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(107, 18, 2, 8, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(108, 18, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(109, 19, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(110, 19, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(111, 19, 2, 8, 30.0000, '+');
INSERT INTO `products_attributes` VALUES(112, 19, 1, 7, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(113, 19, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(114, 19, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(115, 20, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(116, 20, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(117, 20, 1, 7, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(118, 20, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(119, 20, 2, 8, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(120, 20, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(121, 21, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(122, 21, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(123, 21, 1, 7, 5.0000, '+');
INSERT INTO `products_attributes` VALUES(124, 21, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(125, 21, 2, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(126, 21, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(127, 22, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(128, 22, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(129, 22, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(130, 22, 1, 7, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(131, 22, 2, 8, 25.0000, '+');
INSERT INTO `products_attributes` VALUES(132, 22, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(133, 23, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(134, 23, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(135, 23, 1, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(136, 23, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(137, 23, 2, 8, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(138, 23, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(139, 24, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(140, 24, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(141, 24, 2, 8, 15.0000, '+');
INSERT INTO `products_attributes` VALUES(142, 24, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(143, 24, 1, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(144, 24, 1, 1, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(145, 25, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(146, 25, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(147, 25, 1, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(148, 25, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(149, 25, 2, 8, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(150, 25, 2, 4, 10.0000, '-');
INSERT INTO `products_attributes` VALUES(151, 26, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(152, 26, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(153, 26, 1, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(154, 26, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(155, 26, 2, 8, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(156, 26, 2, 4, 10.0000, '-');
INSERT INTO `products_attributes` VALUES(157, 27, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(158, 27, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(159, 27, 2, 8, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(160, 27, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(161, 27, 1, 7, 25.0000, '+');
INSERT INTO `products_attributes` VALUES(162, 27, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(163, 28, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(164, 28, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(165, 28, 1, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(166, 28, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(167, 28, 2, 8, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(168, 28, 2, 4, 5.0000, '-');
INSERT INTO `products_attributes` VALUES(169, 29, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(170, 29, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(171, 29, 1, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(172, 29, 1, 1, 99.9900, '');
INSERT INTO `products_attributes` VALUES(173, 29, 2, 8, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(174, 29, 2, 4, 10.0000, '-');
INSERT INTO `products_attributes` VALUES(175, 30, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(176, 30, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES(177, 30, 1, 7, 149.9900, '+');
INSERT INTO `products_attributes` VALUES(178, 30, 1, 1, 10.0000, '+');
INSERT INTO `products_attributes` VALUES(179, 30, 2, 8, 20.0000, '+');
INSERT INTO `products_attributes` VALUES(180, 30, 2, 4, 10.0000, '-');
INSERT INTO `products_attributes` VALUES(181, 31, 3, 6, 109.9900, '');
INSERT INTO `products_attributes` VALUES(182, 31, 3, 5, 99.9900, '');
## #################################
INSERT INTO products_attributes_download VALUES (31, 'unreal.zip', 7, 3);
## #################################
INSERT INTO `products_options` VALUES(1, 1, 'Color');
INSERT INTO `products_options` VALUES(2, 1, 'Size');
INSERT INTO `products_options` VALUES(3, 1, 'Version');
## #################################
INSERT INTO `products_options_values` VALUES(1, 1, 'light');
INSERT INTO `products_options_values` VALUES(2, 1, 'original');
INSERT INTO `products_options_values` VALUES(3, 1, 'standard');
INSERT INTO `products_options_values` VALUES(4, 1, 'small');
INSERT INTO `products_options_values` VALUES(5, 1, 'Download: Windows - English');
INSERT INTO `products_options_values` VALUES(6, 1, 'Box: Windows - English');
INSERT INTO `products_options_values` VALUES(7, 1, 'dark');
INSERT INTO `products_options_values` VALUES(8, 1, 'large');
## #################################
INSERT INTO `products_options_values_to_products_options` VALUES(1, 1, 1);
INSERT INTO `products_options_values_to_products_options` VALUES(2, 1, 2);
INSERT INTO `products_options_values_to_products_options` VALUES(3, 2, 3);
INSERT INTO `products_options_values_to_products_options` VALUES(4, 2, 4);
INSERT INTO `products_options_values_to_products_options` VALUES(5, 3, 5);
INSERT INTO `products_options_values_to_products_options` VALUES(6, 3, 6);
## #################################
INSERT INTO products_to_categories VALUES (1,1);
INSERT INTO products_to_categories VALUES (2,1);
INSERT INTO products_to_categories VALUES (3,1);
INSERT INTO products_to_categories VALUES (4,1);
INSERT INTO products_to_categories VALUES (5,1);
INSERT INTO products_to_categories VALUES (6,1);
INSERT INTO products_to_categories VALUES (7,1);
INSERT INTO products_to_categories VALUES (8,1);
#######
INSERT INTO products_to_categories VALUES (9,23);
INSERT INTO products_to_categories VALUES (10,23);
INSERT INTO products_to_categories VALUES (11,23);
INSERT INTO products_to_categories VALUES (12,23);
INSERT INTO products_to_categories VALUES (13,23);
INSERT INTO products_to_categories VALUES (14,23);
INSERT INTO products_to_categories VALUES (15,23);
INSERT INTO products_to_categories VALUES (16,23);
INSERT INTO products_to_categories VALUES (17,3);
INSERT INTO products_to_categories VALUES (18,3);
INSERT INTO products_to_categories VALUES (19,3);
INSERT INTO products_to_categories VALUES (20,3);
#######
INSERT INTO products_to_categories VALUES (21,3);
INSERT INTO products_to_categories VALUES (22,3);
INSERT INTO products_to_categories VALUES (23,3);
INSERT INTO products_to_categories VALUES (24,3);
INSERT INTO products_to_categories VALUES (25,4);
INSERT INTO products_to_categories VALUES (26,4);
INSERT INTO products_to_categories VALUES (27,4);
INSERT INTO products_to_categories VALUES (28,4);
INSERT INTO products_to_categories VALUES (29,4);
INSERT INTO products_to_categories VALUES (30,4);
#######
INSERT INTO products_to_categories VALUES (31,4);
INSERT INTO products_to_categories VALUES (32,4);
INSERT INTO products_to_categories VALUES (33,5);
INSERT INTO products_to_categories VALUES (34,5);
INSERT INTO products_to_categories VALUES (35,5);
INSERT INTO products_to_categories VALUES (36,5);
INSERT INTO products_to_categories VALUES (37,5);
INSERT INTO products_to_categories VALUES (38,5);
INSERT INTO products_to_categories VALUES (39,5);
INSERT INTO products_to_categories VALUES (40,5);
#######
INSERT INTO products_to_categories VALUES (41,6);
INSERT INTO products_to_categories VALUES (42,6);
INSERT INTO products_to_categories VALUES (43,6);
INSERT INTO products_to_categories VALUES (44,6);
INSERT INTO products_to_categories VALUES (45,6);
INSERT INTO products_to_categories VALUES (46,6);
INSERT INTO products_to_categories VALUES (47,6);
INSERT INTO products_to_categories VALUES (48,6);
INSERT INTO products_to_categories VALUES (49,7);
INSERT INTO products_to_categories VALUES (50,7);
#######
INSERT INTO products_to_categories VALUES (21,7);
INSERT INTO products_to_categories VALUES (22,7);
INSERT INTO products_to_categories VALUES (23,7);
INSERT INTO products_to_categories VALUES (24,7);
INSERT INTO products_to_categories VALUES (25,7);
INSERT INTO products_to_categories VALUES (6,7);
INSERT INTO products_to_categories VALUES (7,8);
INSERT INTO products_to_categories VALUES (8,8);
INSERT INTO products_to_categories VALUES (9,8);
INSERT INTO products_to_categories VALUES (10,8);
#######
INSERT INTO products_to_categories VALUES (11,8);
INSERT INTO products_to_categories VALUES (12,8);
INSERT INTO products_to_categories VALUES (13,8);
INSERT INTO products_to_categories VALUES (14,8);
INSERT INTO products_to_categories VALUES (15,9);
INSERT INTO products_to_categories VALUES (16,9);
INSERT INTO products_to_categories VALUES (17,9);
INSERT INTO products_to_categories VALUES (18,9);
INSERT INTO products_to_categories VALUES (19,9);
INSERT INTO products_to_categories VALUES (20,9);
#######
INSERT INTO products_to_categories VALUES (21,9);
INSERT INTO products_to_categories VALUES (22,9);
INSERT INTO products_to_categories VALUES (23,10);
INSERT INTO products_to_categories VALUES (24,10);
INSERT INTO products_to_categories VALUES (25,10);
INSERT INTO products_to_categories VALUES (26,10);
INSERT INTO products_to_categories VALUES (27,10);
INSERT INTO products_to_categories VALUES (28,10);
INSERT INTO products_to_categories VALUES (29,10);
INSERT INTO products_to_categories VALUES (30,10);
#######
INSERT INTO products_to_categories VALUES (31,11);
INSERT INTO products_to_categories VALUES (32,11);
INSERT INTO products_to_categories VALUES (33,11);
INSERT INTO products_to_categories VALUES (34,11);
INSERT INTO products_to_categories VALUES (35,11);
INSERT INTO products_to_categories VALUES (36,11);
INSERT INTO products_to_categories VALUES (37,11);
INSERT INTO products_to_categories VALUES (38,11);
INSERT INTO products_to_categories VALUES (39,12);
INSERT INTO products_to_categories VALUES (40,12);
#######
INSERT INTO products_to_categories VALUES (41,12);
INSERT INTO products_to_categories VALUES (42,12);
INSERT INTO products_to_categories VALUES (43,12);
INSERT INTO products_to_categories VALUES (44,12);
INSERT INTO products_to_categories VALUES (45,12);
INSERT INTO products_to_categories VALUES (46,12);
INSERT INTO products_to_categories VALUES (47,13);
INSERT INTO products_to_categories VALUES (48,13);
INSERT INTO products_to_categories VALUES (49,13);
INSERT INTO products_to_categories VALUES (50,13);
#######
INSERT INTO products_to_categories VALUES (51,13);
INSERT INTO products_to_categories VALUES (52,13);
INSERT INTO products_to_categories VALUES (3,13);
INSERT INTO products_to_categories VALUES (4,13);
INSERT INTO products_to_categories VALUES (5,14);
INSERT INTO products_to_categories VALUES (6,14);
INSERT INTO products_to_categories VALUES (7,14);
INSERT INTO products_to_categories VALUES (8,14);
INSERT INTO products_to_categories VALUES (9,14);
INSERT INTO products_to_categories VALUES (10,14);
#######
INSERT INTO products_to_categories VALUES (11,14);
INSERT INTO products_to_categories VALUES (12,14);

INSERT INTO products_to_categories VALUES (33,15);
INSERT INTO products_to_categories VALUES (34,15);
INSERT INTO products_to_categories VALUES (35,15);
INSERT INTO products_to_categories VALUES (36,15);
INSERT INTO products_to_categories VALUES (37,15);
INSERT INTO products_to_categories VALUES (38,15);
INSERT INTO products_to_categories VALUES (39,15);
INSERT INTO products_to_categories VALUES (40,15);
#######
INSERT INTO products_to_categories VALUES (41,16);
INSERT INTO products_to_categories VALUES (42,16);
INSERT INTO products_to_categories VALUES (43,16);
INSERT INTO products_to_categories VALUES (44,16);
INSERT INTO products_to_categories VALUES (45,16);
INSERT INTO products_to_categories VALUES (46,16);
INSERT INTO products_to_categories VALUES (47,16);
INSERT INTO products_to_categories VALUES (48,16);
INSERT INTO products_to_categories VALUES (49,17);
INSERT INTO products_to_categories VALUES (50,17);
#######
INSERT INTO products_to_categories VALUES (21,17);
INSERT INTO products_to_categories VALUES (22,17);
INSERT INTO products_to_categories VALUES (23,17);
INSERT INTO products_to_categories VALUES (24,17);
INSERT INTO products_to_categories VALUES (25,17);
INSERT INTO products_to_categories VALUES (6,17);
INSERT INTO products_to_categories VALUES (7,22);
INSERT INTO products_to_categories VALUES (8,22);
INSERT INTO products_to_categories VALUES (9,22);
INSERT INTO products_to_categories VALUES (10,22);
#######
INSERT INTO products_to_categories VALUES (11,22);
INSERT INTO products_to_categories VALUES (12,22);
INSERT INTO products_to_categories VALUES (13,22);
INSERT INTO products_to_categories VALUES (14,22);
INSERT INTO products_to_categories VALUES (15,19);
INSERT INTO products_to_categories VALUES (16,19);
INSERT INTO products_to_categories VALUES (17,19);
INSERT INTO products_to_categories VALUES (18,19);
INSERT INTO products_to_categories VALUES (19,19);
INSERT INTO products_to_categories VALUES (20,19);
#######
INSERT INTO products_to_categories VALUES (21,19);
INSERT INTO products_to_categories VALUES (22,19);
INSERT INTO products_to_categories VALUES (23,20);
INSERT INTO products_to_categories VALUES (24,20);
INSERT INTO products_to_categories VALUES (25,20);
INSERT INTO products_to_categories VALUES (26,20);
INSERT INTO products_to_categories VALUES (27,20);
INSERT INTO products_to_categories VALUES (28,20);
INSERT INTO products_to_categories VALUES (29,20);
INSERT INTO products_to_categories VALUES (30,20);
#######
INSERT INTO products_to_categories VALUES (31,21);
INSERT INTO products_to_categories VALUES (32,21);
INSERT INTO products_to_categories VALUES (33,21);
INSERT INTO products_to_categories VALUES (34,21);
INSERT INTO products_to_categories VALUES (35,21);
INSERT INTO products_to_categories VALUES (36,21);
INSERT INTO products_to_categories VALUES (37,21);
INSERT INTO products_to_categories VALUES (38,21);
## #################################
INSERT INTO reviews VALUES (1,10,0,'John Doe',2,now(),null,1,0);
INSERT INTO reviews VALUES (2,9,0,'John Doe',3,now(),null,1,0);
INSERT INTO reviews VALUES (3,8,0,'John Doe',5,now(),null,1,0);
INSERT INTO reviews VALUES (4,7,0,'John Doe',1,now(),null,1,0);
INSERT INTO reviews VALUES (5,6,0,'John Doe',2,now(),null,1,0);
INSERT INTO reviews VALUES (6,5,0,'John Doe',3,now(),null,1,0);
INSERT INTO reviews VALUES (7,4,0,'John Doe',4,now(),null,1,0);
INSERT INTO reviews VALUES (8,3,0,'John Doe',5,now(),null,1,0);
INSERT INTO reviews VALUES (9,2,0,'John Doe',1,now(),null,1,0);
INSERT INTO reviews VALUES (10,1,0,'John Doe',2,now(),null,1,0);
INSERT INTO reviews VALUES (11,7,0,'John Doe',3,now(),null,1,0);
INSERT INTO reviews VALUES (12,6,0,'John Doe',4,now(),null,1,0);
INSERT INTO reviews VALUES (13,5,0,'John Doe',5,now(),null,1,0);
INSERT INTO reviews VALUES (14,4,0,'John Doe',1,now(),null,1,0);
INSERT INTO reviews VALUES (15,3,0,'John Doe',2,now(),null,1,0);
INSERT INTO reviews VALUES (16,3,0,'John Doe',3,now(),null,1,0);
INSERT INTO reviews VALUES (17,2,0,'John Doe',4,now(),null,1,0);
INSERT INTO reviews VALUES (18,2,0,'John Doe',5,now(),null,1,0);
INSERT INTO reviews VALUES (19,1,0,'John Doe',1,now(),null,1,0);
INSERT INTO reviews VALUES (20,1,0,'John Doe',3,now(),null,1,0);
## #################################
INSERT INTO reviews_description VALUES (1,1, 'Suspendisse tristique aliquam felis, quis pellentesque nibh iaculis ut. Nam eget felis non tortor adipiscing pulvinar. Pellentesque mauris diam, posuere a pretium sed, lobortis dapibus urna. Aenean scelerisque interdum sapien, in blandit nisl rutrum sed. Cras in mi velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent eget erat sodales dolor lobortis congue. Nunc venenatis ipsum eu enim lacinia adipiscing eget elementum enim. Donec viverra, diam non venenatis malesuada, risus risus malesuada enim, eu scelerisque nisi ligula ullamcorper nunc. Duis tellus neque, imperdiet id venenatis quis, dapibus vel orci. Nam porta ullamcorper vehicula.');
INSERT INTO reviews_description VALUES (2,1, 'Nullam malesuada suscipit velit faucibus pulvinar. Vivamus a tortor in leo luctus hendrerit ut in risus. Pellentesque vel quam quis lorem auctor laoreet tincidunt consequat leo. Nullam dapibus mi cursus neque dictum condimentum. Etiam pharetra lacus vel lorem tempor iaculis. Donec facilisis, augue in cursus auctor, leo orci facilisis lacus, consectetur tempor neque lorem a lorem. Phasellus enim nisl, rutrum et semper id, tincidunt vel lorem. Donec auctor semper dui, id blandit risus porttitor nec. Nullam a dolor nisi, vitae tempor lectus. Pellentesque vel neque quis lectus dapibus rhoncus vitae eu diam. Praesent quis magna dolor. Aliquam sem odio, scelerisque non sollicitudin at, feugiat in nisl. ');
INSERT INTO reviews_description VALUES (3,1, 'Integer adipiscing arcu a nisl imperdiet vulputate. In magna justo, suscipit non rhoncus sit amet, laoreet at sem. Ut tincidunt quam a libero ultricies a lobortis nisl venenatis. Aenean in metus in libero porttitor hendrerit a ac elit. Pellentesque fringilla iaculis lacus, id ultricies neque fermentum eget. Integer malesuada ipsum et ipsum mollis at lacinia elit consectetur. In porta, nulla sit amet convallis blandit, orci lorem feugiat augue, sed fermentum est mauris ut ipsum. Pellentesque non urna turpis. Donec cursus blandit mi, nec sollicitudin justo tempor non. Donec nec dolor sit amet risus cursus consequat. Vivamus tellus lorem, pharetra in convallis posuere, ultricies a purus. Integer semper. ');
INSERT INTO reviews_description VALUES (4,1, 'Maecenas nibh magna, viverra et posuere id, pharetra vel augue. Donec sed diam dolor, et varius ante. Phasellus vitae leo in erat congue cursus. Vivamus aliquam nisl quis justo gravida non euismod neque euismod. In feugiat lorem at metus rutrum pellentesque. Ut facilisis accumsan sollicitudin. Curabitur convallis feugiat magna at semper. Nam molestie tincidunt urna eu vestibulum. Aliquam id elit ut diam egestas volutpat sit amet vestibulum orci. Donec ac enim molestie nisi iaculis adipiscing et vel massa. Etiam tempus risus eu odio congue pellentesque. In et malesuada velit. Pellentesque blandit ligula sed erat interdum feugiat. ');
INSERT INTO reviews_description VALUES (5,1, 'Nulla placerat dictum ipsum, vel dictum lectus tristique vitae. Pellentesque ullamcorper felis enim, et tincidunt lorem. Sed aliquet elementum ultricies. Curabitur et tortor quis nisi fermentum venenatis. Duis faucibus, purus eget consequat porta, sem metus condimentum nisi, nec rutrum nibh orci quis eros. Suspendisse dictum tellus quis tortor ullamcorper euismod. Donec dui sem, pulvinar at fringilla in, vulputate quis felis. Nam condimentum magna id metus malesuada blandit. Nulla auctor condimentum odio, ut aliquam tortor aliquam nec. In dolor quam, fermentum at semper sed, rutrum a lacus.');
INSERT INTO reviews_description VALUES (6,1, 'Vestibulum ut augue in orci lobortis sodales nec et nunc. Integer facilisis placerat ipsum, nec pellentesque turpis gravida eu. Suspendisse a dapibus elit. Proin mollis ornare purus non blandit. Praesent rhoncus imperdiet leo sit amet vestibulum. Praesent volutpat risus a metus faucibus a rhoncus nisl malesuada. Fusce vel dolor adipiscing quam euismod pretium quis at ante. Praesent vitae ante eros. Fusce sapien lorem, adipiscing et porta aliquet, placerat vel diam. Sed augue neque, dignissim quis scelerisque fermentum, aliquet vitae libero. Morbi ultricies congue tortor ut auctor.');
INSERT INTO reviews_description VALUES (7,1, 'Nunc quis fermentum tortor. Nulla eget nulla massa, ut luctus urna. Vestibulum dapibus ligula sed lorem ullamcorper pellentesque. Duis enim est, mollis sit amet pulvinar eu, suscipit sed nunc. Mauris semper nibh vel est placerat ac luctus tellus rhoncus. Aenean suscipit arcu sed sem ultrices id hendrerit odio pulvinar. Vestibulum tincidunt, justo eu semper pellentesque, urna dolor condimentum purus, eget commodo turpis dolor id augue. Suspendisse at purus mauris, in convallis purus. Maecenas in lacus urna. Donec laoreet lacinia eros a accumsan. Nunc lacinia lobortis augue vitae tincidunt. Morbi in augue et justo viverra fermentum. Nulla facilisi. Ut fringilla blandit dapibus. Vestibulum placerat auctor nulla tincidunt laoreet. ');
INSERT INTO reviews_description VALUES (8,1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc non elit ut nulla ultrices adipiscing dictum ac dui. Suspendisse congue tellus at nibh suscipit a semper diam luctus. In dapibus, dui sit amet congue tincidunt, erat lacus dignissim justo, id accumsan urna mi a odio. Aliquam erat volutpat. Nunc bibendum mattis nisl condimentum iaculis. Curabitur facilisis turpis in diam aliquet vel congue purus cursus. Vestibulum massa arcu, posuere quis viverra in, ultricies in nunc. Integer consequat, risus id semper ornare, orci tellus mattis ante, nec suscipit leo urna at ipsum.');
INSERT INTO reviews_description VALUES (9,1, 'Curabitur a justo id elit gravida tincidunt ac sit amet elit. Fusce at sem lacus, vel luctus dolor. Quisque fringilla, orci vitae aliquet malesuada, purus nibh ornare leo, nec pretium metus lorem vitae felis. Sed dolor lacus, euismod eget vulputate at, hendrerit condimentum augue. Nam mollis tortor vel lorem sodales interdum. Nam consequat, mi eu elementum egestas, nunc orci porta augue, et bibendum nibh sem in nulla. Donec lacinia tortor eget lectus posuere egestas. Phasellus a nulla ipsum, a viverra felis. Phasellus nec purus urna, sit amet sodales leo.');
INSERT INTO reviews_description VALUES (10,1, 'Nam pulvinar consectetur interdum. Cras et metus lacus, non porta quam. Phasellus posuere iaculis libero, ut vestibulum lectus faucibus at. Ut pellentesque molestie molestie. Suspendisse ultricies elementum laoreet. In purus nisl, convallis tristique adipiscing id, ullamcorper eget lectus. Nullam ut pulvinar sem. Sed sit amet iaculis quam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam at interdum velit. Nam elementum eros vel mi mattis venenatis. Maecenas ut mauris neque. Proin tincidunt tellus laoreet elit hendrerit eget tristique metus ornare. Integer eu imperdiet augue. Donec molestie nunc at sem laoreet sed eleifend arcu sagittis.');
INSERT INTO reviews_description VALUES (11,1, 'Suspendisse tristique aliquam felis, quis pellentesque nibh iaculis ut. Nam eget felis non tortor adipiscing pulvinar. Pellentesque mauris diam, posuere a pretium sed, lobortis dapibus urna. Aenean scelerisque interdum sapien, in blandit nisl rutrum sed. Cras in mi velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent eget erat sodales dolor lobortis congue. Nunc venenatis ipsum eu enim lacinia adipiscing eget elementum enim. Donec viverra, diam non venenatis malesuada, risus risus malesuada enim, eu scelerisque nisi ligula ullamcorper nunc. Duis tellus neque, imperdiet id venenatis quis, dapibus vel orci. Nam porta ullamcorper vehicula.');
INSERT INTO reviews_description VALUES (12,1, 'Nullam malesuada suscipit velit faucibus pulvinar. Vivamus a tortor in leo luctus hendrerit ut in risus. Pellentesque vel quam quis lorem auctor laoreet tincidunt consequat leo. Nullam dapibus mi cursus neque dictum condimentum. Etiam pharetra lacus vel lorem tempor iaculis. Donec facilisis, augue in cursus auctor, leo orci facilisis lacus, consectetur tempor neque lorem a lorem. Phasellus enim nisl, rutrum et semper id, tincidunt vel lorem. Donec auctor semper dui, id blandit risus porttitor nec. Nullam a dolor nisi, vitae tempor lectus. Pellentesque vel neque quis lectus dapibus rhoncus vitae eu diam. Praesent quis magna dolor. Aliquam sem odio, scelerisque non sollicitudin at, feugiat in nisl. ');
INSERT INTO reviews_description VALUES (13,1, 'Integer adipiscing arcu a nisl imperdiet vulputate. In magna justo, suscipit non rhoncus sit amet, laoreet at sem. Ut tincidunt quam a libero ultricies a lobortis nisl venenatis. Aenean in metus in libero porttitor hendrerit a ac elit. Pellentesque fringilla iaculis lacus, id ultricies neque fermentum eget. Integer malesuada ipsum et ipsum mollis at lacinia elit consectetur. In porta, nulla sit amet convallis blandit, orci lorem feugiat augue, sed fermentum est mauris ut ipsum. Pellentesque non urna turpis. Donec cursus blandit mi, nec sollicitudin justo tempor non. Donec nec dolor sit amet risus cursus consequat. Vivamus tellus lorem, pharetra in convallis posuere, ultricies a purus. Integer semper. ');
INSERT INTO reviews_description VALUES (14,1, 'Maecenas nibh magna, viverra et posuere id, pharetra vel augue. Donec sed diam dolor, et varius ante. Phasellus vitae leo in erat congue cursus. Vivamus aliquam nisl quis justo gravida non euismod neque euismod. In feugiat lorem at metus rutrum pellentesque. Ut facilisis accumsan sollicitudin. Curabitur convallis feugiat magna at semper. Nam molestie tincidunt urna eu vestibulum. Aliquam id elit ut diam egestas volutpat sit amet vestibulum orci. Donec ac enim molestie nisi iaculis adipiscing et vel massa. Etiam tempus risus eu odio congue pellentesque. In et malesuada velit. Pellentesque blandit ligula sed erat interdum feugiat. ');
INSERT INTO reviews_description VALUES (15,1, 'Nulla placerat dictum ipsum, vel dictum lectus tristique vitae. Pellentesque ullamcorper felis enim, et tincidunt lorem. Sed aliquet elementum ultricies. Curabitur et tortor quis nisi fermentum venenatis. Duis faucibus, purus eget consequat porta, sem metus condimentum nisi, nec rutrum nibh orci quis eros. Suspendisse dictum tellus quis tortor ullamcorper euismod. Donec dui sem, pulvinar at fringilla in, vulputate quis felis. Nam condimentum magna id metus malesuada blandit. Nulla auctor condimentum odio, ut aliquam tortor aliquam nec. In dolor quam, fermentum at semper sed, rutrum a lacus.');
INSERT INTO reviews_description VALUES (16,1, 'Vestibulum ut augue in orci lobortis sodales nec et nunc. Integer facilisis placerat ipsum, nec pellentesque turpis gravida eu. Suspendisse a dapibus elit. Proin mollis ornare purus non blandit. Praesent rhoncus imperdiet leo sit amet vestibulum. Praesent volutpat risus a metus faucibus a rhoncus nisl malesuada. Fusce vel dolor adipiscing quam euismod pretium quis at ante. Praesent vitae ante eros. Fusce sapien lorem, adipiscing et porta aliquet, placerat vel diam. Sed augue neque, dignissim quis scelerisque fermentum, aliquet vitae libero. Morbi ultricies congue tortor ut auctor.');
INSERT INTO reviews_description VALUES (17,1, 'Nunc quis fermentum tortor. Nulla eget nulla massa, ut luctus urna. Vestibulum dapibus ligula sed lorem ullamcorper pellentesque. Duis enim est, mollis sit amet pulvinar eu, suscipit sed nunc. Mauris semper nibh vel est placerat ac luctus tellus rhoncus. Aenean suscipit arcu sed sem ultrices id hendrerit odio pulvinar. Vestibulum tincidunt, justo eu semper pellentesque, urna dolor condimentum purus, eget commodo turpis dolor id augue. Suspendisse at purus mauris, in convallis purus. Maecenas in lacus urna. Donec laoreet lacinia eros a accumsan. Nunc lacinia lobortis augue vitae tincidunt. Morbi in augue et justo viverra fermentum. Nulla facilisi. Ut fringilla blandit dapibus. Vestibulum placerat auctor nulla tincidunt laoreet. ');
INSERT INTO reviews_description VALUES (18,1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc non elit ut nulla ultrices adipiscing dictum ac dui. Suspendisse congue tellus at nibh suscipit a semper diam luctus. In dapibus, dui sit amet congue tincidunt, erat lacus dignissim justo, id accumsan urna mi a odio. Aliquam erat volutpat. Nunc bibendum mattis nisl condimentum iaculis. Curabitur facilisis turpis in diam aliquet vel congue purus cursus. Vestibulum massa arcu, posuere quis viverra in, ultricies in nunc. Integer consequat, risus id semper ornare, orci tellus mattis ante, nec suscipit leo urna at ipsum.');
INSERT INTO reviews_description VALUES (19,1, 'Curabitur a justo id elit gravida tincidunt ac sit amet elit. Fusce at sem lacus, vel luctus dolor. Quisque fringilla, orci vitae aliquet malesuada, purus nibh ornare leo, nec pretium metus lorem vitae felis. Sed dolor lacus, euismod eget vulputate at, hendrerit condimentum augue. Nam mollis tortor vel lorem sodales interdum. Nam consequat, mi eu elementum egestas, nunc orci porta augue, et bibendum nibh sem in nulla. Donec lacinia tortor eget lectus posuere egestas. Phasellus a nulla ipsum, a viverra felis. Phasellus nec purus urna, sit amet sodales leo.');
INSERT INTO reviews_description VALUES (20,1, 'Nam pulvinar consectetur interdum. Cras et metus lacus, non porta quam. Phasellus posuere iaculis libero, ut vestibulum lectus faucibus at. Ut pellentesque molestie molestie. Suspendisse ultricies elementum laoreet. In purus nisl, convallis tristique adipiscing id, ullamcorper eget lectus. Nullam ut pulvinar sem. Sed sit amet iaculis quam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam at interdum velit. Nam elementum eros vel mi mattis venenatis. Maecenas ut mauris neque. Proin tincidunt tellus laoreet elit hendrerit eget tristique metus ornare. Integer eu imperdiet augue. Donec molestie nunc at sem laoreet sed eleifend arcu sagittis.');
## #################################
INSERT INTO sec_directory_whitelist values (null, 'admin/backups');
INSERT INTO sec_directory_whitelist values (null, 'admin/images/graphs');
INSERT INTO sec_directory_whitelist values (null, 'images');
INSERT INTO sec_directory_whitelist values (null, 'images/banners');
INSERT INTO sec_directory_whitelist values (null, 'includes/work');
INSERT INTO sec_directory_whitelist values (null, 'pub');
INSERT INTO sec_directory_whitelist values (null, 'includes/products');
## #################################
INSERT INTO specials VALUES (1,3, 39.99, now(), null, null, null, '1');
INSERT INTO specials VALUES (2,5, 30.00, now(), null, null, null, '1');
INSERT INTO specials VALUES (3,6, 30.00, now(), null, null, null, '1');
INSERT INTO specials VALUES (4,16, 29.99, now(), null, null, null, '1');
INSERT INTO specials VALUES (5,26, 5.00, now(), null, null, null, '1');
INSERT INTO specials VALUES (6,12, 5.99, now(), null, null, null, '1');
## #################################
INSERT INTO tax_class VALUES (1, 'Taxable Goods', 'The following types of products are included non-food, services, etc', now(), now());
## #################################
# USA/Florida
INSERT INTO tax_rates VALUES (1, 1, 1, 1, 7.0, 'FL TAX 7.0%', now(), now());
INSERT INTO geo_zones (geo_zone_id,geo_zone_name,geo_zone_description,date_added) VALUES (1,"Florida","Florida local sales tax zone",now());
INSERT INTO zones_to_geo_zones (association_id,zone_country_id,zone_id,geo_zone_id,date_added) VALUES (1,223,18,1,now());
## #################################
# USA
INSERT INTO zones VALUES (1,223,'AL','Alabama');
INSERT INTO zones VALUES (2,223,'AK','Alaska');
INSERT INTO zones VALUES (3,223,'AS','American Samoa');
INSERT INTO zones VALUES (4,223,'AZ','Arizona');
INSERT INTO zones VALUES (5,223,'AR','Arkansas');
INSERT INTO zones VALUES (6,223,'AF','Armed Forces Africa');
INSERT INTO zones VALUES (7,223,'AA','Armed Forces Americas');
INSERT INTO zones VALUES (8,223,'AC','Armed Forces Canada');
INSERT INTO zones VALUES (9,223,'AE','Armed Forces Europe');
INSERT INTO zones VALUES (10,223,'AM','Armed Forces Middle East');
INSERT INTO zones VALUES (11,223,'AP','Armed Forces Pacific');
INSERT INTO zones VALUES (12,223,'CA','California');
INSERT INTO zones VALUES (13,223,'CO','Colorado');
INSERT INTO zones VALUES (14,223,'CT','Connecticut');
INSERT INTO zones VALUES (15,223,'DE','Delaware');
INSERT INTO zones VALUES (16,223,'DC','District of Columbia');
INSERT INTO zones VALUES (17,223,'FM','Federated States Of Micronesia');
INSERT INTO zones VALUES (18,223,'FL','Florida');
INSERT INTO zones VALUES (19,223,'GA','Georgia');
INSERT INTO zones VALUES (20,223,'GU','Guam');
INSERT INTO zones VALUES (21,223,'HI','Hawaii');
INSERT INTO zones VALUES (22,223,'ID','Idaho');
INSERT INTO zones VALUES (23,223,'IL','Illinois');
INSERT INTO zones VALUES (24,223,'IN','Indiana');
INSERT INTO zones VALUES (25,223,'IA','Iowa');
INSERT INTO zones VALUES (26,223,'KS','Kansas');
INSERT INTO zones VALUES (27,223,'KY','Kentucky');
INSERT INTO zones VALUES (28,223,'LA','Louisiana');
INSERT INTO zones VALUES (29,223,'ME','Maine');
INSERT INTO zones VALUES (30,223,'MH','Marshall Islands');
INSERT INTO zones VALUES (31,223,'MD','Maryland');
INSERT INTO zones VALUES (32,223,'MA','Massachusetts');
INSERT INTO zones VALUES (33,223,'MI','Michigan');
INSERT INTO zones VALUES (34,223,'MN','Minnesota');
INSERT INTO zones VALUES (35,223,'MS','Mississippi');
INSERT INTO zones VALUES (36,223,'MO','Missouri');
INSERT INTO zones VALUES (37,223,'MT','Montana');
INSERT INTO zones VALUES (38,223,'NE','Nebraska');
INSERT INTO zones VALUES (39,223,'NV','Nevada');
INSERT INTO zones VALUES (40,223,'NH','New Hampshire');
INSERT INTO zones VALUES (41,223,'NJ','New Jersey');
INSERT INTO zones VALUES (42,223,'NM','New Mexico');
INSERT INTO zones VALUES (43,223,'NY','New York');
INSERT INTO zones VALUES (44,223,'NC','North Carolina');
INSERT INTO zones VALUES (45,223,'ND','North Dakota');
INSERT INTO zones VALUES (46,223,'MP','Northern Mariana Islands');
INSERT INTO zones VALUES (47,223,'OH','Ohio');
INSERT INTO zones VALUES (48,223,'OK','Oklahoma');
INSERT INTO zones VALUES (49,223,'OR','Oregon');
INSERT INTO zones VALUES (50,223,'PW','Palau');
INSERT INTO zones VALUES (51,223,'PA','Pennsylvania');
INSERT INTO zones VALUES (52,223,'PR','Puerto Rico');
INSERT INTO zones VALUES (53,223,'RI','Rhode Island');
INSERT INTO zones VALUES (54,223,'SC','South Carolina');
INSERT INTO zones VALUES (55,223,'SD','South Dakota');
INSERT INTO zones VALUES (56,223,'TN','Tennessee');
INSERT INTO zones VALUES (57,223,'TX','Texas');
INSERT INTO zones VALUES (58,223,'UT','Utah');
INSERT INTO zones VALUES (59,223,'VT','Vermont');
INSERT INTO zones VALUES (60,223,'VI','Virgin Islands');
INSERT INTO zones VALUES (61,223,'VA','Virginia');
INSERT INTO zones VALUES (62,223,'WA','Washington');
INSERT INTO zones VALUES (63,223,'WV','West Virginia');
INSERT INTO zones VALUES (64,223,'WI','Wisconsin');
INSERT INTO zones VALUES (65,223,'WY','Wyoming');
## #################################
# Canada
INSERT INTO zones VALUES (66,38,'AB','Alberta');
INSERT INTO zones VALUES (67,38,'BC','British Columbia');
INSERT INTO zones VALUES (68,38,'MB','Manitoba');
INSERT INTO zones VALUES (69,38,'NF','Newfoundland');
INSERT INTO zones VALUES (70,38,'NB','New Brunswick');
INSERT INTO zones VALUES (71,38,'NS','Nova Scotia');
INSERT INTO zones VALUES (72,38,'NT','Northwest Territories');
INSERT INTO zones VALUES (73,38,'NU','Nunavut');
INSERT INTO zones VALUES (74,38,'ON','Ontario');
INSERT INTO zones VALUES (75,38,'PE','Prince Edward Island');
INSERT INTO zones VALUES (76,38,'QC','Quebec');
INSERT INTO zones VALUES (77,38,'SK','Saskatchewan');
INSERT INTO zones VALUES (78,38,'YT','Yukon Territory');
## #################################
# Germany
INSERT INTO zones VALUES (79,81,'NDS','Niedersachsen');
INSERT INTO zones VALUES (80,81,'BAW','Baden-Württemberg');
INSERT INTO zones VALUES (81,81,'BAY','Bayern');
INSERT INTO zones VALUES (82,81,'BER','Berlin');
INSERT INTO zones VALUES (83,81,'BRG','Brandenburg');
INSERT INTO zones VALUES (84,81,'BRE','Bremen');
INSERT INTO zones VALUES (85,81,'HAM','Hamburg');
INSERT INTO zones VALUES (86,81,'HES','Hessen');
INSERT INTO zones VALUES (87,81,'MEC','Mecklenburg-Vorpommern');
INSERT INTO zones VALUES (88,81,'NRW','Nordrhein-Westfalen');
INSERT INTO zones VALUES (89,81,'RHE','Rheinland-Pfalz');
INSERT INTO zones VALUES (90,81,'SAR','Saarland');
INSERT INTO zones VALUES (91,81,'SAS','Sachsen');
INSERT INTO zones VALUES (92,81,'SAC','Sachsen-Anhalt');
INSERT INTO zones VALUES (93,81,'SCN','Schleswig-Holstein');
INSERT INTO zones VALUES (94,81,'THE','Thüringen');
## #################################
# Austria
INSERT INTO zones VALUES (95,14,'WI','Wien');
INSERT INTO zones VALUES (96,14,'NO','Niederösterreich');
INSERT INTO zones VALUES (97,14,'OO','Oberösterreich');
INSERT INTO zones VALUES (98,14,'SB','Salzburg');
INSERT INTO zones VALUES (99,14,'KN','Kärnten');
INSERT INTO zones VALUES (100,14,'ST','Steiermark');
INSERT INTO zones VALUES (101,14,'TI','Tirol');
INSERT INTO zones VALUES (102,14,'BL','Burgenland');
INSERT INTO zones VALUES (103,14,'VB','Voralberg');
## #################################
# Swizterland
INSERT INTO zones VALUES (104,204,'AG','Aargau');
INSERT INTO zones VALUES (105,204,'AI','Appenzell Innerrhoden');
INSERT INTO zones VALUES (106,204,'AR','Appenzell Ausserrhoden');
INSERT INTO zones VALUES (107,204,'BE','Bern');
INSERT INTO zones VALUES (108,204,'BL','Basel-Landschaft');
INSERT INTO zones VALUES (109,204,'BS','Basel-Stadt');
INSERT INTO zones VALUES (110,204,'FR','Freiburg');
INSERT INTO zones VALUES (111,204,'GE','Genf');
INSERT INTO zones VALUES (112,204,'GL','Glarus');
INSERT INTO zones VALUES (113,204,'JU','Graubünden');
INSERT INTO zones VALUES (114,204,'JU','Jura');
INSERT INTO zones VALUES (115,204,'LU','Luzern');
INSERT INTO zones VALUES (116,204,'NE','Neuenburg');
INSERT INTO zones VALUES (117,204,'NW','Nidwalden');
INSERT INTO zones VALUES (118,204,'OW','Obwalden');
INSERT INTO zones VALUES (119,204,'SG','St. Gallen');
INSERT INTO zones VALUES (120,204,'SH','Schaffhausen');
INSERT INTO zones VALUES (121,204,'SO','Solothurn');
INSERT INTO zones VALUES (122,204,'SZ','Schwyz');
INSERT INTO zones VALUES (123,204,'TG','Thurgau');
INSERT INTO zones VALUES (124,204,'TI','Tessin');
INSERT INTO zones VALUES (125,204,'UR','Uri');
INSERT INTO zones VALUES (126,204,'VD','Waadt');
INSERT INTO zones VALUES (127,204,'VS','Wallis');
INSERT INTO zones VALUES (128,204,'ZG','Zug');
INSERT INTO zones VALUES (129,204,'ZH','Zürich');
## #################################
# Spain
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'A Coruña','A Coruña');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alava','Alava');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Albacete','Albacete');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alicante','Alicante');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Almeria','Almeria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Asturias','Asturias');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Avila','Avila');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Badajoz','Badajoz');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Baleares','Baleares');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Barcelona','Barcelona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Burgos','Burgos');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Caceres','Caceres');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cadiz','Cadiz');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cantabria','Cantabria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Castellon','Castellon');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ceuta','Ceuta');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ciudad Real','Ciudad Real');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cordoba','Cordoba');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cuenca','Cuenca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Girona','Girona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Granada','Granada');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guadalajara','Guadalajara');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guipuzcoa','Guipuzcoa');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huelva','Huelva');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huesca','Huesca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Jaen','Jaen');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'La Rioja','La Rioja');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Las Palmas','Las Palmas');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Leon','Leon');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lleida','Lleida');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lugo','Lugo');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Madrid','Madrid');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Malaga','Malaga');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Melilla','Melilla');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Murcia','Murcia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Navarra','Navarra');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ourense','Ourense');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Palencia','Palencia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Pontevedra','Pontevedra');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Salamanca','Salamanca');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Segovia','Segovia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Sevilla','Sevilla');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Soria','Soria');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Tarragona','Tarragona');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Teruel','Teruel');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Toledo','Toledo');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valencia','Valencia');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valladolid','Valladolid');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Vizcaya','Vizcaya');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zamora','Zamora');
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zaragoza','Zaragoza');
## #################################
# PayPal Express
INSERT INTO orders_status (orders_status_id, language_id, orders_status_name, public_flag, downloads_flag) values ('4', '1', 'PayPal [Transactions]', 0, 0);
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable PayPal Express Checkout', 'MODULE_PAYMENT_PAYPAL_EXPRESS_STATUS', 'True', 'Do you want to accept PayPal Express Checkout payments?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Seller Account', 'MODULE_PAYMENT_PAYPAL_EXPRESS_SELLER_ACCOUNT', '', 'The email address of the seller account if no API credentials has been setup.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Username', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_USERNAME', '', 'The username to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Password', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_PASSWORD', '', 'The password to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API Signature', 'MODULE_PAYMENT_PAYPAL_EXPRESS_API_SIGNATURE', '', 'The signature to use for the PayPal API service', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Transaction Server', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTION_SERVER', 'Live', 'Use the live or testing (sandbox) gateway server to process transactions?', '6', '0', 'tep_cfg_select_option(array(\'Live\', \'Sandbox\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Transaction Method', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTION_METHOD', 'Sale', 'The processing method to use for each transaction.', '6', '0', 'tep_cfg_select_option(array(\'Authorization\', \'Sale\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Account Optional', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ACCOUNT_OPTIONAL', 'False', 'This must also be enabled in your PayPal account, in Profile > Website Payment Preferences.', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Instant Update', 'MODULE_PAYMENT_PAYPAL_EXPRESS_INSTANT_UPDATE', 'True', 'Support PayPal shipping and tax calculations on the PayPal.com site during Express Checkout.', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal Checkout Image', 'MODULE_PAYMENT_PAYPAL_EXPRESS_CHECKOUT_IMAGE', 'Static', 'Use static or dynamic Express Checkout image buttons. Dynamic images are used with PayPal campaigns.', '6', '0', 'tep_cfg_select_option(array(\'Static\', \'Dynamic\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Debug E-Mail Address', 'MODULE_PAYMENT_PAYPAL_EXPRESS_DEBUG_EMAIL', '', 'All parameters of an invalid transaction will be sent to this email address.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Payment Zone', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort order of display.', 'MODULE_PAYMENT_PAYPAL_EXPRESS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('Set Order Status', 'MODULE_PAYMENT_PAYPAL_EXPRESS_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('PayPal Transactions Order Status Level', 'MODULE_PAYMENT_PAYPAL_EXPRESS_TRANSACTIONS_ORDER_STATUS_ID', '4', 'Include PayPal transaction information in this order status level', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('cURL Program Location', 'MODULE_PAYMENT_PAYPAL_EXPRESS_CURL', '/usr/bin/curl', 'The location to the cURL program application.', '6', '0' , now());
## #################################
# Header Tags
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_HEADER_TAGS_INSTALLED', 'ht_manufacturer_title.php;ht_category_title.php;ht_product_title.php', 'List of header tag module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Category Title Module', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_STATUS', 'True', 'Do you want to allow category titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturer Title Module', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_STATUS', 'True', 'Do you want to allow manufacturer titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Title Module', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_STATUS', 'True', 'Do you want to allow product titles to be added to the page title?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
## #################################
# Administration Tool Dasboard
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_ADMIN_DASHBOARD_INSTALLED', 'd_total_revenue.php;d_total_customers.php;d_orders.php;d_customers.php;d_admin_logins.php;d_security_checks.php;d_latest_news.php;d_latest_addons.php;d_version_check.php;d_reviews.php', 'List of Administration Tool Dashboard module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Administrator Logins Module', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_STATUS', 'True', 'Do you want to show the latest administrator logins on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_ADMIN_LOGINS_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Customers Module', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_STATUS', 'True', 'Do you want to show the newest customers on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_CUSTOMERS_SORT_ORDER', '400', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest Add-Ons Module', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_STATUS', 'True', 'Do you want to show the latest osCommerce Add-Ons on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_ADDONS_SORT_ORDER', '800', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest News Module', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_STATUS', 'True', 'Do you want to show the latest osCommerce News on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_LATEST_NEWS_SORT_ORDER', '700', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Orders Module', 'MODULE_ADMIN_DASHBOARD_ORDERS_STATUS', 'True', 'Do you want to show the latest orders on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_ORDERS_SORT_ORDER', '300', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Security Checks Module', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_STATUS', 'True', 'Do you want to run the security checks for this installation?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_SECURITY_CHECKS_SORT_ORDER', '600', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Total Customers Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_STATUS', 'True', 'Do you want to show the total customers chart on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_CUSTOMERS_SORT_ORDER', '200', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Total Revenue Module', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_STATUS', 'True', 'Do you want to show the total revenue chart on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_TOTAL_REVENUE_SORT_ORDER', '100', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Version Check Module', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_STATUS', 'True', 'Do you want to show the version check results on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_VERSION_CHECK_SORT_ORDER', '900', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Latest Reviews Module', 'MODULE_ADMIN_DASHBOARD_REVIEWS_STATUS', 'True', 'Do you want to show the latest reviews on the dashboard?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ADMIN_DASHBOARD_REVIEWS_SORT_ORDER', '1000', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
## #################################
# Boxes
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_BOXES_INSTALLED', 'bm_categories.php;bm_manufacturers.php;bm_search.php;bm_whats_new.php;bm_information.php;bm_shopping_cart.php;bm_manufacturer_info.php;bm_order_history.php;bm_best_sellers.php;bm_product_notifications.php;bm_product_social_bookmarks.php;bm_specials.php;bm_reviews.php;bm_currencies.php;bm_languages.php;cm_menu_footer.php;cm_shopping_cart.php;cm_currencies.php;cm_languages.php;cm_menu_header.php;cm_user_menu.php;cm_banner_set.php;cm_search.php;cm_jcarousellite_slider.php;cm_welcome.php;cm_customer_greeting.php;cm_banner.php;cm_manufacturers.php', 'List of box module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());
##
################################################## bm_categories.php MODULE_BOXES_CATEGORIES
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Categories Module', 'MODULE_BOXES_CATEGORIES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CATEGORIES_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CATEGORIES_SORT_ORDER', '1020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_CATEGORIES_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_best_sellers.php MODULE_BOXES_BEST_SELLERS
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Best Sellers Module', 'MODULE_BOXES_BEST_SELLERS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_BEST_SELLERS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_BEST_SELLERS_SORT_ORDER', '1040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_BEST_SELLERS_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_information.php MODULE_BOXES_INFORMATION
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Information Module', 'MODULE_BOXES_INFORMATION_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_INFORMATION_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_INFORMATION_SORT_ORDER', '1080', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_INFORMATION_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_manufacturer_info.php MODULE_BOXES_MANUFACTURER_INFO
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturer Info Module', 'MODULE_BOXES_MANUFACTURER_INFO_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURER_INFO_CONTENT_PLACEMENT', 'Product Page', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\', \'Product Page\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURER_INFO_SORT_ORDER', '2020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
##
#################################################### bm_languages.php MODULE_BOXES_LANGUAGES
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Languages Module', 'MODULE_BOXES_LANGUAGES_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_LANGUAGES_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_LANGUAGES_SORT_ORDER', '2040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_LANGUAGES_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_currencies.php MODULE_BOXES_CURRENCIES
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Currencies Module', 'MODULE_BOXES_CURRENCIES_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CURRENCIES_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CURRENCIES_SORT_ORDER', '2060', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_CURRENCIES_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed.', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_manufacturers.php MODULE_BOXES_MANUFACTURERS
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Manufacturers Module', 'MODULE_BOXES_MANUFACTURERS_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURERS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURERS_SORT_ORDER', '2080', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_MANUFACTURERS_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_order_history.php MODULE_BOXES_ORDER_HISTORY
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Order History Module', 'MODULE_BOXES_ORDER_HISTORY_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_ORDER_HISTORY_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_ORDER_HISTORY_SORT_ORDER', '3020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_ORDER_HISTORY_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_product_notifications.php MODULE_BOXES_PRODUCT_NOTIFICATIONS
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Notifications Module', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_SORT_ORDER', '3040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_PRODUCT_NOTIFICATIONS_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_product_social_bookmarks.php MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Product Social Bookmarks Module', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_CONTENT_PLACEMENT', 'Product Page', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\', \'Product Page\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_PRODUCT_SOCIAL_BOOKMARKS_SORT_ORDER', '3060', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
##
#################################################### bm_reviews.php MODULE_BOXES_REVIEWS
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Reviews Module', 'MODULE_BOXES_REVIEWS_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_REVIEWS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_REVIEWS_SORT_ORDER', '3080', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_REVIEWS_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_search.php MODULE_BOXES_SEARCH
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Search Module', 'MODULE_BOXES_SEARCH_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SEARCH_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SEARCH_SORT_ORDER', '4020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_SEARCH_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_shopping_cart.php MODULE_BOXES_SHOPPING_CART
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Shopping Cart Module', 'MODULE_BOXES_SHOPPING_CART_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SHOPPING_CART_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SHOPPING_CART_SORT_ORDER', '4040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_SHOPPING_CART_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_specials.php MODULE_BOXES_SPECIALS
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Specials Module', 'MODULE_BOXES_SPECIALS_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SPECIALS_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SPECIALS_SORT_ORDER', '1060', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_SPECIALS_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
#################################################### bm_whats_new.php MODULE_BOXES_WHATS_NEW
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable What\'s New Module', 'MODULE_BOXES_WHATS_NEW_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_WHATS_NEW_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_WHATS_NEW_SORT_ORDER', '4060', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_WHATS_NEW_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_user_menu.php MODULE_BOXES_USER_MENU
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable User Menu Module in Header', 'MODULE_BOXES_USER_MENU_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_USER_MENU_CONTENT_PLACEMENT', 'Header Block', 'Should the module be loaded in the header block only?', '6', '1', 'tep_cfg_select_option(array(\'Header Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_USER_MENU_SORT_ORDER', '4080', 'Sort order of display. Lowest is displayed first.', '6', '16', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_USER_MENU_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 16, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_menu_header.php MODULE_BOXES_MAIN_MENU_HEADER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Main Menu Module in Header', 'MODULE_BOXES_MAIN_MENU_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MAIN_MENU_CONTENT_PLACEMENT', 'Menu Block', 'Should the module be loaded in the header block only?', '6', '1', 'tep_cfg_select_option(array(\'Menu Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MAIN_MENU_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_MAIN_MENU_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_menu_footer.php MODULE_BOXES_MAIN_MENU_FOOTER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Main Menu Module in Footer', 'MODULE_BOXES_MAIN_MENU_FOOTER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MAIN_MENU_FOOTER_CONTENT_PLACEMENT', 'Footer Block', 'Should the module be loaded in the footer block only?', '6', '1', 'tep_cfg_select_option(array(\'Footer Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MAIN_MENU_FOOTER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_MAIN_MENU_FOOTER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_shopping_cart.php MODULE_BOXES_CART_HEADER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Shopping Cart Module in Header', 'MODULE_BOXES_CART_HEADER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CART_HEADER_CONTENT_PLACEMENT', 'Header Block', 'Should the module be loaded in the header block only?', '6', '1', 'tep_cfg_select_option(array(\'Header Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CART_HEADER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_CART_HEADER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_currencies.php MODULE_BOXES_CURRENCIES_HEADER_FOOTER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Currencies Module in Header ', 'MODULE_BOXES_CURRENCIES_HEADER_FOOTER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CURRENCIES_HEADER_FOOTER_CONTENT_PLACEMENT', 'Header Block', 'Should the module be loaded in the header or footer?', '6', '1', 'tep_cfg_select_option(array(\'Header Block\', \'Above Footer Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CURRENCIES_HEADER_FOOTER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_CURRENCIES_HEADER_FOOTER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_languages.php MODULE_BOXES_LANGUAGES_HEADER_FOOTER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Languages Module in Header ', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_CONTENT_PLACEMENT', 'Above Footer Block', 'Should the module be loaded in the header or footer?', '6', '1', 'tep_cfg_select_option(array(\'Above Footer Block\', \'Header Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_LANGUAGES_HEADER_FOOTER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_search.php MODULE_BOXES_SEARCH_HEADER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Search Module in Header Module', 'MODULE_BOXES_SEARCH_HEADER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_SEARCH_HEADER_CONTENT_PLACEMENT', 'Above Footer Block', 'Should the module be loaded in the header block only?', '6', '1', 'tep_cfg_select_option(array(\'Above Footer Block\', \'Header Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_SEARCH_HEADER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_SEARCH_HEADER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_jcarousellite_slider.php MODULE_BOXES_JCAROUSELLITE_SLIDER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable jCarousellite Module in Content', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_CONTENT_PLACEMENT', 'Under Header Block', 'Should the module be loaded in the content block only?', '6', '1', 'tep_cfg_select_option(array(\'Under Header Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_SORT_ORDER', '9020', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_JCAROUSELLITE_SLIDER_DISPLAY_PAGES', 'index.php', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_banner_set.php MODULE_BOXES_BANNER_SET
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Content Block Module in Content', 'MODULE_BOXES_BANNER_SET_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_BANNER_SET_CONTENT_PLACEMENT', 'Under Header Block', 'Should the module be loaded in the content block only?', '6', '1', 'tep_cfg_select_option(array(\'Under Header Block\', \'Under Content Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_BANNER_SET_SORT_ORDER', '9040', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_BANNER_SET_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_customer_greeting.php MODULE_BOXES_CUSTOMER_GREETING
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Header Block Module', 'MODULE_BOXES_CUSTOMER_GREETING_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_CUSTOMER_GREETING_CONTENT_PLACEMENT', 'Welcome Block', 'Should the module be loaded in the content block only?', '6', '1', 'tep_cfg_select_option(array(\'Welcome Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_CUSTOMER_GREETING_SORT_ORDER', '7050', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_CUSTOMER_GREETING_DISPLAY_PAGES', 'index.php', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_welcome.php MODULE_BOXES_WELCOME
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Header Block Module', 'MODULE_BOXES_WELCOME_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_WELCOME_CONTENT_PLACEMENT', 'Welcome Block', 'Should the module be loaded in the content block only?', '6', '1', 'tep_cfg_select_option(array(\'Welcome Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_WELCOME_SORT_ORDER', '7070', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_WELCOME_DISPLAY_PAGES', 'index.php', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_banner.php MODULE_BOXES_BANNER_COLUMN
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Banner Column Module', 'MODULE_BOXES_BANNER_COLUMN_STATUS', 'False', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_BANNER_COLUMN_CONTENT_PLACEMENT', 'Left Column', 'Should the module be loaded in the left or right column?', '6', '1', 'tep_cfg_select_option(array(\'Left Column\', \'Right Column\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_BANNER_COLUMN_SORT_ORDER', '3030', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_BANNER_COLUMN_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
## add by Seaman #################################### cm_manufacturers.php MODULE_BOXES_MANUFACTURERS_HEADER_FOOTER
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Languages Module in Header ', 'MODULE_BOXES_MANUFACTURERS_HEADER_FOOTER_STATUS', 'True', 'Do you want to add the module to your shop?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_BOXES_MANUFACTURERS_HEADER_FOOTER_CONTENT_PLACEMENT', 'Header Block', 'Should the module be loaded in the header or footer?', '6', '1', 'tep_cfg_select_option(array(\'Header Block\', \'Above Footer Block\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_BOXES_MANUFACTURERS_HEADER_FOOTER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
INSERT INTO `configuration` (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `set_function`) VALUES ('display in pages.', 'MODULE_BOXES_MANUFACTURERS_HEADER_FOOTER_DISPLAY_PAGES', 'all', 'select pages where this box should be displayed. ', 6, 0, 'tep_cfg_select_pages(');
##
# Template Block Groups
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Installed Template Block Groups', 'TEMPLATE_BLOCK_GROUPS', 'boxes;header_tags', 'This is automatically updated. No need to edit.', '6', '0', now());