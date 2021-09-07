-- 기존에 존재하는 테이블 삭제
DROP TABLE USER_INFO CASCADE CONSTRAINTS;
DROP TABLE SUBJECT CASCADE CONSTRAINTS;
DROP TABLE KEYWORD CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE TUTOR CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE COMMENTS CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE REVIEW CASCADE CONSTRAINTS;
DROP TABLE CHATTING_ROOM CASCADE CONSTRAINTS;
DROP TABLE CHATTING CASCADE CONSTRAINTS;
DROP TABLE LIKES CASCADE CONSTRAINTS;
DROP TABLE SUB_DATA CASCADE CONSTRAINTS;
DROP TABLE KEY_DATA CASCADE CONSTRAINTS;

-- 기존에 존재하는 시퀀스 삭제
DROP SEQUENCE USER_SEQ;
DROP SEQUENCE SUBJECT_SEQ;
DROP SEQUENCE KEYWORD_SEQ;
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE COMMENTS_SEQ;
DROP SEQUENCE PAYMENT_SEQ;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE CHATTING_ROOM_SEQ;
DROP SEQUENCE CHATTING_SEQ;
DROP SEQUENCE LIKES_SEQ;

-- 사용자 테이블 생성
CREATE TABLE USER_INFO(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_SSN VARCHAR2(20) CONSTRAINT USER_SSN_NN NOT NULL,
    USER_NAME VARCHAR2(20) CONSTRAINT USER_NAME_NN NOT NULL,
    USER_PHONE VARCHAR2(20) CONSTRAINT USER_PHONE_NN NOT NULL,
    USER_ID VARCHAR2(20) CONSTRAINT USER_ID_NN NOT NULL,
    USER_PWD VARCHAR2(100) CONSTRAINT USER_PWD_NN NOT NULL,
    USER_EMAIL VARCHAR2(30) CONSTRAINT USER_EMAIL_NN NOT NULL,
    USER_POSITION CHAR(1) CONSTRAINT USER_POSITION_NN NOT NULL,
    LOGIN_OK CHAR(1) DEFAULT 'Y',
    CONSTRAINT USER_SSN_UQ UNIQUE(USER_SSN),
    CONSTRAINT USER_PHONE_UQ UNIQUE(USER_PHONE),
    CONSTRAINT USER_ID_UQ UNIQUE(USER_ID),
    CONSTRAINT USER_EMAIL_UQ UNIQUE(USER_EMAIL)
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
COMMENT ON TABLE USER_INFO IS '사용자';
COMMENT ON COLUMN USER_INFO.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_INFO.USER_SSN IS '주민번호';
COMMENT ON COLUMN USER_INFO.USER_NAME IS '이름';
COMMENT ON COLUMN USER_INFO.USER_PHONE IS '핸드폰';
COMMENT ON COLUMN USER_INFO.USER_ID IS '아이디';
COMMENT ON COLUMN USER_INFO.USER_PWD IS '비밀번호';
COMMENT ON COLUMN USER_INFO.USER_EMAIL IS '이메일';
COMMENT ON COLUMN USER_INFO.USER_POSITION IS '권한';
COMMENT ON COLUMN USER_INFO.LOGIN_OK IS '로그인 OK';

-- 과목 테이블 생성
CREATE TABLE SUBJECT(
    SUB_NO NUMBER CONSTRAINT SUBJECT_SUB_NO_PK PRIMARY KEY,
    CATEGORY VARCHAR2(30) CONSTRAINT SUBJECT_CATEGORY_NN NOT NULL,
    SUB_NAME VARCHAR2(100) CONSTRAINT SUBJECT_SUB_NAME_NN NOT NULL,
    CONSTRAINT SUBJECT_SUB_NAME_UQ UNIQUE(SUB_NAME)
);

-- 과목 테이블 번호 시퀀스 생성
CREATE SEQUENCE SUBJECT_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 과목 테이블 COMMENT 생성
COMMENT ON TABLE SUBJECT IS '과목';
COMMENT ON COLUMN SUBJECT.SUB_NO IS '과목번호';
COMMENT ON COLUMN SUBJECT.CATEGORY IS '분류';
COMMENT ON COLUMN SUBJECT.SUB_NAME IS '과목이름';

-- 키워드 테이블 생성
CREATE TABLE KEYWORD(
    KEY_NO NUMBER CONSTRAINT KEYWORD_KEY_NO_PK PRIMARY KEY,
    TYPE_PER VARCHAR2(100) CONSTRAINT KEYWORD_TYPE_PER_NN NOT NULL,
    CONSTRAINT KEYWORD_TYPE_PER_UQ UNIQUE(TYPE_PER)
);

-- 키워드 테이블 번호 시퀀스 생성
CREATE SEQUENCE KEYWORD_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 키워드 테이블 COMMENT 생성
COMMENT ON TABLE KEYWORD IS '키워드';
COMMENT ON COLUMN KEYWORD.KEY_NO IS '번호';
COMMENT ON COLUMN KEYWORD.TYPE_PER IS '성격';

-- 학생 테이블 생성
CREATE TABLE STUDENT(
    USER_NO NUMBER CONSTRAINT STUDENT_USER_NO_FK REFERENCES USER_INFO(USER_NO),
    PIC VARCHAR2(20),
    STU_JOB VARCHAR2(20) CONSTRAINT STUDENT_STU_JOB_NN NOT NULL,
    DAY VARCHAR2(30) CONSTRAINT STUDENT_DAY_NN NOT NULL,
    TIME VARCHAR2(100) CONSTRAINT STUDENT_TIME_NN NOT NULL,
    STU_WISH VARCHAR2(100),
    CONSTRAINT STUDENT_USER_NO_PK PRIMARY KEY(USER_NO)
);

-- 학생 테이블 COMMENT 생성
COMMENT ON TABLE STUDENT IS '학생';
COMMENT ON COLUMN STUDENT.USER_NO IS '회원번호';
COMMENT ON COLUMN STUDENT.PIC IS '프로필사진';
COMMENT ON COLUMN STUDENT.STU_JOB IS '학년';
COMMENT ON COLUMN STUDENT.DAY IS '과목가능요일';
COMMENT ON COLUMN STUDENT.TIME IS '과외가능시간';
COMMENT ON COLUMN STUDENT.STU_WISH IS '바라는 점';

-- 선생님 테이블 생성
CREATE TABLE TUTOR(
    USER_NO NUMBER CONSTRAINT TUTOR_USER_NO_FK REFERENCES USER_INFO(USER_NO),
    PIC VARCHAR2(20) CONSTRAINT TUTOR_PIC_NN NOT NULL,
    MIN_PAY VARCHAR2(100) CONSTRAINT TUTOR_MIN_PAY_NN NOT NULL,
    ONLINE_OK CHAR(1) DEFAULT 'N',
    AREA VARCHAR2(30) CONSTRAINT TUTOR_AREA_NN NOT NULL,
    INTRO VARCHAR2(100) CONSTRAINT TUTOR_INTRO_NN NOT NULL,
    DAY VARCHAR2(30) CONSTRAINT TUTOR_DAY_NN NOT NULL,
    TIME VARCHAR2(100) CONSTRAINT TUTOR_TIME_NN NOT NULL,
    STYLE VARCHAR2(100) CONSTRAINT TUTOR_STYLE_NN NOT NULL,
    L_GRD VARCHAR2(100) CONSTRAINT TUTOR_L_GRD_NN NOT NULL,
    CLASS_MIN VARCHAR2(10) CONSTRAINT TUTOR_CLASS_MIN_NN NOT NULL,
    CLASS_TIMES VARCHAR2(10) CONSTRAINT TUTOR_CLASS_TIMES_NN NOT NULL,
    CONSTRAINT TUTOR_USER_NO_PK PRIMARY KEY(USER_NO)
);

-- 선생님 테이블 COMMENT 생성
COMMENT ON TABLE TUTOR IS '선생님';
COMMENT ON COLUMN TUTOR.USER_NO IS '회원번호';
COMMENT ON COLUMN TUTOR.PIC IS '프로필사진';
COMMENT ON COLUMN TUTOR.MIN_PAY IS '최소페이';
COMMENT ON COLUMN TUTOR.ONLINE_OK IS '화상가능여부';
COMMENT ON COLUMN TUTOR.AREA IS '가능 지역';
COMMENT ON COLUMN TUTOR.INTRO IS '한줄소개';
COMMENT ON COLUMN TUTOR.DAY IS '과외가능요일';
COMMENT ON COLUMN TUTOR.TIME IS '과외가능시간';
COMMENT ON COLUMN TUTOR.STYLE IS '과외 스타일';
COMMENT ON COLUMN TUTOR.L_GRD IS '학력';
COMMENT ON COLUMN TUTOR.CLASS_MIN IS '1회당 수업시간';
COMMENT ON COLUMN TUTOR.CLASS_TIMES IS '수업횟수';

-- 게시글 테이블 생성
CREATE TABLE BOARD(
    BOARD_NO NUMBER CONSTRAINT BOARD_NO_PK PRIMARY KEY,
    BOARD_TITLE VARCHAR2(100) CONSTRAINT BOARD_TITLE_NN NOT NULL,
    BOARD_WRITER VARCHAR2(20) CONSTRAINT BOARD_WRITER_NN NOT NULL,
    BOARD_CONTENT VARCHAR2(1000) CONSTRAINT BOARD_CONTENT_NN NOT NULL,
    BOARD_DATE TIMESTAMP CONSTRAINT BOARD_DATE_NN NOT NULL,
    BOARD_ORIGINAL_FILENAME VARCHAR2(100),
    BOARD_RENAME_FILENAME VARCHAR2(100),
    VIEW_CNT NUMBER DEFAULT 0
);

-- 게시글 테이블 번호 시퀀스 생성
CREATE SEQUENCE BOARD_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 게시글 테이블 COMMENT 생성
COMMENT ON TABLE BOARD IS '게시글';
COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '제목';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '작성자';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '내용';
COMMENT ON COLUMN BOARD.BOARD_DATE IS '작성일시';
COMMENT ON COLUMN BOARD.BOARD_ORIGINAL_FILENAME IS 'OFILE';
COMMENT ON COLUMN BOARD.BOARD_RENAME_FILENAME IS 'RFILE';
COMMENT ON COLUMN BOARD.VIEW_CNT IS '조회수';

-- 댓글 테이블 생성
CREATE TABLE COMMENTS(
    COM_NO NUMBER CONSTRAINT COM_NO_PK PRIMARY KEY,
    BOARD_NO NUMBER CONSTRAINT COM_BOARD_NO_NN NOT NULL,
    COM_LEVEL VARCHAR2(100) CONSTRAINT COM_LEVEL_NN NOT NULL,
    COM_WRITER VARCHAR2(100) CONSTRAINT COM_WRITER_NN NOT NULL,
    COM_DATE VARCHAR2(30) CONSTRAINT COM_DATE_NN NOT NULL,
    COM_CONTENT VARCHAR2(100) CONSTRAINT COM_CONTENT_NN NOT NULL,
    CONSTRAINT COM_BOARD_NO_FK FOREIGN KEY (BOARD_NO) REFERENCES BOARD(BOARD_NO)
);

-- 댓글 테이블 번호 시퀀스 생성
CREATE SEQUENCE COMMENTS_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 댓글 테이블 COMMENT 생성
COMMENT ON TABLE COMMENTS IS '댓글';
COMMENT ON COLUMN COMMENTS.COM_NO IS '댓글번호';
COMMENT ON COLUMN COMMENTS.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN COMMENTS.COM_LEVEL IS '댓글 level';
COMMENT ON COLUMN COMMENTS.COM_WRITER IS '작성자';
COMMENT ON COLUMN COMMENTS.COM_DATE IS '작성일시';
COMMENT ON COLUMN COMMENTS.COM_CONTENT IS '내용';

-- 결제 테이블 생성
CREATE TABLE PAYMENT(
    PAY_NO NUMBER CONSTRAINT PAY_NO_PK PRIMARY KEY,
    STUDENT_NO NUMBER CONSTRAINT PAY_STUDENT_NO_NN NOT NULL,
    TUTOR_NO NUMBER CONSTRAINT PAY_TUTOR_NO_NN NOT NULL,
    PAY_DATETM TIMESTAMP CONSTRAINT PAY_DATETM_NN NOT NULL,
    PAY_METHOD VARCHAR2(20) CONSTRAINT PAY_METHOD_NN NOT NULL,
    PAY_AMOUNT VARCHAR2(20) CONSTRAINT PAY_AMOUNT_NN NOT NULL,
    PAY_STATUS CHAR(1) DEFAULT 'N',
    CONSTRAINT PAY_STUDENT_NO_FK FOREIGN KEY (STUDENT_NO) REFERENCES STUDENT(USER_NO),
    CONSTRAINT PAY_TUTOR_NO_FK FOREIGN KEY (TUTOR_NO) REFERENCES TUTOR(USER_NO)
);

-- 결제 테이블 COMMENT 생성
COMMENT ON TABLE PAYMENT IS '결제';
COMMENT ON COLUMN PAYMENT.PAY_NO IS '결제번호';
COMMENT ON COLUMN PAYMENT.TUTOR_NO IS '선생님 번호';
COMMENT ON COLUMN PAYMENT.STUDENT_NO IS '학생 번호';
COMMENT ON COLUMN PAYMENT.PAY_DATETM IS '결제일시';
COMMENT ON COLUMN PAYMENT.PAY_METHOD IS '결제방법';
COMMENT ON COLUMN PAYMENT.PAY_AMOUNT IS '결제금액';
COMMENT ON COLUMN PAYMENT.PAY_STATUS IS '결제상태';

-- 결제 테이블 번호 시퀀스 생성
CREATE SEQUENCE PAYMENT_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 리뷰 테이블 생성
CREATE TABLE REVIEW(
    REV_NO NUMBER CONSTRAINT REV_NO_PK PRIMARY KEY,
    PAY_NO NUMBER CONSTRAINT REV_PAY_NO_NN NOT NULL,
    REV_DATETM TIMESTAMP CONSTRAINT REV_DATETM_NN NOT NULL,
    SCORE NUMBER DEFAULT 0,
    REV_CONTENT VARCHAR2(1000) CONSTRAINT REV_CONTENT_NN NOT NULL,
    CONSTRAINT REV_PAY_NO_FK FOREIGN KEY (PAY_NO) REFERENCES PAYMENT(PAY_NO)
);

-- 리뷰 테이블 번호 시퀀스 생성
CREATE SEQUENCE REVIEW_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 리뷰 테이블 COMMENT 생성
COMMENT ON TABLE REVIEW IS '리뷰';
COMMENT ON COLUMN REVIEW.REV_NO IS '리뷰번호';
COMMENT ON COLUMN REVIEW.PAY_NO IS '결제번호';
COMMENT ON COLUMN REVIEW.REV_DATETM IS '작성일시';
COMMENT ON COLUMN REVIEW.SCORE IS '점수';
COMMENT ON COLUMN REVIEW.REV_CONTENT IS '내용';

-- 채팅방 테이블 생성
CREATE TABLE CHATTING_ROOM(
    CHAT_ROOM_NO NUMBER CONSTRAINT CHAT_ROOM_NO_PK PRIMARY KEY,
    STUDENT_NO NUMBER CONSTRAINT CHAT_ROOM_STUDENT_NO_NN NOT NULL,
    TUTOR_NO NUMBER CONSTRAINT CHAT_ROOM_TUTOR_NO_NN NOT NULL,
    CONSTRAINT CHAT_ROOM_STUDENT_NO_FK FOREIGN KEY (STUDENT_NO) REFERENCES STUDENT(USER_NO),
    CONSTRAINT CHAT_ROOM_TUTOR_NO_FK FOREIGN KEY (TUTOR_NO) REFERENCES TUTOR(USER_NO)
);

-- 채팅방 테이블 번호 시퀀스 생성
CREATE SEQUENCE CHATTING_ROOM_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 채팅방 테이블 COMMENT 생성
COMMENT ON TABLE CHATTING_ROOM IS '채팅방';
COMMENT ON COLUMN CHATTING_ROOM.CHAT_ROOM_NO IS '채팅방 번호';
COMMENT ON COLUMN CHATTING_ROOM.STUDENT_NO IS '학생번호';
COMMENT ON COLUMN CHATTING_ROOM.TUTOR_NO IS '선생님번호';

-- 채팅 테이블 생성
CREATE TABLE CHATTING(
    CHAT_NO NUMBER CONSTRAINT CHAT_NO_PK PRIMARY KEY,
    CHAT_ROOM_NO NUMBER CONSTRAINT CHAT_ROOM_NO_NN NOT NULL,
    WRTN_DATETM TIMESTAMP CONSTRAINT CHAT_WRTN_DATETM_NN NOT NULL,
    USER_NO NUMBER CONSTRAINT CHAT_USER_NO_NN NOT NULL,
    CHAT_CONTENT VARCHAR2(1000) CONSTRAINT CHAT_CONTENT_NN NOT NULL,
    CONSTRAINT CHAT_ROOM_NO_FK FOREIGN KEY (CHAT_ROOM_NO) REFERENCES CHATTING_ROOM(CHAT_ROOM_NO)
);

-- 채팅 테이블 번호 시퀀스 생성
CREATE SEQUENCE CHATTING_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 채팅 테이블 COMMENT 생성
COMMENT ON TABLE CHATTING IS '채팅';
COMMENT ON COLUMN CHATTING.CHAT_NO IS '채팅번호';
COMMENT ON COLUMN CHATTING.CHAT_ROOM_NO IS '채팅방 번호';
COMMENT ON COLUMN CHATTING.WRTN_DATETM IS '작성일시';
COMMENT ON COLUMN CHATTING.USER_NO IS '송신인';
COMMENT ON COLUMN CHATTING.CHAT_CONTENT IS '내용';

-- 찜목록 테이블 생성
CREATE TABLE LIKES(
    LIKE_NO NUMBER CONSTRAINT LIKE_NO_PK PRIMARY KEY,
    STUDENT_NO NUMBER CONSTRAINT LIKE_STUDENT_NO_NN NOT NULL,
    TUTOR_NO NUMBER CONSTRAINT LIKE_TUTOR_NO_NN NOT NULL,
    CONSTRAINT LIKE_STUDENT_NO_FK FOREIGN KEY (STUDENT_NO) REFERENCES STUDENT(USER_NO),
    CONSTRAINT LIKE_TUTOR_NO_FK FOREIGN KEY (TUTOR_NO) REFERENCES TUTOR(USER_NO)
);

-- 찜목록 테이블 번호 시퀀스 생성
CREATE SEQUENCE LIKES_SEQ
INCREMENT BY 1
START WITH 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 찜목록 테이블 COMMENT 생성
COMMENT ON TABLE LIKES IS '찜';
COMMENT ON COLUMN LIKES.LIKE_NO IS '찜 번호';
COMMENT ON COLUMN LIKES.STUDENT_NO IS '학생번호';
COMMENT ON COLUMN LIKES.TUTOR_NO IS '선생님번호';

-- 성격 데이터 테이블 생성
CREATE TABLE SUB_DATA(
    USER_NO NUMBER,
    SUB_NO NUMBER CONSTRAINT SUB_DATA_SUB_NO_NN NOT NULL,
    CONSTRAINT SUB_DATA_USER_NO_FK FOREIGN KEY (USER_NO) REFERENCES USER_INFO(USER_NO),
    CONSTRAINT SUB_DATA_SUB_NO_FK FOREIGN KEY (SUB_NO) REFERENCES SUBJECT(SUB_NO)
);

-- 키워드 데이터 테이블 생성
CREATE TABLE KEY_DATA(
    USER_NO NUMBER,
    KEY_NO NUMBER CONSTRAINT SUB_DATA_KEY_NO_NN NOT NULL,
    CONSTRAINT KEY_DATA_USER_NO_FK FOREIGN KEY (USER_NO) REFERENCES USER_INFO(USER_NO),
    CONSTRAINT KEY_DATA_KEY_NO_FK FOREIGN KEY (KEY_NO) REFERENCES KEYWORD(KEY_NO)
);

--사용자 데이터[ 회원번호, 주민번호, 이름, 핸드폰, 아이디, 비밀번호, 이메일, 권한, 로그인]
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '940725-1111111', '임길동', '010-2222-3333', 'STU01', 'STU01', 'stu01@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '920815-1211111', '홍길동', '010-2222-2222', 'TUT01', 'TUT01', 'tut01@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '941105-1121111', '김길동', '010-2222-4333', 'STU02', 'STU02', 'stu02@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '920615-1211111', '나길동', '010-2222-2232', 'TUT02', 'TUT02', 'tut02@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '940705-1121121', '도길동', '010-2222-4323', 'STU03', 'STU03', 'stu03@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '920515-1211311', '루길동', '010-2222-1232', 'TUT03', 'TUT03', 'tut03@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '840725-1221121', '마길동', '010-2223-4323', 'STU04', 'STU04',' stu04@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '920615-1211391', '박길동', '010-2232-1232', 'TUT04', 'TUT04', 'tut04@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '820725-1251121', '심길동', '010-2823-4323', 'STU05', 'STU05', 'stu05@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '920615-1271391', '노길동', '010-9232-1232', 'TUT05', 'TUT05', 'tut05@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '840725-1251121', '장길동', '010-2823-8323', 'STU06', 'STU06', 'stu06@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '910615-1271391', '차길동', '010-9232-7232', 'TUT06', 'TUT06', 'tut06@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '810125-1291121', '김철수', '010-2823-8723', 'STU07', 'STU07', 'stu07@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '950215-1271399', '김영희', '010-9932-7232', 'TUT07', 'TUT07', 'tut07@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '810325-1291121', '정철수', '010-4823-8723', 'STU08', 'STU08', 'stu08@gmail.com', 'S', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '950929-1271399', '정영희', '010-9937-7232', 'TUT08', 'TUT08', 'tut08@gmail.com', 'T', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '111111-1111111', '백정현', '010-9999-9999', 'MAN01', 'MAN01', 'man01@gmail.com', 'M', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '221111-1111111', '이정현', '010-8888-9999', 'MAN02', 'MAN02', 'man02@gmail.com', 'M', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '331111-1111111', '김정현', '010-7777-9999', 'MAN03', 'MAN03', 'man03@gmail.com', 'M', default);
INSERT INTO USER_INFO VALUES (USER_SEQ.NEXTVAL, '441111-1111111', '도정현', '010-6666-9999', 'MAN04', 'MAN04', 'man04@gmail.com', 'M', default);



