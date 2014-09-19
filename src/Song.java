package tunebazaar;

/**
 *
 * @author jsage8
 */
public class Song {
    private String songName;
    private int trackNumber;
    private String filePath;
    
    public Song() {
        this.songName = "";
        this.trackNumber = 0;
        this.filePath = "";
    }
    
    public Song(String songName, int trackNumber, String filePath) {
        this.songName = songName;
        this.trackNumber = trackNumber;
        this.filePath = filePath;
    }
    
    public String getSongName() {
        return songName;
    }
    
    public int getTrackNumber() {
        return trackNumber;
    }
    
    public String getFilePath() {
        return filePath;
    }
    
    public void setSongName(String songName) {
        this.songName = songName;
    }
    
    public void setTrackNumber(int trackNumber) {
        this.trackNumber = trackNumber;
    }
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
