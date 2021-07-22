-- 기존에 존재하는 테이블 삭제
DROP TABLE COMMENTS CASCADE CONSTRAINTS;
DROP TABLE ITEM CASCADE CONSTRAINTS;
DROP TABLE ITEM_REG_STA CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE POINTS CASCADE CONSTRAINTS;
DROP TABLE TEXT_LIST CASCADE CONSTRAINTS;
DROP TABLE USER_INFO CASCADE CONSTRAINTS;
DROP TABLE WISH_LIST CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE QUESTION CASCADE CONSTRAINTS;

-- 기존에 존재하는 시퀀스 삭제
DROP SEQUENCE ITEM_SEQ;
DROP SEQUENCE USER_SEQ;

-- 사용자 테이블 생성
CREATE TABLE USER_INFO(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_NAME VARCHAR2(10),
    USER_ID VARCHAR2(20) CONSTRAINT USER_ID_NN NOT NULL,
    USER_PWD VARCHAR2(20) CONSTRAINT USER_PWD_NN NOT NULL,
    EMAIL VARCHAR2(20),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(20),
    SHOES_SIZE NUMBER,
    POINT NUMBER,
    MGR CHAR(1),
    BANK_NAME VARCHAR2(5),
    ACCOUNT_NO VARCHAR2(20),
    LOGIN_OK CHAR(1) DEFAULT 'Y',
    CONSTRAINT USER_ID_UK UNIQUE(USER_ID)
);

-- 사용자 테이블 번호 시퀀스 생성
CREATE SEQUENCE USER_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 사용자 테이블 COMMENT 생성
COMMENT ON COLUMN USER_INFO.USER_NO IS '번호';
COMMENT ON COLUMN USER_INFO.USER_NAME IS '이름';
COMMENT ON COLUMN USER_INFO.USER_ID IS '아이디';
COMMENT ON COLUMN USER_INFO.USER_PWD IS '비밀번호';
COMMENT ON COLUMN USER_INFO.EMAIL IS '이메일';
COMMENT ON COLUMN USER_INFO.PHONE IS '전화번호';
COMMENT ON COLUMN USER_INFO.ADDRESS IS '주소';
COMMENT ON COLUMN USER_INFO.SHOES_SIZE IS '신발사이즈';
COMMENT ON COLUMN USER_INFO.POINT IS '적립포인트';
COMMENT ON COLUMN USER_INFO.MGR IS '관리자유무';
COMMENT ON COLUMN USER_INFO.BANK_NAME IS '은행명';
COMMENT ON COLUMN USER_INFO.ACCOUNT_NO IS '계좌번호';
COMMENT ON COLUMN USER_INFO.LOGIN_OK IS '로그인가능유무';

-- 상품 테이블 생성
CREATE TABLE ITEM(
    ITEM_NO	NUMBER CONSTRAINT ITEM_NO_PK PRIMARY KEY,	
    ITEM_ENG_NAME VARCHAR2(100 BYTE) CONSTRAINT ITEM_NAME_NN NOT NULL,
    ITEM_KR_NAME VARCHAR2(100 BYTE),
    ITEM_BRAND VARCHAR2(50 BYTE) CONSTRAINT ITEM_BRAND_NN	NOT NULL,
    ITEM_MODELNO VARCHAR2(30 BYTE) CONSTRAINT ITEM_MODELNO_NN	NOT NULL,
    ITEM_COLORS VARCHAR2(100 BYTE),
    ITEM_PRICE NUMBER CONSTRAINT ITEM_PRICE_NN NOT NULL,
    ITEM_REG_DATE DATE CONSTRAINT ITEM_REG_DATE_NN	NOT NULL,
    ITEM_DROP_DATE DATE,
    ITEM_SIZES VARCHAR2(150 BYTE) CONSTRAINT ITEM_SIZES_NN NOT NULL
);

-- 상품 테이블 번호 시퀀스 생성
CREATE SEQUENCE ITEM_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 상품 테이블 COMMENT 생성
COMMENT ON COLUMN ITEM.ITEM_NO IS '번호';
COMMENT ON COLUMN ITEM.ITEM_ENG_NAME IS '영문이름';
COMMENT ON COLUMN ITEM.ITEM_KR_NAME IS '한글이름';
COMMENT ON COLUMN ITEM.ITEM_BRAND IS '브랜드';
COMMENT ON COLUMN ITEM.ITEM_MODELNO IS '모델번호';
COMMENT ON COLUMN ITEM.ITEM_COLORS IS '색상';
COMMENT ON COLUMN ITEM.ITEM_PRICE IS '가격';
COMMENT ON COLUMN ITEM.ITEM_REG_DATE IS '등록일자';
COMMENT ON COLUMN ITEM.ITEM_DROP_DATE IS '발매일자';
COMMENT ON COLUMN ITEM.ITEM_SIZES IS '신발사이즈';

