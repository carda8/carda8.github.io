<%@page import="ch10web1.LoginDAO"%>
<%@page import="ch10web1.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.sql.*" %>
<%	request.setCharacterEncoding("utf-8");
	


	LoginDTO dto = new LoginDTO(request.getParameter("id"), 
			request.getParameter("name"), request.getParameter("pwd"));
	
	
	LoginDAO dao = new LoginDAO();
	dao.insertLogin(dto);
	response.sendRedirect("list.jsp");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	
</body>
</html>