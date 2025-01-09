$(document).ready(function () {
    $(document).on("click", ".uploadImg", function () {
        $(this).closest(".comment-box, .post-box").find(".imgInput").click();
    });

    // 파일 업로드
    $(document).on("change", ".imgInput", function () {
        const file = this.files[0];
        const targetTextarea = $(this).closest(".comment-box, .post-box").find("textarea");

        if (file && targetTextarea.length) {
            const formData = new FormData();
            formData.append("file", file);

            $.ajax({
                url: "/file/upload",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response.filePath) {
                        const imgUrl = response.filePath;
                        console.log("img:" + imgUrl);
                        insertImgToEditor(targetTextarea, imgUrl);
                    } else {
                        console.error("오류");
                    }
                },
                error: function (xhr, status, error) {
                    alert("이미지 업로드 실패: " + error);
                }
            });
        }
    });

    // 이미지 삽입 함수
    function insertImgToEditor(targetTextarea, imgUrl) {
        console.log("본문 삽입 img:" + imgUrl);
        const cursorPosition = targetTextarea.prop("selectionStart");
        const textBefore = targetTextarea.val().substring(0, cursorPosition);
        const textAfter = targetTextarea.val().substring(cursorPosition);
        targetTextarea.val(textBefore + `\n<img src="${imgUrl}" alt="이미지" />\n` + textAfter);
    }
});
