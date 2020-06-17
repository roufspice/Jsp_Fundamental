<%@page import="kr.or.kpc.dao.NoticeDao2"%>
<%@page import="kr.or.kpc.dto.NoticeDto"%>
<%@page import="kr.or.kpc.dao.NoticeDao"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	int cPage = Integer.parseInt(request.getParameter("page"));
	
	NoticeDao2 dao = NoticeDao2.getInstance();
	
	int resultCount = dao.delete(num);
	if(resultCount == 1){
		%>
		<script>
			alert('글이 삭제 되었습니다.');
			location.href="list.jsp?page=<%=cPage%>";
		</script>
		<%
	}else{
		%>
		<script>
			alert('에러..');
			history.back(-1);
		</script>
		<%
	}
%>







