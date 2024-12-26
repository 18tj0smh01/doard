$(document).ready(function () {
    // 댓글 작성
    $("#commentSubmit").click(function () {
        const postId = $(this).data("post-id");
        const commentContent = $("#commentContent").val().trim();

        if (!postId) {
            alert("게시글 ID를 찾을 수 없습니다.");
            return;
        }

        if (!commentContent) {
            alert("댓글 내용을 입력하세요.");
            return;
        }

        // 댓글 작성 API 호출
        $.ajax({
            url: `/comment/write`,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ postId: postId, commentContent: commentContent }),
            success: function (response) {
                alert("댓글이 등록되었습니다.");
                $("#commentContent").val(""); // 입력창 초기화
                loadComments(postId); // 댓글 목록 갱신
            },
            error: function (xhr, status, error) {
                alert("댓글 등록 중 오류가 발생했습니다.");
                console.error(error);
            }
        });
    });

    // 댓글 목록 불러오기
    function loadComments(postId) {
        console.log("Loading comments for Post ID:", postId);
        $.ajax({
            url: `/comment/detail/${postId}/1`,
            type: "GET",
            success: function (response) {
                console.log("Comments loaded successfully:", response);
                const commentContainer = $("#comment-container");
                commentContainer.empty(); // 기존 댓글 초기화
                response.forEach(function (comment) {
                    commentContainer.append(`
                    <div class="comment-info">
                        <div class="comment-userName">${comment.memberName}</div>
                        <div class="comment-content">${comment.commentContent}</div>
                        <div class="comment-footer">
                            <div class="comment-date">${comment.commentDate}</div>
                        </div>
                    </div>
                `);
                });
            },
            error: function (xhr, status, error) {
                console.error("Error loading comments:", xhr.responseText || error);
                alert("댓글 목록을 불러오는 중 오류가 발생했습니다.");
            }
        });
    }

});