--과목 데이터[ 과목번호, 분류, 과목이름]
INSERT INTO SUBJECT VALUES (1, '수학', '초등수학');
INSERT INTO SUBJECT VALUES (2, '수학', '중등수학');
INSERT INTO SUBJECT VALUES (3, '수학', '고등공통수학');
INSERT INTO SUBJECT VALUES (4, '수학', '고등문과수학');
INSERT INTO SUBJECT VALUES (5, '수학', '고등이과수학');
INSERT INTO SUBJECT VALUES (6, '수학', '편입수학');

INSERT INTO SUBJECT VALUES (7, '영어', '초등영어');
INSERT INTO SUBJECT VALUES (8, '영어', '중등영어');
INSERT INTO SUBJECT VALUES (9, '영어', '고등영어');
INSERT INTO SUBJECT VALUES (10, '영어', '수능영어');
INSERT INTO SUBJECT VALUES (11, '영어', '편입영어');

INSERT INTO SUBJECT VALUES (12, '국어', '초등국어');
INSERT INTO SUBJECT VALUES (13, '국어', '중등국어');
INSERT INTO SUBJECT VALUES (14, '국어', '고등국어');
INSERT INTO SUBJECT VALUES (15, '국어', '고등국어_문학');
INSERT INTO SUBJECT VALUES (16, '국어', '고등국어_화작문');
INSERT INTO SUBJECT VALUES (17, '국어', '고등국어_독서문법');

