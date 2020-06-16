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
	        	<h3>공지사항 작성</h3>
	        	<form method="post" name="f" action="save.jsp">
				  <div class="form-group">
				  <label for="writer">작성자</label>
				    <input type="text" class="form-control" id="writer" placeholder="작성자를 입력해주세요">
				    
				  </div>
				  <div class="form-group">
				  <label for="title">제목</label>
				    <input type="text" class="form-control" id="writer" placeholder="제목을 입력해주세요">
				    
				  </div>
				  
				  
				  <div class="form-group">
				    <label for="content">내용</label>
				    <textarea class="form-control" id="content" name="content" rows="10"></textarea>
				  </div>
				</form>
	        <div class="text-right"  style="margin-bottom : 20px;">
					<a href="list.jsp" class="btn btn-outline-danger">목록</a>
					<a href="#" class="btn btn-outline-danger">저장</a>
					
				</div>
	        </div>
			
        </div>
    </div>

<%@ include file="../inc/footer.jsp"%>