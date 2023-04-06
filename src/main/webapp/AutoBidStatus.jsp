<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-5">
    <h3>AutoBid Status</h3>
    <table class="table">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Current Bid Price</th>
                <th>Upper Limit</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
            	int userId = Integer.parseInt(request.getParameter("userId"));
                PreparedStatement autoBidStmt = null;
                ResultSet autoBidRs = null;
                Connection con = null;
                try {
                	ApplicationDB database = new ApplicationDB();
					con = database.getConnection();
                    String autoBidQuery = "SELECT ab.itemId, i.name, ab.current_bid_price, ab.upper_limit, IF(ab.upper_limit < (SELECT MAX(price) FROM Bid WHERE itemId = ab.itemId AND status = 'active'), 'limit_reached', 'active') as status FROM AutoBid ab JOIN Item i ON ab.itemId = i.itemId WHERE ab.userId = ?";
                    autoBidStmt = con.prepareStatement(autoBidQuery);
                    autoBidStmt.setInt(1, userId);
                    autoBidRs = autoBidStmt.executeQuery();
                    while (autoBidRs.next()) {
            %>
            <tr>
                <td><%= autoBidRs.getString("itemId") %></td>
                <td><%= autoBidRs.getString("name") %></td>
                <td><%= autoBidRs.getDouble("current_bid_price") %></td>
                <td><%= autoBidRs.getDouble("upper_limit") %></td>
                <td><%= autoBidRs.getString("status") %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (autoBidRs != null) {
                        autoBidRs.close();
                    }
                    if (autoBidStmt != null) {
                        autoBidStmt.close();
                    }
                }
            %>
        </tbody>
    </table>
</div>
    
               