-- 상품등록상태 테이블 생성
CREATE TABLE ITEM_REG_STA(
    ITEM_REG_STA_NO NUMBER CONSTRAINT ITEM_REG_STA_NO_PK PRIMARY KEY,
    USER_NO NUMBER CONSTRAINT ITEM_REG_STA_USER_NO_FK REFERENCES USER_INFO(USER_NO),
    USER_ID VARCHAR2(10) CONSTRAINT ITEM_REG_STA_USER_ID_FK REFERENCES USER_INFO(USER_ID),
    ITEM_NO NUMBER CONSTRAINT ITEM_REG_STA_ITEM_NO_FK REFERENCES ITEM(ITEM_NO),
    SHOES_SIZE NUMBER CONSTRAINT ITEM_REG_STA_SHOES_SIZE_NN NOT NULL,
    REG_DATE DATE CONSTRAINT ITEM_REG_STA_REG_DATE_NN NOT NULL,
    PRICE NUMBER CONSTRAINT ITEM_REG_STA_PRICE_NN NOT NULL
);

-- 상품등록상태 테이블 COMMENT 생성
COMMENT ON COLUMN ITEM_REG_STA.ITEM_REG_STA_NO IS '번호';
COMMENT ON COLUMN ITEM_REG_STA.USER_NO IS '사용자번호';
COMMENT ON COLUMN ITEM_REG_STA.USER_ID IS '사용자아이디';
COMMENT ON COLUMN ITEM_REG_STA.ITEM_NO IS '상품번호';
COMMENT ON COLUMN ITEM_REG_STA.SHOES_SIZE IS '신발사이즈';
COMMENT ON COLUMN ITEM_REG_STA.REG_DATE IS '등록일자';
COMMENT ON COLUMN ITEM_REG_STA.PRICE IS '가격';

-- 글목록 테이블 생성
CREATE TABLE TEXT_LIST(
    TEXT_LIST_NO NUMBER CONSTRAINT TEXT_LIST_NO_PK PRIMARY KEY,
    USER_NO NUMBER CONSTRAINT TEXT_LIST_USER_NO_FK REFERENCES USER_INFO(USER_NO),
    TITLE VARCHAR2(20) CONSTRAINT TEXT_LIST_TITLE_NN NOT NULL,
    CONTENT VARCHAR2(100),
    REG_DATE DATE CONSTRAINT TEXT_LIST_REG_DATE_NN NOT NULL,
    CATEGORY VARCHAR2(10) CONSTRAINT TEXT_LIST_CATEGORY_NN NOT NULL,
    VIEWS NUMBER DEFAULT 0,
    HEART CHAR(1) DEFAULT 'N'
);

-- 글목록 테이블 COMMENT 생성
COMMENT ON COLUMN TEXT_LIST.TEXT_LIST_NO IS '번호';
COMMENT ON COLUMN TEXT_LIST.USER_NO IS '사용자번호';
COMMENT ON COLUMN TEXT_LIST.TITLE IS '제목';
COMMENT ON COLUMN TEXT_LIST.CONTENT IS '내용';
COMMENT ON COLUMN TEXT_LIST.REG_DATE IS '등록일자';
COMMENT ON COLUMN TEXT_LIST.CATEGORY IS '카테고리';
COMMENT ON COLUMN TEXT_LIST.VIEWS IS '조회수';
COMMENT ON COLUMN TEXT_LIST.HEART IS '좋아요';

-- 위시리스트 테이블 생성
CREATE TABLE WISH_LIST(
    WISH_LIST_NO NUMBER CONSTRAINT WISH_LIST_NO_PK PRIMARY KEY,
    USER_NO NUMBER CONSTRAINT WISH_LIST_USER_NO_FK REFERENCES USER_INFO(USER_NO),
    ITEM_NO NUMBER CONSTRAINT WISH_LIST_ITEM_NO_FK REFERENCES ITEM(ITEM_NO)
);

