<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.constants.BuyMeConstants" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>

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
			
			int userId = -1;
			boolean userExists = false;
			String message = "";
			String misMatch = "";
			boolean passwordMisMatch = false;
			
			String name = request.getParameter("name");
			String location = request.getParameter("location");
			String email = request.getParameter("email");
			String username = request.getParameter("username");
			String passwordString = request.getParameter("password");
			String confirmpasswordString = request.getParameter("confirmPassword");
			String password = BuyMeUtils.encryptPassword(passwordString);
			
			
			
		   
		    if (passwordString.equals(confirmpasswordString)) {
		        // Passwords match, do something
		    
		
			
			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM User WHERE username = ? OR email = ?");
			ps1.setString(1, username);
			ps1.setString(2, email);
			
			ResultSet resultSet = ps1.executeQuery();
			if (resultSet.next()) {
				userExists = true;
			}
			ps1.close();
			
			if (userExists) {
				message = "Username or email already exists. Please try to login to your account.";
				%>
				<jsp:forward page="Register.jsp">
					<jsp:param name="userExists" value="<%=userExists%>"/>
					<jsp:param name="message" value="<%=message%>"/> 
				</jsp:forward>
				<% 		
			} else {
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
				message = "Registration is successful";
				
				
				UserBean user = new UserBean();
				user.setUserId(userId);
				user.setName(name);
				user.setUsername(username);
				user.setPassword(password);
				user.setEmail(email);
				user.setLocation(location);
				session.setAttribute("user", user);
				%>
				<jsp:forward page="UserHome.jsp">
					<jsp:param name="user" value="<%=user%>"/> 
				</jsp:forward>
				<% 
			}
		    }
		    
		    else {
		        // Passwords do not match, display an error message
		       passwordMisMatch =true;
		       misMatch = "Password and Confirm Password fields should match.";
		        %>
				<jsp:forward page="Register.jsp">
					<jsp:param name="passwordMisMatch" value="<%=passwordMisMatch%>"/>
					<jsp:param name="misMatch" value="<%=misMatch%>"/> 
				</jsp:forward>
				<% 	 
		    }
		    
			conn.close();
			
			
			
		%>
	</body>
</html>

	