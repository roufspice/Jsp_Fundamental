<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
<%
	if(customerDto == null){
		response.sendRedirect("/member/login.jsp");
		return;
	}
	String email = customerDto.getEmail();
%>
	<nav aria-label="breadcrumb ">
	  <ol class="breadcrumb justify-content-end">
	    <li class="breadcrumb-item "><a href="#">홈</a></li>
	    <li class="breadcrumb-item active">회원정보확인</li>
	  </ol>
	</nav>
	
    <div class="container">
    	<div class="row">
	        <div class="col-md-12">
	        	<h3>회원정보확인</h3>
	        	<form method="post" name="f" action="save.jsp">
				  <div class="form-group">
	                <input type="text" class="form-control" id="email" name="email" 
	                	placeholder="Your Email *" value="<%=email %>" readonly/>
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
				</form>
				<div class="text-right" style="margin-bottom : 20px;">
					<a href="" id="checkPwd" class="btn btn-outline-danger">확인</a>
					<a href="" class="btn btn-outline-success">취소</a>
				</div>
				
	        </div>
        </div>
    </div>
	<script>
	$(function(){
		const pwd = $("#pwd");
		$("#checkPwd").click(function(e){
			e.preventDefault();
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
			
			if(!pwd.val()){
				pwd.focus();
				return;
			}
			
			if(success){
				f.submit();
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
		
	});
	</script>
<%@ include file="../inc/footer.jsp"%>




