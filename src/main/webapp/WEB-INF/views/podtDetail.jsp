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
        <a href="${pageContext.request.contextPath}/main">테스트 게시판</a>
    </div>
</div>

<!-- 메인 컨텐츠 -->
<div class="main-container">
    <div class="main-box">
        <!-- 게시글 -->
        <div class="post-box">
            <div class="post-title">${post.postTitle}</div>
            <div class="info-box">
                <div class="user-info">
                    <span class="member-name">${post.memberName}</span>
                    <span class="view-count">조회 <span>${post.viewCount}</span></span>
                </div>
                <section class="order">
                    <a href="${pageContext.request.contextPath}/main">목록으로</a>
                    <a href="${pageContext.request.contextPath}/post/edit?postId=${post.id}">수정</a>
                    <a href="${pageContext.request.contextPath}/post/deletePost?id=${post.id}" class="delete">삭제</a>
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
                <div class="comment-count-box">댓글 수: ${post.commentCount}</div>
            </div>

            <!-- 댓글 목록 -->

            <div id="comment-list" class="comment-container">
                <table class="comment-info">
                    <tr>
                        <th>댓글번호</th>
                        <th class="comment-userName">작성자</th>
                        <th>내용</th>
                    </tr>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.id}</td>
                            <td class="comment-userName">${comment.memberName}</td>
                            <td class="comment-content">${comment.commentContent}</td>
                        </tr>
                        <section class="order">
                            <a class="update">수정</a>
                            <a href="${pageContext.request.contextPath}/post/deleteComment?id=${comment.id}&postId=${post.id}" class="delete">삭제</a>
                        </section>
                        <div class="comment-footer">
                            <div class="comment-date">${comment.commentDate}</div>
                            <button type="button" class="reply-button">답글 쓰기</button>
                        </div>
                        <!-- 대댓글 입력 -->
                        <div class="reply-box">
                            <td class="comment-userName">${comment.memberName}</td>
                            <textarea name="reply" class="comment-input" placeholder="답글을 입력하세요" ${comment.commentContent}></textarea>
                            <div class="comment-footer">
                                <button type="button" class="comment-cancel">취소</button>
                                <button type="submit" class="comment-submit">등록</button>
                            </div>
                        </div>
                    </c:forEach>
                </table>
            </div>
            </div>

            <!-- 댓글 입력 -->
            <form action="${pageContext.request.contextPath}/comment/upload" method="post">
                <div class="comment-box">
                    <div class="comment-user">${memberName}</div>
                    <textarea name="comment" class="comment-input" placeholder="댓글을 입력하세요"></textarea>
                    <div class="comment-footer">
                        <button type="submit" class="comment-submit">등록</button>
                    </div>
                </div>
            </form>
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
    const updateFn = () => {
        const id = '${post.id}';
        location.href = "/post/update?id=" + id;
    }
    const deleteFn = () => {
        const id = '${post.id}';
        location.href = "/post/delete?id=" + id;
    }

    const commentWrite = () => {
        const writer = document.getElementById("commentWriter").value;
        const contents = document.getElementById("commentContents").value;
        const post = '${post.id}';
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                commentWriter: writer,
                commentContents: contents,
                postId: post
            },
            dataType: "json",
            success: function(commentList) {
                console.log("작성성공");
                console.log(commentList);
                let output = "<table>";
                output += "<tr><th>댓글번호</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th></tr>";
                for(let i in commentList){
                    output += "<tr>";
                    output += "<td>"+commentList[i].id+"</td>";
                    output += "<td>"+commentList[i].commentWriter+"</td>";
                    output += "<td>"+commentList[i].commentContents+"</td>";
                    output += "<td>"+commentList[i].commentCreatedTime+"</td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('comment-list').innerHTML = output;
                document.getElementById('commentWriter').value='';
                document.getElementById('commentContents').value='';
            },
            error: function() {
                console.log("실패");
            }
        });
    }
</script>
</body>
</html>
