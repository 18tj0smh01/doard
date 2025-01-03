$(document).ready(function () {
    $("#signUpForm").on("submit", function (e) {
        e.preventDefault();

        const memberId = $(".id-box").val();
        const memberPassword = $(".password-box").val();
        const rePassword = $(".re-password-box").val();
        const memberName = $(".name-box").val();

        if (memberPassword !== rePassword) {
            $(".pwMsg").show();
            return;
        }

        $.ajax({
            url: "/signUp",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                memberId: memberId,
                memberPassword: memberPassword,
                memberName: memberName,
            }),
            success: function () {
                alert("회원가입 성공");
                window.location.href = "/login";
            },
            error: function (xhr) {
                alert("회원가입 실패");
                console.error(xhr.responseText);
            },
        });
    });

    // $(".id-box").next("button").click(function () {
    //     const memberId = $(".id-box").val();
    //     $.ajax({
    //         url: `/signUp/checkId?memberId=${memberId}`,
    //         type: "GET",
    //         success: function (isAvailable) {
    //             $(".idMsg").text(isAvailable ? "사용 가능한 아이디입니다." : "중복된 아이디입니다.")
    //                 .css("color", isAvailable ? "green" : "red")
    //                 .show();
    //         },
    //         error: function () {
    //             $(".idMsg").text("아이디 확인 중 오류가 발생했습니다.").css("color", "red").show();
    //         },
    //     });
    // });
    //
    // $(".name-box").next("button").click(function () {
    //     const memberName = $(".name-box").val();
    //     $.ajax({
    //         url: `/signUp/checkName?memberName=${memberName}`,
    //         type: "GET",
    //         success: function (isAvailable) {
    //             $(".nameMsg").text(isAvailable ? "사용 가능한 닉네임입니다." : "중복된 닉네임입니다.")
    //                 .css("color", isAvailable ? "green" : "red")
    //                 .show();
    //         },
    //         error: function () {
    //             $(".nameMsg").text("닉네임 확인 중 오류가 발생했습니다.").css("color", "red").show();
    //         },
    //     });
    // });
});