INSERT INTO SUBJECT VALUES (18, '과학', '초등과학');
INSERT INTO SUBJECT VALUES (19, '과학', '중등과학');
INSERT INTO SUBJECT VALUES (20, '과학', '고등과학');
INSERT INTO SUBJECT VALUES (21, '과학', '물리1');
INSERT INTO SUBJECT VALUES (22, '과학', '물리2');
INSERT INTO SUBJECT VALUES (23, '과학', '화학1');
INSERT INTO SUBJECT VALUES (24, '과학', '화학2');
INSERT INTO SUBJECT VALUES (25, '과학', '생명과학1');
INSERT INTO SUBJECT VALUES (26, '과학', '생명과학2');
INSERT INTO SUBJECT VALUES (27, '과학', '지구과학1');
INSERT INTO SUBJECT VALUES (28, '과학', '지구과학2');

INSERT INTO SUBJECT VALUES (29, '사회', '초등사회');
INSERT INTO SUBJECT VALUES (30, '사회', '중등사회');
INSERT INTO SUBJECT VALUES (31, '사회', '고등사회');
INSERT INTO SUBJECT VALUES (32, '사회', '세계사');
INSERT INTO SUBJECT VALUES (33, '사회', '한국사');
INSERT INTO SUBJECT VALUES (34, '사회', '세계지리');
INSERT INTO SUBJECT VALUES (35, '사회', '윤리와사상');
INSERT INTO SUBJECT VALUES (36, '사회', '생활과윤리');
INSERT INTO SUBJECT VALUES (37, '사회', '사회문화');
INSERT INTO SUBJECT VALUES (38, '사회', '경제');
INSERT INTO SUBJECT VALUES (39, '사회', '법과정치');
INSERT INTO SUBJECT VALUES (40, '사회', '동아시아사');
INSERT INTO SUBJECT VALUES (41, '사회', '한국지리');

