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

        .reply {
            margin-left: 20px;
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
                    <a href="<c:url value='/post/deletePost/${post.id}' />" class="delete">삭제</a>
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
            <div class="comment-container">
                <c:forEach var="comment" items="${comments}">
                    <div class="comment-info" id="comment-${comment.id}">
                        <div class="comment-userName">${comment.memberName}</div>
                        <div class="comment-content">${comment.commentContent}</div>
                        <div class="comment-footer">
                            <button type="button" class="reply-button">답글 쓰기</button>
                        </div>

                        <!-- 대댓글 입력 -->
                        <div class="reply-box">
                            <textarea class="comment-input" data-parent-id="${comment.id}" placeholder="답글을 입력하세요"></textarea>
                            <div class="comment-footer">
                                <button type="button" class="comment-cancel">취소</button>
                                <button type="submit" class="comment-submit">등록</button>
                            </div>
                        </div>

                        <!-- 대댓글 리스트 -->
                        <div class="reply-container">
                            <c:forEach var="reply" items="${comments.replies}">
                                <div class="comment-info reply" id="reply-${reply.id}">
                                    <div class="comment-userName">${reply.memberName}</div>
                                    <div class="comment-content">${reply.commentContent}</div>
                                    <div class="comment-footer">
                                        <div class="comment-date">${reply.commentDate}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 댓글 입력 -->
            <div class="comment-box">
                <div class="comment-user">${memberName}</div>
                <textarea id="commentContent" class="comment-input" placeholder="댓글을 입력하세요"></textarea>
                <div class="comment-footer">
                    <button id="commentSubmit" class="comment-submit">등록</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
    $(document).ready(function () {
        // 대댓글 입력창 토글
        $(document).on('click', '.reply-button', function () {
            const replyBox = $(this).closest('.comment-info').find('.reply-box');
            replyBox.toggleClass('show-reply-box');
        });

        // 대댓글 입력 취소
        $(document).on('click', '.comment-cancel', function () {
            $(this).closest('.reply-box').removeClass('show-reply-box');
        });

        // 댓글 등록
        $('#commentSubmit').click(function () {
            const content = $('#commentContent').val();
            const postId = "${post.id}"; // 서버에서 post.id 주입

            if (content.trim() === '') {
                alert('댓글 내용을 입력하세요.');
                return;
            }

            $.ajax({
                url: '/comment/add',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ content: content, postId: postId }),
                success: function (response) {
                    if (response.success) {
                        appendComment(response.comment); // 댓글 추가 함수 호출
                        $('#commentContent').val(''); // 입력 필드 초기화
                    }
                },
                error: function () {
                    alert('댓글 등록 중 오류가 발생했습니다.');
                },
            });
        });

        // 대댓글 등록
        $(document).on('click', '.comment-submit', function () {
            const parentId = $(this).closest('.reply-box').find('textarea').data('parent-id');
            const content = $(this).closest('.reply-box').find('textarea').val();
            const postId = "${post.id}"; // 서버에서 post.id 주입

            if (content.trim() === '') {
                alert('대댓글 내용을 입력하세요.');
                return;
            }

            $.ajax({
                url: '/comment/reply',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ content: content, parentId: parentId, postId: postId }),
                success: function (response) {
                    if (response.success) {
                        appendReply(response.comment); // 대댓글 추가 함수 호출
                    }
                },
                error: function () {
                    alert('대댓글 등록 중 오류가 발생했습니다.');
                },
            });
        });
    });

    // 댓글 추가 함수
    function appendComment(comment) {
        const commentHtml = `
        <div class="comment-info" id="comment-${comment.id}">
            <div class="comment-userName">${comment.memberName}</div>
            <div class="comment-content">${comment.commentContent}</div>
            <div class="comment-footer">
                <button type="button" class="reply-button">답글 쓰기</button>
            </div>
            <div class="reply-box">
                <textarea class="comment-input" data-parent-id="${comment.id}" placeholder="답글을 입력하세요"></textarea>
                <div class="comment-footer">
                    <button type="button" class="comment-cancel">취소</button>
                    <button type="submit" class="comment-submit">등록</button>
                </div>
            </div>
        </div>`;
        $('.comment-container').append(commentHtml);
    }

    // 대댓글 추가 함수
    function appendReply(reply) {
        const replyHtml = `
        <div class="comment-info reply" id="reply-${reply.id}">
            <div class="comment-userName">${reply.memberName}</div>
            <div class="comment-content">${reply.commentContent}</div>
            <div class="comment-footer">
                <div class="comment-date">${reply.commentDate}</div>
            </div>
        </div>`;
        $(`#comment-${reply.parentCommentId} .reply-container`).append(replyHtml);
    }
</script>
</body>
</html>
