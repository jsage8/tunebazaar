package tunebazaar;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCartBean {
    
    List<OrderItem> items;
    double subtotal;
    double tax;
    double total;
    
    private final double TAX_RATE = 0.05;
    
    public ShoppingCartBean() {
        items = new ArrayList<OrderItem>();
        tax = -1;
        total = -1;
    }
    
    public ShoppingCartBean(List<OrderItem> items) {
        this.items = items;
    }
    
    public List<OrderItem> getItems() {
        return items;
    }
    
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
    
    public void addItem(OrderItem newItem) {
        items.add(newItem);
    }
    
    public double getSubtotal() {
        double tempTotal = 0;
        if (items == null) {
            return -1;
        }
        else {
            if (items.isEmpty())
                return -1;
            else {
                for (int i=0; i<items.size(); i++) {
                    tempTotal = tempTotal + items.get(i).getCost();
                }
                return tempTotal;
            }
        }
    }
    
    public double getTax() {
        if (items == null)
            return -1;
        else if (items.size() == 0)
            return -1;
        else
            return getSubtotal() * TAX_RATE;
    }
    
    public double getTotal() {
        if (items == null) 
            return -1;
        else if (items.size() == 0)
            return -1;
        else
            return getSubtotal() + getTax();
    }
    
    public int getNumberItemsInCart() {
        return items.size();
    }
    
//    public boolean isAlbumInCart(String albumName) {
    public boolean isAlbumInCart(int albumID) {
        boolean isInCart = false;
        for (int i=0; i<getNumberItemsInCart(); i++) {
//            if (items.get(i).getAlbumInfo().getAlbumName().equalsIgnoreCase(albumName))
            if (items.get(i).getAlbumInfo().getAlbumID() == albumID) {
                isInCart = true;
            }
        }
        return isInCart;
    }
    
//    public void removeItem(String albumName) {
    public void removeItem(int albumID) {
        int removeIndex = -1;
        for (int i=0; i<getNumberItemsInCart(); i++) {
//            if (items.get(i).getAlbumInfo().getAlbumName().equalsIgnoreCase(albumName))
            if (items.get(i).getAlbumInfo().getAlbumID() == albumID) {
                removeIndex = i;
            }
        }
        
        if (removeIndex >= 0)
            items.remove(removeIndex);
    }
}
