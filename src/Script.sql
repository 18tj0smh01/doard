USE board_test;

CREATE TABLE TBL_MEMBER (
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    MEMBER_ID VARCHAR(255) NOT NULL UNIQUE,
    MEMBER_PASSWORD VARCHAR(255) NOT NULL,
    MEMBER_NAME VARCHAR(255) NOT NULL,
    CREATED_TIME DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO TBL_MEMBER (MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME)
VALUES('user3', '1234', '유저3');

SELECT ID FROM TBL_MEMBER WHERE MEMBER_ID = 'user1' AND MEMBER_PASSWORD = '1234';

        SELECT COUNT(ID)
        FROM TBL_MEMBER
        WHERE ID = 2;

select * from tbl_member;

drop table TBL_MEMBER;


CREATE TABLE POST (
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    POST_TITLE VARCHAR(255) NOT NULL,
    POST_CONTENT VARCHAR(1000) NOT NULL,
    VIEWCOUNT BIGINT DEFAULT 0,
    POST_DATE DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    POST_UPDATED_TIME DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    MEMBER_ID BIGINT NOT NULL,
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER(ID) ON DELETE CASCADE
);

INSERT INTO POST (ID, POST_TITLE, POST_CONTENT, MEMBER_ID)
VALUES(1, '테스트4', '내용', 2);

INSERT INTO POST (POST_TITLE, POST_CONTENT, MEMBER_ID)
VALUES('테스트13', '내용', 1);

select * from POST;

-- 매퍼 테스트

-- 글 리스트 출력
SELECT
    p.ID AS id,
    p.POST_TITLE AS postTitle,
    p.MEMBER_ID AS memberId,
    p.POST_DATE AS postDate,
    p.VIEWCOUNT AS viewCount,
    COALESCE(c.commentCount, 0) AS commentCount
FROM POST p
LEFT JOIN (
    SELECT POST_ID, COUNT(*) AS commentCount
    FROM COMMENT
    GROUP BY POST_ID
) c ON p.ID = c.POST_ID
ORDER BY p.POST_DATE DESC
LIMIT 10 OFFSET 0;


        SELECT
        p.ID AS id,
        p.POST_TITLE AS postTitle,
        p.MEMBER_ID AS memberId,
        m.MEMBER_NAME AS memberName,
        p.POST_DATE AS postDate,
        p.POST_UPDATED_TIME AS postUpdatedTime,
        p.VIEWCOUNT AS viewCount,
        p.POST_CONTENT AS postContent
        FROM POST p
        LEFT JOIN TBL_MEMBER m ON p.MEMBER_ID = m.ID
        WHERE p.ID = 1;


-- 글 내용 보기
SELECT 
    p.POST_TITLE, 
    p.MEMBER_ID, 
    p.POST_DATE, 
    p.POST_UPDATED_TIME, 
    p.VIEWCOUNT, 
    (SELECT COUNT(*) FROM COMMENT c WHERE c.POST_ID = p.ID) AS COMMENT_COUNT,
    P.POST_CONTENT 
FROM POST p where ID =1;

-- 글 삭제
	delete from POST where ID = 12;

-- 글 수정
	UPDATE POST
SET 
    POST_TITLE = '수정된 테스트',
    POST_CONTENT = '수정된 내용',
    POST_UPDATED_TIME = CURRENT_TIMESTAMP
WHERE ID = 5;

-- 유저 글개수 검색
SELECT COUNT(ID) FROM POST WHERE MEMBER_ID = 1;

-- 유저 글 검색
SELECT 
    p.ID AS POST_ID, 
    p.POST_TITLE, 
    p.MEMBER_ID, 
    p.POST_DATE, 
    p.VIEWCOUNT, 
    (SELECT COUNT(*) FROM COMMENT c WHERE c.POST_ID = p.ID) AS COMMENT_COUNT
FROM POST p WHERE MEMBER_ID = 1;

-- 전체 글 갯수
SELECT COUNT(*) FROM POST;

-- 글 작성
INSERT INTO POST (POST_TITLE, POST_CONTENT, MEMBER_ID)
VALUES('테스트5', '내용', 3);

drop table POST;


CREATE TABLE COMMENT (
    ID BIGINT AUTO_INCREMENT PRIMARY key,
    COMMENT_CONTENT VARCHAR(500) NOT NULL, 
    COMMENT_DEPTH INT DEFAULT 0, 
    COMMENT_DATE DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, 
    COMMENT_UPDATED_TIME DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PARENT_COMMENT_ID bigint,
    POST_ID BIGINT NOT null,
    MEMBER_ID BIGINT NOT null,
    FOREIGN KEY (POST_ID) REFERENCES POST(ID) ON DELETE CASCADE,
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER(ID) ON DELETE CASCADE,
    FOREIGN KEY (PARENT_COMMENT_ID) REFERENCES COMMENT(ID) ON DELETE CASCADE
);

INSERT INTO COMMENT (COMMENT_CONTENT, POST_ID, MEMBER_ID)
VALUES('테스트 댓글1', 16, 3);

select * from comment;

-- 매퍼 테스트

-- 댓글
INSERT INTO COMMENT (COMMENT_CONTENT, POST_ID, MEMBER_ID)
VALUES('테스트 댓글2', 16, 1);

-- 대댓글
INSERT INTO COMMENT (COMMENT_CONTENT, COMMENT_DEPTH, PARENT_COMMENT_ID, POST_ID, MEMBER_ID)
VALUES('테스트 대댓글1', 1, 9, 16, 1);

-- 댓 or 대댓글 삭제
	delete from comment where ID = 5;

-- 댓 or 대댓글 수정
	UPDATE comment
SET 
    comment_CONTENT = '수정된 내용',
    comment_UPDATED_TIME = CURRENT_TIMESTAMP
WHERE ID = 4;

-- 특정 게시글 전체 댓글 조회
SELECT 
    m.MEMBER_NAME,
    c.COMMENT_CONTENT,
    c.COMMENT_UPDATED_TIME
FROM COMMENT c
JOIN TBL_MEMBER m ON c.MEMBER_ID = m.ID
WHERE c.POST_ID = 41;

SELECT *
FROM COMMENT c
JOIN TBL_MEMBER m ON c.MEMBER_ID = m.ID
WHERE c.POST_ID = 41;

SELECT *
FROM comment
WHERE post_id = 41
ORDER BY comment_depth ASC, parent_comment_id ASC, id ASC;

drop table comment;

CREATE TABLE FILE (
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    FILE_PATH VARCHAR(1000) NOT null,
    FILE_UUID VARCHAR(255) NOT NULL,
    FILE_NAME VARCHAR(255) NOT NULL,
    FILE_TYPE VARCHAR(100) NOT NULL,
    FILE_SIZE BIGINT NOT NULL,
    FILE_PURPOSE ENUM('POST', 'COMMENT', 'MEMBER') NOT NULL,
    POST_ID BIGINT,
    COMMENT_ID BIGINT,
    MEMBER_ID BIGINT,
    FOREIGN KEY (POST_ID) REFERENCES POST(ID) ON DELETE CASCADE,
    FOREIGN KEY (COMMENT_ID) REFERENCES COMMENT(ID) ON DELETE CASCADE,
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER(ID) ON DELETE CASCADE
);

drop table FILE;

-- 매퍼테스트

-- 게시글 파일 조회
SELECT ID, FILE_PATH, FILE_UUID, FILE_NAME, FILE_PURPOSE, FILE_SIZE, POST_ID, FILE_TYPE
FROM FILE WHERE POST_ID = 1;

-- 게시글 이미지 삽입
INSERT INTO FILE 
    (FILE_PATH, FILE_UUID, FILE_NAME, FILE_PURPOSE, FILE_SIZE, POST_ID, FILE_TYPE)
VALUES 
    (#{filePath}, #{fileUuid}, #{fileName}, 'POST', #{fileSize}, #{postId}, #{fileType});



