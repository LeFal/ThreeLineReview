
## 카테고리

CREATE TABLE IF NOT EXISTS `category` (

`id` 				bigint	 		NOT NULL AUTO_INCREMENT,	## 인덱스 10000단위 1depth 100단위 2depth 1단위 3depth
`name`	 			varchar(50) 	DEFAULT NULL,				## 카테고리 이름
`list_order` 		smallint	 	NOT NULL, 					## 순서
`input_date` 		datetime 		NOT NULL,					## 작성일
`status` 			smallint 	 	DEFAULT 0,					## 상태 0=미사용, 1=사용
  	PRIMARY KEY (`id`)
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


### 회원 테이블
CREATE TABLE IF NOT EXISTS `tbl_member` (


`id` 					bigint	 		NOT NULL AUTO_INCREMENT,	## 인덱스
`login_id` 				varchar(20) 	NOT NULL, 					## 로그인 아이디
`password`				varchar(100) 	NOT NULL,					## 비밀번호(bcryp으로 인코딩)
`email` 				varchar(50) 	NOT NULL, 					## 이메일
`facebook_id` 			varchar(50) 	DEFAULT NULL,				## 페이스북 아이디
`facebook_token`		varchar(255)	DEFAULT NULL,				## 페이스북 접속 토큰
`nickname` 				varchar(20) 	NOT NULL,					## 이름
`sms_rcv_yn` 			char(1) 		DEFAULT 'N',				## sms 수신여부
`mail_rcv_yn` 			char(1) 		DEFAULT 'N',				## 이메일 수신여부
`join_date` 			datetime 		NOT NULL,					## 회원 가입일
`last_login_date`		datetime 		DEFAULT NULL,				## 마지막 로그인 일시
`drop_yn` 				char(1) 		DEFAULT 'N',				## 탈퇴 여부
`drop_reason`			text			DEFAULT NULL,				## 탈퇴 사유
`drop_date`				datetime		DEFAULT NULL,				## 탈퇴 일시
`point`	 				bigint	 		DEFAULT 0,					## 포인트
`profile_img`			varchar(50)		DEFAULT NULL,				## 프로필 이미지
`memo`					text			DEFAULT NULL,				## 메모 (제휴사 정보등)
`email_confirm_text`	varchar(50)		DEFAULT NULL,				## 이메일 인증 문자 (이메일 수정 할때 사용 )
`password_change_text`	varchar(50)		DEFAULT NULL,				## 비밀번호 수정 인증 문자열
`change_email`			varchar(50)		DEFAULT NULL,				## 변경할 이메일
`review_count`			int(50)			DEFAULT 0,					## 리뷰 개수
`review_target_count`	int(50)			DEFAULT 0,					## 리뷰 개수
`good_count`			int(50)			DEFAULT 0,					## 리뷰 개수
`soso_count`			int(50)			DEFAULT 0,					## 리뷰 개수
`bad_count`				int(50)			DEFAULT 0,					## 리뷰 개수

  	PRIMARY KEY (`id`)
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


| id            | int(11)     | NO   | PRI | NULL    | auto_increment |
| user_id       | varchar(12) | YES  |     | NULL    |                |
| nickname      | varchar(12) | YES  |     | NULL    |                |
| created       | datetime    | NO   |     | NULL    |                |
| creator       | int(11)     | NO   |     | NULL    |                |
| review_count  | int(11)     | YES  |     | NULL    |                |
| good_count    | int(11)     | YES  |     | NULL    |                |
| soso_count    | int(11)     | YES  |     | NULL    |                |
| bad_count     | int(11)     | YES  |     | NULL    |                |
| average_score | int(11)     | YES  |     | NULL    |                |
| point         | int(11)     | YES  |     | NULL    |                |
| password      | varchar(12) | YES  |     | NULL    |                |