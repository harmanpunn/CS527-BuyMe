package com.buyme.utils;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;


public final class BuyMeUtils {
	
	
	public static String encryptPassword(String password)  {
		
	    String encryptedPassword = null;

	    try {
	      MessageDigest md = MessageDigest.getInstance("MD5");

	      md.update(password.getBytes());

	      byte[] bytes = md.digest();

	      StringBuilder sb = new StringBuilder();
	      for (int i = 0; i < bytes.length; i++) {
	        sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	      }

	      encryptedPassword = sb.toString();
	    } catch (NoSuchAlgorithmException e) {
	      e.printStackTrace();
	    }
	    return encryptedPassword;
	  }
	
	public static void closeExpiredBids(Connection con) {
	    PreparedStatement stmt = null;
	    try {
	        // Update the bids' status for items with closing times that have passed
	        String updateBidsStatusQuery = "UPDATE Bid b JOIN Item i ON b.itemId = i.itemId SET b.status = 'closed' WHERE i.closingtime < NOW() AND b.status = 'active'";
	        stmt = con.prepareStatement(updateBidsStatusQuery);
	        stmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (stmt != null) {
	            try {
	                stmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}
	
	/*public static void triggerAutoBids(Connection con, String itemId, double highestActiveBid) {
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    try {
	        // Find all active auto bids on the item where the upper limit is greater than the current bid price
	    	String findAutoBidsQuery = "SELECT a.bid_id, a.userId, a.auto_bid_increment, a.upper_limit FROM AutoBid a JOIN Bid b ON a.bid_id = b.bid_id WHERE b.itemId = ? AND b.status = 'active' AND a.upper_limit > ?";
	        stmt = con.prepareStatement(findAutoBidsQuery);
	        stmt.setString(1, itemId);
			stmt.setDouble(2, highestActiveBid);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            int bidId = rs.getInt("bid_id");
	            int userId = rs.getInt("userId");
	            double autoBidIncrement = rs.getDouble("auto_bid_increment");
	            double upperLimit = rs.getDouble("upper_limit");

	            // Calculate the new bid price
	            double newBidPrice = highestActiveBid + autoBidIncrement;
	            if (newBidPrice <= upperLimit) {
	            	// Close the previous bid from the same user on the same item
		            String closePreviousBidQuery = "UPDATE Bid SET status = 'closed' WHERE userId = ? AND itemId = ? AND status = 'active'";
		            stmt = con.prepareStatement(closePreviousBidQuery);
		            stmt.setInt(1, userId);
		            stmt.setString(2, itemId);
		            stmt.executeUpdate();

		            // Insert the new bid into the Bid table
		            String insertBidQuery = "INSERT INTO Bid (userId, itemId, price, time, status) VALUES (?, ?, ?, NOW(), 'active')";
		            stmt = con.prepareStatement(insertBidQuery);
		            stmt.setInt(1, userId);
		            stmt.setString(2, itemId);
		            stmt.setDouble(3, newBidPrice);
		            stmt.executeUpdate();
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (rs != null) {
	            try {
	                rs.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (stmt != null) {
	            try {
	                stmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	} */
	
//	public static void triggerAutoBids(Connection con, String itemId, double highestActiveBid) {
//	    boolean autoBidsPlaced = true;
//
//	    while (autoBidsPlaced) {
//	        autoBidsPlaced = false;
//	        PreparedStatement stmt = null;
//	        ResultSet rs = null;
//
//	        try {
//	            // Find all active auto bids on the item where the upper limit is greater than the current bid price
//	            String findAutoBidsQuery = "SELECT a.userId, a.auto_bid_increment, a.upper_limit FROM AutoBid a JOIN Bid b ON a.userId = b.userId WHERE b.itemId = ? AND b.status = 'active' AND a.upper_limit > ?";
//	            stmt = con.prepareStatement(findAutoBidsQuery);
//	            stmt.setString(1, itemId);
//	            stmt.setDouble(2, highestActiveBid);
//	            rs = stmt.executeQuery();
//
//	            while (rs.next()) {
//	      
//	                int userId = rs.getInt("userId");
//	                System.out.println("userID {}"+userId);
//	                double autoBidIncrement = rs.getDouble("auto_bid_increment");
//	                double upperLimit = rs.getDouble("upper_limit");
//
//	                // Calculate the new bid price
//	                double newBidPrice = highestActiveBid + autoBidIncrement;
//	                if (newBidPrice <= upperLimit) {
//	                    // Close the previous bid from the same user on the same item
//	                    String closePreviousBidQuery = "UPDATE Bid SET status = 'closed' WHERE userId = ? AND itemId = ? AND status = 'active'";
//	                    stmt = con.prepareStatement(closePreviousBidQuery);
//	                    stmt.setInt(1, userId);
//	                    stmt.setString(2, itemId);
//	                    stmt.executeUpdate();
//
//	                    // Insert the new bid into the Bid table
//	                    String insertBidQuery = "INSERT INTO Bid (userId, itemId, price, time, status) VALUES (?, ?, ?, NOW(), 'active')";
//	                    stmt = con.prepareStatement(insertBidQuery);
//	                    stmt.setInt(1, userId);
//	                    stmt.setString(2, itemId);
//	                    stmt.setDouble(3, newBidPrice);
//	                    stmt.executeUpdate();
//
//	                    // Update the highest active bid
//	                    highestActiveBid = newBidPrice;
//	                    autoBidsPlaced = true;
//	                }
//	            }
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	        } finally {
//	            if (rs != null) {
//	                try {
//	                    rs.close();
//	                } catch (SQLException e) {
//	                    e.printStackTrace();
//	                }
//	            }
//	            if (stmt != null) {
//	                try {
//	                    stmt.close();
//	                } catch (SQLException e) {
//	                    e.printStackTrace();
//	                }
//	            }
//	        }
//	    }
//	}

	public static void triggerAutoBids(Connection con, String itemId, double highestActiveBid) {
	    boolean autoBidsPlaced = true;
	    Set<Integer> triggeredUsers = new HashSet<>();

	    while (autoBidsPlaced) {
	        autoBidsPlaced = false;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;

	        try {
	            String findAutoBidsQuery = "SELECT a.userId, a.auto_bid_increment, a.upper_limit FROM AutoBid a JOIN Bid b ON a.userId = b.userId WHERE b.itemId = ? AND b.status = 'active' AND a.upper_limit > ?";
	            if (!triggeredUsers.isEmpty()) {
	                findAutoBidsQuery += " AND a.userId NOT IN " + usersIn(triggeredUsers);
	            }
	            System.out.println("findAutoBidsQuery:"+findAutoBidsQuery);
	            stmt = con.prepareStatement(findAutoBidsQuery);
	            stmt.setString(1, itemId);
	            stmt.setDouble(2, highestActiveBid);
	            rs = stmt.executeQuery();

	            System.out.println(stmt.toString());
	            while (rs.next()) {
	            	
	                int userId = rs.getInt("userId");
	                System.out.print("here"+ userId);
	                double autoBidIncrement = rs.getDouble("auto_bid_increment");
	                double upperLimit = rs.getDouble("upper_limit");

	                double newBidPrice = highestActiveBid + autoBidIncrement;
	                if (newBidPrice <= upperLimit) {
	                    String closePreviousBidQuery = "UPDATE Bid SET status = 'closed' WHERE userId = ? AND itemId = ? AND status = 'active'";
	                    stmt = con.prepareStatement(closePreviousBidQuery);
	                    stmt.setInt(1, userId);
	                    stmt.setString(2, itemId);
	                    stmt.executeUpdate();

	                    String insertBidQuery = "INSERT INTO Bid (userId, itemId, price, time, status) VALUES (?, ?, ?, NOW(), 'active')";
	                    stmt = con.prepareStatement(insertBidQuery);
	                    stmt.setInt(1, userId);
	                    stmt.setString(2, itemId);
	                    stmt.setDouble(3, newBidPrice);
	                    stmt.executeUpdate();

	                    highestActiveBid = newBidPrice;
	                    autoBidsPlaced = true;
	                    triggeredUsers.add(userId);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            if (rs != null) {
	                try {
	                    rs.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	            if (stmt != null) {
	                try {
	                    stmt.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }
	}

	private static String usersIn(Set<Integer> users) {
	    if (users.isEmpty()) {
	        return "(NULL)";
	    }
	    return "(" + users.stream().map(String::valueOf).collect(Collectors.joining(",")) + ")";
	}



}
