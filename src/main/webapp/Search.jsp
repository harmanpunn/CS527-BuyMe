<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>


<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application | Search Results</title>
		<link href="assets/css/global.css" rel="stylesheet"/>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	</head>
	<body>
			<%
			
			UserBean user = (UserBean)session.getAttribute("user");
			if(user == null ) {
				response.sendRedirect(request.getContextPath() + "/Login.jsp");
			} else {	
			
			String query = request.getParameter("query");
			if(query == null || query.trim().length() == 0) {
				response.sendRedirect(request.getContextPath() + "/UserHome.jsp");
			} else {
				// Connect to the database
				Connection con = null;
				Statement stmt = null;
				ResultSet rs = null;
				
				try {
					
					ApplicationDB database = new ApplicationDB();
					con = database.getConnection();
					stmt = con.createStatement();
					
					// Execute the search query
					String sql = "SELECT * FROM Item WHERE name LIKE '%" + query + "%' OR description LIKE '%" + query + "%' OR subcategory LIKE '%" + query + "%'";
					rs = stmt.executeQuery(sql);
					
					// Display the search results
					%>
					<jsp:include page="Navbar.jsp">
					    <jsp:param name="username" value="${user.name}" />
					</jsp:include>
					<div class="container mt-5">
						<h2 class="mb-3">Search Results for: <%= query %></h2>
						
						<% if(rs.next()) { %>
						
						<div class="row">
							<% do { %>
							
							<div class="col-md-4 mb-3">
								<div class="card">
									<div class="card-body">
										<h5 class="card-title"><%= rs.getString("name") %></h5>
										<p class="card-text"><%= rs.getString("description") %></p>
										<p class="card-text">Price: <%= rs.getDouble("initialprice") %></p>
										<a href="Item.jsp?itemId=<%= rs.getString("itemId") %>" class="btn btn-primary">Bid Now</a>
									</div>
								</div>
							</div>
							
							<% } while(rs.next()); %>
						</div>
						
						<% } else { %>
						
						<p>No results found.</p>
						
						<% } %>
					</div>
					
					<%
				} catch(SQLException e) {
					e.printStackTrace();
				} finally {
					con.close();
					stmt.close();
				
				}
			}
			}
		%>
	</body>
</html>
	
