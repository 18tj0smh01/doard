$(document).ready(function () {

    function goPage(pageNo) {
        const submitObj = {
            pageIndex: pageNo,
            searchWrd: $("#searchWrd").val()
        };

        $.ajax({
            url: "/list", // API 엔드포인트
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            data: JSON.stringify(submitObj),
            dataType: "json",
            progress: true
        })
            .done(function (data) {
                renderList(data.resultList, data.searchVO); // 결과 리스트 렌더링
                renderPagination(data.searchVO); // 페이징 네비게이션 렌더링
            })
            .fail(function () {
                alert("검색에 실패하였습니다.");
            });
    }

    // 결과 리스트 렌더링
    function renderList(resultList, searchVO) {
        const recordCountPerPage = searchVO.recordCountPerPage;
        const pageIndex = searchVO.pageIndex;
        let ii = (searchVO.resultCnt - (pageIndex - 1) * recordCountPerPage);

        let content = resultList.map(value => `
            <tr class="memList">
                <td class="t_c">${ii--}</td>
                <td class="t_c">${value.me_sido}</td>
                <td>${value.me_gugun}<button type="button" class="btnInfo fr"></button></td>
                <td class="t_c">${value.me_biz_name}</td>
                <td class="t_c">${value.me_name}</td>
                <td class="t_c">${value.me_biz_tel}</td>
            </tr>`).join("");

        $(".listData").html(content);
    }

    // 페이징 네비게이션 렌더링
    function renderPagination(searchVO) {
        const { prev, next, startDate, endDate, pageIndex, realEnd } = searchVO;
        const startButtonDate = startDate - 1;
        const endButtonDate = endDate + 1;

        let pagination = `
            <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
            <ol class="pagination" id="pagination">`;

        // 이전 버튼
        if (prev) {
            pagination += `
                <li class="prev_end"><a href="javascript:void(0);" onclick="goPage(1); return false;"></a></li>
                <li class="prev"><a href="javascript:void(0);" onclick="goPage(${startButtonDate}); return false;"></a></li>`;
        }

        // 페이지 번호
        for (let num = startDate; num <= endDate; num++) {
            if (num === pageIndex) {
                pagination += `<li><a href="javascript:void(0);" onclick="goPage(${num}); return false;" class="num on">${num}</a></li>`;
            } else {
                pagination += `<li><a href="javascript:void(0);" onclick="goPage(${num}); return false;" class="num">${num}</a></li>`;
            }
        }

        // 다음 버튼
        if (next) {
            pagination += `
                <li class="next"><a href="javascript:void(0);" onclick="goPage(${endButtonDate}); return false;"></a></li>
                <li class="next_end"><a href="javascript:void(0);" onclick="goPage(${realEnd}); return false;"></a></li>`;
        }

        pagination += `</ol>`;
        $(".board-list-paging").html(pagination);
    }

    // 초기 페이지 로드
    goPage(1); // 페이지 로드 시 1페이지를 기본으로 요청

    // 검색 버튼 이벤트 처리
    $("#searchBtn").on("click", function () {
        goPage(1); // 검색 시 첫 페이지로 이동
    });
});
