package tunebazaar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

        
public class DisplayProductServlet extends HttpServlet {

    // Servlet Constants
    private final String PRODUCT_URL = "/productResult.jsp";
//    private final String PRODUCT_URL = "/ClassProjectServlet/home.jsp";
    
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
        
        //Instantiate the JavaBean for the album information
        AlbumDetailsBean albumDetails = new AlbumDetailsBean();
        
        // Get album information from the request
        String selectedAlbumIDString = request.getParameter("albumID");
        if (selectedAlbumIDString == null)
            selectedAlbumIDString = (String) request.getAttribute("albumID");
        int selectedAlbumID = Integer.parseInt(selectedAlbumIDString);
            
        // Use album information to query DB for display information
        Connection connection = DatabaseUtil.createConnection();
        try {
            // Query the basic album information first
            PreparedStatement albumInfoPreparedStatement = getQueryCommand("generalAlbumInfo", selectedAlbumID, connection);
            ResultSet infoResultSet = albumInfoPreparedStatement.executeQuery();
            
            if (infoResultSet.next()) {
                albumDetails.setAlbumID(infoResultSet.getInt("album_id"));
                albumDetails.setAlbumName(infoResultSet.getString("album_name"));
                albumDetails.setAlbumArtworkFilepath(infoResultSet.getString("image_filepath"));
                albumDetails.setArtistName(infoResultSet.getString("artist_name"));
                albumDetails.setPrice(infoResultSet.getDouble("price"));
                albumDetails.setReleaseYear(infoResultSet.getString("release_year"));
            }
            
            // Query the songs list
            PreparedStatement albumSongsPreparedStatement = getQueryCommand("albumSongsList", selectedAlbumID, connection);
            ResultSet songsResultSet = albumSongsPreparedStatement.executeQuery();
            
            List<Song> tempSongs = new ArrayList<Song>();
            Song tempSong;
            String tempSongName;
            int tempTrackNumber;
            String tempFilePath;
            while (songsResultSet.next()) {
                tempSongName = songsResultSet.getString("song_name");
                tempTrackNumber = songsResultSet.getInt("track_number");
                tempFilePath = songsResultSet.getString("filepath");
                
                tempSong = new Song(tempSongName, tempTrackNumber, tempFilePath);
                tempSongs.add(tempSong);
            }
            albumDetails.setSongs(tempSongs);
            
            // Query the reviews
            PreparedStatement reviewsPreparedStatement = getQueryCommand("albumReviewsList", selectedAlbumID, connection);
            ResultSet reviewsResultSet = reviewsPreparedStatement.executeQuery();
            
            List<Review> tempReviews = new ArrayList<Review>();
            int sumRating = 0;
            int countRating = 0;
            while (reviewsResultSet.next()) {
                Review tempReview = new Review();
                tempReview.setUserName(reviewsResultSet.getString("username"));
                tempReview.setRating(reviewsResultSet.getInt("rating_value"));
                tempReview.setComment(reviewsResultSet.getString("comments"));
                tempReviews.add(tempReview);
                sumRating = sumRating + reviewsResultSet.getInt("rating_value");
                countRating++;
            }
            albumDetails.setReviews(tempReviews);
            if (countRating != 0) {
                int avgRating = sumRating / countRating;
                albumDetails.setAverageRating(avgRating);
            }
            // Close the connection
            connection.close();
        }
        catch (SQLException ex) {
                Logger.getLogger(DisplayProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Forward album details to product form jsp
        HttpSession session = request.getSession();
        session.setAttribute("albumDetailsForDisplay", albumDetails);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(PRODUCT_URL);
        dispatcher.forward(request, response);

    }
    
    private PreparedStatement getQueryCommand(String action, int searchInt, Connection connection) {
        String command;
        PreparedStatement preparedStatement = null;
        if (action.equalsIgnoreCase("generalAlbumInfo")) {
            command = "SELECT albums.album_id, albums.album_name, artists.artist_name, " +
                    "albums.release_year, albums.image_filepath, albums.price\n" +
                    "FROM albums JOIN artists ON albums.artist_id = artists.artist_id\n" +
                    "WHERE albums.album_id = ?";
            try {
                preparedStatement = connection.prepareStatement(command);
                preparedStatement.setInt(1, searchInt);
            }
            catch (SQLException ex) {
                Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (action.equalsIgnoreCase("albumSongsList")) {
            command = "SELECT songs.song_name, songs.track_number, songs.filepath\n" +
                      "FROM albums JOIN songs on albums.album_id = songs.album_id\n" +
                      "WHERE albums.album_id = ?\n" +
                      "ORDER BY songs.track_number";
            try {
                preparedStatement = connection.prepareStatement(command);
                preparedStatement.setInt(1, searchInt);
            }
            catch (SQLException ex) {
                Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (action.equalsIgnoreCase("albumReviewsList")) {
            command = "SELECT users.username, ratings.rating_value, ratings.comments\n" +
                      "FROM albums JOIN ratings ON albums.album_id = ratings.product_id\n" +
                      "JOIN users ON users.user_id = ratings.user_id\n" +
                      "WHERE albums.album_id = ?";
            try {
                preparedStatement = connection.prepareStatement(command);
                preparedStatement.setInt(1, searchInt);
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