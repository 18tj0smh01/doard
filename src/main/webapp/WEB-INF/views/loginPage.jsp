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
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="indexPage.jsp">JSP 게시판 웹 사이트</a>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<div class="login-box">
				<form method="post" name="login" action="${pageContext.request.contextPath}/login">
					<div class="form-group">
						<input type="text" class="form-control"  value="${memberVO.memberId}" placeholder="아이디" name="memberId" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control"  value="${memberVO.memberPassword}" placeholder="비밀번호" name="memberPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
					<div>
						<button onclick="goToSignup()" >회원가입</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../../resources/js/bootstrap.js"></script>
<script>
	function goToSignup() {
		const signup = "/signUp";
		window.location.href = signup;
	}
</script>
</body>
</html>