$(document).ready(function () {
    // // 아이디 중복 검사
    // function checkId() {
    //     let memberId = $('#memberId').val().trim();
    //     $('.checkIdSpan').remove();
    //
    //     if (!memberId) {
    //         $('#memberId').after("<span class='checkIdSpan' style='color:lightgray'>아이디를 입력해주세요.</span>");
    //         $('#memberId').focus();
    //         return;
    //     }
    //
    //     $.ajax({
    //         url: '/checkId',
    //         type: 'GET',
    //         data: { memberId: memberId },
    //         success: function(response) {
    //             if (response.cnt > 0) {
    //                 $('#memberId').attr('status', 'no');
    //                 $('#memberId').after("<span class='checkIdSpan' style='color:red'>이미 존재하는 아이디입니다.</span>");
    //                 $('#memberId').focus();
    //             } else {
    //                 $('#memberId').attr('status', 'yes');
    //                 $('#memberId').after("<span class='checkIdSpan' style='color:blue'>사용 가능한 아이디입니다.</span>");
    //             }
    //         },
    //         error: function(xhr, status, error) {
    //             console.error("Error:", error);
    //             console.error("ID:", memberId);
    //             alert("아이디 중복 확인 중 오류가 발생했습니다.");
    //         }
    //     });
    //
    // }
    // // 닉네임 중복 검사
    // function checkName() {
    //     let memberName = $('#memberName').val().trim();
    //     $('.checkNameSpan').remove();
    //
    //     if (!memberName) {
    //         $('#memberName').after("<span class='checkNameSpan' style='color:lightgray'>닉네임을 입력해주세요.</span>");
    //         $('#memberName').focus();
    //         return;
    //     }
    //
    //     $.ajax({
    //         url: '/checkName',
    //         type: 'GET',
    //         data: { memberName: memberName },
    //         success: function(response) {
    //             console.error("Name:", memberName);
    //             if (response.cnt > 0) {
    //                 $('#memberName').attr('status', 'no');
    //                 $('#memberName').after("<span class='checkNameSpan' style='color:red'>이미 존재하는 닉네임입니다.</span>");
    //                 $('#memberName').focus();
    //             } else {
    //                 $('#memberName').attr('status', 'yes');
    //                 $('#memberName').after("<span class='checkNameSpan' style='color:blue'>사용 가능한 닉네임입니다.</span>");
    //             }
    //         },
    //         error: function(xhr, status, error) {
    //             console.error("Error:", error);
    //             console.error("Name:", memberName);
    //             alert("닉네임 중복 확인 중 오류가 발생했습니다.");
    //         }
    //     });
    // }



    // $("#loginForm").on("submit", function (e) {
    //     e.preventDefault();
    //
    //     const memberId = $(".id-box").val().trim();
    //     const memberPassword = $(".password-box").val().trim();
    //
    //     if (!memberId) {
    //         alert("아이디를 입력해주세요.");
    //         return;
    //     }    
    //     if (!memberPassword) {
    //         alert("비밀번호를 입력해주세요.");
    //         return;
    //     }
    // });

    $("#signUpForm").on("submit", function (e) {
        e.preventDefault();

        const memberId = $(".id-box").val().trim();
        const memberPassword = $(".password-box").val().trim();
        const rePassword = $(".re-password-box").val().trim();
        const memberName = $(".name-box").val().trim();

        // 필수값 검증
        if (!memberId || !memberPassword || !rePassword || !memberName) {
            alert("모든 필드는 필수입니다.");
            return;
        }

        // 비밀번호 확인
        if (memberPassword !== rePassword) {
            $(".pwMsg").show();
            alert("비밀번호가 일치하지 않습니다.");
            return;
        } else {
            $(".pwMsg").hide();
        }

        // 중복 상태 확인
        const idStatus = $('#memberId').attr('status');
        const nameStatus = $('#memberName').attr('status');

        if (idStatus !== 'yes') {
            alert("아이디 중복 확인을 완료해주세요.");
            return;
        }
        if (nameStatus !== 'yes') {
            alert("닉네임 중복 확인을 완료해주세요.");
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

    // 로그아웃
    $("#logoutButton").click(function () {
        $.ajax({
            url: "/logout",
            type: "GET",
            success: function () {
                alert("로그아웃");
                window.location.href = "/login";
            },
            error: function (xhr, status, error) {
                alert("로그아웃 처리 중 오류가 발생했습니다.");
                console.error("Error: ", error);
            }
        });
    });
});
