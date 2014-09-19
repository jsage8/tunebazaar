package tunebazaar;

import java.util.ArrayList;
import java.util.List;

public class SearchResultBean implements java.io.Serializable {
    
    private List<DetailedAlbum> detailedAlbumList;
    
    public SearchResultBean() {
        detailedAlbumList = new ArrayList<DetailedAlbum>();
    }
    
    public List<DetailedAlbum> getDetailedAlbumList() {
        return this.detailedAlbumList;
    }
    
    public void addDetailedAlbum(DetailedAlbum newDetailedAlbum) {
        detailedAlbumList.add(newDetailedAlbum);
    }
}
