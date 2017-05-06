CREATE TABLE  `user` (

`id` 		int 	NOT NULL AUTO_INCREMENT, 	## 인덱스(PK)
`login_email` 		char(30) 	NOT NULL, 		## 로그인 이메일
`password` 		varchar(100)	NOT NULL, 		## 비밀번호
`name`		varchar(20) 	NOT NULL,		## 이름
`join_date` 		datetime 	NOT NULL, 		## 회원 가입일
`last_login_date` 		datetime 	DEFAULT NULL,	 	## 마지막 로그인 일시
`drop_yn` 		char(1) 	DEFAULT 'N',		## 탈퇴 여부
`drop_date` 		datetime 	DEFAULT NULL, 		## 탈퇴 일시
`user_level` 		smallint	DEFAULT 1, 		## 회원 레벨
`user_point` 		int	DEFAULT 1, 		## 회원 포인트
`good_rate`		int	DEFAULT 0,		## 긍정 평가수
`soso_rate`		int	DEFAULT 0,		## 보통 평가수
`bad_rate`		int	DEFAULT 0, 		## 부정 평가수
 PRIMARY KEY (`id`)
);

CREATE TABLE `category` (

`id` 	int 	NOT NULL AUTO_INCREMENT, 	## 카테고리 id(10000 대분류, 100 중분류, 1 소분류)
`name` 	varchar(50) 	DEFAULT NULL, 		## 카테고리 이름
`list_order` 	smallint	NOT NULL, 		## 순서
`input_date` 	datetime 	NOT NULL, 		## 작성일
`status` 	smallint 	DEFAULT 0, 		## 상태 0=미사용, 1=사용
PRIMARY KEY (`id`)
) ;

CREATE TABLE `review_target` (

`id` 		int 	NOT NULL AUTO_INCREMENT,	## 인덱스
`category_id` 		int 	DEFAULT NULL,		## 카테고리 인덱스(FK)
`input_user_id`	int 	DEFAULT NULL,		## 생성자 아이디
`name` 		varchar(50)	DEFAULT NULL, 		## 카테고리 이름
`score`		float	DEFAULT 0,		## 카테고리 점수
`img` 		varchar(255) 	DEFAULT NULL, 		## 대표 이미지
`basic_info` 		text 	DEFAULT NULL, 		## 기본 정보
`input_date` 		datetime 	NOT NULL, 		## 작성일
`status` 		int 	DEFAULT 1, 		## 상태 0=미사용, 1=사용, 2=신고
`like_count` 		int 	DEFAULT 0,		## 좋아요 수
`review_count` 		int	DEFAULT NULL, 		## 리뷰 수
`delete_yn` 		char(1) 	DEFAULT 'N', 		## 삭제 여부
`delete_user_id` 	bigint 	DEFAULT NULL, 		## 삭제자 아이디
`delete_date` 		datetime 	DEFAULT NULL, 		## 삭제일
`popularity` 		bigint 	DEFAULT NULL, 		## 인기도
 PRIMARY KEY (`id`),
 FOREIGN KEY (`category_id`) REFERENCES `category`(`id`)
);

CREATE TABLE `review` (

`id` 	int 	NOT NULL AUTO_INCREMENT,	## 인덱스
`target_id` 	int 	DEFAULT NULL, 		## 리뷰대상 인덱스
`user_id` 	int	DEFAULT NULL, 		## 작성자 아이디
`score`	float	NOT NULL,		## 리뷰점수
`content` 	text 	DEFAULT NULL, 		## 내용
`like_count` 	int 	DEFAULT 0, 		## 좋아요 수
`input_date` 	datetime	NOT NULL, 		## 작성일
`delete_yn` 	char(1) 	DEFAULT 'N', 		## 삭제 여부
`delete_date` 	datetime 	DEFAULT NULL, 		## 삭제일
`delete_user_id` bigint 	DEFAULT NULL, 		## 삭제자 아이디

PRIMARY KEY (`id`),
FOREIGN KEY (target_id) REFERENCES review_target(id),
FOREIGN KEY (user_id) REFERENCES user(id)
); 

CREATE TABLE `bet_status` (

`id` 	int 	NOT NULL AUTO_INCREMENT,	## 인덱스
`item_id` 	int  NOT NULL	, 	## 아이템 인덱스
`bet_point` 	int NOT NULL	, 	## 베팅 포인트
`bet_user_id` 	int NOT NULL	, 	## 베팅한 사람

PRIMARY KEY (`id`),
##FOREIGN KEY (`item_id`)  REFERENCES store_item (`id`),
FOREIGN KEY (`bet_user_id`) REFERENCES user (`id`)
) ;

CREATE TABLE `store_item` (

`id` 	int NOT NULL AUTO_INCREMENT,	## 아이템인덱스
`name` 		varchar(50)	DEFAULT NULL, 		## 상품 이름
`price`		int	DEFAULT 0,		## 상품 원가
`img` 		varchar(255) 	DEFAULT NULL, 		## 대표 이미지
`basic_info` 		text 	DEFAULT NULL, 		## 기본 정보
`input_date` 		datetime 	NOT NULL, 		## 생성일
`start_date` 		datetime 	NOT NULL, 		## 경매 시작 시간
`end_date` 		datetime 	NOT NULL, 		## 경매 종료 시간
`announce_date` 		datetime 	NOT NULL, 		## 경매 결과 발표 시간
`status` 		int 	DEFAULT 1, 		## 상태 0=준비중, 1=경매중, 2=집계중, 3 = 완료
`bet_count` 		int 	DEFAULT 0,		## 경매 참여자 수
`delete_yn` 		char(1) 	DEFAULT 'N', 		## 삭제 여부
`get_user_id` 		int	DEFAULT NULL, 		## 상품 수령자 id
`store_maneger`		text	DEFAULT NULL,		## 상품관리자 정보
PRIMARY KEY (`id`),
FOREIGN KEY (get_user_id) REFERENCES user(id)
)

