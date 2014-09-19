package tunebazaar;

/**
 *
 * @author jsage8
 */
public class CreditCardBean {
    private String cardType;
    private String cardNumber;
    private String cardMonth;
    private String cardYear;
    private String nameOnCard;
    
    public CreditCardBean() {
        cardType = "";
        cardNumber = "";
        cardMonth = "";
        cardYear = "";
        nameOnCard = "";
    }
    
    public CreditCardBean(String cardType, String cardNumber, String cardMonth, String cardYear, String nameOnCard) {
        this.cardType = cardType;
        this.cardNumber = cardNumber;
        this.cardMonth = cardMonth;
        this.cardYear = cardYear;
        this.nameOnCard = nameOnCard;
    }
    
    public String getCardType() {
        return cardType;
    }
    
    public String getCardNumber() {
        return cardNumber;
    }
    
    public String getCardMonth() {
        return cardMonth;
    }
    
    public String getCardYear() {
        return cardYear;
    }
    
    public String getNameOnCard() {
        return nameOnCard;
    }
    
    public void setCardType(String cardType) {
        this.cardType = cardType;
    }
    
    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    
    public void setCardMonth(String cardMonth) {
        this.cardMonth = cardMonth;
    }
    
    public void setCardYear(String cardYear) {
        this.cardYear = cardYear;
    }
    
    public void setNameOnCard(String nameOnCard) {
        this.nameOnCard = nameOnCard;
    }
}