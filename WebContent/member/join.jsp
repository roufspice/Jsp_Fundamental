<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
	<nav aria-label="breadcrumb ">
	  <ol class="breadcrumb justify-content-end">
	    <li class="breadcrumb-item "><a href="#">홈</a></li>
	    <li class="breadcrumb-item active">회원가입</li>
	  </ol>
	</nav>
	
    <div class="container">
    	<div class="row">
	        <div class="col-md-12">
	        	<h3>회원가입</h3>
	        	<form method="post" name="f" action="save.jsp">
				  <div class="form-group">
	                <input type="text" class="form-control" id="email" name="email" placeholder="Your Email *" value="" />
	              	<div class="invalid-feedback" id="errorEmail">
				       이메일을 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
	              <div class="form-group">
	                <input type="password" class="form-control" id="pwd" name="pwd"  placeholder="Your Password *" value="" />
	              	<div class="invalid-feedback" id="errorPwd">
				    	비밀번호를 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
	              <div class="form-group">
	                <input type="password" class="form-control" id="repwd" name="repwd"  placeholder="Your Re-Password *" value="" />
	              	<div class="invalid-feedback" id="errorRePwd">
				    	비밀번호를 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
	              <div class="form-group">
	                <input type="text" class="form-control" id="name" name="name" placeholder="Your Name *" value="" />
	              	<div class="invalid-feedback" id="errorName">
				       이름을 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
				</form>
				<div class="text-right" style="margin-bottom : 20px;">
					<a href="" id="saveCustomer" class="btn btn-outline-danger">회원가입</a>
					<a href="login.jsp" class="btn btn-outline-success">로그인</a>
				</div>
	        </div>
        </div>
    </div>
	<script>
	$(function(){
		const email = $("#email");
		const pwd = $("#pwd");
		const repwd = $("#repwd");
		const name = $("#name");
		let success = false;
		$("#saveCustomer").click(function(e){
			e.preventDefault();
			if(!email.val()){
				$("#errorEmail").text('이메일을 입력하세요.');
				email.addClass("is-invalid");
			}else{
				if(validateEmail(email.val())){
					$.ajax({
						type : 'get',
						url : 'check_email_ajax.jsp?email='+email.val(),
						dataType : 'json',
						erorr : function(){
							console.log('error');
						},
						success : function(json){
							if(json.result=="ok"){
								email.removeClass("is-invalid");
								email.addClass("is-valid");
								success = true;
							}else{
								email.removeClass("is-valid");
								$("#errorEmail").text('이미 등록된 이메일 입니다.');
								email.addClass("is-invalid");
								email.focus();
								return;
							}
						}
					});
					
				}else{
					$("#errorEmail").text('이메일 주소 형식이 맞지 않습니다.');
					email.addClass("is-invalid");
					email.focus();
					return;
				}
			}
			if(!pwd.val()){
				pwd.addClass("is-invalid");
				$("#errorPwd").text('비밀번호를 입력하세요.');
			}else{
				if(pwd.val().length >= 8 && pwd.val().length <=12){
					pwd.addClass("is-valid");
					success = true;
				}else{
					$("#errorPwd").text('비밀번호는 8-12자리 이어야 합니다.');
					pwd.addClass("is-invalid");
					pwd.focus();
					return;
				}
			}
			
			if(!repwd.val()){
				repwd.addClass("is-invalid");
				$("#errorRePwd").text('비밀번호를 입력하세요.');
			}else{
				if(pwd.val() != repwd.val()){
					repwd.addClass("is-invalid");
					$("#errorRePwd").text('비밀번호가 일치하지 않습니다.');
					repwd.focus();
					return;
				}else{
					repwd.addClass("is-valid");
					success = true;
				}
			}
			
			if(!name.val()){
				name.removeClass("is-valid");
				name.addClass("is-invalid");
				$("#errorName").text('이름을 입력하세요.');
			}else{
				name.removeClass("is-invalid");
				name.addClass("is-valid");
				success = true;
			}
			
			if(!email.val()){
				email.focus();
				return;
			}
			if(!pwd.val()){
				pwd.focus();
				return;
			}
			if(!repwd.val()){
				repwd.focus();
				return;
			}
			if(!name.val()){
				name.focus();
				return;
			}
			
			if(success){
				f.submit();
			}
		
			
		});
		
		email.keyup(function(e){
			if(!email.val()){
				email.removeClass("is-invalid");
				email.removeClass("is-valid");
				success = false;
				return;
			}
			if(validateEmail(email.val())){
				$.ajax({
					type : 'get',
					url : 'check_email_ajax.jsp?email='+email.val(),
					dataType : 'json',
					erorr : function(){
						console.log('error');
					},
					success : function(json){
						if(json.result=="ok"){
							email.removeClass("is-invalid");
							email.addClass("is-valid");
						}else{
							email.removeClass("is-valid");
							$("#errorEmail").text('이미 등록된 이메일 입니다.');
							email.addClass("is-invalid");
						}
					}
				});
			
			}else{
				email.removeClass("is-valid");
				$("#errorEmail").text('이메일 주소 형식이 맞지 않습니다.');
				email.addClass("is-invalid");
			}
		});
		pwd.keyup(function(e){
			pwd.removeClass("is-invalid");
			if(!pwd.val()){
				pwd.removeClass("is-invalid");
				pwd.removeClass("is-valid");
				return;
			}
			if(pwd.val().length >= 8 && pwd.val().length <=12){
				pwd.addClass("is-valid");
			}else{
				pwd.removeClass("is-valid");
				$("#errorPwd").text('비밀번호는 8-12자리 이어야 합니다.');
				pwd.addClass("is-invalid");
			}
			
		});
		repwd.blur(function(){//커서가 나갈때 발생하는 이벤트
			if(!repwd.val()){
				repwd.removeClass("is-valid");
				$("#errorRePwd").text('비밀번호를 입력하세요.');
				repwd.addClass("is-invalid");
				return;
			}
			if(pwd.val() != repwd.val()){
				repwd.removeClass('is-valid');
				repwd.addClass("is-invalid");
				$("#errorRePwd").text('비밀번호가 일치하지 않습니다.');
				
			}else{
				repwd.removeClass("is-invalid");
				repwd.addClass("is-valid");
			}
		});
		name.blur(function(){//커서가 나갈때 발생하는 이벤트
			if(!name.val()){
				name.removeClass("is-valid");
				$("#errorRePwd").text('이름을 입력하세요.');
				name.addClass("is-invalid");
				return;
			}else{
				name.removeClass("is-invalid");
				name.addClass("is-valid");
			}
			
		});
		function validateEmail(email) {
			var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			return re.test(email);
		}
	});
	</script>
<%@ include file="../inc/footer.jsp"%>

