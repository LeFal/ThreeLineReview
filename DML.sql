INSERT into review_target  (category_id,name,img,basic_info,input_date,status,create_user_id,good_value,soso_value,bad_value)
values ('10000','바람과 함께 사라지다');

alter table review_target CHANGE COLUMN good_value good_value INT DEFAULT 0;
alter table review_target CHANGE COLUMN soso_value soso_value INT DEFAULT 0;
alter table review_target CHANGE COLUMN bad_value bad_value INT DEFAULT 0;

alter table review_target CHANGE COLUMN review_count review_count INT DEFAULT 0;
alter table review_target CHANGE COLUMN like_count like_count INT DEFAULT 0;

INSERT into review_target  (category_id,name,img,basic_info,input_date,create_user_id) values ('10000','바람과 함께 사라지다','www.aaa.comff','',now(),1);

alter table user CHANGE  good_rate good_value int DEFAULT 0;
alter table user CHANGE  soso_rate soso_value int DEFAULT 0;
alter table user CHANGE  bad_rate bad_value int DEFAULT 0;

alter table user CHANGE  last_login_date last_connect_date datetime 	DEFAULT NULL
