<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>테스트 게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css"/>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 게시판 이름 -->
<div class="header-box overlay">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/login">테스트 게시판</a>
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
              <button type="button" class="goWritePost write tool-button" data-id="${member.id}">작성</button>
<%--              <a class="write tool-button" href="${pageContext.request.contextPath}/post/write">작성</a>--%>
            <button type="button" class="deletePost delete tool-button" data-id="${post.id}">삭제</button>
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
<%--                <td class="td-num">${post.id}</td>--%>
<%--                <td class="td-title">--%>
<%--                    <a draggable="false" href="${pageContext.request.contextPath}/post/detail?id=${post.id}">--%>
<%--                            ${post.postTitle}--%>
<%--                    </a>--%>
<%--                </td>--%>
<%--                <td class="td-name">${post.memberName}</td>--%>
<%--                <td class="td-date"><fmt:formatDate value="${post.postDate}" pattern="yyyy-MM-dd" /></td>--%>
<%--                <td class="td-view">${post.viewCount}</td>--%>
<%--                <td class="td-comment">${post.commentCount}</td>--%>
<%--            </tr>--%>
<%--        </c:forEach>--%>
<%--        <c:if test="${fn:length(postList) == 0}">--%>
<%--            <tr>--%>
<%--                <td colspan="6" class="first last">조회 결과가 없습니다.</td>--%>
<%--            </tr>--%>
<%--        </c:if>--%>
        </tbody>
    </table>

    <!-- 페이징 -->
    <div class="board-list-paging fr">
        <ul class="pagination" id="pagination">
            <c:if test="${pagination.xprev}">
                <li class="prev_end">
                    <a href="javascript:void(0);" onclick="goPage(1); return false;">처음</a>
                </li>
                <li class="prev">
                    <a href="javascript:void(0);" onclick="goPage(${pagination.firstPageNoOnPageList - 1}); return false;">이전</a>
                </li>
            </c:if>
            <c:forEach var="num" begin="${pagination.firstPageNoOnPageList}" end="${pagination.lastPageNoOnPageList}">
                <li>
                    <a href="javascript:void(0);" onclick="goPage(${num}); return false;" class="${pagination.currentPageNo == num ? 'on' : ''}">${num}</a>
                </li>
            </c:forEach>
            <c:if test="${pagination.xnext}">
                <li class="next">
                    <a href="javascript:void(0);" onclick="goPage(${pagination.lastPageNoOnPageList + 1}); return false;">다음</a>
                </li>
                <li class="next_end">
                    <a href="javascript:void(0);" onclick="goPage(${pagination.realEnd}); return false;">끝</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>
<script>
    let submitObj = {
        pageIndex: 1,
        pageUnit: 10
    };
    const path = "<%= request.getContextPath() %>";
</script>
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

        // 페이지 이동 함수
        function goPage(pageNo) {
            submitObj.pageIndex = pageNo; // 현재 페이지 업데이트
            console.log("goPage 호출:", pageNo);
            loadPostList(); // 데이터 다시 로드
        }

        // 게시글 목록 로드 함수
        function loadPostList() {
            console.log("loadPostList 호출:", submitObj);

            $.ajax({
                url: "/post/list/json", // 서버에서 데이터 가져오는 엔드포인트
                type: "GET",
                data: submitObj, // 현재 페이지와 페이지 단위 전달
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

        // 게시글 리스트 업데이트 함수
        function updatePostList(postList) {
            console.log("updatePostList 호출:", postList);

            let content = '';
            postList.forEach(post => {
                const formattedDate = new Date(post.postDate).toLocaleDateString(); // 날짜 포맷팅
                content += `
            <tr>
                <td class="td-num">${post.id}</td>
                <td class="td-title">
                    <a draggable="false" href="${pageContext.request.contextPath}/post/detail?id=${post.id}">
                            ${post.postTitle}
                    </a>
                </td>
                <td class="td-name">${post.memberName}</td>
                <td class="td-date"><fmt:formatDate value="${post.postDate}" pattern="yyyy-MM-dd" /></td>
                <td class="td-view">${post.viewCount}</td>
                <td class="td-comment">${post.commentCount}</td>
            </tr>
            `;
            });


            const postListContainer = document.getElementById('post-list');
            if (postListContainer) {
                postListContainer.innerHTML = content;
            }
        }

        function updatePagination(pagination) {
            const $pagination = $(".pagination");
            $pagination.empty();

            for (let i = 1; i <= pagination.realEnd; i++) {
                const activeClass = (i === pagination.currentPageNo) ? "active" : "";
                $pagination.append(`
            <button class="pagination-button ${activeClass}" data-page="${i}">
                ${i}
            </button>
        `);
            }

            $(".pagination-button").on("click", function () {
                const pageIndex = $(this).data("page");
                loadPostList(pageIndex);
            });
        }

        window.goPage = goPage;

        // 초기 게시글 목록 로드
        loadPostList();
    });
</script>
<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/postRE.js"></script>
</body>
</html>
