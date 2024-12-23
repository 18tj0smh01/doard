<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
        <c:forEach var="post" items="${postList}">
            <tr>
                <td class="checkbox">
                    <input type="checkbox" name="post" class="post-checkbox" data-post-id="${post.id}" />
                </td>
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
        </c:forEach>
        </tbody>
    </table>

    <!-- 페이징 -->
    <tbody class="listData">
    <c:set var="ii" value="${resultCnt - (searchVO.pageIndex -1) * paginationInfo.recordCountPerPage }" />
    <c:forEach var="result" items="${resultList}" varStatus="sts">
        <tr class="memList">
            <td class="t_c"><c:out value="${ii}" /></td>
            <td class="t_c"><c:out value="${result.me_sido}" /></td>
            <td><c:out value="${result.me_gugun}" /><button type="button" class="btnInfo fr"></button></td>
            <td class="t_c"><c:out value="${result.me_biz_name}" /></td>
            <td class="t_c"><c:out value="${result.me_name}" /></td>
            <td class="t_c"><c:out value="${result.me_biz_tel}" /></td>
        </tr>
        <c:set var="ii" value="${ii - 1}" />
    </c:forEach>
    <c:if test="${fn:length(resultList) == 0}">
        <tr>
            <td colspan="6" class="first last">조회 결과가 없습니다.</td>
        </tr>
    </c:if>
    </tbody>
    </table>
</div>

<div class="board-list-paging fr">
    <ol class="pagination" id="pagination">
        <c:if test="${searchVO.prev}">
            <li class="prev_end">
                <a href="javascript:void(0);" onclick="fn_go_page(1); return false;" ></a>
            </li>
            <li class="prev">
                <a href="javascript:void(0);" onclick="fn_go_page(${searchVO.startDate - 1}); return false;" ></a>
            </li>
        </c:if>
        <c:forEach var="num" begin="${searchVO.startDate}" end="${searchVO.endDate}">
            <li>
                <a href="javascript:void(0);" onclick="fn_go_page(${num}); return false;" class="num ${pageIndex eq num ? 'on':'' }" title="${num}">${num}</a>
            </li>
        </c:forEach>
        <c:if test="${searchVO.next}">
            <li class="next">
                <a href="javascript:void(0);" onclick="fn_go_page(${searchVO.endDate + 1}); return false;" ></a>
            </li>
            <li class="next_end">
                <a href="javascript:void(0);" onclick="fn_go_page(${searchVO.realEnd }); return false;"></a>
            </li>
        </c:if>
    </ol>
</div>

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
<script type="text/javascript">
    function fn_go_page(pageNo) {

        var submitObj = new Object();

        submitObj.pageIndex = pageNo;
        $.ajax({
            url: path + "/gnb01/lnb06/snb03/areaListAjax.do",
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            data: JSON.stringify(submitObj),
            dataType: "json",
            progress: true
        })
            .done(function(data) {

                var result = data.resultList;
                var postVO = data.postVO;
                var realEnd = postVO.realEnd;
                var startDate = postVO.startDate;
                var startButtonDate = startDate - 1;
                var endDate = postVO.endDate;
                var endButtonDate = endDate + 1;
                var pageIndex = postVO.pageIndex;
                var resultCnt = data.resultCnt;
                var totalPostPageCnt = data.totalPostPageCnt;
                var recordCountPerPage = postVO.recordCountPerPage;

                var ii = (resultCnt - (pageIndex - 1) * recordCountPerPage);

                var content = '';
                var content2 = '';

                $.each(result, function(key, value) {

                    content += '<tr class="memList">';
                    content += '<td class="t_c">' + ii + '</td>';
                    content += '<td class="t_c">' + value.me_sido + '</td>';
                    content += '<td>' + value.me_gugun + '<button type="button" class="btnInfo fr"></button></td>';
                    content += '<td class="t_c">' + value.me_biz_name + '</td>';
                    content += '<td class="t_c">' + value.me_name + '</td>';
                    content += '<td class="t_c">' + value.me_biz_tel + '</td>';
                    content += '</tr>';
                    ii--;
                });

                $(".listData").html(content);

                content2 = '<input type="hidden" id="pageIndex" name="pageIndex" value="1">';
                content2 += '<ol class="pagination" id="pagination">';

                if (postVO.prev) {
                    content2 += '<li class="prev_end"><a href="javascript:void(0);" onclick="fn_go_page(1); return false;" ></a></li>';
                    content2 += '<li class="prev"><a href="javascript:void(0);" onclick="fn_go_page(' + startButtonDate + '); return false;" ></a></li>';
                }

                for (var num = startDate; num <= endDate; num++) {
                    if (num == pageIndex) {
                        content2 += '<li><a href="javascript:void(0);" onclick="fn_go_page(' + num + '); return false;" title="' + num + '" class="num on">' + num + '</a></li>';
                    } else {
                        content2 += '<li><a href="javascript:void(0);" onclick="fn_go_page(' + num + '); return false;" title="' + num + '" class="num">' + num + '</a></li>';
                    }
                }

                if (postVO.next) {
                    content2 += '<li class="next"><a href="javascript:void(0);" onclick="fn_go_page(' + endButtonDate + '); return false;" ></a></li>';
                    content2 += '<li class="next_end"><a href="javascript:void(0);" onclick="fn_go_page(' + postVO.realEnd + '); return false;"></a></li>';
                }

                content2 += '</ol>';

                $(".board-list-paging").html(content2);

            })

            .always(function() {

            });
    }

</script>

</body>
</html>