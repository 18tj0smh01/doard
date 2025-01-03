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
                    <div class="idMsg" style="display: none;  color: red;" >중복된 아이디</div>
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
                    <div class="nameMsg" style="display: none; color: red;">중복된 닉네임</div>
                </div>
                <input type="submit" class="btn btn-primary form-control" value="가입">
            </form>
        </div>
    </div>
    <div class="col-lg-4"></div>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../../resources/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sign.js"></script>
<script>

</script>
</body>
</html>