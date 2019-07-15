#!/bin/bash

#run with args.eg: ./load_data.sh 2018-12-25
args=$1
dt=
if [ ${#args} == 0 ]
then
dt=`date -d "1 days ago" "+%Y%m%d"`
else
dt=$1
fi

echo "开始执行脚本"
sqoop job -exec	full_customer
sqoop job -exec	full_product
sqoop job -exec	full_sales_order
sqoop job -exec	incr_customer
sqoop job -exec	incr_product
sqoop job -exec	incr_sales_order
echo "开始导入数据"
hive --database sales_source -e "load data inpath '/sales_source/full_customer/*' into table sales_source.full_customer"
hive --database sales_source -e "load data inpath '/sales_source/full_product/*' into table sales_source.full_product"
hive --database sales_source -e "load data inpath '/sales_source/full_sales_order/*' into table sales_source.full_sales_order"
hive --database sales_source -e "load data inpath '/sales_source/incr_customer/*' into table sales_source.incr_customer partition(dt=${dt})";
hive --database sales_source -e "load data inpath '/sales_source/incr_product/*' into table sales_source.incr_product partition(dt=${dt})";
hive --database sales_source -e "load data inpath '/sales_source/incr_sales_order/*' into table sales_source.incr_sales_order partition(dt=${dt})";