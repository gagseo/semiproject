<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>EMAIL CHECK</title>

<!-- Custom fonts for this template-->
<link href="/up/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/up/resources/css/sb-admin-2.min.css" rel="stylesheet">


<style>
#logo>img {
	width: 8%;
	height: 8%;
	padding-bottom: 5%;
}
</style>
</head>
<body class="bg-gradient-primary">
	<div class="container">
		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-2"></div>
							<div class="col-lg-8">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-2">이메일을 확인해주세요</h1>
										<p class="mb-4">회원 가입을 위해 확인 메일이 발송되었습니다.</p>
										<p class="mb-4">수신 메일의 링크를 클릭하면 회원가입이 완료됩니다. 메일이 도착하지 않았다면
											이메일 주소를 확인하거나 다시 한 번 발송 버튼을 클릭해주세요.</p>
									</div>
									<form class="user"
										action="<%=request.getContextPath()%>/member/emailcheck.do"
										method="post">
										<div class="form-group">
											<input type="email" class="form-control form-control-user"
												id="userEmail" name="userEmail"
												value="<%=request.getParameter("userEmail")%>"
												aria-describedby="emailHelp"
												placeholder=<%=request.getParameter("userEmail")%>>
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control form-control-user"
												id="userId" name="userId"
												value="<%=request.getParameter("userId")%>">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control form-control-user"
												id="userPwd" name="userPwd"
												value="<%=request.getParameter("userPwd")%>">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control form-control-user"
												id="userName" name="userName"
												value="<%=request.getParameter("userName")%>">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control form-control-user"
												id="userNickName" name="userNickName"
												value="<%=request.getParameter("userNickName")%>">
										</div>
										<button type="submit"
											class="btn btn-primary btn-user btn-block">메일 보내기</button>
									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="register.do">회원가입</a>
									</div>
									<div class="text-center">
										<a class="small" href="login.do">이미 회원가입을 하셨나요?</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>
	<div class="text-center" id="logo">
		<img src="/up/resources/img/upLogo.png" />
	</div>
	<%@include file="../include/footer.jsp"%>

	<!-- Bootstrap core JavaScript-->
	<script src="/up/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/up/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/up/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/up/resources/js/sb-admin-2.min.js"></script>


</body>
</html>