-- 위시리스트 테이블 COMMENT 생성
COMMENT ON COLUMN WISH_LIST.WISH_LIST_NO IS '번호';
COMMENT ON COLUMN WISH_LIST.USER_NO IS '사용자번호';
COMMENT ON COLUMN WISH_LIST.ITEM_NO IS '상품번호';

-- 댓글 테이블 생성
CREATE TABLE COMMENTS(
    COMMENTS_NO NUMBER CONSTRAINT COMMENTS_NO_PK PRIMARY KEY,
    REPLY_NO NUMBER CONSTRAINT COMMENTS_REPLY_NO_NN NOT NULL,
    COMMENTS_LEVEL NUMBER CONSTRAINT COMMENTS_LEVEL_NN NOT NULL,
    COMMENTS_SEQ NUMBER CONSTRAINT COMMENTS_SEQ_NN NOT NULL,
    CONSTRAINT COMMENTS_REPLY_NO_UK UNIQUE(REPLY_NO),
    CONSTRAINT COMMENTS_LEVEL_UK UNIQUE(COMMENTS_LEVEL),
    CONSTRAINT COMMENTS_SEQ_UK UNIQUE(COMMENTS_SEQ)
);

-- 댓글 테이블 COMMENT 생성
COMMENT ON COLUMN COMMENTS.COMMENTS_NO IS '번호';
COMMENT ON COLUMN COMMENTS.REPLY_NO IS '대댓글번호';
COMMENT ON COLUMN COMMENTS.COMMENTS_LEVEL IS '댓글단계';
COMMENT ON COLUMN COMMENTS.COMMENTS_SEQ IS '댓글순번';

-- 주문 테이블 생성
CREATE TABLE ORDERS(
    ORDERS_NO NUMBER CONSTRAINT ORDERS_NO_PK PRIMARY KEY,
    USER_NO NUMBER CONSTRAINT ORDERS_USER_NO_FK REFERENCES USER_INFO(USER_NO),
    ITEM_NO NUMBER CONSTRAINT ORDERS_ITEM_NO_FK REFERENCES ITEM(ITEM_NO),
    USER_ID VARCHAR2(10) CONSTRAINT ORDERS_USER_ID_FK REFERENCES USER_INFO(USER_ID),
    PUR_DATE DATE CONSTRAINT ORDERS_PUR_DATE_NN NOT NULL,
    COUNT NUMBER DEFAULT 0,
    PROGRESS VARCHAR2(10) CONSTRAINT ORDERS_PROGRESS_NN NOT NULL,
    PRICE NUMBER CONSTRAINT ORDERS_PRICE_NN NOT NULL,
    ADDRESS VARCHAR2(20) CONSTRAINT ORDERS_ADDRESS_NN NOT NULL,
    SHOES_SIZE NUMBER CONSTRAINT ORDERS_SHOES_SIZE_NN NOT NULL,
    PHONE VARCHAR2(20) CONSTRAINT ORDERS_PHONE_NN NOT NULL,
    DEL_FEE NUMBER CONSTRAINT ORDERS_DEL_FEE_NN NOT NULL,
    PAYMENT VARCHAR2(10) CONSTRAINT ORDERS_PAYMENT_NN NOT NULL
);

-- 주문 테이블 COMMENT 생성
COMMENT ON COLUMN ORDERS.ORDERS_NO IS '번호';
COMMENT ON COLUMN ORDERS.USER_NO IS '사용자번호';
COMMENT ON COLUMN ORDERS.ITEM_NO IS '상품번호';
COMMENT ON COLUMN ORDERS.USER_ID IS '사용자아이디';
COMMENT ON COLUMN ORDERS.PUR_DATE IS '구매일자';
COMMENT ON COLUMN ORDERS.COUNT IS '개수';
COMMENT ON COLUMN ORDERS.PROGRESS IS '진행상태';
COMMENT ON COLUMN ORDERS.PRICE IS '가격';
COMMENT ON COLUMN ORDERS.ADDRESS IS '주소';
COMMENT ON COLUMN ORDERS.SHOES_SIZE IS '신발사이즈';
COMMENT ON COLUMN ORDERS.PHONE IS '전화번호';
COMMENT ON COLUMN ORDERS.DEL_FEE IS '배송비';
COMMENT ON COLUMN ORDERS.PAYMENT IS '결제수단';

