<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<link href="assets/css/carousel.css" rel="stylesheet"/>

<div class="container mt-5">
    <h3>Items Based on Your Interests</h3>
    <div class="carousel">
        <div class="carousel-track">
            <%
            	int userId = Integer.parseInt(request.getParameter("userId"));
                PreparedStatement itemsOfInterestStmt = null;
                ResultSet itemsOfInterestRs = null;
                Connection con = null;
                try {
                	ApplicationDB database = new ApplicationDB();
    				con = database.getConnection();
                    String itemsOfInterestQuery = "SELECT i.itemId, i.name, i.description, i.initialprice, i.closingtime FROM Item i WHERE i.subcategory IN (SELECT interest FROM UserInterests WHERE userId = ?) AND i.closingtime > NOW()";
                    itemsOfInterestStmt = con.prepareStatement(itemsOfInterestQuery);
                    itemsOfInterestStmt.setInt(1, userId);
                    itemsOfInterestRs = itemsOfInterestStmt.executeQuery();
                    while (itemsOfInterestRs.next()) {
            %>
            <div class="carousel-card">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><%= itemsOfInterestRs.getString("name") %></h5>
                        <p class="card-text"><%= itemsOfInterestRs.getString("description") %></p>
                        <p class="card-text">Price: <%= itemsOfInterestRs.getDouble("initialprice") %></p>
                        
                        <% 
                        Timestamp closingTime = itemsOfInterestRs.getTimestamp("closingtime");
                        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                        boolean isClosed = closingTime.before(currentTime);
                        %>
                        
                        <a href="Item.jsp?itemId=<%= itemsOfInterestRs.getString("itemId") %>" class="btn btn-primary <%= isClosed ? "disabled" : "" %>">Bid Now</a>
                    </div>
                </div>
            </div>
            <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (itemsOfInterestRs != null) {
                        try {
                            itemsOfInterestRs.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (itemsOfInterestStmt != null) {
                        try {
                            itemsOfInterestStmt.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (con != null) {
                        try {
                            con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>
    </div>
</div>
