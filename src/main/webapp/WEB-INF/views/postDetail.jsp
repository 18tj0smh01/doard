<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Detail Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/postDetail.css"/>
    <style>
        .reply-box {
            display: none;
        }

        .reply-box.show-reply-box {
            display: block;
        }
    </style>
</head>
<body>
<div class="header-box">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/post/list">테스트 게시판</a>
    </div>
</div>

<!-- 메인 컨텐츠 -->
<div class="main-container">
    <div class="main-box">
        <div class="post-box">
            <div class="post-title">${post.postTitle}</div>
            <div class="info-box">
                <div class="user-info">
                    <span class="member-name">${post.memberName}</span>
                    <span class="view-count">조회 <span>${post.viewCount}</span></span>
                </div>
                <section class="order">
                    <a href="<c:url value='/post/edit/${post.id}' />">수정</a>
                    <button type="button" class="delete deletePost tool-button" data-id="${post.id}">삭제</button>
                </section>
                <div class="post-info">
                    <span class="post-date">${post.postDate}</span>
                </div>
            </div>
            <div class="content-box">
                <div class="content-area">${post.postContent}</div>
            </div>
        </div>

        <!-- 댓글 -->
        <div class="comment-section">
            <div class="content-footer">
                <div class="comment-count-box">댓글 수: <span>${post.commentCount}</span></div>
            </div>

            <!-- 댓글 목록 -->
            <div id="comment-container">
                <c:forEach var="comment" items="${comments}">
                    <div class="comment-info">
                        <div class="comment-userName">${comment.memberName}</div>
                        <div class="comment-content">${comment.commentContent}</div>
                        <div class="comment-footer">
                            <div class="comment-date">${comment.commentDate}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 댓글 입력 -->
            <div class="comment-box">
                <div class="comment-user">${memberName}</div>
                <textarea id="commentContent" class="comment-input" placeholder="댓글을 입력하세요"></textarea>
                <div class="comment-footer">
                    <button id="commentSubmit" class="comment-submit" data-post-id="${post.id}">등록</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/comment.js"></script>
</body>
</html>