INSERT INTO SUBJECT VALUES (42, '외국어공인인증', '토익');
INSERT INTO SUBJECT VALUES (43, '외국어공인인증', '토스');
INSERT INTO SUBJECT VALUES (44, '외국어공인인증', '텝스');
INSERT INTO SUBJECT VALUES (45, '외국어공인인증', '토플');
INSERT INTO SUBJECT VALUES (46, '외국어공인인증', '아이엘츠');
INSERT INTO SUBJECT VALUES (47, '외국어공인인증', '오픽');
INSERT INTO SUBJECT VALUES (48, '외국어공인인증', 'HSK/TSC');
INSERT INTO SUBJECT VALUES (49, '외국어공인인증', 'JPT/JLPT');
INSERT INTO SUBJECT VALUES (50, '외국어공인인증', 'DELE');
INSERT INTO SUBJECT VALUES (51, '외국어공인인증', 'DELF/DALF');
INSERT INTO SUBJECT VALUES (52, '외국어공인인증', 'TORFL');




--키워드 데이터[번호 ,  성격]
--INSERT INTO KEYWORD VALUES (1, 'TYPE_PER 1');

INSERT INTO KEYWORD VALUES (1, '차분한');	
INSERT INTO KEYWORD VALUES (2, '인자한');
INSERT INTO KEYWORD VALUES (3, '느긋한');
INSERT INTO KEYWORD VALUES (4, '꼼꼼한');
INSERT INTO KEYWORD VALUES (5, '활동적인');
INSERT INTO KEYWORD VALUES (6, '여유로운');
INSERT INTO KEYWORD VALUES (7, '엄격한');
INSERT INTO KEYWORD VALUES (8, '계획적인');
INSERT INTO KEYWORD VALUES (9, '책임감있는');
INSERT INTO KEYWORD VALUES (10, '밝은');
INSERT INTO KEYWORD VALUES (11, '세심한');
INSERT INTO KEYWORD VALUES (12, '솔직한');
INSERT INTO KEYWORD VALUES (13, '철두철미한');
INSERT INTO KEYWORD VALUES (14, '털털한');
INSERT INTO KEYWORD VALUES (15, '친근한');
INSERT INTO KEYWORD VALUES (16, '사명감');
INSERT INTO KEYWORD VALUES (17, '정이많은');
INSERT INTO KEYWORD VALUES (18, '조용한');
INSERT INTO KEYWORD VALUES (19, '공감능력있는');
INSERT INTO KEYWORD VALUES (20, '이성적인');


