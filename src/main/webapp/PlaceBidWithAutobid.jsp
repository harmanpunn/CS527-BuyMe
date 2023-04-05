<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.Item" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>

<%
	UserBean user = (UserBean) session.getAttribute("user");
	if (user == null) {
		response.sendRedirect(request.getContextPath() + "/Login.jsp");
	} else {
		String itemId = request.getParameter("itemId");
		double bidPrice = Double.parseDouble(request.getParameter("bidPrice"));
		String upperLimitStr = request.getParameter("upperLimit");
		Double upperLimit = null;

		if (upperLimitStr != null && !upperLimitStr.trim().isEmpty()) {
			upperLimit = Double.parseDouble(upperLimitStr);
		}

		// Connect to the database
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int bidId = -1;
		
		try {
			ApplicationDB database = new ApplicationDB();
			con = database.getConnection();
			con.setAutoCommit(false);
			
			
			// Close the previous bid from the same user on the same item
		    String closePreviousBidQuery = "UPDATE Bid SET status = 'closed' WHERE userId = ? AND itemId = ? AND status = 'active'";
		    stmt = con.prepareStatement(closePreviousBidQuery);
		    stmt.setInt(1, user.getUserId());
		    stmt.setString(2, itemId);
		    stmt.executeUpdate();
		    stmt.close();


			// Generate a new bid ID
			String bidIdQuery = "SELECT MAX(bid_id) as max_bid_id FROM Bid";
			stmt = con.prepareStatement(bidIdQuery);
			rs = stmt.executeQuery();

			if (rs.next()) {
				bidId = rs.getInt("max_bid_id") + 1;
			}

			// Insert the new bid into the Bid table
			String insertBidQuery = "INSERT INTO Bid (bid_id, userId, itemId, price, time, status) VALUES (?, ?, ?, ?, NOW(), 'active')";
			stmt = con.prepareStatement(insertBidQuery);
			stmt.setInt(1, bidId);
			stmt.setInt(2, user.getUserId());
			stmt.setString(3, itemId);
			stmt.setDouble(4, bidPrice);
			stmt.executeUpdate();

			// Insert the autobid (if applicable) into the AutoBid table
			if (upperLimit != null && upperLimit >= bidPrice) {
				String insertAutobidQuery = "INSERT INTO AutoBid (bid_id, auto_bid_increment, current_bid_price, upper_limit) VALUES (?, ?, ?, ?)";
				stmt = con.prepareStatement(insertAutobidQuery);
				stmt.setInt(1, bidId);
				stmt.setDouble(2, 0); // Assuming the auto_bid_increment is 0, change it accordingly if required
				stmt.setDouble(3, bidPrice);
				stmt.setDouble(4, upperLimit);
				stmt.executeUpdate();
			}

			con.commit();
			// Redirect to the item page after successful bid placement
			response.sendRedirect(request.getContextPath() + "/Item.jsp?itemId=" + itemId + "&success=true");

		} catch (SQLException e) {
			if (con != null) {
				try {
					con.rollback();
				} catch (SQLException e2) {
					e2.printStackTrace();
				}
			}
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/Item.jsp?itemId=" + itemId + "&error=true");
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
%>

