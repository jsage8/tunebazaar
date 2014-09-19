<%-- 
    Document   : home_userAccountForm
    Created on : Dec 3, 2013, 4:25:14 PM
    Author     : cren
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ page import="tunebazaar.UserAccountBean" %>
        <%
            String userAccountMessage = (String) request.getAttribute("userAccountMessage");
                if (userAccountMessage == null) {
                    userAccountMessage = "";
                }

                UserAccountBean userInfo = (UserAccountBean) request.getAttribute("userInfo");
                if (userInfo == null) {
                    userInfo = new UserAccountBean();
                }
        %>
        
        <form action="/UserAccountServlet" method="get">
            Username:<input type="text" name="newUsername" value="<%= userInfo.getUserName() %>">
            <br>
            Password:<input type="password" name="newPassword" value="<%= userInfo.getPassword() %>">
            <br>
            First Name:<input type="text" name="newFirstName" value="<%= userInfo.getFirstName() %>">
            <br>
            Last Name:<input type="text" name="newLastName" value="<%= userInfo.getLastName() %>">
            <br>
            Middle Initial:<input type="text" style="width: 10px" name="newMiddleInitial" value="<%= userInfo.getMiddleInitial() %>" maxlength="1">
            <br>
            Email:<input type="text" name="newEmail" value="<%= userInfo.getEmailAddress() %>">
            
            <%
                String accountLoggedIn = (String) session.getAttribute("logged-in");
                if (accountLoggedIn.equalsIgnoreCase("true")) {
            %>
            <input type="hidden" name="action" value="modify_submit">
            <%
                }
                else {
            %>
            <input type="hidden" name="action" value="add_submit">
            <%
                }
            %>
            
            <input type="submit" name="postAccountInfo" value="Submit">
        </form>
            
            
            <br>
            
            <%
                if (!userAccountMessage.equalsIgnoreCase("")) {
            %>
            <p> Message: <%= userAccountMessage %> </p>
            <%
                }
            %>
    </body>
</html>
