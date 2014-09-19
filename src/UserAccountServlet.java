package tunebazaar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserAccountServlet extends HttpServlet {

    private final String LOGIN_URL = "/login.jsp";
    private final String FORM_URL = "/login.jsp";
    private final String MODIFY_URL = "/account.jsp";
    private final String HOME_URL = "/index";
    private final String CART_CHECKOUT_URL = "/checkout.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the request action parameter
        String requestAction = request.getParameter("action");
        if (requestAction == null) {
            requestAction = "";
        }

        // Use album information to query DB for display information
        Connection connection = DatabaseUtil.createConnection();

        // Declare the requestDispatcher
        RequestDispatcher dispatcher = null;

        // Get the request session object
        HttpSession session = request.getSession();

        // Catch and handle possible non-existent session logged in variable
        Boolean tempLoggedInStatus = (Boolean) session.getAttribute("logged-in");
        if (tempLoggedInStatus == null) {
            session.setAttribute("logged-in", false);
        }

        // Handle request action
        if (requestAction.equalsIgnoreCase("login")) {
            /**
             * *****************************************************************
             * When user clicks login when they're not logged in.
             * *****************************************************************
             */
            String returnURI = request.getParameter("originURI");
            session.setAttribute("returnURI", returnURI);
            dispatcher = getServletContext().getRequestDispatcher(LOGIN_URL);
        } else if (requestAction.equalsIgnoreCase("login_submit")) {
            /**
             * *****************************************************************
             * User fills out username and password, then hits submit
             * *****************************************************************
             */
            String uname = request.getParameter("userName");
            if (uname == null) {
                uname = "";
            }

            String pword = request.getParameter("password");
            if (pword == null) {
                pword = "";
            }

            Boolean[] isLoginError = new Boolean[1];
            isLoginError[0] = false;

            if (uname.length() == 0) {
                request.setAttribute("userAccountMessage", "username is empty!!!  Enter a username and a password!!!");
                dispatcher = getServletContext().getRequestDispatcher(LOGIN_URL);
                isLoginError[0] = true;
            } else if (pword.length() == 0) {
                request.setAttribute("username", uname);
                request.setAttribute("userAccountMessage", "Password is empty!!!  Enter a username and a password!!!");
                dispatcher = getServletContext().getRequestDispatcher(LOGIN_URL);
                isLoginError[0] = true;
            } else {
                try {
                    String preparedSQL = "SELECT * FROM users WHERE username = ? AND password = ?";
                    PreparedStatement ps = connection.prepareStatement(preparedSQL);
                    ps.setString(1, uname);
                    ps.setString(2, pword);
                    ResultSet authentication = ps.executeQuery();

                    if (authentication.next() == false) {
                        request.setAttribute("userAccountMessage", "Account authentication failed with username and password!!!");
                        request.setAttribute("username", uname);
                        dispatcher = getServletContext().getRequestDispatcher(LOGIN_URL);
                        isLoginError[0] = true;
                    } else {
                        // Create UserAccountBean and keep it to session
                        UserAccountBean userAccount = new UserAccountBean(uname, pword, authentication.getString("first_name"),
                                authentication.getString("last_name"), authentication.getString("middle_initial"),
                                authentication.getString("email_address"));
                        session.setAttribute("userAccount", userAccount);

                        // Set logged-in status to true and session username
                        session.setAttribute("logged-in", true);
                        session.setAttribute("logged-in-username", authentication.getString("username"));

                        String returnToURI = (String) session.getAttribute("returnURI");
                        if (returnToURI == null) {
                            returnToURI = HOME_URL;
                        } else if (returnToURI.contains("index")) {
                            returnToURI = HOME_URL;
                        } 
                        
                        Boolean wasCheckingOut = (Boolean) session.getAttribute("wasCheckingOut");
                        if (wasCheckingOut == null)
                            wasCheckingOut = false;
                        if (wasCheckingOut.booleanValue() == true) {
                            returnToURI = CART_CHECKOUT_URL;
                            wasCheckingOut = false;
                            session.setAttribute("wasCheckingOut", wasCheckingOut);
                        }
                        
                        dispatcher = getServletContext().getRequestDispatcher(returnToURI);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(UserAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("isLoginError", isLoginError);
            }
        } else if (requestAction.equalsIgnoreCase("logout")) {
            /**
             * *****************************************************************
             * User clicks to Sign Out after logged in
             * *****************************************************************
             */
            UserAccountBean userAccount = new UserAccountBean();
            session.setAttribute("userAccount", userAccount);
            session.setAttribute("logged-in", false);

            dispatcher = getServletContext().getRequestDispatcher(HOME_URL);
            request.setAttribute("userAccountMessage", "You have been logged out.");
        } else if (requestAction.equalsIgnoreCase("add")) {
            /**
             * *****************************************************************
             * User clicks on a Register new account button
             * *****************************************************************
             */
            String returnURI = request.getParameter("originURI");
            session.setAttribute("returnURI", returnURI);
            request.setAttribute("userAccountMessage", "Fill out the account info form and click Submit");
            dispatcher = getServletContext().getRequestDispatcher(FORM_URL);
        } else if (requestAction.equalsIgnoreCase("add_submit")) {
            /**
             * *****************************************************************
             * User submits the form in an account creation page
             * *****************************************************************
             */
            String newUsername = request.getParameter("newUserName");
            if (newUsername == null) {
                newUsername = "";
            }
            String newPassword = request.getParameter("newPassword");
            if (newPassword == null) {
                newPassword = "";
            }
            String newFirstName = request.getParameter("firstName");
            if (newFirstName == null) {
                newFirstName = "";
            }
            String newLastName = request.getParameter("lastName");
            if (newLastName == null) {
                newLastName = "";
            }
            String newMiddleInitial = request.getParameter("middleInitial");
            if (newMiddleInitial == null) {
                newMiddleInitial = "";
            }
            String newEmail = request.getParameter("emailAddress");
            if (newEmail == null) {
                newEmail = "";
            }

            Boolean[] isAccountError = validateAccount(newUsername, newPassword);
            Boolean[] isBasicError = validateBasicInfo(newFirstName, newMiddleInitial, newLastName, newEmail);

            if (newUsername.equalsIgnoreCase("") || newPassword.equalsIgnoreCase("")
                    || newFirstName.equalsIgnoreCase("") || newLastName.equalsIgnoreCase("")
                    || newEmail.equalsIgnoreCase("")) {
                UserAccountBean tempUserAccountInfo = new UserAccountBean(newUsername,
                        newPassword, newFirstName, newLastName, "", newEmail);
                request.setAttribute("userInfo", tempUserAccountInfo);
                request.setAttribute("userAccountMessage", "Form is incomplete!  Complete form and hit submit!");
                dispatcher = getServletContext().getRequestDispatcher(FORM_URL);
            } else {
                try {
                    // Checking if username is already taken
                    String usernameCheckSQL = "SELECT * FROM users WHERE username = ?";
                    PreparedStatement ps1 = connection.prepareStatement(usernameCheckSQL);
                    ps1.setString(1, newUsername);
                    ResultSet usernameCheckResult = ps1.executeQuery();

                    // Username already exists!!!
                    if (usernameCheckResult.next() == true) {
                        request.setAttribute("userAccountMessage", "Username is already taken.  Use another username!");
                        UserAccountBean tempUserAccountInfo = new UserAccountBean(newUsername,
                                newPassword, newFirstName, newLastName, "", newEmail);
                        request.setAttribute("userInfo", tempUserAccountInfo);
                        dispatcher = getServletContext().getRequestDispatcher(FORM_URL);
                        isAccountError[0] = true;
                    } // Username is not taken, proceed to create new account.
                    else {
                        String lengthCheckSQL = "SELECT MAX(user_id) FROM users";
                        Statement lengthStatement = connection.createStatement();
                        ResultSet lengthResultSet = lengthStatement.executeQuery(lengthCheckSQL);
                        int currentMax = 0;
                        if (lengthResultSet.next()) {
                            currentMax = lengthResultSet.getInt(1);
                        }
                        int newAccountID = currentMax + 1;

                        String preparedSQL = "INSERT INTO users (user_id, username, password, first_name, last_name, middle_initial, email_address) "
                                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
                        PreparedStatement ps2 = connection.prepareStatement(preparedSQL);
                        ps2.setInt(1, currentMax + 1);
                        ps2.setString(2, newUsername);
                        ps2.setString(3, newPassword);
                        ps2.setString(4, newFirstName);
                        ps2.setString(5, newLastName);
                        ps2.setString(6, newMiddleInitial);
                        ps2.setString(7, newEmail);
                        ps2.executeUpdate();

                        // Create UserAccountBean and place in Session
                        UserAccountBean userAccount = new UserAccountBean(newUsername, newPassword,
                                newFirstName, newLastName, newMiddleInitial, newEmail);
                        session.setAttribute("userAccount", userAccount);

                        // Set logged-in status and logged-in-username
                        session.setAttribute("logged-in", true);
                        session.setAttribute("logged-in-username", newUsername);

                        // Configure to return to returnURI
                        request.setAttribute("userAccountMessage", "New account added successfully");
                        String returnToURI = (String) session.getAttribute("returnURI");
                        if (returnToURI == null) {
                            returnToURI = HOME_URL;
                        } else if (returnToURI.contains("index")) {
                            returnToURI = HOME_URL;
                        }
                        
                        Boolean wasCheckingOut = (Boolean) session.getAttribute("wasCheckingOut");
                        if (wasCheckingOut == null)
                            wasCheckingOut = false;
                        if (wasCheckingOut.booleanValue() == true) {
                            returnToURI = CART_CHECKOUT_URL;
                            wasCheckingOut = false;
                            session.setAttribute("wasCheckingOut", wasCheckingOut);
                        }
                        
                        dispatcher = getServletContext().getRequestDispatcher(returnToURI);

                        // Add new cookie to browser with account ID for future recommendations
                        Cookie newIDCookie = new Cookie("accountIDCookie", String.valueOf(newAccountID));
                        newIDCookie.setMaxAge(60 * 60 * 24 * 365 * 2);
                        newIDCookie.setPath("/");
                        response.addCookie(newIDCookie);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(UserAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            request.setAttribute("isAccountError", isAccountError);
            request.setAttribute("isBasicError", isBasicError);

        } else if (requestAction.equalsIgnoreCase("modify")) {
            /**
             * *****************************************************************
             * User clicks on modify account information after already logged in
             * *****************************************************************
             */
            String returnURI = request.getParameter("originURI");
            String activeUsername = (String) session.getAttribute("logged-in-username");
            session.setAttribute("returnURI", returnURI);
            dispatcher = getServletContext().getRequestDispatcher(MODIFY_URL);
            request.setAttribute("userAccountMessage",
                    "Modify the account info on the form and click Submit");

            String usernameCheckSQL = "SELECT * FROM users WHERE username = ?";
            PreparedStatement ps;
            UserAccountBean tempUserInfo = new UserAccountBean();
            try {
                ps = connection.prepareStatement(usernameCheckSQL);
                ps.setString(1, activeUsername);
                ResultSet userInfo = ps.executeQuery();
                if (userInfo.next()) {
                    tempUserInfo = new UserAccountBean(userInfo.getString("username"),
                            userInfo.getString("password"),
                            userInfo.getString("first_name"),
                            userInfo.getString("last_name"),
                            userInfo.getString("middle_initial"),
                            userInfo.getString("email_address"));
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            session.setAttribute("userAccount", tempUserInfo);

        } else if (requestAction.equalsIgnoreCase("modify_submit")) {
            /**
             * *****************************************************************
             * User attempts to modify information on existing account
             * *****************************************************************
             */
            UserAccountBean activeAccount = (UserAccountBean) session.getAttribute("userAccount");

            String currentUsername = activeAccount.getUserName();

            String oldPassword = request.getParameter("oldPassword1");
            if (oldPassword == null) {
                oldPassword = "";
            }
            String newPassword1 = request.getParameter("newPassword1");
            if (newPassword1 == null) {
                newPassword1 = "";
            }
            String newPassword2 = request.getParameter("newPassword2");
            if (newPassword2 == null) {
                newPassword2 = "";
            }

            String newFirstName = request.getParameter("firstName");
            if (newFirstName == null) {
                newFirstName = "";
            }
            String newLastName = request.getParameter("lastName");
            if (newLastName == null) {
                newLastName = "";
            }
            String newMiddleInitial = request.getParameter("middleInitial");
            if (newMiddleInitial == null) {
                newMiddleInitial = "";
            }
            String newEmail = request.getParameter("emailAddress");
            if (newEmail == null) {
                newEmail = "";
            }

            StringBuilder sbMessage = new StringBuilder("Debug Message: ");

            Boolean[] isPasswordError = validateNewPassword(connection, activeAccount, oldPassword, newPassword1, newPassword2);
            Boolean[] isBasicError = validateBasicInfo(newFirstName, newMiddleInitial, newLastName, newEmail);

            if (isPasswordError[0] || isPasswordError[1] || isPasswordError[2] || isBasicError[0]
                    || isBasicError[1] || isBasicError[2] || isBasicError[3]) {
                request.setAttribute("userAccountMessage", "Account info change failed!");
                dispatcher = getServletContext().getRequestDispatcher(MODIFY_URL);
            } else {
                sbMessage.append("\n\r inputs accepted as valid, oldpassword checks out!");
                try {
                    String accountIDSQL = "SELECT user_id FROM users WHERE username = ?";
                    PreparedStatement ps1 = connection.prepareStatement(accountIDSQL);
                    ps1.setString(1, currentUsername);
                    ResultSet accountIDResult = ps1.executeQuery();
                    int accountID = 0;
                    if (accountIDResult.next()) {
                        accountID = accountIDResult.getInt("user_id");
                    }

                    String preparedSQL = "UPDATE users SET user_id = ?, username = ?, password = ?, "
                            + "first_name = ?, last_name = ?, middle_initial = ?, email_address = ? "
                            + "WHERE user_id = ?";
                    PreparedStatement ps2 = connection.prepareStatement(preparedSQL);
                    ps2.setInt(1, accountID);
                    ps2.setString(2, currentUsername);
                    
                    // If there is a new password, use new password, otherwise use old password
                    if (newPassword1.length() != 0)
                        ps2.setString(3, newPassword1);
                    else
                        ps2.setString(3, oldPassword
                                );
                    ps2.setString(4, newFirstName);
                    ps2.setString(5, newLastName);
                    ps2.setString(6, newMiddleInitial);
                    ps2.setString(7, newEmail);
                    ps2.setInt(8, accountID);
                    ps2.executeUpdate();

                    sbMessage.append("\n\r Account info successfully updated in DB!");

                    // Create UserAccountBean and set it to session
                    UserAccountBean userAccount = new UserAccountBean(currentUsername, newPassword1,
                            newFirstName, newLastName, newMiddleInitial, newEmail);
                    session.setAttribute("userAccount", userAccount);

                    // Set session logged-in username
                    session.setAttribute("logged-in-username", currentUsername);

                    // Configure to return to returnURI, set to be logged in, set session username
                    String returnToURI = (String) session.getAttribute("returnURI");

                    sbMessage.append("\n\r returning to URI(" + returnToURI + ")");

                    returnToURI = HOME_URL;
                    dispatcher = getServletContext().getRequestDispatcher(returnToURI);
                    request.setAttribute("userAccountMessage", "Account info changed successfully!");
                } catch (SQLException ex) {
                    Logger.getLogger(UserAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            request.setAttribute("isPasswordError", isPasswordError);
            request.setAttribute("isBasicError", isBasicError);
        }

        /**
         * *********************************************************************
         * Closing the connection object
         * ********************************************************************
         */
        try {
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // forward via the dispatcher
        dispatcher.forward(request, response);
    }

    private Boolean[] validateAccount(String username, String password) {
        Boolean[] hasError = new Boolean[2];
        if (username.length() == 0) {
            hasError[0] = true;
        } else {
            hasError[0] = false;
        }

        if (password.length() == 0) {
            hasError[1] = true;
        } else {
            hasError[1] = false;
        }

        return hasError;
    }

    private Boolean[] validateNewPassword(Connection connection, UserAccountBean currentAccount, String oldPW, String newPW1, String newPW2) {
        Boolean[] hasError = new Boolean[3];
        for (int i = 0; i < 3; i++) {
            hasError[i] = false;
        }

        //  Check for empty inputs
        if (oldPW.length() == 0) {
            hasError[0] = true;
        }

        // check new passwords only if they are typed in, otherwise they can be left empty
        if (newPW1.length() != 0 || newPW2.length() != 0) {
            //  Check if the two newPasswords are matching
            if (newPW1.equals(newPW2) == false) {
                hasError[1] = true;
                hasError[2] = true;
            }
        }

        //  Check if the oldPassword is correct
        try {
            // Checking if username is already taken
            String pwCheckSQL = "SELECT COUNT(1) FROM users WHERE username = ? AND password = ?";
            PreparedStatement psPW = connection.prepareStatement(pwCheckSQL);
            psPW.setString(1, currentAccount.getUserName());
            psPW.setString(2, oldPW);
            ResultSet pwCheckResult = psPW.executeQuery();

            if (pwCheckResult.next()) {
                if (pwCheckResult.getInt("COUNT(1)") == 0) {
                    hasError[0] = true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        return hasError;
    }

    private Boolean[] validateBasicInfo(String fname, String minit, String lname, String email) {
        Boolean[] hasError = new Boolean[4];
        if (fname.length() == 0) {
            hasError[0] = true;
        } else {
            hasError[0] = false;
        }

        if (minit.length() > 1) {
            hasError[1] = true;
        } else {
            hasError[1] = false;
        }

        if (lname.length() == 0) {
            hasError[2] = true;
        } else {
            hasError[2] = false;
        }

        if (email.length() == 0) {
            hasError[3] = true;
        } else {
            hasError[3] = false;
        }

        return hasError;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
