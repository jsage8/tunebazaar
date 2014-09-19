package tunebazaar;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AvailableGenres {

    public static List<String> getAvailableGenres() {

        List<String> genres = new ArrayList<String>();

        Connection tc = DatabaseUtil.createConnection();

        try {
            // Select only the genres that have artists associated with them
            String genreQueryCommand = "SELECT genre.genre_name " +
                                        "FROM genre " +
                                        "WHERE genre_id IN " +
                                            "(SELECT DISTINCT artists.genre_id " +
                                            "FROM artists) " +
                                        "ORDER BY genre.genre_name";
            
            Statement genreQueryStatement = tc.createStatement();
            ResultSet genreResultSet = genreQueryStatement.executeQuery(genreQueryCommand);

            while (genreResultSet.next()) {
                genres.add(genreResultSet.getString("genre_name"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(AvailableGenres.class.getName()).log(Level.SEVERE, null, ex);
        }

        return genres;
    }
}