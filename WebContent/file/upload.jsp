<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" 
    pageEncoding="UTF-8"%>
  <%
  
  request.setCharacterEncoding("utf-8");
  String path = request.getRealPath("/upload/files");
 
  MultipartRequest mr = null;
  
  try{
	  mr = new MultipartRequest(
			  request,
			  path,		      //파일경로
			  10*1024*1024,  //파일크기
			  "utf-8",		//인코딩타입
			  //파일이름이 중복되었을때 파일명 끝에 1,2,3순으로 이름 변경해주는 클래스
			  new DefaultFileRenamePolicy()
			  
			  );
			  
  //MultipartRequest 객체가 생성되면 파일 업로드 완료
	  
  } catch(Exception e){
	  e.printStackTrace();
  }
  

  String name = request.getParameter("name");
  String fileName = mr.getFilesystemName("file"); 	   //업로드한 파일명이 있는경우, 시스템에있는 파일
  String uploadName = mr.getOriginalFileName("file");  //사용자가 올리는 파일 이름 두가지를 같이 DB화 시킨다.
  
  
  %>
  
  name: <%=name %><br>
  file system name :  <%= fileName %> <br>
  file origin name : <%=uploadName %>
