insert overwrite table qfbap_dws.dws_user_visit_month1 partition(dt=${hivevar:param_dt})
select
a.user_id,
a.type,
a.cnt,
a.content,
a.rn,
current_timestamp() dw_date
from(
select
t.user_id,
t.type,
t.cnt,
t.content,
row_number() over(distribute by user_id,type sort by cnt desc) rn
from(
select
user_id,
'visit_ip' as type,
sum(pv) as cnt,
visit_ip as content
from
qfbap_dwd.dwd_user_pc_pv
group by
user_id,
visit_ip
union all
select
user_id,
'cookie_id' as type,
sum(pv) as cnt,
cookie_id as content
from
qfbap_dwd.dwd_user_pc_pv
group by
user_id,
cookie_id
union all
select
user_id,
'browser_name' as type,
sum(pv) as cnt,
browser_name as content
from
qfbap_dwd.dwd_user_pc_pv
group by
user_id,
browser_name
union all
select
user_id,
'visit_os' as type,
sum(pv) as cnt,
visit_os as content
from
qfbap_dwd.dwd_user_pc_pv
group by
user_id,
visit_os
) t
)a