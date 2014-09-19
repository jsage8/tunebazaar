package tunebazaar;

/**
 *
 * @author jsage8
 */
public class UserAccountBean {

    private String userName;
    private String password;
    private String firstName;
    private String lastName;
    private String middleInitial;
    private String emailAddress;

    public UserAccountBean() {
        this.userName = "";
        this.password = "";
        this.firstName = "";
        this.lastName = "";
        this.middleInitial = "";
        this.emailAddress = "";
    }

    public UserAccountBean(String userName, String password, String firstName,
            String lastName, String middleInitial, String emailAddress) {
        this.userName = userName;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.middleInitial = middleInitial;
        this.emailAddress = emailAddress;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getMiddleInitial() {
        return middleInitial;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setMiddleInitial(String middleInitial) {
        this.middleInitial = middleInitial;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
}
