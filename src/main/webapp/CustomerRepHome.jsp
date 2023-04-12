<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Customer Representative Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
	<%
				
			UserBean user = (UserBean)session.getAttribute("user");
			
			if(user == null ) {
				response.sendRedirect(request.getContextPath() + "/Login.jsp");
		} else {  
			boolean isEmployee = true;
		%>
		
		
		<jsp:include page="Navbar.jsp">
			<jsp:param name="username" value="${user.name}" />
			<jsp:param name="isEmployee" value="true" />
			<jsp:param name="landingPage" value="CustomerRepHome" />
		</jsp:include>
				
		
    <div class="container mt-4">
        <h3 class="text-center">Customer Representative Dashboard</h3>
        
       	<jsp:include page="EndUserList.jsp"/>
	
        
    </div>
    <%} %>
</body>
</html>
