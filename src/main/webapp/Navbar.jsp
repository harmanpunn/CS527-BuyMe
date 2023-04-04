<nav class="navbar navbar-expand-lg navbar-light bg-light px-5">
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="Laptops.jsp">Laptops <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Smartphones.jsp">Smartphones</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Tablets.jsp">Tablets</a>
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
