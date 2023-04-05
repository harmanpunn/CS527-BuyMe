<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.Item" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application | Item Page</title>
		<link href="assets/css/global.css" rel="stylesheet"/>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	</head>
	<body>
		<%
			UserBean user = (UserBean)session.getAttribute("user");
			if(user == null ) {
				response.sendRedirect(request.getContextPath() + "/Login.jsp");
			} else {
				// Get the item ID from the query parameter
				String itemId = request.getParameter("itemId");
				if(itemId == null || itemId.trim().length() == 0) {
					response.sendRedirect(request.getContextPath() + "/UserHome.jsp");
				} else {
					// Connect to the database
					Connection con = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;
					
					try {
						ApplicationDB database = new ApplicationDB();
						con = database.getConnection();
						
						// Execute the query to retrieve the item details
						String sql = "SELECT * FROM Item WHERE itemId=?";
						stmt = con.prepareStatement(sql);
						stmt.setString(1, itemId);
						rs = stmt.executeQuery();
						
						// Retrieve the item details from the result set
						Item item = null;
						if(rs.next()) {
							item = new Item(
									rs.getInt("userId"),
									rs.getString("itemId"),
									rs.getString("name"),
									rs.getString("description"),
									rs.getString("subcategory"),
									rs.getDouble("initialprice"),
									rs.getTimestamp("closingtime"),
									rs.getDouble("bidincrement"),
									rs.getDouble("minprice")
							);
						}
						
						%>
						<jsp:include page="Navbar.jsp">
						    <jsp:param name="username" value="${user.name}" />
						</jsp:include>
						<div class="container mt-5">
							<h2><%= item.getName() %></h2>
							<p><%= item.getDescription() %></p>
							<p>Price: <%= item.getInitialPrice() %></p>
							
							<form method="post" action="PlaceBid.jsp">
								<input type="hidden" name="itemId" value="<%= item.getItemId() %>">
								
								<div class="form-group">
									<label for="bidPrice">Bid Price:</label>
									<input type="number" name="bidPrice" id="bidPrice" class="form-control" min="<%= item.getInitialPrice() %>" step="<%= item.getBidIncrement() %>" required>
								</div>
								
								<div class="form-group">
									<button type="submit" class="btn btn-primary">Place Bid</button>
								</div>
							</form>
							
						</div>
						
						<%
					} catch(SQLException e) {
						e.printStackTrace();
					} finally {
						stmt.close();
						con.close();
					} }	}%>

					</body>
</html>