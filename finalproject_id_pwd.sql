-- ITYS 계정, 비밀번호, 권한 설정
CREATE USER c##finalproject IDENTIFIED BY c##finalproject;
GRANT CONNECT, RESOURCE TO c##finalproject;
ALTER USER c##finalproject QUOTA 1024M ON USERS;