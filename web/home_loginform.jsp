<%-- 
    Document   : home_loginform
    Created on : Dec 2, 2013, 2:32:30 PM
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
        <%
            String message = (String) request.getAttribute("userAccountMessage");
            if (message == null)
                message = "";
            String uname = (String) request.getAttribute("username");
            if (uname == null)
                uname = "";
        %>
        <fieldset style="width:400px; background-color:#ffffdd">
            <form action="/UserAccountServlet" method="post" style="width:400px">
                <table border="0" spacing="5">
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" style="background-color:#ffffaa; width:200px" name="username" value="<%= uname %>"></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" style="background-color:#ffffaa; width:200px" name="password"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Submit"></td>
                    </tr>
                </table>
                <input type="hidden" name="action" value="submit">
            </form>
            
            <p><%= message %></p>
        </fieldset>
    </body>
</html>
