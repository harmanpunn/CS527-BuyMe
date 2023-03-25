<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.constants.BuyMeConstants" %>


<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
	</head>
	<body>
		<%
		
			UserBean user = null;
			ApplicationDB database = new ApplicationDB();
			Connection conn = database.getConnection();
			
			int userId = -1;
			String name = request.getParameter("name");
			String location = request.getParameter("location");
			String email = request.getParameter("email");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String query = "INSERT INTO User (name, location, username, email, password) VALUES (?, ?, ?, ?, ?)";
			
			PreparedStatement preparedStatement = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, name);
			preparedStatement.setString(2, location);
			preparedStatement.setString(3, username);
			preparedStatement.setString(4, email);
			preparedStatement.setString(5, password);
			preparedStatement.executeUpdate();
			
			ResultSet rs = preparedStatement.getGeneratedKeys();
			while (rs.next()) {
		         userId = Integer.parseInt(rs.getString(1));
	      	}
			
			preparedStatement.close();
			
			String query2 = "INSERT INTO EndUser (userId) VALUES (?)";
			
			PreparedStatement ps2 =  conn.prepareStatement(query2);
			ps2.setInt(1, userId);
			ps2.executeUpdate();
			ps2.close();
			
			conn.close();
			
		%>
	</body>
</html>

	