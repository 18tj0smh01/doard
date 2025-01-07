$(document).ready(function () {
    function uploadFile(file, callback) {
        const formData = new FormData();
        formData.append("file", file);

        $.ajax({
            url: "/file/upload",
            type: "POST",
            processData: false,
            contentType: false,
            data: formData,
            success: function (response) {
                callback(null, response.filePath);
            },
            error: function (xhr, status, error) {
                callback(error, null);
            }
        });
    }
});