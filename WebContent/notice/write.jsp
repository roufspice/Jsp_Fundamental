<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
	
	<%
	int displayCount =5;
	int displayPageCount= 3;
	String tempPage = request.getParameter("page");
	int cPage = 0;
	if(tempPage == null || tempPage.length()==0){
		cPage = 1;
	}
	
	try {
		cPage = Integer.parseInt(tempPage);
	}catch(NumberFormatException e){
		cPage = 1;
	}
	
	

	%>
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
					<a href="list.jsp?page=<%=cPage %>" class="btn btn-outline-danger" id="saveNotice">저장</a>
					
				</div>
	        </div>
			
        </div>
    </div>
    <script>
    	$(function(){
    		$("#saveNotice").click(function(e){
    			//a 기능은 href 속성에 있는 주소로 이동하는데 이런기능을 제거한다는 의미이다.
    			e.preventDefault(); //원래있는 기능을 없애는 메소드
    			let writer = $("#writer").val();
    			let title = $("#writer").val();
    			let content = $("#writer").val();
    			//falcy value 
    			if(!writer){
    				alert('작성자를 입력해주세요');
    				$("#writer").focus(); //마우스커서를 가져다주는 메소드 :.focus();
    				return;
    			}
    			if(!title){
    				alert('제목을입력해주세요');
    				$("#title").focus(); //마우스커서를 가져다주는 메소드 :.focus();
    				return;
    			}
    			if(!content){
    				alert('내용을 입력해주세요');
    				$("#content").focus(); //마우스커서를 가져다주는 메소드 :.focus();
    				return;
    			}
    			
    			f.submit();
    				
    			}
    		});
    	})
    </script>

<%@ include file="../inc/footer.jsp"%>