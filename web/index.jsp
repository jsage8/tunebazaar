<%-- 
    Document   : index
    Created on : Nov 2, 2013, 12:27:43 PM
    Author     : jsage8
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tune Bazaar</title>
    <link rel="stylesheet" type="text/css" href="../css/tunebazaar/style.css" />
</head>
    
<body id="main">
    <%@ page import="java.util.List" %>
    <%@ page import="tunebazaar.SearchResultBean" %>
    <%@ page import="tunebazaar.DetailedAlbum" %>
    <%
        SearchResultBean searchResult = (SearchResultBean) request.getAttribute("searchResultForDisplay");
        if (searchResult == null) {
            searchResult = new SearchResultBean();
        }

        List<DetailedAlbum> detailedAlbumList = searchResult.getDetailedAlbumList();
        int rowLength = 5;
    %>

    <div id="wrap">
        <%@include file="../header.jsp" %>

        <div id="content">
            <%@include file="../navigation.jsp" %>

            <section class="standard_section" id="output">
                <h2>Recommended</h2>
                <table class="thumbnails">
                    <tbody id="recommended">
                    <% for(int i = 0; i < detailedAlbumList.size(); i++) { %>    
                        <% if(i % rowLength == 0) { %>
                        <tr>
                        <% } %>
                            <td>
                                <a href="DisplayProductServlet?albumID=<%= detailedAlbumList.get(i).getAlbumID() %>">
                                    <img src="<%= detailedAlbumList.get(i).getFilePath() %>" width="150">
                                </a>
                                <a class="album_name" href="DisplayProductServlet?albumID=<%= detailedAlbumList.get(i).getAlbumID() %>"><%= detailedAlbumList.get(i).getAlbumName() %></a>
                                <a class="artist_name" href="SearchDisplayServlet?searchByArtistString=<%= detailedAlbumList.get(i).getArtistName() %>&searchAction=searchByArtist"><%= detailedAlbumList.get(i).getArtistName() %></a>
                            </td>
                        <% if(i % rowLength == rowLength - 1) { %>
                        </tr>
                        <% } %>
                    <% } %>
                    </tbody>
                </table>
            </section>
        </div>

        <%@include file="../footer.jsp" %>
    </div>
</body>

</html>
