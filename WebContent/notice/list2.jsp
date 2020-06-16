<%@page import="kr.or.kpc.dto.NoticeDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.kpc.dao.NoticeDao"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>

	<nav aria-label="breadcrumb ">
	  <ol class="breadcrumb justify-content-end">
	    <li class="breadcrumb-item "><a href="#">홈</a></li>
	    <li class="breadcrumb-item active">공지사항</li>
	  </ol>
	</nav>
	
    <div class="container">
    	<div class="row">
	        <div class="col-md-12">
	        	<h3>공지사항 리스트</h3>
	        	<div class="table-responsive">
	        	<table class="table table-hover">
	        	  <colgroup>
	        	  	<col width = "10%"/>
	        	  	<col width = "15%"/>
	        	  	<col width = "60%"/>
	        	  	<col width = "15%"/>
	        	  </colgroup>
				  <thead>
				    <tr>
				      <th scope="col">번호</th>
				      <th scope="col">작성자</th>
				      <th scope="col">제목</th>
				      <th scope="col">등록날짜</th>
				    </tr>
				  </thead>
				  <tbody>
				  
				    
				    
				  </tbody>
				</table>
				
				<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
				    <li class="page-item disabled">
				      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
				    </li>
				    <li class="page-item"><a class="page-link" href="#">1</a></li>
				    <li class="page-item"><a class="page-link" href="#">2</a></li>
				    <li class="page-item"><a class="page-link" href="#">3</a></li>
				    <li class="page-item">
				      <a class="page-link" href="#">Next</a>
				    </li>
				  </ul>
				</nav>
				
				<div class="text-right"  style="margin-bottom : 20px;">
					<a href="write.jsp" class="btn btn-outline-danger">글쓰기</a>
				</div>
	        	
	        	</div>
	        </div>
        </div>
    </div>




<%@ include file="../inc/footer.jsp"%>