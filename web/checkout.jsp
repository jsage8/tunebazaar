<%-- 
    Document   : checkout
    Created on : Dec 2, 2013, 7:52:45 PM
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
        String errorMessage = (String) request.getAttribute("errorMessage");
        Boolean[] isShipError = (Boolean[]) request.getAttribute("isShipError");
        Boolean[] isBillError = (Boolean[]) request.getAttribute("isBillError");
        Boolean[] isPhoneError = (Boolean[]) request.getAttribute("isPhoneError");
        Boolean[] isCreditError = (Boolean[]) request.getAttribute("isCreditError");
        
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

        if(errorMessage == null) { errorMessage = ""; }

        if(isShipError == null) {
            isShipError = new Boolean[5];
            for(int i = 0; i < isShipError.length; i++) {
                isShipError[i] = false;
            }
        }
        if(isBillError == null) {
            isBillError = new Boolean[5];
            for(int i = 0; i < isBillError.length; i++) {
                isBillError[i] = false;
            }
        }
        if(isPhoneError == null) {
            isPhoneError = new Boolean[4];
            for(int i = 0; i < isPhoneError.length; i++) {
                isPhoneError[i] = false;
            }
        }
        if(isCreditError == null) {
            isCreditError = new Boolean[4];
            for(int i = 0; i < isCreditError.length; i++) {
                isCreditError[i] = false;
            }
        }
    %>
    
    <%!
        public boolean falseIfAllFalse(Boolean[] array) {
            for(Boolean b : array) {
                if(b) {
                    return true;
                }
            }
            return false;
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
                <form id="checkoutForm" name="checkoutForm" action="/ShoppingCartServlet" method="post">
                    <h2>Address Information</h2>
                    <% if(falseIfAllFalse(isShipError)) { %>
                    <p class="error"><%= errorMessage %></p>
                    <% } %>
                    <fieldset>
                        <legend <% if(falseIfAllFalse(isShipError)) { %>class="error"<% } %>>Shipping Address</legend>
                        <ul>
                            <li>
                                <label for="sline1" class="textInput clear <% if(isShipError[0]) { %>error<% } %>">Address Line 1: </label>
                                <input type="text" name="sline1" id="sline1" class="textInput" value="<%= shipAddress.getLine1() %>">
                            </li>
                            <li>
                                <label for="sline2" class="textInput clear <% if(isShipError[1]) { %>error<% } %>">Address Line 2: </label>
                                <input type="text" name="sline2" id="line2" class="textInput" value="<%= shipAddress.getLine2() %>">
                            </li>
                            <li>
                                <label for="scity" class="textInput clear <% if(isShipError[2]) { %>error<% } %>">City: </label>
                                <input type="text" name="scity" id="scity" class="textInput" value="<%= shipAddress.getCity() %>">
                            </li>
                            <li>
                                <label for="sstate" class="textInput clear <% if(isShipError[3]) { %>error<% } %>">State: </label>
                                <input type="text" maxlength="2" name="sstate" id="sstate" class="textInput" value="<%= shipAddress.getState() %>">
                            </li>
                            <li>
                                <label for="szip" class="textInput clear <% if(isShipError[4]) { %>error<% } %>">Zip: </label>
                                <input type="text" maxlength="5" name="szip" id="szip" class="textInput" value="<% if(shipAddress.getZip() != -1) { %><%= shipAddress.getZip() %><% } %>">
                            </li>
                        </ul>

                    </fieldset>
                    <% if(falseIfAllFalse(isShipError)) { %>
                    <p class="error"><%= errorMessage %></p>
                    <% } %>
                    <fieldset>
                        <legend <% if(falseIfAllFalse(isBillError)) { %>class="error"<% } %>>Billing Address</legend>
                        <ul>
                            <li>
                                <label for="isSameAddress" class="textInput"><b>Same as Shipping: </b></label>
                                <input type="checkbox" name="isSameAddress" id="isSameAddress" value="isSameAddress" class="checkbox" <% if(billAddress.getIsSame()) { %>checked<% } %>>
                            </li>
                            <li>
                                <label for="bline1" class="textInput<% if(isBillError[0]) { %> error<% } %>">Address Line 1: </label>
                                <input type="text" name="bline1" id="bline1" class="textInput" value="<%= billAddress.getLine1() %>">
                            </li>
                            <li>
                                <label for="bline2" class="textInput<% if(isBillError[1]) { %> error<% } %>">Address Line 2: </label>
                                <input type="text" name="bline2" id="line2" class="textInput" value="<%= billAddress.getLine2() %>">
                            </li>
                            <li>
                                <label for="bcity" class="textInput<% if(isBillError[2]) { %> error<% } %>">City: </label>
                                <input type="text" name="bcity" id="bcity" class="textInput" value="<%= billAddress.getCity() %>">
                            </li>
                            <li>
                                <label for="bstate" class="textInput<% if(isBillError[3]) { %> error<% } %>">State: </label>
                                <input type="text" maxlength="2" name="bstate" id="bstate" class="textInput" value="<%= billAddress.getState() %>">
                            </li>
                            <li>
                                <label for="bzip" class="textInput<% if(isBillError[4]) { %> error<% } %>">Zip: </label>
                                <input type="text" maxlength="5" name="bzip" id="bzip" class="textInput" value="<% if(billAddress.getZip() != -1) { %> <%= billAddress.getZip() %> <% } %>">
                            </li>
                        </ul>
                    </fieldset>
                    <h2>Contact</h2>
                    <fieldset>
                        <legend <% if(falseIfAllFalse(isPhoneError)) { %>class="error"<% } %>>Phone Number</legend>
                        <ul>
                            <li>
                                <label for="homePhone" class="textInput<% if(isPhoneError[0]) { %> error<% } %>">Home Phone: </label>
                                <input type="text" name="homePhone" id="homePhone" class="textInput" value="<%= homePhone.getPhone() %>">
                                <input type="checkbox" name="homeIsPrimary" id="homeIsPrimary" value="homeIsPrimary" class="checkbox" <% if(homePhone.getIsPrimary()) { %>checked<% } %>>
                                <label for="homeIsPrimary" class="checkbox<% if(isPhoneError[1]) { %> error<% } %>">Primary Phone</label> 
                            </li>
                            <li>
                                <label for="cellPhone" class="textInput<% if(isPhoneError[2]) { %> error<% } %>">Cell Phone: </label>
                                <input type="text" name="cellPhone" id="cellPhone" class="textInput" value="<%= cellPhone.getPhone() %>">
                                <input type="checkbox" name="cellIsPrimary" id="cellIsPrimary" value="cellIsPrimary" class="checkbox" <% if(cellPhone.getIsPrimary()) { %>checked<% } %>>
                                <label for="cellIsPrimary" class="checkbox<% if(isPhoneError[3]) { %> error<% } %>">Primary Phone</label>
                            </li>
                        </ul>
                    </fieldset>
                    <h2>Payment Information</h2>
                    <fieldset>
                        <legend <% if(falseIfAllFalse(isCreditError)) { %>class="error"<% } %>>Credit Card</legend>
                        <ul>
                            <li>
                                <label class="textInput<% if(isCreditError[0]) { %> error<% } %>">Credit Card Type: </label>
                                <input type="radio" name="cardType" id="visa" value="visa" class="radio" <% if(creditCard.getCardType().equals("visa")) { %>checked="checked"<% } %>>
                                <label for="visa" class="radio">Visa</label>

                                <input type="radio" name="cardType" id="mastercard" value="mastercard" class="radio" <% if(creditCard.getCardType().equals("mastercard")) { %>checked="checked"<% } %>>
                                <label for="mastercard" class="radio">Mastercard</label>

                                <input type="radio" name="cardType" id="discover" value="discover" class="radio" <% if(creditCard.getCardType().equals("discover")) { %>checked="checked"<% } %>>
                                <label for="discover" class="radio">Discover</label>
                            </li>
                            <li>
                                <label for="cardNumber" class="textInput <% if(isCreditError[1]) { %>error<% } %>">Credit Card Number: </label>
                                <input type="text" name="cardNumber" id="cardNumber" class="textInput" value="<%= creditCard.getCardNumber() %>">
                            </li>
                            <li>
                                <label for="cardMonth" class="textInput <% if(isCreditError[2]) { %>error<% } %>">Card Expiration Date (MM/YY): </label>
                                <input type="text" maxlength="2" name="cardMonth" id="cardMonth" class="textInputSmall" value="<%= creditCard.getCardMonth() %>">
                                <input type="text" maxlength="2" name="cardYear" id="cardYear" class="textInputSmall" value="<%= creditCard.getCardYear() %>">
                            </li>
                            <li>
                                <label for="nameOnCard" class="textInput <% if(isCreditError[3]) { %>error<% } %>">Name on Card: </label>
                                <input type="text" name="nameOnCard" id="nameOnCard" class="textInput" value="<%= creditCard.getNameOnCard() %>">
                            </li>
                        </ul>
                    </fieldset>
                    <input type="submit" value="submit">
                    <input type="hidden" name="action" value="checkout_submit">
                </form>
            </section>
        </div>

        <%@include file="../footer.jsp" %>
    </div>
</body>

</html>