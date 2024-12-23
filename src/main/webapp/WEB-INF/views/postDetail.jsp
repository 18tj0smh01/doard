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
<%--            <p>--%>
<%--                ${postVO.content}--%>
<%--            </p>--%>
            <div class="post-title">${post.postTitle}</div>
            <div class="info-box">
                <div class="user-info">
                    <span class="member-name">${post.memberName}</span>
                    <span class="view-count">조회 <span>${post.viewCount}</span></span>
                </div>
                <section class="order">
                    <a href="<c:url value='/post/edit/${post.id}' />">수정</a>
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
    $(".replyAddBtn").on("click", function () {

        var replyerObj = $("#newReplyWriter");
        var replytextObj = $("#newReplyText");
        var replyer = replyerObj.val();
        var replytext = replytextObj.val();

        $.ajax({
            type: "post",
            url: "/replies/",
            headers: {
                "Content-Type" : "application/json",
                "X-HTTP-Method-Override" : "POST"
            },
            dataType: "text",
            data: JSON.stringify({
                bno:bno,
                replyer:replyer,
                replytext:replytext
            }),
            success: function (result) {
                console.log("result : " + result);
                if (result == "INSERTED") {
                    alert("댓글이 등록되었습니다.");
                    replyPage = 1;
                    getPage("/replies/" + bno + "/" + replyPage);
                    replyerObj.val("");
                    replytextObj.val("");
                }
            }
        });
    });
</script>
</body>
</html>
