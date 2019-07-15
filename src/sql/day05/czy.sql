CREATE DATABASE IF NOT EXISTS sales_source;
use sales_source;
CREATE TABLE full_customer
(
   customer_number      int,
   customer_name        string,
   customer_street_address string,
   customer_zip_code    int,
   customer_city        string,
   customer_state       string 
);
CREATE TABLE incr_customer
(
   customer_number      int,
   customer_name        string,
   customer_street_address string,
   customer_zip_code    int,
   customer_city        string,
   customer_state       string 
)partitioned by (dt string);
CREATE TABLE full_product
(
   product_code         int,
   product_name         string,
   product_category     string
);
CREATE TABLE incr_product
(
   product_code         int,
   product_name         string,
   product_category     string
)partitioned by (dt string);
CREATE TABLE full_sales_order
(
   order_number         int,
   customer_number      int,
   product_code         int,
   order_date           date,
   entry_date           date,
   order_amount         decimal(18,2) 
);
CREATE TABLE incr_sales_order
(
   order_number         int,
   customer_number      int,
   product_code         int,
   order_date           date,
   entry_date           date,
   order_amount         decimal(18,2) 
)partitioned by (dt string);