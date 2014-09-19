<%-- 
    Document   : cart
    Created on : Dec 4, 2013, 8:13:08 PM
    Author     : jsage8
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tune Bazaar</title>
    <link rel="stylesheet" type="text/css" href="css/tunebazaar/style.css" />
</head>
    
<body id="main">
    <%@ page import="java.util.List" %>
    <%@ page import="tunebazaar.OrderItem" %>
    <% 
        String shoppingCartMessage = (String) request.getAttribute("shoppingCartMessage");
        if (shoppingCartMessage == null) {
             shoppingCartMessage = "";
        }

         
    %>
    
    <div id="wrap">
        <%@include file="../header.jsp" %>

        <div id="content">
            <%@include file="../navigation.jsp" %>

            <section class="standard_section" id="output">
                <h2>Your Cart</h2>
                <% if (shoppingCart.getNumberItemsInCart() <= 0) { %>
                <p>Your shopping cart is empty!</p>
                <% } else { %>
            
                
            
                <table class="wide">
                    <% for (int i=0; i<shoppingCart.getNumberItemsInCart(); i++) { %>
                    <tr>                
                        <form action="/ShoppingCartServlet" method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="albumProductID" value="<%= shoppingCart.getItems().get(i).getProductId() %>">
                            <input type="hidden" value="<%= request.getRequestURI() %>" name="originURI">
                            <td class="contents"><img src="<%= shoppingCart.getItems().get(i).getAlbumInfo().getFilePath() %>" width="75px"></td>
                            <td class="contents"><%= shoppingCart.getItems().get(i).getAlbumInfo().getArtistName() %> - <%= shoppingCart.getItems().get(i).getAlbumInfo().getAlbumName() %></td>
                            <td class="contents"><%= df.format(shoppingCart.getItems().get(i).getCost()) %></td>
                            <td class="contents"><input type="submit" value="Remove"></td>
                        </form>
                    </tr>
                    <% } %>
                    <tr>
                        <td class="totals" colspan ="2" align="right"><b>Subtotal:</b></td>
                        <td><%= df.format(shoppingCart.getSubtotal()) %></td>
                    </tr>
                    <tr>
                        <td class="totals" colspan ="2" align="right"><b>Tax:</b></td>
                        <td><%= df.format(shoppingCart.getTax()) %></td>
                    </tr>
                    <tr>
                        <td class="totals" colspan ="2" align="right"><b>Total:</b></td>
                        <td><%= df.format(shoppingCart.getTotal()) %></td>
                    </tr>
                </table>
                <% } %>
            </section>
        </div>

        <%@include file="../footer.jsp" %>
    </div>
</body>

</html>