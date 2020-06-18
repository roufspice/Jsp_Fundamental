<%@page import="kr.or.kpc.dao.CustomerDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"%>

<%
	String email = request.getParameter("email");
	CustomerDao dao = CustomerDao.getInstance();
	boolean existed = dao.isExisted(email);
	
	if(existed){
		%>
		{"result" : "FAIL"}
		<%
	}else {
		%>
		{"result" : "OK"}
		
<%}%>
