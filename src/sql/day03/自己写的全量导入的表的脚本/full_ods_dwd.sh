#!/bin/bash
args=$1
dt=
if [ ${#args} == 0 ]
then
dt=`date -d "1 days ago" "+%Y%m%d"`
else
dt=$1
fi

echo "load full dwd hive"
##hive -hivevar date_dt=${dt} -f ods2dwd.sql
hive -f full_ods_dwd.sql