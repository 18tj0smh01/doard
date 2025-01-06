<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>write</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css"/>
</head>
<body>
<div class="header-box">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/post/list">테스트 게시판</a>
    </div>
</div>
<div class="board-title">글 수정</div>
<%--<form action="${pageContext.request.contextPath}/post/edit" method="post" name="form" class="main-container">--%>
<%--    <input type="hidden" name="id" value="${post.id}" />--%>
<%--    <div class="title-box">--%>
<%--        <input--%>
<%--                type="text"--%>
<%--                id="postTitle"--%>
<%--                class="title-area"--%>
<%--                value="${post.postTitle != null ? post.postTitle : ''}" />--%>
<%--    </div>--%>
<%--    <div class="file-input">--%>
<%--        <input type="file" name="file" class="file-upload" />--%>
<%--    </div>--%>
<%--    <div class="content-box">--%>
<%--        <textarea--%>
<%--                id="postContent"--%>
<%--                class="content-area">${post.postContent != null ? post.postContent : ''}</textarea>--%>
<%--    </div>--%>
<%--    <button type="button" class="ok-button">등록</button>--%>
<%--</form>--%>
<div class="main-container">
    <input type="hidden" name="id" value="${post.id}" />
    <div class="title-box">
        <input
                type="text"
                id="postTitle"
                class="title-area"
                value="${post.postTitle != null ? post.postTitle : ''}" />
    </div>
    <div class="file-input">
        <input type="file" name="file" class="file-upload" />
    </div>
    <div class="content-box">
        <textarea
                id="postContent"
                class="content-area">${post.postContent != null ? post.postContent : ''}</textarea>
    </div>
    <button type="button" class="save-edit-post" data-id="${post.id}">등록</button>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/postRE.js"></script>
<%--<script>--%>
<%--    $("button.ok-button").on("click", function () {--%>
<%--        $("form[name='form']").submit();--%>
<%--    });--%>
<%--</script>--%>
</html>
