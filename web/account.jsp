<%-- 
    Document   : account.jsp
    Created on : Dec 4, 2013, 10:23:40 PM
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
    <%
        String errorMessage = (String) request.getAttribute("userAccountMessage");
        Boolean[] isPasswordError = (Boolean[]) request.getAttribute("isPasswordError");
        Boolean[] isBasicError = (Boolean[]) request.getAttribute("isBasicError");

        if(errorMessage == null) { errorMessage = ""; }

        if(isPasswordError == null) {
            isPasswordError = new Boolean[3];
            for(int i = 0; i < isPasswordError.length; i++) {
                isPasswordError[i] = false;
            }
        }
        if(isBasicError == null) {
            isBasicError = new Boolean[4];
            for(int i = 0; i < isBasicError.length; i++) {
                isBasicError[i] = false;
            }
        }

        
    %>
    
    <%!
        public boolean falseIfAllFalse(Boolean[] array) {
            for(boolean b : array) {
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
                <h2><%= userAccount.getUserName() %> Account Information</h2>
                <% if(falseIfAllFalse(isPasswordError)) { %>
                <p class="error"><%= errorMessage %></p>
                <% } %>
                <form id="newUserForm" name="newUserForm" action="/UserAccountServlet" method="get">
                    <fieldset>
                        <legend <% if(falseIfAllFalse(isPasswordError)) { %>class="error"<% } %>>Password Change</legend>
                        <ul>
                            <li>
                                <label for="oldPassword1" class="textInput <% if(isPasswordError[0]) { %>error<% } %>">Old Password: </label>
                                <input type="password" name="oldPassword1" id="oldPassword1" class="textInput">
                            </li>
                            <li>
                                <label for="newPassword1" class="textInput <% if(isPasswordError[1]) { %>error<% } %>">New Password: </label>
                                <input type="password" name="newPassword1" id="newPassword1" class="textInput">
                            </li>
                            <li>
                                <label for="newPassword2" class="textInput <% if(isPasswordError[2]) { %>error<% } %>">Re-Type New Password: </label>
                                <input type="password" name="newPassword2" id="newPassword2" class="textInput">
                            </li>
                        </ul>                        
                    </fieldset>
                    <fieldset>
                        <legend <% if(falseIfAllFalse(isBasicError)) { %>class="error"<% } %>>Basic Information Change</legend>
                        <ul>
                            <li>
                                <label for="firstName" class="textInput <% if(isBasicError[0]) { %>error<% } %>"><span class="access">F</span>irst Name: </label>
                                <input accesskey="f" type="text" name="firstName" id="firstName" class="textInput" value="<%= userAccount.getFirstName() %>">
                            </li>
                            <li>
                                <label for="middleInitial" class="textInput<% if(isBasicError[1]) { %>error<% } %>">Middle Initial</label>
                                <input type="text" name="middleInitial" id="middleInitial" class="textInput" maxlength="1" value="<%= userAccount.getMiddleInitial() %>">
                            </li>
                            <li>
                                <label for="lastName" class="textInput <% if(isBasicError[2]) { %>error<% } %>"><span class="access">L</span>ast Name: </label>
                                <input accesskey="l" type="text" name="lastName" id="lastName" class="textInput" value="<%= userAccount.getLastName() %>">
                            </li>
                            <li>
                                <label for="emailAddress" class="textInput <% if(isBasicError[3]) { %>error<% } %>"><span class="access">E</span>-mail Address: </label>
                                <input accesskey="e" type="text" name="emailAddress" id="emailAddress" class="textInput" value="<%= userAccount.getEmailAddress() %>">
                            </li>
                        </ul>
                    </fieldset>
                    <input id="newUserSubmit" type="submit" value="submit">
                    <input type="hidden" name="action" value="modify_submit">
                </form>
            </section>
        </div>

        <%@include file="../footer.jsp" %>
    </div>
</body>

</html>