-- 포인트 테이블 생성
CREATE TABLE POINTS(
    ORDERS_NO NUMBER CONSTRAINT POINTS_ORDERS_NO_FK REFERENCES ORDERS(ORDERS_NO),
    REG_DATE DATE CONSTRAINT POINTS_REG_DATE_NN NOT NULL,
    POINT NUMBER DEFAULT 0,
    HISTORY VARCHAR2(20) CONSTRAINT POINTS_HISTORY_NN NOT NULL
);

-- 포인트 테이블 COMMENT 생성
COMMENT ON COLUMN POINTS.ORDERS_NO IS '주문번호';
COMMENT ON COLUMN POINTS.REG_DATE IS '등록일자';
COMMENT ON COLUMN POINTS.POINT IS '포인트';
COMMENT ON COLUMN POINTS.HISTORY IS '적립내역';

-- 공지 테이블 생성
CREATE TABLE NOTICE(
 NOTICENO NUMBER,
 NOTICETITLE VARCHAR2(50),
 NOTICEWRITER VARCHAR2(20),
 NOTICEDATE DATE DEFAULT SYSDATE,
 NOTICECONTENT VARCHAR2(2048),
 NOTICEAVAILABLE NUMBER,
 NOTICEREADCOUNT NUMBER DEFAULT 0,
 CONSTRAINT PK_NOTICE PRIMARY KEY (NOTICENO)
);

-- 질문 테이블 생성
CREATE TABLE QUESTION(
 QUESTION_NO NUMBER,
 QUESTION_TITLE VARCHAR2(50),
 QUESTION_WRITER VARCHAR2(20),
 QUESTION_DATE DATE DEFAULT SYSDATE,
 QUESTION_CONTENT VARCHAR2(2048),
 QUESTION_READCOUNT NUMBER DEFAULT 0,
 QUESTION_REF NUMBER,
 QUESTION_LEVEL NUMBER,
 QUESTION_AVAILABLE NUMBER,
 CONSTRAINT PK_QUESTION PRIMARY KEY (QUESTION_NO)
);

