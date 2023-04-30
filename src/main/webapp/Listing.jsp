<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import= "java.text.SimpleDateFormat, java.util.Date" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Buy Me Application | Laptops</title>
        <link href="assets/css/global.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <body>
        <%
        UserBean user = (UserBean) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
        } else {

            String subcategory = request.getParameter("subcategory");
            String sortby = request.getParameter("sortby");

            if (subcategory == null || subcategory.trim().length() == 0) {
                response.sendRedirect(request.getContextPath() + "/UserHome.jsp");
            } else {
                // Connect to the database
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    ApplicationDB database = new ApplicationDB();
                    con = database.getConnection();
                    String startDateStr = request.getParameter("startDate");
    				String endDateStr = request.getParameter("endDate");
    				Timestamp startDateTimestamp = null;
    				Timestamp endDateTimestamp = null;
    				
    				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    				if (startDateStr != null && !startDateStr.isEmpty()) {
    				    Date startDate = dateFormat.parse(startDateStr);
    				    startDateTimestamp = new Timestamp(startDate.getTime());
    				}
    				if (endDateStr != null && !endDateStr.isEmpty()) {
    				    Date endDate = dateFormat.parse(endDateStr);
    				    endDateTimestamp = new Timestamp(endDate.getTime());
    				}
    				

                    // Prepare the query based on the selected filter option
                    String sql = "SELECT * FROM Item WHERE subcategory = ?";
                    
                	if (startDateTimestamp != null) {
    				    sql += " AND closingtime >= ?";
    				}

    				if (endDateTimestamp != null) {
    				    sql += " AND closingtime <= ?";
    				}
                   
                   	if ("Name".equals(sortby)) {
					    sql += " ORDER BY name";
					} else if ("lowToHigh".equals(sortby)) {
					    sql += " ORDER BY initialprice ASC";
					} else if ("highToLow".equals(sortby)) {
					    sql += " ORDER BY initialprice DESC";
					} else if ("Open".equals(sortby)) {
					    sql += " AND closingtime > CURRENT_TIMESTAMP";
					} else if ("Closed".equals(sortby)) {
					    sql += " AND closingtime <= CURRENT_TIMESTAMP";
					} else {
					    sql += " ORDER BY closingtime DESC";
					}

                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, subcategory);
                    int index = 2;
                    if (startDateTimestamp != null) {
    				    pstmt.setTimestamp(index++, startDateTimestamp);
    				}

    				if (endDateTimestamp != null) {
    				    pstmt.setTimestamp(index++, endDateTimestamp);
    				}
                    
                    rs = pstmt.executeQuery();

                    // Display the search results
                    %>
                    <jsp:include page="Navbar.jsp">
                        <jsp:param name="username" value="${user.name}" />
                        <jsp:param name="landingPage" value="UserHome" />
                    </jsp:include>
                    <div class="container mt-5">
                        <h2 class="mb-3"><%= subcategory %> Listings</h2>

                      <%-- <form class="form-inline d-flex mb-5 mx-auto" method="GET" action="Listing.jsp">
						  <label class="pt-2 for="sortby">Sort by:</label>
						  <select class="custom-select mx-3 form-control w-auto" name="sortby" id="sortby">
						    <option value="None" <%= "None".equals(sortby) ? "selected" : "" %>>---</option>
							<option value="Name" <%= "Name".equals(sortby) ? "selected" : "" %>>Name</option>
							<option value="lowToHigh" <%= "lowToHigh".equals(sortby) ? "selected" : "" %>>Price (Ascending)</option>
							<option value="highToLow" <%= "highToLow".equals(sortby) ? "selected" : "" %>>Price (Descending)</option>
							<option value="Open" <%= "Open".equals(sortby) ? "selected" : "" %>>Status: Open</option>
							<option value="Closed" <%= "Closed".equals(sortby) ? "selected" : "" %>>Status: Closed</option>
						  </select>
						  <input type="hidden" name="subcategory" value="<%= subcategory %>">
						  <button type="submit" class="btn btn-primary mr-2">Apply</button>
						</form> --%>
						
						
						<form class="mb-5 mx-auto" method="GET" action="Listing.jsp">
						    <input type="hidden" name="subcategory" value="<%= subcategory %>">
						    <div class="container">
						        <div class="row align-items-center">
						            <div class="col-auto form-group">
						                <label for="sortby">Sort by:</label>
						                <select class="custom-select form-control" name="sortby" id="sortby">
						                    <option value="None" <%= "None".equals(sortby) ? "selected" : "" %>>---</option>
						                    <option value="Name" <%= "Name".equals(sortby) ? "selected" : "" %>>Name</option>
						                    <option value="lowToHigh" <%= "lowToHigh".equals(sortby) ? "selected" : "" %>>Price (Ascending)</option>
						                    <option value="highToLow" <%= "highToLow".equals(sortby) ? "selected" : "" %>>Price (Descending)</option>
						                    <option value="Open" <%= "Open".equals(sortby) ? "selected" : "" %>>Status: Open</option>
						                    <option value="Closed" <%= "Closed".equals(sortby) ? "selected" : "" %>>Status: Closed</option>
						                </select>
						            </div>
						            <div class="col-auto form-group">
						                <label for="startDate">Start Date:</label>
						                <input type="date" class="form-control" id="startDate" name="startDate" value="<%= request.getParameter("startDate") %>">
						            </div>
						            <div class="col-auto form-group">
						                <label for="endDate">End Date:</label>
						                <input type="date" class="form-control" id="endDate" name="endDate" value="<%= request.getParameter("endDate") %>">
						            </div>
						            <div class="col-auto form-group mt-rem-2">
						                <button type="submit" class="btn btn-primary">Apply</button>
						            </div>
						        </div>
						    </div>
						</form>
						


					    
					    
					    <% if (rs.next()) { %>

					    <div class="row">
					        <% do { %>
					            <div class="col-md-4 mb-3">
					                <div class="card">
					                    <div class="card-body">
					                        <h5 class="card-title"><%= rs.getString("name") %></h5>
					                        <p class="card-text"><%= rs.getString("description") %></p>
					                        <p class="card-text">Price: <%= rs.getDouble("initialprice") %></p>
					                        
					                        <% 
					                        Timestamp closingTime = rs.getTimestamp("closingtime");
					                        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
					                        boolean isClosed = closingTime.before(currentTime);
					                        %>
   					                        <a href="Item.jsp?itemId=<%= rs.getString("itemId") %>" class="btn btn-primary"  >Bid Now</a>
					                        <%-- <a href="Item.jsp?itemId=<%= rs.getString("itemId") %>" class="btn btn-primary <%= isClosed ? "disabled" : "" %>"  >Bid Now</a> --%>
					                    </div>
					                </div>
					            </div>
					
					        <% } while (rs.next()); %>
					    </div>
					
					<% } else { %>
					
					    <p>No results found.</p>
					
					<% } %>
				</div>	    
				<jsp:include page="Footer.jsp" />	    
					    <%
			} catch(SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					con.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			}
		}
		}
	%>
					
</body>
</html>