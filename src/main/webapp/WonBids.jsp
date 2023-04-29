<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-5">
    <h3>Victorious: Your Winning Bids</h3>
    <table class="table">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Winning Bid Price</th>
                <th>Bid Time</th>
                <th>Closing Time</th>
            </tr>
        </thead>
        <tbody>
            <%
            	int userId = Integer.parseInt(request.getParameter("userId"));
                PreparedStatement bidsWonStmt = null;
                ResultSet bidsWonRs = null;
                Connection con = null;
                try {
                	ApplicationDB database = new ApplicationDB();
					con = database.getConnection();
					/* String bidsWonQuery = "SELECT b.itemId, i.name, b.price, b.time, i.closingtime FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE b.userId = ? AND b.status = 'closed' AND i.closingtime <= NOW() AND b.price = (SELECT MAX(price) FROM Bid WHERE itemId = b.itemId AND userId = ? AND status = 'closed') AND b.time = (SELECT MAX(time) FROM Bid WHERE itemId = b.itemId AND userId = ? AND status = 'closed');";
					bidsWonStmt = con.prepareStatement(bidsWonQuery);
                    bidsWonStmt.setInt(1, userId);
                    bidsWonStmt.setInt(2, userId);
                    bidsWonStmt.setInt(3, userId); */
                    String bidsWonQuery = "SELECT b.itemId, i.name, b.price, b.time, i.closingtime FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE b.userId = ? AND b.status = 'closed' AND i.closingtime <= NOW() AND b.winning_bid = 1";
                    bidsWonStmt = con.prepareStatement(bidsWonQuery);
                    bidsWonStmt.setInt(1, userId);


                    bidsWonRs = bidsWonStmt.executeQuery();
                    while (bidsWonRs.next()) {
            %>
            <tr>
              	<td><a href="Item.jsp?itemId=<%= bidsWonRs.getString("itemId") %>"><%= bidsWonRs.getString("itemId") %></a></td>
                <td><%= bidsWonRs.getString("name") %></td>
                <td><%= bidsWonRs.getDouble("price") %></td>
                <td><%= bidsWonRs.getTimestamp("time") %></td>
                <td><%= bidsWonRs.getTimestamp("closingtime") %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (bidsWonRs != null) {
                        bidsWonRs.close();
                    }
                    if (bidsWonStmt != null) {
                        bidsWonStmt.close();
                    }
                }
            %>
        </tbody>
    </table>
</div>
