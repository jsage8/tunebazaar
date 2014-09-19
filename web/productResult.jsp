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
    <link rel="stylesheet" type="text/css" href="css/tunebazaar/style.css" />
    
    
</head>
    
<body id="main">
    <%@ page import="java.util.List" %>
    <%@ page import="tunebazaar.AlbumDetailsBean" %>
    <%@ page import="tunebazaar.Review" %>
    <%@ page import="tunebazaar.Song" %>
    <%
        AlbumDetailsBean albumInfo = (AlbumDetailsBean) session.getAttribute("albumDetailsForDisplay");
        if (albumInfo == null) {
            albumInfo = new AlbumDetailsBean();
        }
        List<Song> songsList = albumInfo.getSongs();
        List<Review> reviewsList = albumInfo.getReviews();
    %>
    <div id="wrap">
        <%@include file="header.jsp" %>

        <div id="content">
            <%@include file="navigation.jsp" %>

            <section class="standard_section" id="output">
                <form name="to_cart" id="to_cart" action="/ShoppingCartServlet" method="get">
                    <input class="wide_button" type="submit" value="Add to Cart">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="albumProductID" value="<%= albumInfo.getAlbumID() %>">
                    <input type="hidden" value="<%= request.getRequestURI() %>" name="originURI">
                </form>
                <img class="album_cover" src="<%= albumInfo.getAlbumArtworkFilepath() %>">
                <article class="basic_info">
                    <h2><%= albumInfo.getAlbumName() %></h2>
                    <a class="artist_name" href="SearchDisplayServlet?searchByArtistString=<%= albumInfo.getArtistName() %>&searchAction=searchByArtist"><p><%= albumInfo.getArtistName() %></p></a>
                    <p>Rating: <% if(albumInfo.getAverageRating() < 0) { %>Not Yet Rated<% } else { %><%= albumInfo.getAverageRating() %><% } %></p>
                    <p>Release Date: <%= albumInfo.getReleaseYear() %></p>
                </article>
                
                <article class="tracks">
                    <h2>Track Listing</h2>
                    <table class="tracks">
                        <% for (int i = 0; i < songsList.size(); i++) { %>
                        <tr>
                            <td><%= songsList.get(i).getTrackNumber() %></td>
                            <td><%= songsList.get(i).getSongName() %></td>
                            <td>
                                <audio controls preload="none">
                                    <source src="<%= songsList.get(i).getFilePath() %>" type="audio/mpeg">
                                    Audio Not Supported! Upgrade your browser.
                                </audio>
                            </td>
                        </tr>
                        <% } %>
                    </table>
                </article>
                    
                <article class="reviews">
                    <h2>Reviews</h2>
                    <% if(reviewsList.size() <= 0) { %>
                    <p>There are no reviews for this product. Be the <a href="ReviewServlet?reviewByAlbumString=<%= albumInfo.getAlbumName() %>">first!</a></p>
                    <% } else { %>
                    <table class="tracks">
                        <%
                            for (int i = 0; i < reviewsList.size(); i++) { 
                                Review tempReview = reviewsList.get(i);
                        %>
                        <tr>
                            <td><%= i%></td>
                            <td><%= tempReview.getUserName() %></td>
                            <td><%= tempReview.getRating() %></td>
                            <td><%= tempReview.getComment() %></td>
                        </tr>
                        <% } %>
                    </table>
                    <p>Own this product? Review it <a href="ReviewServlet?reviewByAlbumString=<%= albumInfo.getAlbumName() %>">here!</a></p>
                    <% } %>
                </article>    
            </section>
        </div>

        <%@include file="footer.jsp" %>

    </div>
</body>

</html>
