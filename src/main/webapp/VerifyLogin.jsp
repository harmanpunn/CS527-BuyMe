<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>


<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
	</head>
	<body>
		<%
			ApplicationDB database = new ApplicationDB();
			Connection conn = database.getConnection();
			
			Statement stmt = conn.createStatement();
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String query = "SELECT * FROM USER WHERE username = ? and password = ?";
			
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, password);
			
			System.out.println(preparedStatement);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			System.out.println(rs);
			
			if(rs.next()) {
				System.out.println("Logged in !!!");
				session.setAttribute("username", username);
			} else {
				System.out.println("Login Failed !!!");
			}
			
		%>
	</body>
</html>
