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
    <title>테스트트 게시판</title>
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
<%--            <button class="check tool-button" id="toggle-checkbox">--%>
<%--                선택모드--%>
<%--            </button>--%>
<%--            <button class="check-all tool-button" id="select-all">전체 선택</button>--%>
            <span class="right-tool">
              <button type="button" class="goWritePost write tool-button" data-id="${member.id}">작성</button>
<%--              <a class="write tool-button" href="${pageContext.request.contextPath}/post/write">작성</a>--%>
<%--            <button type="button" class="deletePost delete tool-button" data-id="${post.id}">삭제</button>--%>
                <button type="button" id="logoutButton" class="btn btn-secondary">로그아웃</button>
          </span>
        </div>
    </div>

    <!-- 글 목록 -->
    <table class="main-box" id="post-table">
        <thead class="table-head">
        <tr>
            <th>번호</th>
            <th >제목</th>
            <th >작성자</th>
            <th >작성일</th>
            <th>조회</th>
            <th>댓글</th>
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
        </ul>
    </div>
</div>
<script>
    let submitObj = {
        pageIndex: 1,
        pageUnit: 10
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
            let maxTitleLength = 20;
            let truncatedTitle = post.postTitle.length > maxTitleLength
            let content = '';
            postList.forEach(post => {
                content += '<tr>';
                content += '<td class="table-left">' + post.id + '</td>';
                content += '<td class="td-title"><a href="/post/detail?id=' + post.id + '">' + post.postTitle + '</a></td>';
                content += '<td class="table-right td-member">' + post.memberName + '</td>';
                content += '<td class="table-right td-date">' + post.postDate + '</td>';
                content += '<td class="table-right td-view">' + post.viewCount + '</td>';
                content += '<td class="table-right td-comment">' + post.commentCount + '</td>';
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
            goPage(parseInt(pageNum, 10));
        });

        // 초기 게시글 목록 로드
        loadPostList();

        $("#logoutButton").click(function () {
            $.ajax({
                url: "/logout",
                type: "GET",
                success: function () {
                    alert("로그아웃");
                    window.location.href = "/login";
                },
                error: function (xhr, status, error) {
                    alert("로그아웃 중 오류가 발생했습니다.");
                    console.error("오류 발생:", error);
                }
            });
        });
    });
</script>
<script src="${pageContext.request.contextPath}/resources/js/postRE.js"></script>
</body>
</html>
