<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<%
	UserBean user = (UserBean)session.getAttribute("user");
	Set<String> userInterests = new HashSet<>();
	if(user == null ) {
		response.sendRedirect(request.getContextPath() + "/Login.jsp");
	} else { 
	    
	
	    if (request.getMethod().equals("POST")) {
	        String[] interests = request.getParameterValues("interests");
	        int userId = user.getUserId();
	
	        try {
	            ApplicationDB database = new ApplicationDB();
	            Connection conn = database.getConnection();
	
	            // Delete existing interests for the user
	            String deleteQuery = "DELETE FROM UserInterests WHERE userId = ?";
	            PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
	            deleteStmt.setInt(1, userId);
	            deleteStmt.executeUpdate();
	
	            // Insert new interests
	            String insertQuery = "INSERT INTO UserInterests (userId, interest) VALUES (?, ?)";
	            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
	
	            for (String interest : interests) {
	                insertStmt.setInt(1, userId);
	                insertStmt.setString(2, interest);
	                insertStmt.addBatch();
	            }
	            insertStmt.executeBatch();
	
	            conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	
	    // Load user interests
	    int userId = user.getUserId();
	    PreparedStatement interestsStmt = null;
	    ResultSet interestsRs = null;
	    try {
	        ApplicationDB database = new ApplicationDB();
	        Connection con = database.getConnection();
	        String interestsQuery = "SELECT interest FROM UserInterests WHERE userId = ?";
	        interestsStmt = con.prepareStatement(interestsQuery);
	        interestsStmt.setInt(1, userId);
	        interestsRs = interestsStmt.executeQuery();
	        while (interestsRs.next()) {
	            userInterests.add(interestsRs.getString("interest"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (interestsRs != null) {
	            interestsRs.close();
	        }
	        if (interestsStmt != null) {
	            interestsStmt.close();
	        }
	    }
	 }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
	<jsp:include page="Navbar.jsp">
		<jsp:param name="username" value="${user.name}" />
	</jsp:include>
    <div class="container mt-5">
        <h3>Manage Interests</h3>
        <form id="interestForm" method="POST" action="Account.jsp">
            <div class="mb-3">
                <label for="interests" class="form-label">Select Interests</label>
                <select multiple class="form-select" id="interests" name="interests">
                    <option value="Laptops" <% if (userInterests.contains("Laptops")) { %>selected<% } %>>Laptops</option>
                    <option value="Smartphones" <% if (userInterests.contains("Smartphones")) { %>selected<% } %>>Smartphones</option>
                    <option value="Tablets" <% if (userInterests.contains("Tablets")) { %>selected<% } %>>Tablets</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Save Interests</button>
        </form>
    </div>
</body>
</html>
