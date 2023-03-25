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
			
			Statement stmt = conn.createStatement();
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String employeeType = request.getParameter("employeeType");
			String query = "";
			boolean endUser = false;
			//String query = "SELECT * FROM User u, EndUser eu WHERE username = ? and password = ? AND u.userId = eu.userId " ;
			
			if(employeeType != null)  {
				if(employeeType.equalsIgnoreCase(BuyMeConstants.ADMIN)) {
					query = BuyMeConstants.ADMIN_USER_LOOKUP;
					 
				} else if(employeeType.equalsIgnoreCase(BuyMeConstants.CUSTOMER_REP)) {
					query = BuyMeConstants.CUST_REP_USER_LOOKUP;
				}
			} else {
				endUser = true;
				query = BuyMeConstants.END_USER_LOOKUP;
			}
			
			
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, password);
			
			System.out.println(preparedStatement);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			
			
			if(rs.next()) {
				user = new UserBean();
				System.out.println("Logged in !!!");
				System.out.println(rs.getString("name"));
				
				user.setName(rs.getString("name"));
				
				if(endUser) user.setRating(Double.parseDouble(rs.getString("rating")));
				
				user.setUserId(rs.getInt("userId"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setLocation(rs.getString("location"));
				
				session.setAttribute("user", user);
				%>
				<jsp:forward page="UserHome.jsp">
					<jsp:param name="user" value="<%=user%>"/> 
				</jsp:forward>
				<% 
			} else {
				System.out.println("Login Failed !!!");
				if(endUser) {
				%>
				<jsp:forward page="Login.jsp">
					<jsp:param name="loginFailed" value="true"/>
				</jsp:forward>			
				<% } else {
					%>  
					<jsp:forward page="EmployeeLogin.jsp">
						<jsp:param name="loginFailed" value="true"/>
					</jsp:forward>	
			<% 	}
			}
			
		%>
	</body>
</html>
