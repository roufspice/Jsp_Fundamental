<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//두가지 클래스! 사용
	
	JSONObject obj = new JSONObject();	//최종 완성될 JSONObject 선언(전체)
	JSONArray array = new JSONArray(); // JSON정보를 담을 Array 선언
	
	JSONObject obj1 = new JSONObject();
	obj1.put("no", "1");
	obj1.put("storeName", "홈플러스1");
	array.add(obj1);
	
	JSONObject obj2 = new JSONObject();
	obj2.put("no", "2");
	obj2.put("storeName", "홈플러스2");
	array.add(obj2);
	
	JSONObject obj3 = new JSONObject();
	obj3.put("no", "3");
	obj3.put("storeName", "홈플러스3");
	array.add(obj3);
	
	JSONObject obj4 = new JSONObject();
	obj4.put("no", "4");
	obj4.put("storeName", "홈플러스4");
	array.add(obj4);
	
	
	obj.put("items", array);
	
	//JSONObject를 String 객체에 할당
	String jsonInfo = obj.toJSONString();
	out.print(jsonInfo);
	
	
	
	
	
	

%>