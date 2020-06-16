<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.kpc.dao.MemberDao"%>
<%@page import="kr.or.kpc.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>script Element</title>
</head>
<body>
	<%!   //메소드 선언 가능!
		private String name;
		public int plus(int a, int b){
			return a+b;
		}
		
		
	%>
	
	
	<%
		int result = plus(10,20);
		out.println(result);
		
	

	
	
	%>
	<%= result %>
	
	<% 
		MemberDto dto = new MemberDto(1,"성영한","서울");
	
	%>
	<%=dto.getName() %>, <%= dto.getNum() %>, <%=dto.getAddr() %> <br>
	
	<%
		MemberDao dao = MemberDao.getInstance();
		ArrayList<MemberDto> list = dao.select();
		
	
	%>
	<table>
		<tr>
			<th>번호</th><th>이름</th><th>주소</th>
		</tr>
		<%for (MemberDto memberDto : list){%>
			<tr>
				<td><%=memberDto.getNum() %></td>
				<td><%=memberDto.getName() %></td>
				<td><%=memberDto.getAddr() %></td>
			</tr>
				
		<%} %>	
		
	</table>
	
	


</body>
</html>