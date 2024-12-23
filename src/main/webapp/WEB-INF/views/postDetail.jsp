<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Detail Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/postDetail.css"/>
    <style>
        .reply-box {
            display: none;
        }

        .reply-box.show-reply-box {
            display: block;
        }

        .post-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .info-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .content-area {
            margin-top: 20px;
            font-size: 16px;
        }

        .comment-section {
            margin-top: 40px;
        }

        .comment-box {
            margin-top: 20px;
            border: 1px solid #ddd;
            padding: 10px;
        }

        .comment-input {
            width: 100%;
            height: 60px;
            margin-bottom: 10px;
        }

        .comment-footer {
            display: flex;
            justify-content: flex-end;
        }

        .post-list-box {
            margin-top: 40px;
        }

        .td-title a {
            text-decoration: none;
            color: #000;
        }
    </style>
</head>
<body>
<div class="header-box">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/list">테스트 게시판</a>
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
                    <a href="<c:url value='/post/edit/${post.postId}' />">수정</a>
                    <a href="<c:url value='/post/edit/${post.postId}' />">수정</a>
                    <a href="<c:url value='/post/deletePost/${post.postId}' />" class="delete">삭제</a>
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
                    <div class="comment-info">
                        <div class="comment-userName">${comment.memberName}</div>
                        <div class="comment-content">${comment.commentContent}</div>
                        <section class="order">
                            <a class="update">수정</a>
                            <a href="">?id=${comment.id}&postId=${post.postId}" class="delete">삭제</a>
                        </section>
                        <div class="comment-footer">
                            <div class="comment-date">${comment.commentDate}</div>
                            <button type="button" class="reply-button">답글 쓰기</button>
                        </div>

                        <!-- 대댓글 입력-->
                        <div class="reply-box">
                            <textarea name="reply" class="comment-input" placeholder="답글을 입력하세요">${commentDTO.commentContent}</textarea>
                            <div class="comment-footer">
                                <button type="button" class="comment-cancel">취소</button>
                                <button type="submit" class="comment-submit">등록</button>
                            </div>
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

        <!-- 게시글 목록 -->
        <div class="post-list-box">
            <div class="other-post">최신 글</div>
            <table>
                <tbody>
                <c:forEach var="otherPost" items="${postList}">
                    <tr>
                        <td class="td-num">${otherPost.id}</td>
                        <td class="td-title">
                            <a href="${pageContext.request.contextPath}/post/detail?postId=${otherPost.id}">${otherPost.postTitle}</a>
                        </td>
                        <td class="td-name">${otherPost.memberName}</td>
                        <td class="td-date">${otherPost.postDate}</td>
                        <td class="td-view">${otherPost.viewCount}</td>
                        <td class="td-comment">${otherPost.commentCount}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js">
</script>
<script>
    $(document).ready(function () {
        $(".reply-button").click(function () {
            const replyBox = $(this).closest(".comment-info").find(".reply-box");
            replyBox.toggleClass("show-reply-box");
        });

        $(".comment-cancel").click(function () {
            $(this).closest(".reply-box").removeClass("show-reply-box");
        });
    });
</script>
<script>
    document.getElementById("commentSubmit").addEventListener("click", function () {
    const postId = "[[${post.id}]]";
    const commentContent = document.getElementById("commentContent").value;

    if (!commentContent.trim()) {
    alert("댓글 내용을 입력하세요.");
    return;
    }

    fetch('/comment/uploadComment', {
    method: 'POST',
    headers: {
    'Content-Type': 'application/json',
    },
    body: JSON.stringify({
    postId: postId,
    commentContent: commentContent,
    }),
    })
    .then((response) => {
    if (!response.ok) {
    throw new Error("댓글 등록에 실패했습니다.");
    }
    return response.json(); // 서버에서 반환된 댓글 리스트
    })
    .then((data) => {
    updateComments(data); // 댓글 목록 업데이트
    document.getElementById("commentContent").value = ""; // 입력창 초기화
    })
    .catch((error) => {
    console.error(error);
    alert("오류가 발생했습니다. 다시 시도하세요.");
    });
    });

    function updateComments(comments) {
    const container = document.getElementById("comment-container");
    container.innerHTML = ""; // 기존 댓글 초기화

    comments.forEach((comment) => {
    const commentItem = document.createElement("div");
    commentItem.className = "comment-item";
    commentItem.innerHTML = `
    <div class="comment-userName">${comment.memberName}</div>
    <div class="comment-content">${comment.commentContent}</div>
    <div class="comment-footer">
    <div class="comment-date">${comment.commentDate}</div>
    </div>
    `;
    container.appendChild(commentItem);
    });
    }

</script>
</body>
</html>
