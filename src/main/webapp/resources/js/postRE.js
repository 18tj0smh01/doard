$(document).ready(function () {
    let submitObj = {
        pageIndex: 1,
        pageUnit: 10
    };
    function goPage(pageNum) {
        submitObj.pageIndex = pageNum;
        console.log("goPage called with pageNum:", pageNum);
        loadPostList();
    }
    function loadPostList() {
        console.log("loadPostList:", submitObj);

        $.ajax({
            url: "/post/list/json",
            type: "GET",
            data: submitObj,
            dataType: "json",
            success: function (response) {
                console.log("Response from server:", response);
                updatePostList(response.postList);
                updatePagination(response.pagination);
            },
            error: function (xhr, status, error) {
                alert("데이터 로딩 중 오류가 발생했습니다.");
                console.error("Error occurred:", error);
            }
        });
    }

    $(".pagination-button").on("click", function () {
        const pageIndex = $(this).data("page");
        loadPostList(pageIndex);
    });

    function updatePostList(postList) {
        console.log("updatePostList:", postList);
        let content = '';
        $.each(postList, function (index, post) {
            content += `
                <tr>
                    <td>${post.id}</td>
                    <td><a href="/post/detail?id=${post.id}">${post.postTitle}</a></td>
                    <td>${post.memberName}</td>
                    <td>${post.postDate}</td>
                    <td>${post.viewCount}</td>
                    <td>${post.commentCount}</td>
                </tr>`;
        });
        $("#post-list").html(content);
    }

    function updatePagination(pagination) {
        console.log("updatePagination", pagination);
        let content = '<ol class="pagination" id="pagination">';
        if (pagination.xprev) {
            content += `<li class="prev_end"><a href="javascript:void(0);" onclick="goPage(1); return false;">처음</a></li>`;
            content += `<li class="prev"><a href="javascript:void(0);" onclick="goPage(${pagination.firstPageNoOnPageList - 1}); return false;">이전</a></li>`;
        }
        for (let pageNum = pagination.firstPageNoOnPageList; pageNum <= pagination.lastPageNoOnPageList; pageNum++) {
            content += `<li><a href="javascript:void(0);" onclick="goPage(${pageNum}); return false;" class="pageNum ${pagination.currentPageNo == pageNum ? 'on' : ''}">${pageNum}</a></li>`;
        }
        if (pagination.xnext) {
            content += `<li class="next"><a href="javascript:void(0);" onclick="goPage(${pagination.lastPageNoOnPageList + 1}); return false;">다음</a></li>`;
            content += `<li class="next_end"><a href="javascript:void(0);" onclick="goPage(${pagination.realEnd}); return false;">끝</a></li>`;
        }
        content += '</ol>';
        $(".board-list-paging").html(content);
    }

    $(document).on("click", ".deletePost", function () {
        const postId = $(this).data("id");
        console.log("postId =", postId);
        if (!postId) {
            alert("삭제할 게시글 ID를 찾을 수 없습니다.");
            return;
        }

        if (!confirm("게시글을 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: `/post/deletePost/${postId}`,
            type: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({ id: postId }),
            success: function (response) {
                alert(response);
                window.location.href = "/post/list";
            },
            error: function (xhr, status, error) {
                alert("게시글 삭제에 실패했습니다.");
                console.error("Error:", error);
            }
        });
    });

    $(document).on("click", ".goWritePost", function () {
        window.location.href = "/post/write";
    });

    $(".writePost").click(function () {
        const postData = {
            postTitle: $("#postTitle").val(),
            postContent: $("#postContent").val()
        };

        if (!postData.postTitle || !postData.postContent) {
            alert("제목과 내용을 모두 입력해주세요.");
            console.log("제목과 내용을 모두 입력해주세요.");
            return;
        }

        if (!confirm("게시글을 작성하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: "/post/write",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(postData),
            success: function (response) {
                alert("게시글 작성이 완료되었습니다.");
                window.location.href = "/post/list";
            },
            error: function (xhr, status, error) {
                alert("게시글 작성에 실패했습니다.");
                console.error("Error:", error);
            }
        });
    });

    $(document).on("click", ".editPost", function () {
        const postId = $(this).data("id");
        console.log("postId =", postId);

        if (!postId) {
            alert("수정할 게시글 ID를 찾을 수 없습니다.");
            return;
        }

        if (confirm("게시글을 수정하시겠습니까?")) {
            window.location.href = `/post/edit/${postId}`;
        }
    });

    $(document).on("click", ".save-edit-post", function () {
        const id = $(this).data("id");
        const postTitle = $("#postTitle").val().trim();
        const postContent = $("#postContent").val().trim();

        if (!postTitle || !postContent) {
            alert("제목과 내용을 모두 입력하세요.");
            return;
        }

        $.ajax({
            url: `/post/edit/${id}`,
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
                postTitle: postTitle,
                postContent: postContent
            }),
            success: function (response) {
                alert("게시글이 성공적으로 수정되었습니다.");
                window.location.href = "/post/list";
            },
            error: function (xhr, status, error) {
                alert("게시글 수정에 실패했습니다.");
                console.error("Error:", error);
            }
        });
    });


    // 초기 페이지 로드
    loadPostList();
});
