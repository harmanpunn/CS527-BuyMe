<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.Item" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>

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
						
						// Close expired bids
				        BuyMeUtils.closeExpiredBids(con);
						
						// Execute the query to retrieve the item details
						// String sql = "SELECT * FROM Item WHERE itemId=?";
						String sql = "SELECT i.*, u.name AS seller_name, MAX(b.price) AS highest_bid, MAX(CASE WHEN b.userId = ? THEN b.price ELSE NULL END) AS user_bid FROM Item i LEFT JOIN Bid b ON i.itemId = b.itemId LEFT JOIN User u ON i.userId = u.userId WHERE i.itemId = ? GROUP BY i.itemId";

						stmt = con.prepareStatement(sql);
						stmt.setInt(1, user.getUserId());
						stmt.setString(2, itemId);
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
							item.setSellerName(rs.getString("seller_name"));
							item.setHighestBid(rs.getDouble("highest_bid"));
							item.setUserBid(rs.getDouble("user_bid"));
						}
						
						%>
						<jsp:include page="Navbar.jsp">
						    <jsp:param name="username" value="${user.name}" />
						</jsp:include>
						<%-- <div class="container mt-5">
							<h2><%= item.getName() %></h2>
							<p><%= item.getDescription() %></p>
							<p>Price: <%= item.getInitialPrice() %></p>
							<p>Seller: <%= item.getSellerName() %></p>
							<p>Closing time: <%= item.getClosingTime() %></p>
							<p>Current bid placed by you: <%=  item.getUserBid() == 0.0 ? "None" : item.getUserBid() %></p>
							<p>Highest bid placed on the item: <%= item.getHighestBid() == 0.0 ? "None" : item.getHighestBid()  %></p>
														
							<form method="post" action="PlaceBidWithAutobid.jsp">
								<input type="hidden" name="itemId" value="<%= item.getItemId() %>">
								
								<div class="form-group d-flex">
									<label for="bidPrice" class="pt-2">Bid Price:</label>
									<input type="number" name="bidPrice" id="bidPrice" class="form-control w-8 mx-3" min="<%= item.getInitialPrice() %>" step="<%= item.getBidIncrement() %>" required>
								</div>
							
								<div class="form-group d-flex">
									<label for="upperLimit" class="pt-2">Autobid Upper Limit (optional):</label>
									<input type="number" name="upperLimit" id="upperLimit" class="form-control w-8 mx-3" min="<%= item.getInitialPrice() %>">
								</div>
							
								<div class="form-group ">
									<button type="submit" class="btn btn-primary">Place Bid</button>
								</div>
							</form>
							
						</div> --%>
						
						<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <h2><%= item.getName() %></h2>
        </div>
        <div class="card-body">
            <p class="card-text lead"><%= item.getDescription() %></p>
            <div class="row">
                <div class="col-sm-6">
                    <p class="card-text mb-1"><strong>Price:</strong> <%= item.getInitialPrice() %></p>
                    <p class="card-text mb-1"><strong>Closing time:</strong> <%= item.getClosingTime() %></p>
                    <p class="card-text mb-1"><strong>Current bid placed by you:</strong> <%=  item.getUserBid() == 0.0 ? "None" : item.getUserBid() %></p>
                    <p class="card-text mb-1"><strong>Highest bid placed on the item:</strong> <%= item.getHighestBid() == 0.0 ? "None" : item.getHighestBid()  %></p>
                    <p class="card-text mb-1"><strong>Seller:</strong> <%= item.getSellerName() %></p>
                </div>
                <div class="col-sm-6">
                    <form method="post" action="PlaceBidWithAutobid.jsp">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        
                        <div class="mb-3">
                            <label for="bidPrice" class="form-label"><strong>Bid Price:</strong></label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" name="bidPrice" id="bidPrice" class="form-control" min="<%= item.getInitialPrice() %>" step="<%= item.getBidIncrement() %>" required>
                            </div>
                        </div>
                    
                        <div class="mb-3">
                            <label for="upperLimit" class="form-label"><strong>Autobid Upper Limit (optional):</strong></label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" name="upperLimit" id="upperLimit" class="form-control" min="<%= item.getInitialPrice() %>">
                            </div>
                        </div>
                    
                        <div class="mb-3">
                            <button type="submit" class="btn btn-primary">Place Bid</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
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