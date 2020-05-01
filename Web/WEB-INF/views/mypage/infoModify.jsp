<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
.size11 {
	height: 650px;
}

.size1 {
	height: 7rem;
	width: 7rem;
}
</style>
<%@ include file="../include/header.jsp"%>
<body id="page-top">

	<div id="wrapper">

		<%@ include file="../include/mypageNav.jsp"%>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../include/top.jsp"%>
				<div class="container-fluid size11">

					<div class="card shadow border-left-primary h-100 w-100 ">
						<div class="card-header">
							<div class="row  ">
								<div class="col-3 ">
									<h1 class="h3 text-gray-900 ">개인정보수정</h1>
								</div>


							</div>

						</div>

						<div class="cardbody ">
						<form action="/up/mypage/infoupdate.do" method="post" enctype="multipart/form-data" onsubmit="return validata();">
							<div class="row   py-5">
								<div
									class="col-2 d-flex align-items-center justify-content-end pl-2">
									<img class="img-profile size1 rounded-circle"
										src="https://source.unsplash.com/QAB-WJcbgJk/60x60">

								</div>
								
								<div class="col-3 justify-content-start align-self-end">
									<input type="file" name="profile"/>
									<span class="text-white bg-danger">${data.alertMsg}</span>
									<button class="btn btn-primary " type="submit">Change profile picture</button>
								</div>
								
							</div>

								<div class="row mb-4">
									<div class="col-2 ml-5 pl-5">
										<span class="text text-gray-900 mr-5 font-weight-bold">ID</span>
									</div>
									<div class="col-8 ml-0 pl-0">
										<span class="text text-gray-900 h5 ">wjdkdtn</span>
									</div>
								</div>

								<div class="row  mb-4">
									<div class="col-2 ml-5 pl-5">
										<span class="text text-gray-900 mr-5 font-weight-bold">TITLE
										</span>

									</div>
									<div class="col-2 ml-0 pl-0">
										<select class="custom-select" name="title">
											<c:forEach var="tList" items="${data.tList}"
												varStatus="status">
												<option class="text-white"
													style="background:${tList.TColor}">${tList.TName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="row  mb-4">
									<div class="col-2 ml-5 pl-5">
										<span class="text text-gray-900 mr-5 font-weight-bold">NAME
										</span>

									</div>
									<div class="col-2 ml-0 pl-0">
										<span class="text text-gray-900 mr-5">정상훈 </span>
									</div>
								</div>
								<div class="row  mb-2">
									<div class="col-2 ml-5 pl-5">
										<span class="text text-gray-900 mr-5 font-weight-bold">NICKNAME
										</span>

									</div>
									<div class="col-2 ml-0 pl-0">
										<div class="form-group ">
											<input type="text" id="inputNickName"
												class="form-control form-control-user" name="nick"
												value="huni" placeholder="Enter a nickname to change" />
										</div>
									</div>
								</div>

								<div class="row  mb-4">
									<div class="col-2 ml-5 pl-5">
										<span class="text text-gray-900 mr-5 font-weight-bold">EMAIL
										</span>

									</div>
									<div class="col-3 ml-0 pl-0">
										<div class="form-group ">
											<!-- <input type="email" class="form-control form-control-user"
												id="exampleInputEmail" value="wjdkdtn7233@naver.com"
												placeholder="Enter email to change"
												aria-describedby="emailHelp" name="email"> -->
											<span class="text text-gray-900 mr-5">wjdkdtn7233@naver.com
											</span>
										</div>
									</div>
									<div class="col-5 ml-3">
										<span class="bg-gradient-danger text-white" id="infoNick"></span>
									</div>
								</div>
								<div class="row  mb-4">
									<div class="col-4 ml-5 pl-5">
										<button class="btn btn-success btn-icon-split" type="submit">
											<span class="icon text-white-50"> <i
												class="fas fa-check"></i>
											</span> <span class="text">Information Modified Completed</span>
										</button>
									</div>
								</div>
							</form>

						</div>

					</div>





				</div>


			</div>
			<%@ include file="../include/footer.jsp"%>
			<a class="scroll-to-top rounded" href="#page-top"> <i
				class="fas fa-angle-up"></i>
			</a>
		</div>

	</div>
	<%@ include file="../include/jsRoot.jsp"%>
	<script src="https://code.jquery.com/jquery-3.5.0.js"
		integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc="
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		function validata() {
			//?=.* 어느자리에 있든? 
			var nick = $('#inputNickName');
			var email = $('#exampleInputEmail');
			//닉네임 검사
			var regExpNick = /^(?=.*\d{1,15})(?=.*[가-힣a-zA-Z]{1,15}).{3,15}$/;
			//닉네임에 특수문자가 있는지 검사
			var regExpNick2 = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;

			$('#inputNickName').on('click', function() {
				$('#infoNick').html("");
			});

			function chk(re, e, msg) {

				if (re.test(e.val())) {

					return true;
				} else {
					$('#infoNick').html("<i class='fas fa-exclamation-triangle'></i>" + msg);
					e.value = "";
					e.focus();
					return false;
				}
			}

			//닉네임 특수문자 검사
			if (chk(regExpNick2, nick, "")) {
				$('#infoNick').html("<i class='fas fa-exclamation-triangle'></i>" +"닉네임에 특수문자를 포함시킬 수 없습니다.");
				return false;
			}

			//닉네임 검사
			if (!chk(regExpNick, nick,
					"닉네임은 영문/한글 과 숫자를 포함하여 3자 에서 15자 이내로 기입해주세요.")) {
				return false;
			}

			return true;
		}
	</script>

</body>
</html>