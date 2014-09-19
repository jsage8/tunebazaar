package tunebazaar;

/**
 *
 * @author jsage8
 */
public class PhoneBean {
    private String phone;
    private boolean isPrimary;
    private String phoneType;
    
    public PhoneBean() {
        this.phone = "";
        this.isPrimary = false;
        this.phoneType = "";
    }
    
    public PhoneBean(String phone, boolean isPrimary, String phoneType) {
        this.phone = phone;
        this.isPrimary = isPrimary;
        this.phoneType = phoneType;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public boolean getIsPrimary() {
        return isPrimary;
    }
    
    public String getPhoneType() {
        return phoneType;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public void setIsPrimary(boolean isPrimary) {
        this.isPrimary = isPrimary;
    }
    
    public void setPhoneType(String phoneType) {
        this.phoneType = phoneType;
    } 
}
