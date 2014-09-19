package tunebazaar;

import java.util.List;
import java.util.ArrayList;

public class AlbumDetailsBean implements java.io.Serializable {
    private int albumID;
    private String albumName;
    private String artistName;
    private String releaseYear;
    private String albumArtworkFilepath;
    private double price;
    private int averageRating;
    private List<Review> reviews;
    private List<Song> songs;
    
    public AlbumDetailsBean() {
        albumID = -1;
        albumName = "";
        artistName = "";
        releaseYear = "";
        albumArtworkFilepath = "";
        price = -0.1;
        averageRating = -1;
        reviews = new ArrayList<Review>();
        songs = new ArrayList<Song>();
    }
    
    public AlbumDetailsBean(int newAlbumID, String alb, String art, String year, String fp,
            double p, int ar, List<Review> r, List<Song> s) {
        albumID = newAlbumID;
        albumName = alb;
        artistName = art;
        releaseYear = year;
        albumArtworkFilepath = fp;
        price = p;
        averageRating = ar;
        reviews = r;
        songs = s;
    }
    
    public int getAlbumID() {
        return this.albumID;
    }
    
    public void setAlbumID(int albumID) {
        this.albumID = albumID;
    }
    
    public String getAlbumName() {
        return this.albumName;
    }
    
    public void setAlbumName(String a) {
        albumName = a;
    }
    
    public String getArtistName() {
        return this.artistName;
    }
    
    public void setArtistName(String a) {
        artistName = a;
    }
    
    public String getReleaseYear() {
        return this.releaseYear;
    }
    
    public void setReleaseYear(String y) {
        releaseYear = y;
    }
    
    public String getAlbumArtworkFilepath() {
        return this.albumArtworkFilepath;
    }
    
    public void setAlbumArtworkFilepath(String fp) {
        albumArtworkFilepath = fp;
    }
    
    public double getPrice() {
        return this.price;
    }
    
    public void setPrice(double p) {
        price = p;
    }
    
    public int getAverageRating() {
        return this.averageRating;
    }
    
    public void setAverageRating(int avgRating) {
        averageRating = avgRating;
    }
    
    public List<Review> getReviews() {
        return this.reviews;
    }
    
    public void setReviews(List<Review> r) {
        reviews = r;
    }
    
    public List<Song> getSongs() {
        return this.songs;
    }
    
    public void setSongs(List<Song> s) {
        songs = s;
    }
    
}
