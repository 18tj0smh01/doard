const postId = $(this).data("id");
$(document).ready(function () {

    // 삭제
    $(".deletePost").click(function () {

        if (!postId) {
            alert("삭제할 게시글 ID를 찾을 수 없습니다.");
            return;
        }

        if (!confirm("게시글을 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: "/post/deletePost", // 서버의 DELETE 요청 URL
            type: "DELETE",
            // type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ id: postId }),
            success: function (response) {
                alert(response);
                window.location.href = "/post/list"; // 삭제 후 리스트 페이지로 이동
            },
            error: function (xhr, status, error) {
                alert("게시글 삭제에 실패했습니다.");
                console.error(error);
            }
        });
    });

    // 작성
    $(".writePost").click(function () {

        if (!confirm("게시글을 작성하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: "/post/write", // 서버의 POST 요청 URL
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ id: postId }),
            success: function (response) {
                alert(response);
                window.location.href = "/post/list"; // 작성 후 리스트 페이지로 이동
            },
            error: function (xhr, status, error) {
                alert("게시글 작성에 실패했습니다.");
                console.error(error);
            }
        });
    });



});
