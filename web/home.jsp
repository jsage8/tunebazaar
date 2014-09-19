<%-- 
    Document   : index
    Created on : Nov 15, 2013, 11:14:42 PM
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
        <h1>Servlet Tester by Cheng Ren</h1>
        
        <!------------------------------------------------------------------------------->
        <!--------------------------- TESTING WelcomingServlet -------------------------->
        <!------------------------------------------------------------------------------->
        <fieldset style="width:400px; background-color:#ffffdd">
            <legend align="left">WelcomingServlet Testing</legend>
            <form action="/WelcomingServlet" method="get" style="width:500px" align="left">
                <input type="submit" value="Test WelcomingServlet">
                <input type="hidden" name="goal" value="none">
            </form>

            <form action="/WelcomingServlet" method="get" style="width:500px" align="left">
                <input type="submit" value="Delete All Cookies">
                <input type="hidden" name="goal" value="remove">
            </form>

            <table border="1">
                <%@ page import="tunebazaar.RecommendationsBean" %>
                <%@ page import="java.util.List" %>
                <%
                    RecommendationsBean recommendations = (RecommendationsBean) request.getAttribute("recommendations");
                    if (recommendations == null) {
                        recommendations = new RecommendationsBean();
                    }

                    List<String> albumNamesList = recommendations.getAlbumNameList();
                    List<String> albumArtworkPathList = recommendations.getFilePathList();

                    for (int i = 0; i < albumNamesList.size(); i++) {
                %>
                <tr>
                    <td>
                        <%= i%>: album name (<%= albumNamesList.get(i)%>)  Path(<%= albumArtworkPathList.get(i)%>)
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </fieldset>
            <br>
            <br>
        
        <!------------------------------------------------------------------------------->
        <!------------------------- TESTING SearchDisplayServlet------------------------->
        <!------------------------------------------------------------------------------->
        <fieldset style="width:400px; background-color:#ffffdd">
            <legend align="left">SearchDisplayServlet Testing</legend>
            <form action="/SearchDisplayServlet" method="get" style="width:500px" align="left">
                Search Relevant Word:<input type="text" style="background-color:#ffffaa; width:150px" name="searchByRelevanceString">
                <input type="submit" value="Search">
                <input type="hidden" name="searchAction" value="searchByRelevance">
            </form>

            <form action="/SearchDisplayServlet" method="get" style="width:500px" align="left">
                Search Genre:<input type="text" style="background-color:#ffffaa; width:150px" name="searchByGenreString">
                <input type="submit" value="Search">
                <input type="hidden" name="searchAction" value="searchByGenre">
            </form>

            <form action="/SearchDisplayServlet" method="get" style="width:500px" align="left">
                Search Artist:<input type="text" style="background-color:#ffffaa; width:150px" name="searchByArtistString">
                <input type="submit" value="Search">
                <input type="hidden" name="searchAction" value="searchByArtist">
            </form>
            <br>
            <table border="1" spacing="0">
                <tr>
                    <td>#</td>
                    <td>Album Name</td>
                    <td>File Path</td>
                    <td>Artist Name</td>
                    <td>Year</td>
                    <td>Rating</td>
                </tr>
                <%@ page import="tunebazaar.SearchResultBean" %>
                <%@ page import="tunebazaar.DetailedAlbum" %>
                <%
                    SearchResultBean searchResult = (SearchResultBean) request.getAttribute("searchResultForDisplay");
                    if (searchResult == null) {
                        System.out.println("(DEBUG)home.jsp: searchResult is null");
                        searchResult = new SearchResultBean();
                    }

                    List<DetailedAlbum> detailedAlbumList = searchResult.getDetailedAlbumList();
                    for (int i = 0; i < detailedAlbumList.size(); i++) {
                %>
                <tr>
                    <td><%= i%></td>
                    <td><%= detailedAlbumList.get(i).getAlbumName()%></td>
                    <td><%= detailedAlbumList.get(i).getFilePath()%></td>
                    <td><%= detailedAlbumList.get(i).getArtistName()%></td>
                    <td><%= detailedAlbumList.get(i).getYear()%></td>
                    <td><%= detailedAlbumList.get(i).getRating()%></td>
                </tr>
                <%
                    }
                %>
            </table>
        </fieldset>
        
            
        <!------------------------------------------------------------------------------->
        <!------------------------- TESTING DisplayProductServlet ----------------------->
        <!------------------------------------------------------------------------------->
        <fieldset style="width:400px; background-color:#ffffdd">
            <legend align="left">DisplayProductServlet Testing</legend>
            <form action="/DisplayProductServlet" method="get" style="width:500px" align="left">
                Get Album Information:<input type="text" style="background-color:#ffffaa; width:150px" name="albumName">
                <input type="submit" value="Search">
            </form>
            <table border="1" spacing="0">
                <%@ page import="tunebazaar.AlbumDetailsBean" %>
                <%@ page import="tunebazaar.Review" %>
                
                <%
                    AlbumDetailsBean albumInfo = (AlbumDetailsBean) session.getAttribute("albumDetailsForDisplay");
                    if (albumInfo == null) {
                        System.out.println("(DEBUG)home.jsp: albumInfo is null");
                        albumInfo = new AlbumDetailsBean();
                    } else {
                %>

                <tr>
                    <td>Album Name:</td>
                    <td><%= albumInfo.getAlbumName()%></td>
                </tr>
                <tr>
                    <td>Artist Name :</td>
                    <td><%= albumInfo.getArtistName()%></td>
                </tr>
                <tr>
                    <td>Release Year:</td>
                    <td><%= albumInfo.getReleaseYear()%></td>
                </tr>
                <tr>
                    <td>Average Rating:</td>
                    <td><%= albumInfo.getAverageRating()%></td>
                </tr>
                <tr>
                    <td>Artwork Filepath:</td>
                    <td><%= albumInfo.getAlbumArtworkFilepath()%></td>
                </tr>
                <tr>
                    <td colspan="2">SONGS</td>
                </tr>
                <%
                    List<String> songsList = albumInfo.getSongs();
                    for (int i = 0; i < songsList.size(); i++) {
                %>
                <tr>
                    <td><%= i%></td>
                    <td><%= songsList.get(i)%></td>
                </tr>
                <%
                    }
                %>
                <tr>
                    <td colspan="2">Reviews</td>
                </tr>
                <%
                    List<Review> reviewsList = albumInfo.getReviews();
                    for (int i = 0; i < reviewsList.size(); i++) {
                        Review tempReview = reviewsList.get(i);
                %>
                <tr>
                    <td><%= i%></td>
                    <td><%= tempReview.getUserName() %></td>
                    <td><%= tempReview.getRating() %></td>
                    <td><%= tempReview.getComment() %></td>
                </tr>
                <%
                        }

                    }
                %>
            </table>
        </fieldset>
    </body>
</html>