-- 아이템 테이블 예시 컬럼값 삽입
SET DEFINE OFF;
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike Dunk Low Retro Black', '나이키 덩크 로우 레트로 블랙', 'Nike', 'DD1391-100', 'WHITE,BLACK', 119000, SYSDATE, '21/01/14', '240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(W) Nike Dunk Low Black', '(W) 나이키 덩크 로우 블랙', 'Nike', 'DD1503-101', 'WHITE,BLACK', 119000, SYSDATE, '21/01/14', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(W) Jordan 1 Low White Wolf Grey', '(W) 조던 1 로우 화이트 울프 그레이', 'Jordan', 'DC0774-105', 'WHITE,WOLF GREY,ALUMINUM', 119000, SYSDATE, '21/07/17', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 1 Retro High OG Hyper Royal', '조던 1 레트로 하이 OG 하이퍼 로얄', 'Jordan', '555088-402', 'HYPER ROYAL,LIGHT SMOKE GREY,WHITE', 199000, SYSDATE, '21/04/14', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'New Balance 992 Made in USA Grey (D Standard)', '뉴발란스 992 메이드 인 USA 그레이 (D 스탠다드)', 'New Balance', 'M992GR', 'GREY', 259000, SYSDATE, '20/04/13', '215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 1 Retro High OG Black Mocha', '조던 1 레트로 하이 OG 블랙 모카', 'Jordan', '555088-105', 'SAIL,DARK MOCHA-BLACK-BLACK', 199000, SYSDATE, '20/11/13', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 1 Retro High OG University Blue', '조던 1 레트로 하이 OG 유니버시티 블루', 'Jordan', '555088-134', 'WHITE,UNIVERSITY BLUE,BLACK', 199000, SYSDATE, '21/03/06', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Peaceminusone Air Force 1 Low Para-Noise 2.0', '나이키 x 피스마이너스원 에어포스 1 로우 파라노이즈 2.0', 'Nike', 'DD3223-100', 'WHITE,BLACK-WHITE', 219000, SYSDATE, '20/11/25', '230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,320,330');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 1 Retro High OG Shadow 2.0', '조던 1 레트로 하이 OG 쉐도우 2.0', 'Jordan', '555088-035', 'BLACK,LIGHT SMOKE GREY-WHITE', 199000, SYSDATE, '21/05/15', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 4 x Union Retro SP Desert Moss', '조던 4 x 유니온 레트로 SP 데저트 모스', 'Jordan', 'DJ5718-300', 'DESERT MOSS,TURQUOISE BLUE,DARK IRIS', 299000, SYSDATE, '21/06/26', '230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'New Balance 992 Made in USA Black Grey', '뉴발란스 992 메이드 인 USA 블랙 그레이', 'New Balance', 'M992EB', 'BLACK,GREY', 259000, SYSDATE, '21/06/15', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike Air Force 1 07 Low White', '나이키 에어포스 1 07 로우 화이트', 'Nike', '315122-111/CW2288-111', 'WHITE,WHITE', 129000, SYSDATE, NULL, '235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Ambush Dunk High Deep Royal Blue', '나이키 x 앰부쉬 덩크 하이 딥 로얄 블루', 'Nike', 'CU7544-400', 'DEEP ROYAL BLUE,WHITE-PALE IVORY-BLACK', 219000, SYSDATE, '21/05/18', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Sacai VaporWaffle Sesame and Blue Void', '나이키 x 사카이 베이퍼와플 세서미 앤 블루 보이드', 'Nike', 'DD1875-200', 'SESAME,BLUE VOID-WHITE', 219000, SYSDATE, '21/04/29', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Sacai VaporWaffle Dark Iris', '나이키 x 사카이 베이퍼와플 다크 아이리스', 'Nike', 'DD1875-500', 'DARK IRIS,CAMPFIRE ORANGE,WHITE', 219000, SYSDATE, '21/04/29', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Adidas Yeezy Foam RNNR Sand', '아디다스 이지 폼 러너 샌드', 'adidas Yeezy', 'FY4567', 'SAND,SAND,SAND', 99000, SYSDATE, '21/03/26', '225,235,245,255,265,275,285,295,305,315,325,335');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Sacai Blazer Low Classic Green', '나이키 x 사카이 블레이저 로우 클래식 그린', 'Nike', 'DD1877-001', 'MEDIUM GREY,CLASSIC GREEN,WHITE', 139000, SYSDATE, '21/06/10', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Supreme Air Force 1 Low White', '나이키 x 슈프림 에어포스 1 로우 화이트', 'Nike', 'CU9225-100', 'WHITE,WHITE-WHITE', 110200, SYSDATE, '20/03/05', '215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike Dunk Low Retro Varsity Green', '나이키 덩크 로우 레트로 바시티 그린', 'Nike', 'DD1391-101', 'WHITE,TEAM GREEN,ORANGE', 119000, SYSDATE, '21/04/28', '230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Adidas Yeezy Slide Pure', '아디다스 이지 슬라이드 퓨어', 'adidas Yeezy', 'GZ5554', 'PURE,PURE,PURE', 79000, SYSDATE, '21/04/26', '225,235,245,255,265,275,285,295,305,315,325,335');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 6 x Travis Scott Retro SP British Khaki', '조던 6 x 트래비스 스캇 레트로 SP 브리티쉬 카키', 'Jordan', 'DH0690-200', 'BRITISH KHAKI,SAIL-BRIGHT CRIMSON', 299000, SYSDATE, '21/04/30', '230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,320,330');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(W) Jordan 1 Low SE Corduroy Tan', '(W) 조던 1 로우 SE 코듀로이 탄', 'Jordan', 'DH7820-700', 'TWINE,ORANGE,ORANGE QUARTZ,SAIL', 119000, SYSDATE, '21/06/11', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 1 x Travis Scott Retro High Mocha', '조던 1 x 트래비스 스캇 레트로 하이 모카', 'Jordan', 'CD4487-100', 'SAIL,BLACK-DARK MOCHA-UNIVERSITY RED', 239000, SYSDATE, '19/05/12', '215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 4 Retro Tech White', '조던 4 레트로 테크 화이트', 'Jordan', 'CT8527-100', 'WHITE,TECH GREY,BLACK,FIRE RED', 229000, SYSDATE, '21/06/24', '250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(W) Jordan 1 Mid Wolf Grey', '(W) 조던 1 미드 울프 그레이', 'Jordan', 'BQ6472-105', 'WHITE,ALUMINUM-WOLF GREY', 139000, SYSDATE, '21/06/30', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'New Balance 327 White Black', '뉴발란스 327 화이트 블랙', 'New Balance', 'MS327FE', 'SEA SALT,BLACK', 109000, SYSDATE, '21/02/20', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Jordan 1 Low OG Neutral Grey 2021', '조던 1 로우 OG 뉴트럴 그레이 2021', 'Jordan', 'CZ0790-100', 'WHITE,WHITE-NEUTRAL GREY', 159000, SYSDATE, '21/06/17', '250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(W) Nike Dunk Low Coast', '(W) 나이키 덩크 로우 코스트', 'Nike', 'DD1503-100', 'SAIL,COAST,UNIVERSITY GOLD', 119000, SYSDATE, '21/01/14', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Adidas Yeezy Boost 350 V2 Black Red 2020', '아디다스 이지 부스트 350 V2 블랙 레드 2020', 'adidas Yeezy', 'CP9652', 'CORE BLACK,CORE BLACK,RED', 289000, SYSDATE, '20/12/05', '220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Sacai VaporWaffle Tour Yellow&Gorge Green Sail', '나이키 x 사카이 베이퍼와플 투어 옐로우 & 골지 그린 세일', 'Nike', 'CV1363-700', 'TOUR YELLOW,GORGE GREEN,SAIL', 219000, SYSDATE, '20/12/17', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike Dunk Low Retro University Blue', '나이키 덩크 로우 레트로 유니버시티 블루', 'Nike', 'DD1391-102', 'WHITE,UNIVERSITY BLUE-WHITE', 119000, SYSDATE, '21/04/28', '240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, 'Nike x Sacai Blazer Low Magma Orange', '나이키 x 사카이 블레이저 로우 마그마 오렌지', 'Nike', 'DD1877-100', 'WHITE,MAGMA ORANGE-WHITE', 139000, SYSDATE, '21/06/10', '225,230,235(US 4.5),235(US 5),240(US 5.5),240(US 6),245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(GS) Nike Dunk Low Black', '(GS) 나이키 덩크 로우 블랙', 'Nike', 'CW1590-100', 'WHITE,BLACK', 99000, SYSDATE, '21/01/14', '225(3.5Y),230(4Y),235(4.5Y),235(5Y·W),240(5.5Y),240(6Y·W),245(6.5Y),250(7Y)');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(W) New Balance 327 White Moonbeam', '(W) 뉴발란스 327 화이트 문빔', 'New Balance', 'WS327SFD', 'MUNSELL WHITE,MOONBEAM', 109000, SYSDATE, '21/02/04', '215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(W) Nike Air Force 1 07 Low White', '(W) 나이키 에어포스 1 07 로우 화이트', 'Nike', '315115-112/DD8959-100', 'WHITE,WHITE', 129000, SYSDATE, NULL, '215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290');
INSERT INTO ITEM
VALUES (ITEM_SEQ.NEXTVAL, '(GS) Jordan 1 Retro High OG University Blue', '(GS) 조던 1 레트로 하이 OG 유니버시티 블루', 'Jordan', '575441-134', 'WHITE,UNIVERSITY BLUE,BLACK', 139000, SYSDATE, '21/03/06', '225(3.5Y),230(4Y),235(4.5Y),235(5Y·W),240(5.5Y),240(6Y·W),245(6.5Y),250(7Y)');

-- 공지 테이블 예시 컬럼값 삽입
INSERT INTO NOTICE VALUES(1, '관리자 게시글', 'admin', sysdate, 
'저희 사이트를 이용해 주셔서 감사합니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(2, '개인정보 처리방침 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(3, '서비스 일시 중단 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(4, '입고 지연 안내', 'admin', sysdate, 
'테스트 페이지입니다..', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(5, '휴무일 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(6, '7월 이벤트 당첨자 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(7, '이용약관 변경 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(8, '가품거래 시도와 관련한 조치사항', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(9, '부정거래 이용제한 조치 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(10, '개인정보 이용 처리방침 변경 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);
INSERT INTO NOTICE VALUES(11, '택배사 휴무 안내', 'admin', sysdate, 
'테스트 페이지입니다.', 1 , DEFAULT);

-- 질문 테이블 예시 컬럼값 삽입
INSERT INTO QUESTION VALUES(1, '배송문의', 'user01', SYSDATE, 
'테스트 페이지 입니다.', DEFAULT, 1, 1, 1);
INSERT INTO QUESTION VALUES(2, '답변입니다.', 'admin', SYSDATE, 
'테스트 페이지입니다.', DEFAULT, 1, 2, 1);

-- 커밋 완료
commit;
