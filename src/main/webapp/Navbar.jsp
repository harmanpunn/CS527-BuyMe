<h2 class="my-3 text-center">Welcome to BuyMe </h2>
<nav class="navbar navbar-expand-sm navbar-light bg-light px-5">
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
        	<li class="nav-item active">
                <a class="nav-link" href="UserHome.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
       		 <span class="navbar-text"> | </span>
            <li class="nav-item active">
                <a class="nav-link" href="Listing.jsp?subcategory=Laptop">Laptops <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Listing.jsp?subcategory=Smartphone">Smartphones</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Listing.jsp?subcategory=Tablet">Tablets</a>
            </li>
        </ul>
    </div>
    <div class="float-right">
        <ul class="navbar-nav">
            <span class="navbar-text font-bold">${param.username} &nbsp;</span>
            <span class="navbar-text"> | </span>
            <li class="nav-item">
                <a class="nav-link" href="Account.jsp">Account</a>
            </li>
            <span class="navbar-text"> | </span>
            <li class="nav-item">
                <a class="nav-link" href="Logout.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>	
<jsp:include page="Search.jsp"></jsp:include>