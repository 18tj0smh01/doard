$(document).ready(function () {
    // 페이지 로드 시 댓글 자동 로드
    const postId = $("#postId").val(); // 숨겨진 필드에서 postId를 가져옴
    if (postId) {
        loadComments(postId);
    }

    // 댓글 작성
    $("#commentSubmit").click(function () {
        const commentContent = $("#commentContent").val()?.trim() || ""; // 수정: 기본값을 빈 문자열로 설정

        if (!postId) {
            alert("게시글 ID를 찾을 수 없습니다.");
            return;
        }

        if (!commentContent) {
            alert("댓글 내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: `/comment/writeComment`,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ postId: postId, commentContent: commentContent }),
            success: function () {
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
        $.ajax({
            url: `/comment/detail/${postId}/1`,
            type: "GET",
            success: function (response) {
                const commentContainer = $("#comment-container");
                commentContainer.empty();

                response.forEach(function (comment) {
                    commentContainer.append(`
                    <div class="comment-info" data-comment-id="${comment.id}">
                        <div class="comment-userName">${comment.memberName}</div>
                        <div class="comment-content">${comment.commentContent}</div>
                        <section class="order">
                            <a data-id="${comment.id}" class="edit editComment">수정</a>
                            <a data-id="${comment.id}" class="delete deleteComment">삭제</a>
                        </section>
                        <div class="comment-footer">
                            <div class="comment-date">${comment.commentDate}</div>
                            <button type="button" class="reply-button">답글 쓰기</button>
                        </div>
                        <div class="reply-box" style="display: none;">
                            <textarea name="reply" class="comment-input" placeholder="답글을 입력하세요"></textarea>
                            <div class="comment-footer">
                                <button type="button" class="comment-cancel">취소</button>
                                <button type="submit" class="comment-submit">등록</button>
                            </div>
                        </div>
                             <div class="replies-container">
                                  ${renderReplies(comment.replies)}
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

    // 대댓글
    function renderReplies(replies) {
        $.ajax({
            url: `/comment/detail/${postId}/1`,
            type: "GET",
            success: function (response) {
                const replyContainer = $("#replies-container");
                if (!replies || replies.length === 0) return "";

                let replyHTML = "";

                replies.forEach(function (reply) {
                    replyHTML += `
            <div class="comment-reply" data-comment-id="${reply.id}">
                <div class="reply-userName">${reply.memberName}</div>
                <div class="reply-content">${reply.commentContent}</div>
                <div class="reply-footer">
                    <div class="reply-date">${reply.commentDate}</div>
                    <button type="button" class="reply-to-reply-button">답글 쓰기</button>
                </div>
            </div>
        `;
                });
                return replyHTML;
            }
        });
    }

    // 답글 버튼 이벤트
    $(document).on("click", ".reply-button", function () {
        const replyBox = $(this).closest(".comment-info").find(".reply-box");
        replyBox.toggle();
    });

    // 답글 취소 버튼 이벤트
    $(document).on("click", ".comment-cancel", function () {
        const replyBox = $(this).closest(".reply-box");
        replyBox.hide();
    });

    // 답글 등록 버튼 이벤트
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
            data: JSON.stringify({ postId: postId, parentCommentId: parentCommentId, commentContent: replyContent }),
            success: function () {
                alert("답글이 등록되었습니다.");
                loadComments(postId);
            },
            error: function (xhr, status, error) {
                alert("답글 등록 중 오류가 발생했습니다.");
                console.error(error);
            }
        });
    });

    // 댓글 삭제 버튼 이벤트
    $(document).on("click", ".deleteComment", function () {
        const commentId = $(this).data("id");

        if (!commentId) {
            alert("삭제할 댓글 ID를 찾을 수 없습니다.");
            return;
        }

        if (!confirm("댓글을 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: `/comment/delete/${commentId}`,
            type: "DELETE",
            success: function () {
                alert("댓글이 삭제되었습니다.");
                loadComments(postId);
            },
            error: function (xhr, status, error) {
                alert("댓글 삭제에 실패했습니다.");
                console.error(error);
            }
        });
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
        $(this).hide(); // 수정 버튼 숨김
    });

    // 댓글 수정 저장 버튼 이벤트
    $(document).on("click", ".edit-save", function () {
        const commentId = $(this).data("id");
        const updatedContent = $(this).closest(".edit-box").find(".edit-input").val().trim();

        if (!updatedContent) {
            alert("수정할 내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: `/comment/edit/${commentId}`,
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({ commentContent: updatedContent }),
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
