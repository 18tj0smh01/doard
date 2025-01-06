<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1">
<div class="modal-body">
    <form id="signUpForm" onsubmit="return formCheck()">
        <div>회원가입</div>
        <div class="form-group">
            <div>아이디</div>
            <span>
                <input type="text" id="memberId" class="form-control id-box" placeholder="아이디" maxlength="20">
                <button type="button" onclick="checkId()">아이디 중복 확인</button>
            </span>
            <div class="idMsg" style="display: none; color: red;">중복된 아이디</div>
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
                <input type="text" class="form-control name-box" id="memberName" placeholder="닉네임" maxlength="20">
                <button type="button" onclick="checkName()">닉네임 중복 확인</button>
            </span>
            <div class="nameMsg" style="display: none; color: red;">중복된 닉네임</div>
        </div>
        <input type="submit" class="btn btn-primary form-control" value="가입">
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
</div>
<script src="${pageContext.request.contextPath}/resources/js/sign.js"></script>
