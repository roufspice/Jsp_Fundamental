<%@page import="kr.or.kpc.dao.NoticeDao2"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
NoticeDao2 dao = NoticeDao2.getInstance(); //객체의 싱글턴패턴
String json = dao.selectJson(0,20);
out.print(json);



%>