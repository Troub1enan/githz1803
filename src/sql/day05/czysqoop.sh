#!/bin/bash
#1.全量导出full_customer
sqoop job --create full_customer -- import \
--connect jdbc:mysql://CentOS7:3306/sales_source?dontTrackOpenResources=true\&defaultFetchSize=1000\&useCursorFetch=true \
--driver com.mysql.jdbc.Driver \
--username root \
--password 123456 \
--table customer \
--delete-target-dir \
--target-dir /sales_source/full_customer \
--fields-terminated-by '\001' \
--bindir ./
#2.全量导出full_product
sqoop job --create full_product -- import \
--connect jdbc:mysql://CentOS7:3306/sales_source?dontTrackOpenResources=true\&defaultFetchSize=1000\&useCursorFetch=true \
--driver com.mysql.jdbc.Driver \
--username root \
--password 123456 \
--table product \
--delete-target-dir \
--target-dir /sales_source/full_product \
--fields-terminated-by '\001' \
--bindir ./
#3.全量导出full_sales_order
sqoop job --create full_sales_order -- import \
--connect jdbc:mysql://CentOS7:3306/sales_source?dontTrackOpenResources=true\&defaultFetchSize=1000\&useCursorFetch=true \
--driver com.mysql.jdbc.Driver \
--username root \
--password 123456 \
--table sales_order \
--delete-target-dir \
--target-dir /sales_source/full_sales_order \
--fields-terminated-by '\001' \
--bindir ./
#4.增量导出incr_customer
sqoop job --create incr_customer -- import \
--connect jdbc:mysql://CentOS7:3306/sales_source?dontTrackOpenResources=true\&defaultFetchSize=1000\&useCursorFetch=true \
--driver com.mysql.jdbc.Driver \
--username root \
--password 123456 \
--table customer \
--target-dir /sales_source/incr_customer \
--fields-terminated-by '\001' \
--check-column customer_number \
--incremental append \
--last-value 0 \
--bindir ./
#5.增量导出incr_product
sqoop job --create incr_product -- import \
--connect jdbc:mysql://CentOS7:3306/sales_source?dontTrackOpenResources=true\&defaultFetchSize=1000\&useCursorFetch=true \
--driver com.mysql.jdbc.Driver \
--username root \
--password 123456 \
--table product \
--target-dir /sales_source/incr_product \
--fields-terminated-by '\001' \
--check-column product_code \
--incremental append \
--last-value 0 \
--bindir ./
#6.增量导出incr_sales_order
sqoop job --create incr_sales_order -- import \
--connect jdbc:mysql://CentOS7:3306/sales_source?dontTrackOpenResources=true\&defaultFetchSize=1000\&useCursorFetch=true \
--driver com.mysql.jdbc.Driver \
--username root \
--password 123456 \
--table sales_order \
--target-dir /sales_source/incr_sales_order \
--fields-terminated-by '\001' \
--check-column order_number \
--incremental append \
--last-value 0 \
--bindir ./