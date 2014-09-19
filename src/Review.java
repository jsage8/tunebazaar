package tunebazaar;

public class Review implements java.io.Serializable {
    
    private String userName;
    private int rating;
    private String comment;
    
    public Review() {
        userName = "";
        rating = -1;
        comment = "";
    }
    
    public Review(String u, int r, String c) {
        userName = u;
        rating = r;
        comment = c;
    }
    
    public String getUserName() {
        return this.userName;
    }
    
    public void setUserName(String u) {
        userName = u;
    }
    
    public int getRating() {
        return this.rating;
    }
    
    public void setRating(int r) {
        rating = r;
    }
    
    public String getComment() {
        return this.comment;
    }
    
    public void setComment(String c) {
        comment = c;
    }   
}
