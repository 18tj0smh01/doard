// const postId = $(this).data("id");
$(document).ready(function () {
    // 상세



    // 삭제
    // $(".deletePost").click(function () {
    //     const postId = $(this).data("id");
    //     if (!postId) {
    //         alert("삭제할 게시글 ID를 찾을 수 없습니다.");
    //         return;
    //     }
    //
    //     if (!confirm("게시글을 삭제하시겠습니까?")) {
    //         return;
    //     }
    //
    //     $.ajax({
    //         url: "/post/deletePost", // 서버의 DELETE 요청 URL
    //         type: "DELETE",
    //         contentType: "application/json",
    //         data: JSON.stringify({ id: postId }),
    //         success: function (response) {
    //             alert(response);
    //             window.location.href = "/post/list"; // 삭제 후 리스트 페이지로 이동
    //         },
    //         error: function (xhr, status, error) {
    //             alert("게시글 삭제에 실패했습니다.");
    //             console.error(error);
    //         }
    //     });
    // });

    $(".deletePost").click(function () {
        const postId = $(this).data("id");
        if (!postId) {
            alert("삭제할 게시글 ID를 찾을 수 없습니다.");
            return;
        }

        if (!confirm("게시글을 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: "/post/deletePost",
            type: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({ id: postId }),
            success: function (response) {
                if (response.status === "success") {
                    alert(response.message);
                    window.location.href = response.redirect;
                } else {
                    alert(response.message);
                    if (response.redirect) {
                        window.location.href = response.redirect;
                    }
                }
            },
            error: function (xhr, status, error) {
                alert("게시글 삭제에 실패했습니다.");
                console.error(error);
            }
        });
    });
    // 수정
    $(".editPost").click(function () {

        if (!postId) {
            alert("수정할 게시글 ID를 찾을 수 없습니다.");
            return;
        }

        if (!confirm("게시글을 수정하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: "/post/edit", // 서버의 PUT 요청 URL
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({ id: postId }),
            success: function (response) {
                alert(response);
                window.location.href = "/post/list"; // 수정 후 상세 페이지로 이동
            },
            error: function (xhr, status, error) {
                alert("게시글 수정에 실패했습니다.");
                console.error(error);
            }
        });
    });

});
