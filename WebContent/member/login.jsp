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
		$("#loginMember").click(function(e){
			e.preventDefault();
			if(!email.val()){
				email.addClass("is-invalid");
				email.focus();
				return;
			}
			if(validateEmail(email.val())){
				email.addClass("is-valid");
			}else{
				$("#errorEmail").text('이메일 주소 형식이 맞지 않습니다.');
				email.addClass("is-invalid");
				email.focus();
				return;
			}
			if(!pwd.val()){
				pwd.addClass("is-invalid");
				pwd.focus();
				return;
			}
			if(pwd.val().length >= 8 && pwd.val().length <=12){
				pwd.addClass("is-valid");
			}else{
				$("#errorPwd").text('비밀번호는 8-12자리 이어야 합니다.');
				pwd.addClass("is-invalid");
				pwd.focus();
				return;
			}
			f.submit();
		});
		
		email.keyup(function(e){
			email.removeClass("is-invalid");
			if(!email.val()){
				email.removeClass("is-invalid");
				email.removeClass("is-valid");
				return;
			}
			if(validateEmail(email.val())){
				email.addClass("is-valid");
			}else{
				$("#errorEmail").text('이메일 주소 형식이 맞지 않습니다.');
				email.addClass("is-invalid");
				return;
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
				$("#errorPwd").text('비밀번호는 8-12자리 이어야 합니다.');
				pwd.addClass("is-invalid");
			}
			
		});
		function validateEmail(email) {
			var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			return re.test(email);
		}
	});
</script>

    
    

<%@ include file="../inc/footer.jsp"%>