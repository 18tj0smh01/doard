$('#submitComment').click(function () {
    const commentContent = $('#commentContent').val();
    const postId = postId

    if (!commentContent.trim()) {
        alert('댓글 내용을 입력하세요.');
        return;
    }

    $.ajax({
        url: '/comment/write',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            postId: postId,
            commentContent: commentContent
        }),
        success: function (response) {
            alert('댓글이 등록되었습니다.');
            loadComments(postId); // 댓글 목록 갱신
            $('#commentContent').val(''); // 입력 필드 초기화
        },
        error: function () {
            alert('댓글 등록 중 오류가 발생했습니다.');
        }
    });
});
