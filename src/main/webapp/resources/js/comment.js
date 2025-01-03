$(document).ready(function () {
    const postId = $("#postId").val();

    if (postId) {
        loadComments(postId);
    }

    // 댓글 작성
    $("#commentSubmit").click(function () {
        const commentContent = $("#commentContent").val()?.trim() || "";

        if (!postId || !commentContent) {
            alert(postId ? "댓글 내용을 입력하세요." : "게시글 ID를 찾을 수 없습니다.");
            return;
        }

        $.ajax({
            url: `/comment/writeComment`,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ postId, commentContent }),
            success: function () {
                $("#commentContent").val("");
                loadComments(postId);
            },
            error: function (xhr) {
                alert("댓글 등록 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
            },
        });
    });


    // 댓글 목록 불러오기
    function loadComments(postId) {
        $.ajax({
            url: `/comment/detail/${postId}/1`,
            type: "GET",
            success: function (comments) {
                const commentContainer = $("#comment-container");
                commentContainer.empty();

                comments.forEach(function (comment) {
                    const commentHTML = renderComment(comment);
                    commentContainer.append(commentHTML);
                });
            },
            error: function (xhr) {
                alert("댓글 목록을 불러오는 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
            },
        });
    }

    // 댓글 렌더링 함수
    function renderComment(comment) {
        let repliesHTML = "";

        // 대댓글 렌더링
        if (comment.replies && comment.replies.length > 0) {
            comment.replies.forEach(function (reply) {
                repliesHTML += renderReply(reply);
            });
        }

        return `
            <div class="comment-info" data-comment-id="${comment.id}">
                <div class="comment-header">
                    <span class="comment-userName">${comment.memberName}</span>
                    <span class="comment-date">${comment.commentDate}</span>
                </div>
                <div class="comment-content">${comment.commentContent}</div>
                <section class="order">
                    <a data-id="${comment.id}" class="edit editComment">수정</a>
                    <a data-id="${comment.id}" class="delete deleteComment">삭제</a>
                </section>
                <button type="button" class="reply-button">답글 쓰기</button>
                <div class="reply-box" style="display: none;">
                    <textarea name="reply" class="comment-input" placeholder="답글을 입력하세요"></textarea>
                    <button type="button" class="comment-cancel">취소</button>
                    <button type="submit" class="comment-submit">등록</button>
                </div>
                <div class="replies-container">
                    ${repliesHTML}
                </div>
            </div>
        `;
    }

    // 대댓글 렌더링 함수
    function renderReply(reply) {
        return `
            <div class="comment-reply" data-comment-id="${reply.id}">
                <div class="reply-header">
                    <span class="reply-userName">${reply.memberName}</span>
                    <span class="reply-date">${reply.commentDate}</span>
                </div>
                <div class="reply-content">${reply.commentContent}</div>
                <section class="order">
                    <button  data-id="${reply.id}" class="edit editComment">수정</a>
                    <button  data-id="${reply.id}" class="delete deleteComment">삭제</a>
                </section>
            </div>
        `;
    }

    // 답글 버튼 클릭 이벤트
    $(document).on("click", ".reply-button", function () {
        const replyBox = $(this).closest(".comment-info").find(".reply-box");
        replyBox.toggle();
    });

    // 답글 등록
    $(document).on("click", ".comment-submit", function () {
        const replyBox = $(this).closest(".reply-box");
        const replyContent = replyBox.find(".comment-input").val().trim();
        const parentCommentId = $(this).closest(".comment-info").data("comment-id");

        if (!replyContent) {
            alert("답글 내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: `/comment/writeReply`,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ postId, parentCommentId, commentContent: replyContent }),
            success: function () {
                loadComments(postId);
            },
            error: function (xhr) {
                alert("답글 등록 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
            },
        });
    });

    // 댓글 삭제
    $(document).on("click", ".deleteComment", function () {
        const commentId = $(this).data("id");

        if (!confirm("댓글을 삭제하시겠습니까?")) return;

        $.ajax({
            url: `/comment/delete/${commentId}`,
            type: "DELETE",
            success: function () {
                loadComments(postId);
            },
            error: function (xhr) {
                alert("댓글 삭제 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
            },
        });
    });


    // 답글 취소
    $(document).on("click", ".comment-cancel", function () {
        const replyBox = $(this).closest(".reply-box");
        replyBox.hide();
    });

    // 댓글 수정 버튼 이벤트
    $(document).on("click", ".editComment", function () {
        const commentId = $(this).data("id");
        const commentContent = $(this).closest(".comment-info").find(".comment-content").text().trim();

        if (!commentId) {
            alert("수정할 댓글 ID를 찾을 수 없습니다.");
            return;
        }

        const editBox = `
            <div class="edit-box">
                <textarea class="edit-input">${commentContent}</textarea>
                <button class="edit-save" data-id="${commentId}">저장</button>
                <button class="edit-cancel">취소</button>
            </div>
        `;

        $(this).closest(".comment-info").append(editBox);
        $(this).hide();
    });

    // 댓글 수정 저장 버튼 이벤트
    $(document).on("click", ".edit-save", function () {
        const commentId = $(this).data("id");
        const commentContent = $(this).closest(".edit-box").find(".edit-input").val().trim();

        if (!commentContent) {
            alert("수정할 내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: `/comment/edit/${commentId}`,
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({ commentContent: commentContent }),
            success: function () {
                alert("댓글이 수정되었습니다.");
                loadComments(postId);
            },
            error: function (xhr, status, error) {
                alert("댓글 수정에 실패했습니다.");
                console.error(error);
            }
        });
    });

    // 댓글 수정 취소 버튼 이벤트
    $(document).on("click", ".edit-cancel", function () {
        $(this).closest(".edit-box").remove();
        $(this).closest(".comment-info").find(".editComment").show();
    });
});
