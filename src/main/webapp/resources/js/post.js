$(document).ready(function () {
    // 게시글 삭제
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

    // 게시글 작성
    $(document).on("click", ".goWritePost", function () {
        const memberId = $(this).data("id");
            window.location.href = `/post/write`;
    });

    // 게시글 작성
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


        // 게시글 수정 페이지 이동
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

        // 게시글 수정 내용 저장
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

    //게시글 리스트
    $.ajax({
        url: path + "/post/list",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify(submitObj),
        dataType: "json"
    })
        .done(function(data) {
            updatePostList(data.postList);
            updatePagination(data.pagination);
        })
        .fail(function() {
            alert("데이터 로딩 중 오류가 발생했습니다.");
        });

    function updatePostList(postList) {
        var content = '';
        $.each(postList, function(index, post) {
            content += `
                <tr>
                    <td>${post.id}</td>
                    <td><a href="${pageContext.request.contextPath}/post/detail?id=${post.id}">${post.postTitle}</a></td>
                    <td>${post.memberName}</td>
                    <td>${post.postDate}</td>
                    <td>${post.viewCount}</td>
                    <td>${post.commentCount}</td>
                </tr>`;
        });
        $("#post-list").html(content);
    }

    ///


    // function goPage(pageNo) {
    //     var path = "${pageContext.request.contextPath}";
    //     var submitObj = {
    //         pageIndex: pageNo
    //     };
    //
    //     $.ajax({
    //         url: path + "/post/list",
    //         type: "POST",
    //         contentType: "application/json;charset=UTF-8",
    //         data: JSON.stringify(submitObj),
    //         dataType: "json"
    //     })
    //         .done(function(data) {
    //             updatePostList(data.postList);
    //             updatePagination(data.pagination);
    //         })
    //         .fail(function() {
    //             alert("데이터 로딩 중 오류가 발생했습니다.");
    //         });
    // }
    //
    // function updatePostList(postList) {
    //     var content = '';
    //     $.each(postList, function(index, post) {
    //         content += `
    //             <tr>
    //                 <td>${post.id}</td>
    //                 <td><a href="${pageContext.request.contextPath}/post/detail?id=${post.id}">${post.postTitle}</a></td>
    //                 <td>${post.memberName}</td>
    //                 <td>${post.postDate}</td>
    //                 <td>${post.viewCount}</td>
    //                 <td>${post.commentCount}</td>
    //             </tr>`;
    //     });
    //     $("#post-list").html(content);
    // }
    //
    // function updatePagination(pagination) {
    //     var content = '<ol class="pagination" id="pagination">';
    //     if (pagination.xprev) {
    //         content += `<li class="prev_end"><a href="javascript:void(0);" onclick="goPage(1); return false;">처음</a></li>`;
    //         content += `<li class="prev"><a href="javascript:void(0);" onclick="goPage(${pagination.firstPageNoOnPageList - 1}); return false;">이전</a></li>`;
    //     }
    //     for (var num = pagination.firstPageNoOnPageList; num <= pagination.lastPageNoOnPageList; num++) {
    //         content += `<li><a href="javascript:void(0);" onclick="goPage(${num}); return false;"
    //             class="num ${pagination.currentPageNo == num ? 'on' : ''}">${num}</a></li>`;
    //     }
    //     if (pagination.xnext) {
    //         content += `<li class="next"><a href="javascript:void(0);" onclick="goPage(${pagination.lastPageNoOnPageList + 1}); return false;">다음</a></li>`;
    //         content += `<li class="next_end"><a href="javascript:void(0);" onclick="goPage(${pagination.realEnd}); return false;">끝</a></li>`;
    //     }
    //     content += '</ol>';
    //     $(".board-list-paging").html(content);
    // }
});