--학생 데이터[ 회원번호,  프로필사진, 학년, 과목이름, 과목가능요일, 과목가능시간, 바라는점]
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (1, 'PIC 01','초등학생', '월, 화', '18:00,22:00', '지각하지 않아줬으면 좋겠어요');
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (3, 'PIC 02','대학생', '수, 목, 금', '12:00,20:00', '잘생겼으면 좋겠어요');
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (5, 'PIC 03','고등학생', '토, 일', '18:00,22:00', '아만다 4점 이상만');
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (7, 'PIC 04','중학생', '금, 토, 일', '14:00,20:00', '제가 산만해서 엄격하셨으면 좋겠어요');
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (9, 'PIC 05','재수생', '화, 목','09:00,12:00', '목소리 좋은 사람만');
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (11, 'PIC 06','초등학생', '수, 목', '13:00,20:00','노래 잘부르시는 분');
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (13, 'PIC 07','고등학생', '월, 화', '15:00,18:00','이과쌤구해요');
INSERT INTO STUDENT (USER_NO, PIC, STU_JOB, DAY, TIME, STU_WISH) VALUES (15, 'PIC 08','대학생', '금,토,일', '17:00,20:00','키 179cm이상');





--선생님 데이터
--[ 회원번호, 프로필사진, 성격, 최소월급, 화상강의가능, 과외지역, 과목, 한줄소개, 가능요일, 가능시간, 과외스타일, 학력]
INSERT INTO TUTOR VALUES (2, 'PIC1.jpg', '30만원', 'N', '서울 광진구', '즐거운 수학시간', '월, 목', '14:00,16:00', '기출문제 반복 풀이', '한국대학교 재학중');
INSERT INTO TUTOR VALUES (4, 'PIC2.jpg',  '60만원', 'Y', '충남 공주시', '토익만점',  '월, 화', '15:00,17:00', '문제풀이를 반복적으로 하며 매주 단어 시험봄', '고려대학교 대학원 졸업');
INSERT INTO TUTOR VALUES (6, 'PIC3.jpg', '35만원', 'N', '서울시 관악구', '훈민정음', '화, 목', '16:00, 18:00', '꼼꼼하게 수업하며 숙제안하면 나머지 수업 있음', '서울대학교 재학중');
INSERT INTO TUTOR VALUES (8, 'PIC4.jpg', '25만원', 'Y', '대전 유성구', '재밌는 역사', '화,금', '18:00, 20:00', '역사에 담긴 얘기를 많이 해줌', '서강대학교 졸업');
INSERT INTO TUTOR VALUES (10, 'PIC5.jpg', '45만원', 'Y', '서울 용산구', 'teacher 노', '수, 일', '16:30, 18:30', '천천히 이해할 수 있을 때까지 자세히 설명함', '동국대학교 졸업');
INSERT INTO TUTOR VALUES (12, 'PIC6.jpg', '50만원', 'N', '서울 서대문구', '과탐 길동쌤', '목,일', '17:00, 19:30', '기출문제를 분석하여 새로운 문제를 만들어보며 오답노트 활용', '연세대학교 재학중');
INSERT INTO TUTOR VALUES (14, 'PIC7.jpg', '30만원', 'Y', '인천 연수구', '길동이의 경제교실', '수, 일', '17:30, 19:30', '모의고사 기출문제 반복 풀이', '인천대학교 대학원 재학중');
INSERT INTO TUTOR VALUES (16, 'PIC8.jpg', '35만원', 'Y', '서울 노원구', '니하오중국어',  '월,금', '17:00, 19:00', '중국어로 수업', '한국외국어대학교 재학중');





--게시글 데이터[게시글번호, 제목, 작성자, 내용, 작성일시,OFILE, RFILE, 조회수]
INSERT INTO BOARD VALUES (1, '고등수학 선생님 추천해주세요.', 'STU01', '제가 고등학교 2학년이고 이과입니다. 제가 미적분이 약해서… 고등수학 과외 선생님 좀 추천해주세요 ㅜㅜ', '20/08/09 12:56:10', null, null, 6);
INSERT INTO BOARD VALUES (2, '중학생 국어 문제집 좋은거 있나요?', 'STU03', '저희 아이가 이제 중학교에 올라가는데 국어가 약해서요. 중학생용 국어 문제집 중에 좋은게 있을까요?', '20/08/09 13:00:00', null, null, 1);
INSERT INTO BOARD VALUES (3, '토익 단어책 다 외우면 독해가 잘 되겠죠?', 'STU08', '제가 토익 독해 부분이 잘 안되서요.. 토익 단어 책 day50 중에 30까지 끝냈습니다… 단어장 다 외우는거 처음인데 나머지 20까지 공부하면 독해가 잘 되겠죠?' ,'20/08/11 22:19:30', null, null, 12);
INSERT INTO BOARD VALUES (4, '9월 모의고사를 바로 볼까요?', 'STU07', '집에서 9모 본다면 9모 실시일 바로 다음에 볼까요, 좀 더 공부하고 9월 중순에 볼까요?', '20/09/17 08:09:09', null, null, 40);
INSERT INTO BOARD VALUES (5, '문과가 방사선 학과 써도 되요?', 'STU02', '제가 문과인데 교과로 을지대 방사선 학과를 써도 되나요?', '20/10/11 06:15:58', null, null, 20);
INSERT INTO BOARD VALUES (6, '화학 문제집 추천합니다.', 'TUT03', '화학에 대해 어려우신 분들은 A출판사의 화학 문제집을 읽으시면 개념이 빠르게 잡히실 거에요.', '20/11/19 07:08:08', null, null, 10);
INSERT INTO BOARD VALUES (7, '토익은 무조건 800점 이상이어야 좋은가요?', 'STU08', '제가 이번에 토익 점수가 780점이 나왔는데.. 두번이나 700점대가 나오니까 뭔가 좀… 꼭 800점을 넘겨야 좋은가요?', '20/12/28 23:18:50', null, null, 20);
INSERT INTO BOARD VALUES (8, '사회문화 질문 드려요!', 'STU04', '사회문화를 보는 관점에서 개인의 행위를 강제하는 사회 체계를 중시하는가? 는 거시적 관점론 중에 갈등론만 해당 되나요?', '21/01/02 14:28:30', null, null, 30);
INSERT INTO BOARD VALUES (9, '모의 고사 하루 전에 뭐하셨나요?', 'STU05', '모의고사 하루 전에는 무엇을 하는게 가장 좋을까요? 선생님들은 어떤 대비를 하셨나요?', '21/01/03 13:45:10', null, null, 10);
INSERT INTO BOARD VALUES (10, '법과 정치 질문합니다.', 'STU06', '헌법재판소 재판관은 대통령이 임명하는 건가요?', '21/02/13 09:17:54', null, null, 24);
INSERT INTO BOARD VALUES (11, '입시 과학에 대해 설명 들으실 분!!', 'TUT03', '제가 입시 과학만 5년째 가르치고 있고, 매년 설명회를 하고 있습니다. 관심있으시다면 참석해 주세요.', '21/02/24 16:31:10', null, null, 30);
INSERT INTO BOARD VALUES (12, '사회 과목 문제 드려요.', 'STU04', '사회적 쟁점에는 뭐가 있나요?', '21/03/01 03:10:12', null, null, 6);
INSERT INTO BOARD VALUES (13, '영상 추천해주세요.', 'STU05', '시사 다큐멘터리로 토의 할 수 있는 영상 알려주세요. 찬반토론이나', '21/03/17 10:21:43', null, null, 7);
INSERT INTO BOARD VALUES (14, '단어 어떻게 외우셨어요?', 'STU06', '혹시 선생님들께서는 내신기간때 단어 계속 외우셨어요? 아니면 멈추고 내신에 집중하는게 좋을까요?', '21/03/05 17:40:58', null, null, 7);
INSERT INTO BOARD VALUES (15, '화상으로만 테스트 과외도 가능한가요?', 'STU02', '제가 지금 혼자 단어 외우는데 화상으로 1주일에 2회씩 테스트만 봐주실 쌤이 계실까요??', '21/04/20 21:35:19', null, null, 9);
INSERT INTO BOARD VALUES (16, '영어 회화 그룹 과외 하실 분 계신가요?', 'TUT01', '제가 영어 회화 과외를 하는데 많은 분들과 대화하는게 도움이 될 것 같아서요. 그룹 회화 하고싶으신 분은 채팅주세요.', '21/05/06 11:11:20', null, null, 27);
INSERT INTO BOARD VALUES (17, '제 의지가 약한데 어떻게 할까요?', 'STU02', '태플릿으로 인강, 유튜브로 해설강의, 단어 어플… 등 태블릿 사용이 많은데.. 유튜브, 아프리카 티비에 빠져서 집중이 안되는데 어떻게 하면 좋을까요…?', '21/05/27 16:18:20', null, null, 2);
INSERT INTO BOARD VALUES (18, '중학생 영어 과외는 어느 분이 좋으실까요?', 'STU03', '아이가 영어 회화는 좋아하는데, 독해를 어려워해서요. 중학생 영어 과외 선생님 추천해주실수 있나요?', '21/06/18 18:12:30', null, null, 10);
INSERT INTO BOARD VALUES (19, '몇등을 해야할까요?', 'STU06', '현실적으로 세종시에서 일반고를 나와서 인서울 하려면 몇등안에 들어야 할까요?', '21/07/06 12:12:12', null, null, 2);
INSERT INTO BOARD VALUES (20, '논술은 어떻게 준비해야 하나요?', 'STU05', '논술 과외를 받는게 좋을까요? 제가 논술이 약해서 걱정이에요… ', '21/07/13 19:40:20', null, null, 3);


