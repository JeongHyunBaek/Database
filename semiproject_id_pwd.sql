CREATE USER c##semiproject IDENTIFIED BY c##semiproject;
GRANT CONNECT, RESOURCE TO c##semiproject;
ALTER USER c##semiproject QUOTA 1024M ON USERS;