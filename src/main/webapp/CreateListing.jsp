<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
		<link href="assets/css/global.css" rel="stylesheet"/>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	</head>
	<body>
		<div class="container">
			<form class="text-center form-signin" method="post" action="EndUserCreateListing.jsp">
				<h3 class="h3 mb-3 font-weight-normal">Create Listing</h3>
				<input type="hidden" name="userId" value="<%= request.getParameter("userId") %>"></input>
				<label for="itemName" class="sr-only">Item Name</label>
				<input id="itemName" class="form-control" type="text" name="item_name" placeholder="Item Name" required autofocus>
				
				<label for="itemDescription" class="sr-only">Description</label>
				<input id="itemDescription" class="form-control" type="text" name="item_description" placeholder="Description" required autofocus>
				
				<label for="itemSubcategory" class="sr-only">Subcategory</label>
				<select class="form-control login-select" id="itemSubcategory" name="subcategory" required>
					<option value="" disabled selected>Select Subcategory</option>
					<option value="laptop">Laptops</option>
					<option value="laptop">Smartphones</option>
					<option value="laptop">Tablets</option>
				
				</select>
				
				<label for="itemInitialPrice" class="sr-only">Initial Price</label>
				<input id="itemInitialPrice" class="form-control" type="number" name="item_initial_price" placeholder="Initial Price" required autofocus>
				
				<label for="itemClosingTime" class="sr-only">Closing Time</label>
				<input id="itemClosingTime" class="form-control" type="datetime-local" name="item_closing_time" placeholder="Closing Time" required autofocus>
				
				<label for="itemBidIncrement" class="sr-only">Bid Increment</label>
				<input id="itemBidIncrement" class="form-control" type="number" name="item_bid_increment" placeholder="Bid Increment" required autofocus>
				
				<label for="itemMinPrice" class="sr-only">Minimum Price</label>
				<input id="itemMinPrice" class="form-control" type="number" name="item_min_price" placeholder="Minimum Price" required autofocus>
				
				<button class="btn btn-primary btn-lg btn-login" type="submit" value="Submit">Submit</button>
						
			</form>
			
		</div>
	</body>
</html>