--댓글 데이터[댓글번호, 게시글번호, 댓글 LEV, 작성자, 작성일시, 내용]
--INSERT INTO COMMENTS VALUES (1, 1, 1, 'COM_WRITER 1', sysdate, 'COM_CONTENT 1');
INSERT INTO COMMENTS VALUES (1, 2 , 1, 'STU01', '21/01/09 8:00:44', '저도 그렇게 생각해요');
INSERT INTO COMMENTS VALUES (2, 4 , 1, 'STU02', '21/12/19 9:05:20', '저는 그렇게 생각안해요');
INSERT INTO COMMENTS VALUES (3, 6, 1, 'STU03', '21/03/26 10:55:50', '널 품기 전 알지 못했다');
INSERT INTO COMMENTS VALUES (4, 8, 1, 'STU04', '21/04/24 13:22:10', '내 머문 세상 이토록');
INSERT INTO COMMENTS VALUES (5, 10 , 1, 'STU05', '21/06/29 14:33:25', '찬란한 것을');
INSERT INTO COMMENTS VALUES (6, 13 , 1, 'STU06', '21/04/10 22:44:34', '작은 숨결로 닿은 사람');
INSERT INTO COMMENTS VALUES (7, 11 , 1, 'STU07', '21/01/30 23:23:21', '겁 없이 나를 불러준 사랑');
INSERT INTO COMMENTS VALUES (8, 15, 1, 'STU08', '21/03/20 11:11:50', '몹시도 좋았다');
INSERT INTO COMMENTS VALUES (9, 17, 1, 'STU09', '21/02/10 15:45:40', '너를 지켜보고 설레고');
INSERT INTO COMMENTS VALUES (10, 19, 1, 'STU10', '21/06/18 18:35:30', '우습게 질투도 했던');
INSERT INTO COMMENTS VALUES (11, 11, 2, 'STU07', '21/03/11 17:12:20', '평범한 모든 순간들이');
INSERT INTO COMMENTS VALUES (12, 8, 2, 'STU04', '21/04/29 20:47:10', '캄캄한 영원');
INSERT INTO COMMENTS VALUES (13, 6, 2, 'STU03', '21/07/16 13:16:15', '그 오랜 기다림 속으로');
INSERT INTO COMMENTS VALUES (14, 4, 2, 'STU02', '21/12/25 12:34:12', '햇살처럼 니가 내렸다');
INSERT INTO COMMENTS VALUES (15, 2, 2, 'STU01', '21/08/12 10:35:00', '널 놓기 전 알지 못했다');
INSERT INTO COMMENTS VALUES (16, 17, 2, 'STU09', '21/09/03 20:22:59', '내 머문 세상 이토록');
INSERT INTO COMMENTS VALUES (17, 19, 2, 'STU10', '21/11/02 22:27:49', '쓸쓸한 것을');
INSERT INTO COMMENTS VALUES (18, 10, 2, 'STU05', '21/08/19 23:17:29', '고운 꽃이 피고 진 이 곳');
INSERT INTO COMMENTS VALUES (19, 13, 2, 'STU06', '21/09/29 00:06:19', '다시는 없을 너라는 계절');
INSERT INTO COMMENTS VALUES (20, 15, 2, 'STU08', '21/10/19 9:35:30', '욕심이 생겼다');


--결제 데이터[결제번호,   선생님 번호,   학생번호,   결제일시,  결제방법,  결제금액,  결제상태] 
INSERT INTO PAYMENT VALUES (PAYMENT_SEQ.NEXTVAL, 1, 2, '20/01/31 18:51:12', '카드', '30만원','Y');
INSERT INTO PAYMENT VALUES (PAYMENT_SEQ.NEXTVAL, 11, 12, '20/09/07 17:20:30', '카드', '50만원', 'Y');
INSERT INTO PAYMENT VALUES (PAYMENT_SEQ.NEXTVAL, 7, 10, '21/02/24 18:10:40', '카드', '45만원', 'Y');
INSERT INTO PAYMENT VALUES (PAYMENT_SEQ.NEXTVAL, 3, 8, '21/05/29 20:41:20', '카드', '25만원', 'Y');
INSERT INTO PAYMENT VALUES (PAYMENT_SEQ.NEXTVAL, 9, 14, '21/08/05 16:40:29', '계좌이체', '35만원', 'Y');


