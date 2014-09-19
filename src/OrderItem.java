package tunebazaar;

public class OrderItem {
    private double cost;
    private int productId;
    private DetailedAlbum albumInfo;
    
    public OrderItem() {
        this.cost = -1;
        this.productId = -1;
        this.albumInfo = new DetailedAlbum();
    }
    
    public OrderItem(double cost, int productId, DetailedAlbum albumInfo) {
        this.cost = cost;
        this.productId = productId;
        this.albumInfo = albumInfo;
    }
    
    public double getCost() {
        return cost;
    }
    
    public void setCost(double cost) {
        this.cost = cost;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public DetailedAlbum getAlbumInfo() {
        return albumInfo;
    }
    
    public void setAlbumInfo(DetailedAlbum albumInfo) {
        this.albumInfo = albumInfo;
    }
}
