<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta
            name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>write</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/write.css" />
</head>
<body>
<div class="header-box">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/main">테스트 게시판</a>
    </div>
</div>
<div class="board-title">글 쓰기</div>
<form class="main-container" action="${pageContext.request.contextPath}/post/write" method="post" enctype="multipart/form-data">
    <div class="title-box">
        <input
                type="text"
                name="postTitle"
                class="title-area"
                placeholder="제목을 입력해 주세요."
                value="${postVO.postTitle != null ? postVO.postTitle : ''}" />
    </div>
    <div class="file-input">
        <input type="file" name="file" class="file-upload" />
    </div>
    <div class="content-box">
            <textarea
                    name="postContent"
                    class="content-area"
                    placeholder="내용을 입력해 주세요.">${postVO.postContent != null ? postVO.postContent : ''}</textarea>
    </div>
    <button type="submit">등록</button>
</form>
</body>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
    // JavaScript 코드 추가 가능
</script>
</html>
