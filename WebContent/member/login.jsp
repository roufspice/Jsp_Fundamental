<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
	<nav aria-label="breadcrumb ">
	  <ol class="breadcrumb justify-content-end">
	    <li class="breadcrumb-item "><a href="#">Home</a></li>
	    <li class="breadcrumb-item"><a href="#">Library</a></li>
	    <li class="breadcrumb-item active" aria-current="page">Data</li>
	  </ol>
	</nav>
	
    <div class="container">
    	<div class="row">
	        <div class="col-md-12"> 
	        
	        	<h5 class="card-title">로그인</h5>
	            <form name="f" method="post" action="checkLogin.jsp">
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
	                <input type="submit" id="loginMember" class="btn btn-primary" value="Login" />
	              </div>
	              
	            </form>
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
				email.focus();
				success = false
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
							success = true;
						}else{
							email.removeClass("is-valid");
							$("#errorEmail").text('이미 등록된 이메일 입니다.');
							email.addClass("is-invalid");
						}
					}
				});
				
			}else{
				$("#errorEmail").text('이메일 주소 형식이 맞지 않습니다.');
				email.addClass("is-invalid");
				email.focus();
				success = false;
			}
			if(!pwd.val()){
				pwd.addClass("is-invalid");
				$("#errorPwd").text('비밀번호를 입력하세요.');
				pwd.focus();
				success = false;
			}
			if(pwd.val().length >= 8 && pwd.val().length <=12){
				pwd.addClass("is-valid");
				success = true;
			}else{
				$("#errorPwd").text('비밀번호는 8-12자리 이어야 합니다.');
				pwd.addClass("is-invalid");
				pwd.focus();
				success = false;
			}
			
			if(!repwd.val()){
				repwd.addClass("is-invalid");
				$("#errorRePwd").text('비밀번호를 입력하세요.');
				repwd.focus();
				success = false;
			}
			
			if(pwd.val() != repwd.val()){
				repwd.addClass("is-invalid");
				$("#errorRePwd").text('비밀번호가 일치하지 않습니다.');
				repwd.focus();
				success = false;
			}else{
				repwd.addClass("is-valid");
				success = true;
			}
			
			/*
			if(success){
				f.submit();
			}
			*/
		});
		
		email.keyup(function(e){
			if(!email.val()){
				email.removeClass("is-invalid");
				email.removeClass("is-valid");
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
		repwd.blur(function(){
			if(pwd.val() != repwd.val()){
				repwd.addClass("is-invalid");
				$("#errorRePwd").text('비밀번호가 일치하지 않습니다.');
				repwd.focus();
				
			}else{
				repwd.addClass("is-valid");
				
			}
		});
		function validateEmail(email) {
			var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			return re.test(email);
		}
	});
</script>

    
    

<%@ include file="../inc/footer.jsp"%>