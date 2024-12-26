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


});
