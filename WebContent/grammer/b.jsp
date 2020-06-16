<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<%	//자바언어
		request.setCharacterEncoding("utf-8");	//한글로 인코딩하고 시작하기!
		String id =request.getParameter("id");	
		String num = request.getParameter("num");
		String name = request.getParameter("name");
		String text = "안녕하세요";
		
	%>
	id: <%=id %>, num: <%=num %>, name:<%=name %>

</body>
</html>