
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    /*
    {
    	items:[
   		{"no":1,"storeName":"강남스토어1"},
   		{"no":2,"storeName":"강남스토어2"},
   		{"no":3,"storeName":"강남스토어3"}
   			       
   	 ]
    }
    
    */
    
    
    
    //JSON 파일을 만드려면 두가지 클래스만 알면 된다.! 
    //1. JSON 생성하는 파일
    JSONObject obj = new JSONObject();
  
    //2. JSON 배열을 생성하는 파일 (기본 공공데이터 형식에서 볼수 있는 형태)
    JSONArray array = new JSONArray();
    
    JSONObject obj1 = new JSONObject();
    obj1.put("no",1);
    obj1.put("storeName","강남스토어1");
    
    JSONObject obj2 = new JSONObject();
    obj2.put("no",2);
    obj2.put("storeName","강남스토어2");
    
    JSONObject obj3 = new JSONObject();
    obj3.put("no",3);
    obj3.put("storeName","강남스토어2");
    
    array.add(obj1);
    array.add(obj2);
    array.add(obj3);
    
    obj.put("items",array);
    
    out.print(obj.toJSONString());
    
    //toJSONString() :JAVA 객체를 JSON문자열로 변환해줍니다.
    
    
    
    
    
    
    
    %>