-- qfbap_ods.ods_user->qfbap_dwd.dwd_user
insert overwrite table qfbap_dwd.dwd_user
select
user_id,
user_name,
user_gender,
user_birthday,
user_age,
constellation,
province,
city,
city_level,
e_mail,
op_mail,
mobile,
num_seg_mobile,
op_Mobile,
register_time,
login_ip,
login_source,
request_user,
total_score,
used_score,
is_blacklist,
is_married,
education,
monthly_income,
profession,
create_date
from 
qfbap_ods.ods_user;