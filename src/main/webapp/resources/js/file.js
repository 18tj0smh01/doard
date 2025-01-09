$(document).ready(function () {
    // 이미지 버튼 클릭 이벤트
    $("#uploadImg").click(function () {
        $("#imgInput").click();
    });

    // 파일 업로드
    $("#imgInput").change(function () {
        const file = this.files[0];
        if (file) {
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
                        insertImgToEditor(imgUrl);
                    } else {
                        console.error("파일 업로드 응답에 URL이 없습니다.");
                    }
                },
                error: function (xhr, status, error) {
                    alert("이미지 업로드 실패: " + error);
                }
            });
        }
    });

    // 본문에 삽입 함수
    function insertImgToEditor(imgUrl) {
        console.log("본문 삽입 img:" + imgUrl);
        const textarea = $("#postContent");
        const cursorPosition = textarea.prop("selectionStart");
        const textBefore = textarea.val().substring(0, cursorPosition);
        const textAfter = textarea.val().substring(cursorPosition);
        textarea.val(textBefore + `\n<img src="${imgUrl}" alt="이미지" />\n` + textAfter);
    }
});
