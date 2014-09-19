        <%@ page import="tunebazaar.UserAccountBean" %>        
        <%@ page import="tunebazaar.ShoppingCartBean" %>
        <%@ page import="java.text.DecimalFormat" %>
        <%
            String userAccountMessage = (String) request.getAttribute("userAccountMessage");
            if (userAccountMessage == null) {
                userAccountMessage = "";
            }
            String accountID = (String) session.getAttribute("accountID");
            Boolean accountLoggedIn;
            if(session.getAttribute("logged-in") == null) {
                accountLoggedIn = false;
            }
            else {
                accountLoggedIn = (Boolean) session.getAttribute("logged-in");
            }
            
            UserAccountBean userAccount = (UserAccountBean) session.getAttribute("userAccount");
            if (userAccount == null) {
                userAccount = new UserAccountBean();
            }
            
            ShoppingCartBean shoppingCart = (ShoppingCartBean) session.getAttribute("shoppingCart");
            if (shoppingCart == null) {
                shoppingCart = new ShoppingCartBean();
            }
            
            DecimalFormat df = new DecimalFormat("#.00");
        %>

        <section id="header" class="standard_section">
            <h1><a class="home" href="index">Tune Bazaar</a></h1>
            <% if (accountLoggedIn) { %>
            <p class="login">Welcome Back <a class="user_name" href="UserAccountServlet?action=modify&originURI=<%= request.getRequestURI() %>"><%= userAccount.getFirstName() %></a>, Not You? <a class="logout" href="UserAccountServlet?action=logout&originURI=<%= request.getRequestURI() %>">Logout</a></p>
            <% } else { %>
            <a class="login" href="UserAccountServlet?action=login&originURI=<%= request.getRequestURI() %>">Login</a>
            <% } %>
            <div id="buttonOptions">
                <form name="search" id="search" action="/SearchDisplayServlet" method="get">
                    <input type="search" name="searchByRelevanceString" placeholder="Enter a search term" autofocus="autofocus">
                    <input type="submit" value="Search">
                    <input type="hidden" name="searchAction" value="searchByRelevance">
                </form>
                <form name="cart" id="cart" action="/ShoppingCartServlet" method="get">
                    <button type="submit">Cart<% if(shoppingCart.getNumberItemsInCart() > 0) { %> ( <%= shoppingCart.getNumberItemsInCart() %> )<% } %></button>
                    <input type="hidden" name="action" value="viewCart">
                </form>
                <form name="checkout" id="checkout" action="/ShoppingCartServlet" method="get">
                    <input type="submit" value="Checkout">
                    <input type="hidden" name="action" value="toCheckout">
					<input type="hidden" name="originURI" value="<%= request.getRequestURI() %>">
                </form>
                <% if (accountLoggedIn) { %>
                <form name="account" id="account" action="/UserAccountServlet" method="get">
                    <input type="submit" value="Account">
                    <input type="hidden" name="action" value="modify">
					<input type="hidden" name="originURI" value="<%= request.getRequestURI() %>">
                </form>
                <% } %>
            </div>
        </section>