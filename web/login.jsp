<%-- 
    Document   : login
    Created on : Dec 2, 2013, 2:47:54 PM
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
        Boolean[] isLoginError = (Boolean[]) request.getAttribute("isLoginError");
        Boolean[] isAccountError = (Boolean[]) request.getAttribute("isAccountError");
        Boolean[] isBasicError = (Boolean[]) request.getAttribute("isBasicError");

        if(errorMessage == null) { errorMessage = ""; }
        if(isLoginError == null) {
            isLoginError = new Boolean[1];
            for(int i = 0; i < isLoginError.length; i++) {
                isLoginError[i] = false;
            }
        }
        if(isAccountError == null) {
            isAccountError = new Boolean[2];
            for(int i = 0; i < isAccountError.length; i++) {
                isAccountError[i] = false;
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
                <div>
                    <h2>Login</h2>
                    <% if(falseIfAllFalse(isLoginError)) { %>
                    <p class="error"><%= errorMessage %></p>
                    <% } %>
                    <form id="loginForm" name="loginForm" action="/UserAccountServlet" method="get">
                        <fieldset>
                            <legend <% if(falseIfAllFalse(isLoginError)) { %>class="error"<% } %>>Already a member? Login</legend>
                            <ul>
                                <li>
                                    <label for="userName" class="textInput <% if(isLoginError[0]) { %>error<% } %>">User <span class="access">N</span>ame: </label>
                                    <input accesskey="n" type="text" name="userName" id="userName" class="textInput" value="<%= userAccount.getUserName() %>">
                                </li>
                                <li>
                                    <label for="password" class="textInput <% if(isLoginError[0]) { %>error<% } %>"><span class="access">P</span>assword: </label>
                                    <input accesskey="p" type="password" name="password" id="password" class="textInput">
                                </li>
                            </ul>
                        </fieldset>
                        <input id="loginSubmit" type="submit" value="submit">
                        <input type="hidden" name="action" value="login_submit">
                    </form>
                </div>
                <hr>
                <div>
                    <h2>New User</h2>
                    <% if(falseIfAllFalse(isAccountError)) { %>
                    <p class="error"><%= errorMessage %></p>
                    <% } %>
                    <form id="newUserForm" name="newUserForm" action="/UserAccountServlet" method="get">
                        <fieldset>
                            <legend <% if(falseIfAllFalse(isAccountError)) { %>class="error"<% } %>>New user? Create an account!</legend>
                            <ul>
                                <li>
                                    <label for="newUserName" class="textInput <% if(isAccountError[0]) { %>error<% } %>"><span class="access">U</span>ser Name: </label>
                                    <input accesskey="u" type="text" name="newUserName" id="newUserName" class="textInput" value="<%= userAccount.getUserName() %>">
                                </li>
                                <li>
                                    <label for="newPassword" class="textInput <% if(isAccountError[1]) { %>error<% } %>">Pa<span class="access">s</span>sword: </label>
                                    <input accesskey="s" type="password" name="newPassword" id="newPassword" class="textInput">
                                </li>
                            </ul>
                        </fieldset>
                        <fieldset>
                            <legend <% if(falseIfAllFalse(isBasicError)) { %>class="error"<% } %>>Basic Information</legend>
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
                        <input type="hidden" name="action" value="add_submit">
                    </form>
                </div>
                
                
            </section>
        </div>

        <%@include file="../footer.jsp" %>
    </div>
</body>

</html>