<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <title>회원가입</title>
</head>
<body>
<div class="container">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
        <div class="jumbotron" style="padding-top: 20px;">
            <form id="signUpForm">
                <div>회원가입</div>
                <div class="form-group">
                    <div>아이디</div>
                    <span>
                        <input type="text" class="form-control id-box" placeholder="아이디" maxlength="20">
                        <button type="button">중복 확인</button>
                    </span>
                    <div class="idMsg" style="display: none;">중복된 아이디</div>
                </div>
                <div class="form-group">
                    <div>비밀번호</div>
                    <input type="password" class="form-control password-box" placeholder="비밀번호" maxlength="20">
                </div>
                <div class="form-group">
                    <div>비밀번호 재입력</div>
                    <input type="password" class="form-control re-password-box" placeholder="비밀번호" maxlength="20">
                    <div class="pwMsg" style="display: none; color: red;">비밀번호가 일치하지 않습니다.</div>
                </div>
                <div class="form-group">
                    <div>닉네임</div>
                    <span>
                        <input type="text" class="form-control name-box" placeholder="닉네임" maxlength="20">
                        <button type="button">중복 확인</button>
                    </span>
                    <div class="nameMsg" style="display: none;">중복된 닉네임</div>
                </div>
                <input type="submit" class="btn btn-primary form-control" value="가입">
            </form>
        </div>
    </div>
    <div class="col-lg-4"></div>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../../resources/js/bootstrap.js"></script>
<script>
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

        <%--$(".id-box").next("button").click(function () {--%>
        <%--    const memberId = $(".id-box").val();--%>
        <%--    $.ajax({--%>
        <%--        url: `/signUp/checkId?memberId=${memberId}`,--%>
        <%--        type: "GET",--%>
        <%--        success: function (isAvailable) {--%>
        <%--            $(".idMsg").text(isAvailable ? "사용 가능한 아이디입니다." : "중복된 아이디입니다.")--%>
        <%--                .css("color", isAvailable ? "green" : "red")--%>
        <%--                .show();--%>
        <%--        },--%>
        <%--        error: function () {--%>
        <%--            $(".idMsg").text("아이디 확인 중 오류가 발생했습니다.").css("color", "red").show();--%>
        <%--        },--%>
        <%--    });--%>
        <%--});--%>

        <%--$(".name-box").next("button").click(function () {--%>
        <%--    const memberName = $(".name-box").val();--%>
        <%--    $.ajax({--%>
        <%--        url: `/signUp/checkName?memberName=${memberName}`,--%>
        <%--        type: "GET",--%>
        <%--        success: function (isAvailable) {--%>
        <%--            $(".nameMsg").text(isAvailable ? "사용 가능한 닉네임입니다." : "중복된 닉네임입니다.")--%>
        <%--                .css("color", isAvailable ? "green" : "red")--%>
        <%--                .show();--%>
        <%--        },--%>
        <%--        error: function () {--%>
        <%--            $(".nameMsg").text("닉네임 확인 중 오류가 발생했습니다.").css("color", "red").show();--%>
        <%--        },--%>
        <%--    });--%>
        <%--});--%>
    });
</script>
</body>
</html>