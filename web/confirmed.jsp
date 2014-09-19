<%-- 
    Document   : confirmed
    Created on : Dec 6, 2013, 5:23:31 AM
    Author     : jsage8
--%>

<%-- 
    Document   : confirm
    Created on : Dec 5, 2013, 5:43:31 PM
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
    <%@ page import="tunebazaar.AddressBean" %>
    <%@ page import="tunebazaar.PhoneBean" %>
    <%@ page import="tunebazaar.CreditCardBean" %>
    <%      
        AddressBean shipAddress = (AddressBean) session.getAttribute("shipAddress");
        if (shipAddress == null) {
            shipAddress = new AddressBean();
        }

        AddressBean billAddress = (AddressBean) session.getAttribute("billAddress");
        if (billAddress == null) {
            billAddress = new AddressBean();
        }

        PhoneBean homePhone = (PhoneBean) session.getAttribute("homePhone");
        if(homePhone == null) { 
            homePhone = new PhoneBean(); 
        }

        PhoneBean cellPhone = (PhoneBean) session.getAttribute("cellPhone");
        if(cellPhone == null) { 
            cellPhone = new PhoneBean(); 
        }

        CreditCardBean creditCard = (CreditCardBean) session.getAttribute("creditCard");
        if(creditCard == null) { 
            creditCard = new CreditCardBean(); 
        }
		
		ShoppingCartBean confirmedCart = (ShoppingCartBean) request.getAttribute("confirmedCart");
		if (confirmedCart == null) {
			confirmedCart = new ShoppingCartBean();
        }
        
        //int orderID = Integer.getInteger((String)request.getAttribute("orderID"));
		String orderID = (String)request.getAttribute("orderID");
    %>

    <div id="wrap">
        <%@include file="../header.jsp" %>

        <div id="content">
            <%@include file="../navigation.jsp" %>

            <section class="standard_section" id="output">
                <h2>Your Order Has Been Placed!</h2>
                <p class="receipt">Please print this page for your records.</p>
                <p class="receipt">A confirmation email was sent to <%= userAccount.getEmailAddress() %>.</p>
                <p class="receipt">Your order number is <%= orderID %>.</p>
                
                <h2>Your Order</h2>
                <table class="wide">
                    <% for (int i = 0; i < confirmedCart.getNumberItemsInCart(); i++) { %>
                    <tr>                
                        <td class="contents"><img src="<%= confirmedCart.getItems().get(i).getAlbumInfo().getFilePath() %>" width="75px"></td>
                        <td class="contents"><%= confirmedCart.getItems().get(i).getAlbumInfo().getArtistName() %> - <%= confirmedCart.getItems().get(i).getAlbumInfo().getAlbumName() %></td>
                        <td class="contents"><%= df.format(confirmedCart.getItems().get(i).getCost()) %></td>
                    </tr>
                    <% } %>
                    <tr>
                        <td class="totals" colspan ="2" align="right"><b>Subtotal:</b></td>
                        <td><%= df.format(confirmedCart.getSubtotal()) %></td>
                    </tr>
                    <tr>
                        <td class="totals" colspan ="2" align="right"><b>Tax:</b></td>
                        <td><%= df.format(confirmedCart.getTax()) %></td>
                    </tr>
                    <tr>
                        <td class="totals" colspan ="2" align="right"><b>Total:</b></td>
                        <td><%= df.format(confirmedCart.getTotal()) %></td>
                    </tr>
                </table>
                <article>
                    <h2>Shipping Address</h2>
                    <p class="receipt"><%= userAccount.getFirstName() %> <%= userAccount.getMiddleInitial() %> <%= userAccount.getLastName() %></p>
                    <p class="receipt"><%= shipAddress.getLine1() %></p>
                    <% if(!shipAddress.getLine2().equals("")) { %><p class="receipt"><%= shipAddress.getLine2() %></p><% } %>
                    <p class="receipt"><%= shipAddress.getCity() %>, <%= shipAddress.getState() %> <%= shipAddress.getZip() %></p>
                </article>
                <article>
                    <h2>Billing Address</h2>
                    <p class="receipt"><%= userAccount.getFirstName() %> <%= userAccount.getMiddleInitial() %> <%= userAccount.getLastName() %></p>
                    <p class="receipt"><%= billAddress.getLine1() %></p>
                    <% if(!billAddress.getLine2().equals("")) { %><p class="receipt"><%= billAddress.getLine2() %></p><% } %>
                    <p class="receipt"><%= billAddress.getCity() %>, <%= billAddress.getState() %> <%= billAddress.getZip() %></p>
                </article>
                <h2>Contact</h2>
                <article>
                    <% if(!homePhone.getPhone().equals("")) { %>
                    <p class="receipt">Home Phone: <%= homePhone.getPhone() %> <% if(homePhone.getIsPrimary()) { %>Primary<% } %></p>
                    <% } %>
                    <% if(!cellPhone.getPhone().equals("")) { %>
                    <p class="receipt">Cell Phone: <%= cellPhone.getPhone() %> <% if(cellPhone.getIsPrimary()) { %>Primary<% } %></p>
                    <% } %>
                </article>
                <h2>Payment Information</h2>
                <article>
                    <p class="receipt">Credit Card Type: <%= creditCard.getCardType() %></p>
                    <p class="receipt">Credit Card Number: <%= creditCard.getCardNumber() %></p>
                    <p class="receipt">Card Expiration Date (MM/YY): <%= creditCard.getCardMonth() %>/<%= creditCard.getCardYear() %></p>
                    <p class="receipt">Name on Card: <%= creditCard.getNameOnCard() %></p>
                </article>
            </section>
        </div>

        <%@include file="../footer.jsp" %>
    </div>
</body>

</html>