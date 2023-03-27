<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application | User Home Page</title>
		<link href="assets/css/global.css" rel="stylesheet"/>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	</head>
	<body>
		<%
			UserBean user = (UserBean)session.getAttribute("user");
			if(user == null ) {
				response.sendRedirect(request.getContextPath() + "/Login.jsp");
		} else { %>
			<div class="user-container">		
				<h2>Welcome ${user.name} </h2>
				<a class="btn btn-primary " href="Logout.jsp">Logout</a>
			</div>
		<% } %>
	</body>
</html>