<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta
            name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>테스트 게시판</title>
    <link rel="stylesheet" href="../css/main.css"/>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 게시판 이름 -->
<div class="header-box overlay">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/main">테스트 게시판</a>
    </div>
</div>

<!-- 메인 컨텐츠 -->
<div class="main-container">
    <!-- 글 관리 도구 -->
    <div class="board-title">전체글</div>
    <div class="tool-wrapper">
        <div class="tool-box">
            <button class="check tool-button" id="toggle-checkbox">
                선택모드
            </button>
            <button class="check-all tool-button" id="select-all">전체 선택</button>
            <span class="right-tool">
              <a class="write tool-button" href="${pageContext.request.contextPath}/post/write">작성</a>
            <button class="delete tool-button">삭제</button>
          </span>
        </div>
    </div>

    <!-- 글 목록 -->
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
<%--        <c:forEach var="post" items="${postList}">--%>
<%--            <tr>--%>
<%--                <td class="checkbox">--%>
<%--                    <input type="checkbox" name="post" class="post-checkbox" data-post-id="${post.id}" />--%>
<%--                </td>--%>
<%--                <td class="td-num">${post.id}</td>--%>
<%--                <td class="td-title">--%>
<%--                    <a draggable="false" href="${pageContext.request.contextPath}/post/detail?postId=${post.id}">--%>
<%--                            ${post.postTitle}--%>
<%--                    </a>--%>
<%--                </td>--%>
<%--                <td class="td-name">${post.memberName}</td>--%>
<%--                <td class="td-date"><fmt:formatDate value="${post.postDate}" pattern="yyyy-MM-dd" /></td>--%>
<%--                <td class="td-view">${post.viewCount}</td>--%>
<%--                <td class="td-comment">${post.commentCount}</td>--%>
<%--            </tr>--%>
<%--        </c:forEach>--%>
        </tbody>
    </table>

    <!-- 페이징 -->
<%--    <jsp:include page="/WEB-INF/views/utils/pagination.jsp">--%>
<%--        <jsp:param name="pagination" value="${pagination}" />--%>
<%--    </jsp:include>--%>
</div>

<script>
    $(document).ready(function () {
        // 선택 모드 토글
        $("#toggle-checkbox").on("click", function () {
            const isActive = $(this).hasClass("active");
            $("#post-table").toggleClass("show-checkbox", !isActive);
            $(".check-all").toggle(!isActive);
            $(this).toggleClass("active");
        });

        // 전체 선택 기능
        $("#select-all").on("click", function () {
            const isActive = $(this).hasClass("active");
            $(".post-checkbox").prop("checked", !isActive);
            $(this).toggleClass("active");
        });

    });
</script>

<script>
    $(document).ready(function () {
        fetchPosts();

        function fetchPosts() {
            $.ajax({
                url: '/post/list',
                method: 'POST',
                contentType: 'application/json',
                success: function (data) {
                    renderPosts(data);
                },
                error: function () {
                    alert('게시글을 가져오는 데 실패했습니다.');
                }
            });
        }

        function renderPosts(posts) {
            const $postList = $('#post-list');
            $postList.empty();

            posts.forEach(function (post) {
                const postRow = `
                <tr>
                    <td class="td-num">${post.id}</td>
                    <td class="td-title">
                        <a draggable="false" href="/post/detail?postId=${post.id}">
                            ${post.postTitle}
                        </a>
                    </td>
                    <td class="td-name">${post.memberName}</td>
                    <td class="td-date">${post.postDate}</td>
                    <td class="td-view">${post.viewCount}</td>
                    <td class="td-comment">${post.commentCount}</td>
                </tr>`;
                $postList.append(postRow);
            });
        }
    });
</script>
</body>
</html>