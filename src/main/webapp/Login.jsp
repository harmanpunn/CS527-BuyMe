<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
	</head>
	<body>
		<h1>Welcome to BuyMe</h1>
		<h2>Login to your account</h2>
		<form method="post" action="verifyLogin.jsp">
			<table>
				<tr>    
					<td>Email</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Login">
		</form>
	</body>
</html>
