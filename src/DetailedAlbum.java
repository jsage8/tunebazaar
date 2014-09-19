package tunebazaar;

public class DetailedAlbum {
    private int albumID;
    private String albumName;
    private String filePath;
    private String artistName;
    private int rating;
    private String year;
    
    public DetailedAlbum() {
        albumID = -1;
        albumName = "";
        filePath = "";
        artistName = "";
        rating = -1;
        year = "";
    }
    
    public DetailedAlbum(int newAlbumID, String newAlbumName, String newFilePath, String newArtistName) {
        albumID = newAlbumID;
        albumName = newAlbumName;
        filePath = newFilePath;
        artistName = newArtistName;
        rating = -1;
        year = "";
    }
    
    public DetailedAlbum(int newAlbumID, String newAlbumName, String newFilePath, String newArtistName, int newRating, String newYear) {
        albumID = newAlbumID;
        albumName = newAlbumName;
        filePath = newFilePath;
        artistName = newArtistName;
        rating = newRating;
        year = newYear;
    }
    
    public int getAlbumID() {
        return this.albumID;
    }
    
    public String getAlbumName() {
        return this.albumName;
    }
    
    public String getFilePath() {
        return this.filePath;
    }
    
    public String getArtistName() {
        return this.artistName;
    }
    
    public int getRating() {
        return this.rating;
    }
    
    public String getYear() {
        return this.year;
    }
}
