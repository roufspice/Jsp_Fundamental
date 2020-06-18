
<%@page import="kr.or.kpc.dto.CustomerDto"%>
<%@page import="kr.or.kpc.dao.CustomerDao"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");
	if(request.getMethod().equals("POST")){
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		
		CustomerDao dao = CustomerDao.getInstance();
		CustomerDto dto = new CustomerDto(email,pwd,name);
		int resultCount = dao.insert(dto);
		if(resultCount == 1){
			%>
			<script>
			alert('회원가입에 성공 했습니다.');
			location.href="login.jsp";
			</script>
			<%
		}else{
			%>
			<script>
			alert('에러...');
			history.back(-1);
			</script>
		<%}%>
	<%}else{ %>
	<script>
		alert('POST방식으로 요청해야 합니다.');
		location.href="join.jsp";
	</script>
	<%} %>



