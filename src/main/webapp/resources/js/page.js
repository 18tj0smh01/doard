$(document).ready(function () {
    let submitObj = {
        pageIndex: 1,
        pageUnit: 10,
    };

    function goPage(pageNo) {
        submitObj.pageIndex = pageNo;
        console.log("goPage called with pageNo:", pageNo);
        console.log("submitObj:", submitObj);

        $.ajax({
            url: "/post/list",
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            data: JSON.stringify(submitObj),
            dataType: "json",
        })
            .done(function (data) {
                console.log("Response from server:", data);
                renderList(data.postList);
                renderPagination(data.pagination);
            })
            .fail(function (xhr, status, error) {
                console.error("Error occurred:", error);
                console.error("Response status:", status);
                console.error("XHR object:", xhr);
                alert("페이지 로딩 중 오류가 발생했습니다.");
            });
    }

    function renderList(postList) {
        console.log("renderList called with postList:", postList);
        let content = postList.map(post => `
            <tr>
                <td>${post.id}</td>
                <td>${post.postTitle}</td>
                <td>${post.memberName}</td>
                <td>${post.postDate}</td>
                <td>${post.viewCount}</td>
                <td>${post.commentCount}</td>
            </tr>`).join("");
        $("#post-list").html(content);
    }

    function renderPagination(pagination) {
        console.log("renderPagination called with pagination:", pagination);
        const { currentPageNo, realEnd, totalPageCount } = pagination;

        let paginationContent = '<ol class="pagination">';
        for (let i = 1; i <= totalPageCount; i++) {
            paginationContent += `
                <li>
                    <a href="javascript:void(0);" onclick="goPage(${i});" 
                        class="${i === currentPageNo ? 'active' : ''}">${i}</a>
                </li>`;
        }
        paginationContent += '</ol>';
        $(".pagination-container").html(paginationContent);
    }

    goPage(1);
});
