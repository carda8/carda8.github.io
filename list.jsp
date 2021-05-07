<%@page import="ch10web1.LoginDAO"%>
<%@page import="ch10web1.LoginDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginDAO dao = new LoginDAO();
	ArrayList<LoginDTO> dtos = dao.listLogin();
%>
    
<%
	//연결 정보와 SQL
	String url = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	String user = "SEUNGJUN";
	String passwd = "1111";
	//1. DB 연동 드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//2. 연결 객체 생성
	Connection con = DriverManager.getConnection(url, user, passwd);
	//3. 생성된 연결을 통해 SQL문 실행 의뢰 준비
	String sql = "SELECT * FROM LOGIN";
	Statement st = con.createStatement();
	
	//4. SQL 실행
	ResultSet rs = st.executeQuery(sql);
	
	//ResultSet 객체에 담겨진 레코드를 dto에 넣고 전체를 ArrayList에 저장
	
	while(rs.next()){
		LoginDTO dto = new LoginDTO(rs.getString("id"), rs.getString("name"), rs.getString("pwd"));
		dtos.add(dto);
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
	<br>
	<h1 class="text-center font-weight-bold">로그인 정보</h1>
	<br>
	<table class="table table-hover">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>비밀번호</th>
		</tr>
<% 
	//5. 결과집합 처리 
	for(LoginDTO dto: dtos){
	
%>	
		<tr>
			<td><a href="updateForm.jsp?id=<%=dto.getId() %>"><%=dto.getId() %></td>
			<td><%=dto.getName() %></td>
			<td><%=dto.getPwd() %></td>
		</tr>
<%} 
	//6. 연결 해제
	con.close();
	st.close();
	rs.close();
%>
	</table>
	</div>	
</body>
</html>