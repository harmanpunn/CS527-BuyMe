<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
		<link href="assets/css/global.css" rel="stylesheet"/>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	</head>
	<body>
		<div class="container">
			<h1>Welcome to BuyMe</h1>
			<h3>Login to your account</h3>
			<form class="login" method="post" action="verifyLogin.jsp">
				<table class="login-table">
					<tr>    
						<td>Username</td><td><input type="text" name="username" required></td>
					</tr>
					<tr>
						<td>Password</td><td><input type="password" name="password" required></td>
					</tr>
					<tr>
						<td><input class="btn btn-primary" type="submit" value="Login"></td>
					</tr>
					<tr>
						<td>Create an account with us </td>
						<td><a class="btn btn-primary" href="Register.jsp">Sign up</a></td>
					</tr>
					<tr>
						<td>Employee?</td>
						<td><a class="btn btn-primary" href="EmployeeLogin.jsp">Click Here</a></td>
					</tr>
					
				</table>
				
				
		</form>
		</div>
	</body>
</html>