--리뷰 데이터[리뷰번호,  결제번호,  작성일시,  점수,  내용]
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 1, sysdate, 0, 'REV_CONTENT 1');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 1, '21/10/19 8:00:29', 1, '절대적 룰을 지켜 내 손을 놓지 말아');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 2, '21/01/29 10:05:19', 2, '결속은 나의 무기광야로 걸어가');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 3, '21/12/09 13:20:59', 3, '위협에 맞서서제껴라 제껴라 제껴라');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 4, '21/02/05 15:30:05', 4, '감당할 수 없는 절망도내 믿음을 깨지 못해');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 5, '21/04/21 9:44:23', 5, '더 아픈 시련을 맞아도난 잡은 손을 놓지 않을게');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 1, '21/06/30 20:55:44', 6, '절대로 뒤를 돌아보지 말아');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 2, '21/03/05 00:19:55', 7, '약속이 깨지면모두 걷잡을 수 없게 돼');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 3, '21/09/15 23:38:14', 8, '언제부턴가 불안해져 가는 신호');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 4, '21/10/24 21:19:51', 9, '중심을 잃고 목소리도 잃고 비난받고사람들과 멀어지는 착각 속에');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 5, '21/07/20 22:39:23', 10, '밤하늘의 별을 따서 너에게 줄래 너는 내가 사랑하니까 더 소중하니까');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 1, '21/06/18 19:27:45', 1, '오직 너 아니면 안 된다고 외치고 싶어');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 2, '21/05/05 18:57:21', 2, '그저 내 곁에만 있어줘 떠나지 말아줘');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 3, '21/03/03 17:51:35', 3, '참 많이 어색했었죠 널 처음 만난 날');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 4, '21/06/20 7:24:10', 4, '멀리서 좋아하다가 들킨 사람처럼');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 5, '21/07/15 4:28:18', 5, '숨이 가득 차올라서 아무 말 하지 못했는데');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 1, '21/05/08 2:52:23', 6, '너는 말 없이 웃으며 내 손 잡아줬죠');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 2, '21/01/01 1:25:29', 7, '널 좋아하는 내 마음이 표현이 안 돼');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 3, '21/02/25 23:41:48', 8, '꿈이 아니면 좋겠어 자꾸 웃음 나와');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 4, '21/12/20 21:58:28', 9, '내 모든 걸 다 준대도 너에겐 아깝질 않아');
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 5, '21/09/14 20:42:00', 10, '이 순간이 영원하길 난 정말 행복해');


--채팅방 데이터[ 채팅방번호,   학생번호,   선생님번호]
INSERT INTO CHATTING_ROOM VALUES (1, 1, 2);
INSERT INTO CHATTING_ROOM VALUES (2, 3, 4);
INSERT INTO CHATTING_ROOM VALUES (3, 5, 6);
INSERT INTO CHATTING_ROOM VALUES (4, 7, 8);
INSERT INTO CHATTING_ROOM VALUES (5, 9, 10);
INSERT INTO CHATTING_ROOM VALUES (6, 11, 12);
INSERT INTO CHATTING_ROOM VALUES (7, 13, 14);
INSERT INTO CHATTING_ROOM VALUES (8, 15, 16);
INSERT INTO CHATTING_ROOM VALUES (9, 1, 16);
INSERT INTO CHATTING_ROOM VALUES (10, 3, 14);
INSERT INTO CHATTING_ROOM VALUES (11, 5, 12);
INSERT INTO CHATTING_ROOM VALUES (12, 7, 10);
INSERT INTO CHATTING_ROOM VALUES (13, 9, 8);
INSERT INTO CHATTING_ROOM VALUES (14, 11, 6);
INSERT INTO CHATTING_ROOM VALUES (15, 13, 4);
INSERT INTO CHATTING_ROOM VALUES (16, 15, 2);
INSERT INTO CHATTING_ROOM VALUES (17, 1, 4);
INSERT INTO CHATTING_ROOM VALUES (18, 3, 8);
INSERT INTO CHATTING_ROOM VALUES (19, 7, 12);
INSERT INTO CHATTING_ROOM VALUES (20, 9, 14);


--채팅 데이터 [ 채팅번호,  채팅방번호,  작성일시,  송신인,  내용]
INSERT INTO CHATTING VALUES (1, 1, '20/01/23 18:32:00', 1, '안녕하세요 선생님, 고등학생 수학 과외에 대해 상담하고 싶습니다.');
INSERT INTO CHATTING VALUES (2, 1, '20/01/23 18:33:20', 2, '네 안녕하세요. 지금 학년이 어떻게 되시나요?');
INSERT INTO CHATTING VALUES (3, 1, '20/01/23 18:35:12', 1, '저는 고등학교 1학년이고, 혹시 언제 시간이 비시나요?');
INSERT INTO CHATTING VALUES (4, 1, '20/01/23 18:40:45', 2, '화목 7시 전이나 월수금 1타임 정도 빕니다.');
INSERT INTO CHATTING VALUES (5, 1, '20/01/23 18:42:06', 1, '월요일이나 금요일 날에 몇시쯤 가능하실까요?');
INSERT INTO CHATTING VALUES (6, 1, '20/01/23 18:43:17', 2, '수업이 있어서 맞춰봐야 해요. 언제 시간대 원하시나요? 수학 어떤 과목 수업 원하는지도요.');
INSERT INTO CHATTING VALUES (7, 1, '20/01/23 18:45:29', 1, '저는 2시 이후로는 시간은 관계 없습니다. 지금 일단 함수 진도 나가서 그 부분부터 배우고 싶습니다.');
INSERT INTO CHATTING VALUES (8, 1, '20/01/23 18:50:34', 2, '그럼 금요일 2시에 시범과외 어떠세요? 장소는 서울역 앞 스타벅스에서요.');
INSERT INTO CHATTING VALUES (9, 1, '20/01/23 18:51:12', 1, '네 알겠습니다. 그때 뵐게요.');

INSERT INTO CHATTING VALUES (10, 2, '20/04/12 08:13:55', 3, '안녕하세요. 토익 과외에 대해서 문의드립니다.');
INSERT INTO CHATTING VALUES (11, 2, '20/04/12 08:15:20', 4, '네 안녕하세요. 토익 점수가 어떻게 되시나요? 몇점을 원하시나요?');
INSERT INTO CHATTING VALUES (12, 2, '20/04/12 08:17:12', 3, '지금 제가 650점인데 800점대로 올리고 싶어요.');
INSERT INTO CHATTING VALUES (13, 2, '20/04/12 08:18:27', 4, '리딩이랑 리스닝 중 어느 부분을 중점으로 하길 원하세요?');
INSERT INTO CHATTING VALUES (14, 2, '20/04/12 08:20:53', 3, '저는 리딩 쪽이 부족합니다. 과외 시간은 언제가 가능한가요?');
INSERT INTO CHATTING VALUES (15, 2, '20/04/12 08:22:00', 4, '월화 3시 혹은 수금 5시 가능합니다.');
INSERT INTO CHATTING VALUES (16, 2, '20/04/12 08:23:44', 3, '그럼 월화 3시로 하겠습니다.');
INSERT INTO CHATTING VALUES (17, 2, '20/04/12 08:26:20', 4, '네 그럼 다음주 월요일 3시에 홍대역에서 봐요.');
INSERT INTO CHATTING VALUES (18, 2, '20/04/12 08:28:38', 3, '네 알겠습니다.');


