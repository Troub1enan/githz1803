-- qfbap_ods.ods_order_delivery->qfbap_dwd.dwd_order_delivery
insert overwrite table qfbap_dwd.dwd_order_delivery partition(dt=${hivevar:date_dt})
select
order_id,
order_no,
consignee,
area_id,
area_name,
address,
mobile,
phone,
coupon_id,
coupon_money,
carriage_money,
create_time,
update_time,
addr_id,   
current_timestamp() dw_date
from
qfbap_ods.ods_order_delivery;