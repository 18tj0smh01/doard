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
<%--                    <a href="<c:url value='/post/edit/${post.id}' />">수정</a>--%>
                    <button type="button" class="edit editPost tool-button" data-id="${post.id}">수정</button>
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
            <input type="hidden" id="postId" value="${post.id}">
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
    <!-- 글 목록 -->
    <div>
        <div> 최신글</div>
    <table class="main-box" id="post-table">
        <thead class="table-head">
        <tr>
            <th class="table-left td-num">번호</th>
            <th class="td-title">제목</th>
            <th class="table-right td-member">작성자</th>
            <th class="table-right td-date">작성일</th>
            <th class="table-right td-view">조회</th>
            <th class="table-right td-comment">댓글</th>
        </tr>
        </thead>
        <tbody class="list-box" id="post-list">
        </tbody>
    </table>
    <!-- 페이징 -->
    <div class="board-list-paging fr">
        <ul class="pagination" id="pagination">
        </ul>
    </div>
</div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/postRE.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/comment.js"></script>
<script>
    let submitObj = {
    pageIndex: 1,
    pageUnit: 5
};

    const path = "<%= request.getContextPath() %>";

    $(document).ready(function () {
    // 페이지 이동 함수 (글로벌 스코프 등록)
    window.goPage = function (pageNum) {
        submitObj.pageIndex = pageNum;
        console.log("goPage 호출:", pageNum);
        loadPostList();
    };

    // 게시글 목록 로드
    function loadPostList() {
    console.log("loadPostList 호출:", submitObj);

    $.ajax({
    url: "/post/list/json", // 서버에서 데이터 가져오는 엔드포인트
    type: "GET",
    data: submitObj, // 페이지 단위 전달
    dataType: "json",
    success: function (response) {
    console.log("서버 응답:", response);
    updatePostList(response.postList); // 게시글 리스트 업데이트
    updatePagination(response.pagination); // 페이지네이션 업데이트
},
    error: function (xhr, status, error) {
    alert("데이터 로딩 중 오류 발생");
    console.error("오류 발생:", error);
}
});
}

    // 게시글 리스트
    function updatePostList(postList) {
    console.log("updatePostList 호출:", postList);

    let content = '';
    postList.forEach(post => {
    content += '<tr>';
    content += '<td>' + post.id + '</td>';
    content += '<td><a href="/post/detail?id=' + post.id + '">' + post.postTitle + '</a></td>';
    content += '<td>' + post.memberName + '</td>';
    content += '<td>' + post.postDate + '</td>';
    content += '<td>' + post.viewCount + '</td>';
    content += '<td>' + post.commentCount + '</td>';
    content += '</tr>';
});

    $("#post-list").html(content);
}

    // 페이지네이션 업데이트
    function updatePagination(pagination) {
    console.log("updatePagination 호출:", pagination);

    let content = '<ol class="pagination" id="pagination">';
    if (pagination.xprev) {
    content += `<li class="prev_end"><a href="javascript:void(0);" onclick="goPage(1); return false;">처음</a></li>`;
    content += `<li class="prev"><a href="javascript:void(0);" onclick="goPage(${pagination.firstPageNoOnPageList - 1}); return false;">이전</a></li>`;
}
    for (let pageNum = pagination.firstPageNoOnPageList; pageNum <= pagination.lastPageNoOnPageList; pageNum++) {
    console.log("PageNum 확인:", pageNum);
    if (!isNaN(pageNum) && pageNum !== undefined) {
    content += `<li><a href="javascript:void(0);" onclick="goPage(`+ pageNum +`); return false;" class="pageNum ${pagination.currentPageNo == pageNum ? 'on' : ''}">`+pageNum+`</a></li>`;
} else {
    console.error("유효하지 않은 PageNum 값:", pageNum);
}
}
    if (pagination.xnext) {
    console.log("lastPageNoOnPageList 확인:", pagination.lastPageNoOnPageList);
    content += `<li class="next"><a href="javascript:void(0);" onclick="goPage(`+pagination.lastPageNoOnPageList + 1+`); return false;">다음</a></li>`;
    content += `<li class="next_end"><a href="javascript:void(0);" onclick="goPage(`+pagination.realEnd+`); return false;">끝</a></li>`;
}
    content += '</ol>';

    console.log("생성된 Pagination HTML:", content);
    $(".board-list-paging").html(content);
}

    $(document).on("click", ".pagination .pageNum", function () {
    const pageNum = $(this).text().trim();
    console.log("클릭된 페이지 번호:", pageNum);
    goPage(parseInt(pageNum, 5));
});

    // 초기 게시글 목록 로드
    loadPostList();
});
</script>
</body>
</html>
