package tunebazaar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class IndexServlet extends HttpServlet {

    // Servlet Constants
    private final String HOME_URL = "/WEB-INF/index.jsp";
//    private final String HOME_URL = "/ClassProjectServlets/home.jsp";

    
    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sqlQuery;
        PreparedStatement preparedStatement;
        ResultSet resultSet;
        ResultSet recommendationsResultSet = null;
   
        // Instantiate the JavaBean for the results
        SearchResultBean recommendationsList = new SearchResultBean();
        
        // Debug Message
        StringBuilder debugMessage = new StringBuilder();
        
        // Check for previous persistent cookies for a previously registered account
        Cookie[] cookies = request.getCookies();
        String accountIDCookieName = "accountIDCookie";
        String accountIDCookieValue = "";
        
        if (cookies != null) {
            for(Cookie cookie : cookies) {
                if (accountIDCookieName.equals(cookie.getName())) {
                    accountIDCookieValue = cookie.getValue();
                }
            }
        }
        
        if (accountIDCookieValue == null)
            accountIDCookieValue = "";
        
        // If a registered account is found, query database for previour purchase genres
        boolean isReturningUser = false;
        if (accountIDCookieValue.equals("") == false) {
            isReturningUser = true;
            debugMessage.append("AccountIDCookie not found!\n");
        }
        else {
            debugMessage.append("AccountIDCookie found as " + accountIDCookieValue + "  |  ");
        }
        
        // Obtain connection and perform query for most recently ordered albums
        Connection connection = DatabaseUtil.createConnection();

        int tempAlbumID;
        String tempAlbumName;
        String tempAlbumFilepath;
        String tempArtistName;
        int resultCount = 0;
        try {
            if (isReturningUser) {
                // Query for the most recent product purchases under the userID
                sqlQuery = "SELECT order_lines.product_id\n"
                        + "FROM orders JOIN order_lines ON orders.order_id = order_lines.order_id\n"
                        + "WHERE user_id = ?";
                preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, accountIDCookieValue);
                resultSet = preparedStatement.executeQuery();

                // Instantiate the genre counters list
                List<Integer> genreIDs = new ArrayList<Integer>();
                List<Integer> genreOccurrences = new ArrayList<Integer>();

                // Query for the product information to get the genre of the music
                while (resultSet.next()) {
                    sqlQuery = "SELECT artists.genre_id\n"
                            + "FROM albums JOIN artists ON albums.artist_id = artists.artist_id\n"
                            + "WHERE album_id = ?";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setInt(1, resultSet.getInt("product_id"));
                    ResultSet tempProductGenreResultSet = preparedStatement.executeQuery();

                    while (tempProductGenreResultSet.next()) {
                        int tempGenreID = tempProductGenreResultSet.getInt("genre_id");
                        if (genreIDs.contains(tempGenreID)) {
                            int tempIndex = genreIDs.indexOf(tempGenreID);
                            int newOccurrence = genreOccurrences.get(tempIndex) + 1;
                            genreOccurrences.set(tempIndex, newOccurrence);
                        } else {
                            genreIDs.add(tempGenreID);
                            genreOccurrences.add(1);
                        }
                    }
                }

                // Find the most purchased genre
                int bestGenre = -1;
                if (genreIDs.isEmpty()) {
                    // No purchase history, do nothing here and 
                } else if (genreIDs.size() == 1) {
                    bestGenre = genreIDs.get(0);
                } else {
                    Iterator<Integer> tempIterator = genreOccurrences.iterator();
                    int max = 0;
                    while (tempIterator.hasNext()) {
                        int value = tempIterator.next();
                        if (value > max) {
                            max = value;
                        }
                    }
                    bestGenre = genreIDs.get(genreOccurrences.indexOf(max));
                }

                // Use the genre ID to find 10 albums as recommendations
                resultCount = 0;
                if (bestGenre != -1) {
                    sqlQuery = "SELECT albums.album_id, albums.album_name, albums.image_filepath, artists.artist_name\n"
                            + "FROM albums\n"
                            + "JOIN artists ON albums.artist_id = artists.artist_id\n"
                            + "WHERE artists.genre_id = ?\n"
                            + "ORDER BY RAND()\n"
                            + "LIMIT 10";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setInt(1, bestGenre);
                    recommendationsResultSet = preparedStatement.executeQuery();

                    while (recommendationsResultSet.next()) {
                        tempAlbumID = recommendationsResultSet.getInt("album_id");
                        tempAlbumName = recommendationsResultSet.getString("album_name");
                        tempAlbumFilepath = recommendationsResultSet.getString("image_filepath");
                        tempArtistName = recommendationsResultSet.getString("artist_name");

                        // Add the DetailedAlbum to the list
                        DetailedAlbum tempDetailedAlbum;
                        tempDetailedAlbum = new DetailedAlbum(tempAlbumID, tempAlbumName, tempAlbumFilepath, tempArtistName);
                        recommendationsList.addDetailedAlbum(tempDetailedAlbum);
                        resultCount++;
                    }
                }
                
                debugMessage.append("AccountIDCookie used and found " + resultCount + "recommendations.  |  ");
            }
            
            int i = 0;
            
            while (resultCount < 10) {
                sqlQuery = "SELECT albums.album_id, albums.album_name, albums.image_filepath, artists.artist_name\n"
                        + "FROM albums\n"
                        + "JOIN artists ON albums.artist_id = artists.artist_id\n"
                        + "ORDER BY RAND()\n"
                        + "LIMIT ?";
                preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setInt(1, 10 - resultCount);
                recommendationsResultSet = preparedStatement.executeQuery();

                while (recommendationsResultSet.next()) {
                    tempAlbumID = recommendationsResultSet.getInt("album_id");
                    tempAlbumName = recommendationsResultSet.getString("album_name");
                    tempAlbumFilepath = recommendationsResultSet.getString("image_filepath");
                    tempArtistName = recommendationsResultSet.getString("artist_name");

                    // Add the DetailedAlbum to the list if it's not already in there
                    DetailedAlbum tempDetailedAlbum = new DetailedAlbum(tempAlbumID, tempAlbumName, tempAlbumFilepath, tempArtistName);
                    if (recommendationsList.getDetailedAlbumList().contains(tempDetailedAlbum) == false) {
                        recommendationsList.addDetailedAlbum(tempDetailedAlbum);
                        resultCount++;
                        i++;
                    }
                }
            }
            debugMessage.append("Random recommendations queried: " + i + ".  |  ");
        } 
        catch (SQLException ex) {
            Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Pass recommendations to the session object and forward request to the home page
        // Store the Registration object in the session
        HttpSession session = request.getSession();
        if (isReturningUser){
            //Set accountIDCookieValue as accountID attribute to session object
            session.setAttribute("accountID", accountIDCookieValue);
        }
        else {
            //Set "Visitor" as accountID attribute to session object
            session.setAttribute("accountID", "Vistor");
        }
        debugMessage.append("Before being passed to request, recommendationsList # of content = " + recommendationsList.getDetailedAlbumList().size() + ".  |  ");
        request.setAttribute("searchResultForDisplay", recommendationsList);
        
        Boolean tempLoggedInStatus = (Boolean) session.getAttribute("logged-in");
        if (tempLoggedInStatus == null) {
            session.setAttribute("logged-in", false);
        }
        
        
        request.setAttribute("debugMessage", debugMessage.toString());
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(HOME_URL);
        dispatcher.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
