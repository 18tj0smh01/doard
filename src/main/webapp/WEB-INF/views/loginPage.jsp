<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-default">
	<div class="navbar-header">
		<a class="navbar-brand" href="#">JSP 게시판</a>
	</div>
</nav>
<div class="container">
	<div class="login-box">
		<form method="post" name="login" action="/login">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="아이디" name="memberId" maxlength="20">
			</div>
			<div class="form-group">
				<input type="password" class="form-control" placeholder="비밀번호" name="memberPassword" maxlength="20">
			</div>
			<input type="submit" class="btn btn-primary form-control" value="로그인">
		</form>
		<div>
			<button class="btn btn-secondary" onclick="loadSignUpModal()">회원가입</button>
		</div>
	</div>
</div>

<div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="signupModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="signupModalLabel">회원가입</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="signupModalContent">
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sign.js"></script>
<script>
	function loadSignUpModal() {
		$.ajax({
			url: "/signUp",
			type: "GET",
			success: function (html) {
				$("#signupModalContent").html(html);
				$("#signupModal").modal("show");
			},
			error: function () {
				alert("회원가입 페이지를 로드하는 중 오류가 발생했습니다.");
			}
		});
	}

	// 아이디 중복 검사
	function checkId() {
		let memberId = $('#memberId').val().trim();
		$('.checkIdSpan').remove();

		if (!memberId) {
			$('#memberId').after("<span class='checkIdSpan' style='color:lightgray'>아이디를 입력해주세요.</span>");
			$('#memberId').focus();
			return;
		}

		$.ajax({
			url: '/checkId',
			type: 'GET',
			data: { memberId: memberId },
			success: function(response) {
				if (response.cnt > 0) {
					$('#memberId').attr('status', 'no');
					$('#memberId').after("<span class='checkIdSpan' style='color:red'>이미 존재하는 아이디입니다.</span>");
					$('#memberId').focus();
				} else {
					$('#memberId').attr('status', 'yes');
					$('#memberId').after("<span class='checkIdSpan' style='color:blue'>사용 가능한 아이디입니다.</span>");
				}
			},
			error: function(xhr, status, error) {
				console.error("Error:", error);
				console.error("ID:", memberId);
				alert("아이디 중복 확인 중 오류가 발생했습니다.");
			}
		});

	}
	// 닉네임 중복 검사
	function checkName() {
		let memberName = $('#memberName').val().trim();
		$('.checkNameSpan').remove();

		if (!memberName) {
			$('#memberName').after("<span class='checkNameSpan' style='color:lightgray'>닉네임을 입력해주세요.</span>");
			$('#memberName').focus();
			return;
		}

		$.ajax({
			url: '/checkName',
			type: 'GET',
			data: { memberName: memberName },
			success: function(response) {
				console.error("Name:", memberName);
				if (response.cnt > 0) {
					$('#memberName').attr('status', 'no');
					$('#memberName').after("<span class='checkNameSpan' style='color:red'>이미 존재하는 닉네임입니다.</span>");
					$('#memberName').focus();
				} else {
					$('#memberName').attr('status', 'yes');
					$('#memberName').after("<span class='checkNameSpan' style='color:blue'>사용 가능한 닉네임입니다.</span>");
				}
			},
			error: function(xhr, status, error) {
				console.error("Error:", error);
				console.error("Name:", memberName);
				alert("닉네임 중복 확인 중 오류가 발생했습니다.");
			}
		});
	}
</script>
</body>
</html>