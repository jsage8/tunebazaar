package tunebazaar;

/**
 *
 * @author jsage8
 */
public class AddressBean {
    private String line1;
    private String line2;
    private String city;
    private String state;
    private int zip;
    private boolean isSame;
    
    public AddressBean() {
        this.line1 = "";
        this.line2 = "";
        this.city = "";
        this.state = "";
        this.zip = -1;
    }

    
    public AddressBean(String line1, String city, String state, int zip) {
        this.line1 = line1;
        this.city = city;
        this.state = state;
        this.zip = zip;
    }
    
    public AddressBean(String line1, String line2, String city, String state) {
        this.line1 = line1;
        this.line2 = line2;
        this.city = city;
        this.state = state;
        this.zip = -1;
    }
    
    public AddressBean(String line1, String line2, String city, String state, int zip) {
        this.line1 = line1;
        this.line2 = line2;
        this.city = city;
        this.state = state;
        this.zip = zip;
    }
    
    public String getLine1() {
        return line1;
    }
    
    public String getLine2() {
        return line2;
    }
    
    public String getCity() {
        return city;
    }
    
    public String getState() {
        return state;
    }
    
    public int getZip() {
        return zip;
    }
    
    public boolean getIsSame() {
        return isSame;
    }
    
    public void setLine1(String line1) {
        this.line1 = line1;
    }
    
    public void setLine2(String line2) {
        this.line2 = line2;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public void setZip(int zip) {
        this.zip = zip;
    }
    
    public void setIsSame(boolean isSame) {
        this.isSame = isSame;
    }
}