INSERT INTO CHATTING VALUES (19, 6, '20/09/05 13:18:13', 11, '안녕하세요. 화학 과외 문의 되나요?');
INSERT INTO CHATTING VALUES (20, 6, '20/09/05 13:20:30', 12, '네 가능합니다. 화학 어떤걸 문의 하시나요?');
INSERT INTO CHATTING VALUES (21, 6, '20/09/05 13:22:21', 11, '저는 화학 2를 문의합니다.');
INSERT INTO CHATTING VALUES (22, 6, '20/09/05 13:26:39', 12, '그러면 시범과외는 월 수 3시 가능합니다.');
INSERT INTO CHATTING VALUES (23, 6, '20/09/05 13:30:56', 12, '네 그럼 월요일 3시에 뵙겠습니다.');

INSERT INTO CHATTING VALUES (24, 12, '21/02/18 20:54:39', 7, '안녕하세요. 초등국어 과외 문의 드려도 될까요?');
INSERT INTO CHATTING VALUES (25, 12, '21/02/18 20:56:21', 10, '네 가능합니다. 몇학년인가요?');
INSERT INTO CHATTING VALUES (26, 12, '21/02/18 20:58:10', 7, '지금 초등학교 5학년이에요.');
INSERT INTO CHATTING VALUES (27, 12, '21/02/18 21:00:30', 10, '그럼 화수 4시에 과외 가능하세요.');
INSERT INTO CHATTING VALUES (28, 12, '21/02/18 21:03:23', 7, '시범 과외도 가능할까요?');
INSERT INTO CHATTING VALUES (29, 12, '21/02/18 21:05:11', 10, '네 가능하십니다. 언제로 해드릴까요?');
INSERT INTO CHATTING VALUES (30, 12, '21/02/18 21:07:39', 7, '다음주 수요일에 가능할까요?');
INSERT INTO CHATTING VALUES (31, 12, '21/02/18 21:10:40', 10, '네 주소 보내주시면 수요일에 뵙겠습니다.');

INSERT INTO CHATTING VALUES (32, 18, '21/05/28 10:23:16', 3, '안녕하세요. 토플 과외 문의합니다.');
INSERT INTO CHATTING VALUES (33, 18, '21/05/28 10:24:10', 8, '네 안녕하세요. 학생이신가요?');
INSERT INTO CHATTING VALUES (34, 18, '21/05/28 10:26:17', 3, '네, 지금 대학생입니다.');
INSERT INTO CHATTING VALUES (35, 18, '21/05/28 10:29:57', 8, '토플 점수를 언제까지 따야 하나요?');
INSERT INTO CHATTING VALUES (36, 18, '21/05/28 10:32:42', 3, '올해 10월까지는 따야 합니다. 제가 두번 떨어져서 꼭 따야합니다.');
INSERT INTO CHATTING VALUES (37, 18, '21/05/28 10:35:27', 8, '점수는 몇점이었나요?');
INSERT INTO CHATTING VALUES (38, 18, '21/05/28 10:40:38', 3, '제가 52점으로 떨어졌어요.');
INSERT INTO CHATTING VALUES (39, 18, '21/05/28 10:41:27', 8, '과외는 지금 금토 6시에 가능하세요.');
INSERT INTO CHATTING VALUES (40, 18, '21/05/28 10:41:20', 3, '그럼 이번주 토요일부터 가능할까요?');
INSERT INTO CHATTING VALUES (41, 18, '21/05/28 10:43:12', 8, '그럼 주소 보내주시면 이번주부터 과외 시작하겠습니다.');

INSERT INTO CHATTING VALUES (42, 20, '21/07/31 22:15:40', 9, '안녕하세요. 편입수학 과외를 하려고 하는데요. 지금 채팅 가능 하신가요?');
INSERT INTO CHATTING VALUES (43, 20, '21/07/31 22:16:20', 14, '네, 가능하십니다. 편입수학 준비하시는거에요?');
INSERT INTO CHATTING VALUES (44, 20, '21/07/31 22:18:39', 9, '네, 제가 편입 준비중인데 영어가 부족해서 과외를 받으려구요.');
INSERT INTO CHATTING VALUES (45, 20, '21/07/31 22:20:19', 14, '그럼 어느 학교로 편입을 준비중이세요?');
INSERT INTO CHATTING VALUES (46, 20, '21/07/31 22:24:59', 9, '저는 서울대로 편입준비중입니다.');
INSERT INTO CHATTING VALUES (47, 20, '21/07/31 22:30:16', 14, '그러시면 시범과외 겸 직접 만나서 얘기하는건 어떠세요?');
INSERT INTO CHATTING VALUES (48, 20, '21/07/31 22:31:28', 9, '네 가능합니다. 시간은 언제인가요?');
INSERT INTO CHATTING VALUES (49, 20, '21/07/31 22:34:09', 14, '다음주 목요일 괜찮으세요?');
INSERT INTO CHATTING VALUES (50, 20, '21/07/31 22:36:38', 9, '목요일은 4시 이후로는 괜찮아요. 부평역 괜찮으세요?');
INSERT INTO CHATTING VALUES (51, 20, '21/07/31 22:40:29', 14, '네 그럼 목요일 4시에 부평역에서 뵙죠.');


--찜 데이터[찜 번호,   학생번호,   선생님번호] 
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 1, 10);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 1, 12);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 3, 12);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 3, 14);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 5, 2);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 5, 6);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 5, 14);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 7, 2);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 7, 10);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 7, 14);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 9, 8);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 9, 6);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 11, 6);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 11, 8);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 11, 10);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 11, 14);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 13, 12);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 13, 4);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 15, 4);
INSERT INTO LIKES VALUES (LIKES_SEQ.NEXTVAL, 15, 10);


--과목 데이터
INSERT INTO SUB_DATA VALUES (1, 1);
INSERT INTO SUB_DATA VALUES (1, 2);
INSERT INTO SUB_DATA VALUES (1, 3);
INSERT INTO SUB_DATA VALUES (1, 4);
INSERT INTO SUB_DATA VALUES (1, 5);
INSERT INTO SUB_DATA VALUES (2, 6);
INSERT INTO SUB_DATA VALUES (2, 7);
INSERT INTO SUB_DATA VALUES (2, 8);
INSERT INTO SUB_DATA VALUES (2, 9);
INSERT INTO SUB_DATA VALUES (2, 10);

--키워드 데이터
INSERT INTO KEY_DATA VALUES (1, 1);
INSERT INTO KEY_DATA VALUES (1, 2);
INSERT INTO KEY_DATA VALUES (1, 3);
INSERT INTO KEY_DATA VALUES (1, 4);
INSERT INTO KEY_DATA VALUES (1, 5);
INSERT INTO KEY_DATA VALUES (2, 6);
INSERT INTO KEY_DATA VALUES (2, 7);
INSERT INTO KEY_DATA VALUES (2, 8);
INSERT INTO KEY_DATA VALUES (2, 9);
INSERT INTO KEY_DATA VALUES (2, 10);

commit;