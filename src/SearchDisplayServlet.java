package tunebazaar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;


public class SearchDisplayServlet extends HttpServlet {

    // Servlet Constants
    private final String RESULT_URL = "/searchResult.jsp";
//    private final String RESULT_URL = "/ClassProjectServlets/home.jsp";

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
        
        //Instantiate the JavaBean for the search results
        SearchResultBean searchResult = new SearchResultBean();
        
        // Get search attributes from request
        String searchAction = (String) request.getParameter("searchAction");
        String searchString = "";
        if (searchAction.equalsIgnoreCase("searchByRelevance"))
            searchString = (String) request.getParameter("searchByRelevanceString");
        else if (searchAction.equalsIgnoreCase("searchByGenre"))
            searchString = (String) request.getParameter("searchByGenreString");
        else if (searchAction.equalsIgnoreCase("searchByArtist"))
            searchString = (String) request.getParameter("searchByArtistString");
        if (searchString.length() == 0)
            searchString = "Empty";
        
        
        // Use searchText for querying database
        Connection connection = DatabaseUtil.createConnection();
        try {
            PreparedStatement mainPreparedStatement = getQueryCommand(searchAction, searchString, connection);
            ResultSet searchResultSet = mainPreparedStatement.executeQuery();
            int tempAlbumID;
            String tempAlbumName;
            String tempAlbumFilepath;
            String tempArtistName;
            String tempAlbumYear;
            int tempAlbumRating;
            
            // Process the query results and populate a Javabean which persists in the request
            while (searchResultSet.next()) {
                tempAlbumID = searchResultSet.getInt("album_id");
                tempAlbumName = searchResultSet.getString("album_name");
                tempAlbumFilepath = searchResultSet.getString("image_filepath");
                tempArtistName = searchResultSet.getString("artist_name");
                tempAlbumYear = searchResultSet.getString("release_year");
                tempAlbumRating = 0;
                
                // Query for ratings for the album
                PreparedStatement ratingPreparedStatement = getQueryCommand("getRating", tempAlbumName, connection);
                ResultSet ratingResultSet = ratingPreparedStatement.executeQuery();
                
                // Process rating result set and set rating value
                int ratingSum = 0;
                int ratingCount = 0;
                while (ratingResultSet.next()){
                    ratingSum = ratingSum + ratingResultSet.getInt("rating_value");
                    ratingCount++;
                }
                if (ratingCount != 0)
                    tempAlbumRating = (int)ratingSum/ratingCount;
                
                // Add the DetailedAlbum to the list
                DetailedAlbum tempDetailedAlbum = new DetailedAlbum(tempAlbumID, tempAlbumName, tempAlbumFilepath,
                        tempArtistName, tempAlbumRating, tempAlbumYear);
                searchResult.addDetailedAlbum(tempDetailedAlbum);              
            }
        }
        catch (SQLException ex) {
                Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            // close the connection
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(SearchDisplayServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Forward the bean along witht he searchText attribute to the RESULT_URL
        request.setAttribute("searchResultForDisplay", searchResult);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(RESULT_URL);
        dispatcher.forward(request, response);
    }
    
    private PreparedStatement getQueryCommand(String action, String searchString, Connection connection) {
        
        String command;
        PreparedStatement preparedStatement = null;
        if (action.equalsIgnoreCase("searchByRelevance")) {
            command = "SELECT albums.album_id, albums.album_name, albums.image_filepath, artists.artist_name,"
                    + " albums.release_year \n" +
                      "FROM albums " + 
                      "JOIN artists ON albums.artist_id = artists.artist_id \n" +
                      "WHERE albums.album_name LIKE ?" +
                      " OR artists.artist_name LIKE ?";
            try {
                preparedStatement = connection.prepareStatement(command);
                preparedStatement.setString(1, "%" + searchString + "%");
                preparedStatement.setString(2, "%" + searchString + "%");
            }
            catch (SQLException ex) {
                Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (action.equalsIgnoreCase("searchByGenre")) {
            command = "SELECT albums.album_id, albums.album_name, albums.image_filepath, artists.artist_name,"
                    + " albums.release_year \n" +
                      "FROM albums " + 
                      "JOIN artists ON albums.artist_id = artists.artist_id \n" +
                      "JOIN genre ON genre.genre_id = artists.genre_id \n" +
                      "WHERE genre.genre_name LIKE ?";
            try {
                preparedStatement = connection.prepareStatement(command);
                preparedStatement.setString(1, "%" + searchString + "%");
            }
            catch (SQLException ex) {
                Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (action.equalsIgnoreCase("searchByArtist")){
            command = "SELECT albums.album_id, albums.album_name, albums.image_filepath, artists.artist_name," +
                      " albums.release_year \n" +
                      "FROM albums " + 
                      "JOIN artists ON albums.artist_id = artists.artist_id \n" +
                      "WHERE artists.artist_name LIKE ?";
            try {
                preparedStatement = connection.prepareStatement(command);
                preparedStatement.setString(1, "%" + searchString + "%");
            }
            catch (SQLException ex) {
                Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        else if (action.equalsIgnoreCase("getRating")) {
            command = "SELECT ratings.rating_value \n" +
                      "FROM albums JOIN ratings ON albums.album_id = ratings.product_id \n" +
                      "WHERE albums.album_name LIKE ?";
            try {
                preparedStatement = connection.prepareStatement(command);
                preparedStatement.setString(1, "%" + searchString + "%");
            }
            catch (SQLException ex) {
                Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return preparedStatement;
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
