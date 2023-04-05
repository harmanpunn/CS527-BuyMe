package com.buyme.utils;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
