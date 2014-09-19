package tunebazaar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;

import java.math.BigDecimal;
import java.sql.Statement;
import java.sql.Types;
import javax.mail.MessagingException;

public class ShoppingCartServlet extends HttpServlet {

    private final String CART_CONTENT_URL = "/cart.jsp";
    private final String CART_CHECKOUT_URL = "/checkout.jsp";
    private final String ORDER_CONFIRM_URL = "/orderConfirm.jsp";
    private final String ORDER_CONFIRMED_URL = "/confirmed.jsp";
    private final String LOGIN_URL = "/login.jsp";
    
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
        Boolean tempLoggedInStatus = false;
        if (session.getAttribute("logged-in") == null) {
            session.setAttribute("logged-in", false);
        }
        else {
            tempLoggedInStatus = (Boolean) session.getAttribute("logged-in");
        }
        
        ShoppingCartBean shoppingCart = (ShoppingCartBean) session.getAttribute("shoppingCart");
        if (shoppingCart == null) {
            shoppingCart = new ShoppingCartBean();
        }
        
        // Handle request action
        if (requestAction.equalsIgnoreCase("add")) {
            /*******************************************************************
             * When user clicks Add To Cart on a product page
             ******************************************************************/
            int addedAlbumID = Integer.parseInt(request.getParameter("albumProductID"));
            if (shoppingCart.isAlbumInCart(addedAlbumID)) {
                request.setAttribute("shoppingCartMessage", "Item is already in cart!");
            }
            else {
                String getProductInfoSQL = "SELECT * FROM "
                        + "albums JOIN artists ON albums.artist_id = artists.artist_id "
                        + "WHERE album_id = ?";
                try {
                    PreparedStatement ps = connection.prepareStatement(getProductInfoSQL);
                    ps.setInt(1, addedAlbumID);
                    ResultSet albumProductResult = ps.executeQuery();

                    OrderItem newItemToCart = new OrderItem();
                    if (albumProductResult.next()) {
                        newItemToCart.setCost(albumProductResult.getDouble("price"));
                        newItemToCart.setProductId(albumProductResult.getInt("album_id"));
                        DetailedAlbum tempDetailedAlbum = new DetailedAlbum(
                                albumProductResult.getInt("album_id"),
                                albumProductResult.getString("album_name"), 
                                albumProductResult.getString("image_filepath"), 
                                albumProductResult.getString("artist_name"), -1, 
                                albumProductResult.getString("release_year"));
                        newItemToCart.setAlbumInfo(tempDetailedAlbum);
                        
                        shoppingCart.addItem(newItemToCart);
                        request.setAttribute("shoppingCartMessage", "Item has been added successfully");
                    }
                    else {
                        request.setAttribute("shoppingCartMessage", "Item cannot be added to cart - album name not found!");
                    }
                    
                } catch (SQLException ex) {
                    Logger.getLogger(UserAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
            request.setAttribute("albumID", String.valueOf(addedAlbumID));            
            dispatcher = getServletContext().getRequestDispatcher("/DisplayProductServlet");
        }
        else if (requestAction.equalsIgnoreCase("remove")) {
            /*******************************************************************
             * When user clicks remove item
             ******************************************************************/
            int removeAlbumID = Integer.parseInt(request.getParameter("albumProductID"));
            if (shoppingCart.isAlbumInCart(removeAlbumID)) {
                shoppingCart.removeItem(removeAlbumID);
                request.setAttribute("shoppingCartMessage", "Album successfully removed from shopping cart!");
            }
            else {
                request.setAttribute("shoppingCartMessage", "Cannot remove item - Album not found in cart!");
            }
            String returnURI = request.getParameter("originURI");
            
            // Handles if shopping cart is emptied in checkout.jsp, kick user back to cart.jsp
            if (shoppingCart.getNumberItemsInCart() == 0 && returnURI.contains("checkout.jsp"))
                dispatcher = getServletContext().getRequestDispatcher(CART_CONTENT_URL);
            else
                dispatcher = getServletContext().getRequestDispatcher(returnURI);
        }
        else if (requestAction.equalsIgnoreCase("clear")) {
            /*******************************************************************
             * When user clicks clear shopping cart
             ******************************************************************/
            shoppingCart = new ShoppingCartBean();
            request.setAttribute("shoppingCartMessage", "Shopping cart has been emptied!");
            String returnURI = request.getParameter("originURI");
            
            // Handles if shopping cart is emptied in checkout.jsp, kick user back to cart.jsp
            if (returnURI.contains("checkout.jsp"))
                dispatcher = getServletContext().getRequestDispatcher(CART_CONTENT_URL);
            else
                dispatcher = getServletContext().getRequestDispatcher(returnURI);
        }
        else if (requestAction.equalsIgnoreCase("toCheckout")) {
            /*******************************************************************
             * When user clicks checkout cart items
             ******************************************************************/
            if (tempLoggedInStatus == false) {
                dispatcher = getServletContext().getRequestDispatcher(LOGIN_URL);
                String returnURI = request.getParameter("originURI");
                session.setAttribute("returnURI", returnURI);
                Boolean wasCheckingOut = true;
                session.setAttribute("wasCheckingOut", wasCheckingOut);
            }
            else {
                if (shoppingCart.getNumberItemsInCart() <= 0) {
                    dispatcher = getServletContext().getRequestDispatcher(CART_CONTENT_URL);
                } else {
                    dispatcher = getServletContext().getRequestDispatcher(CART_CHECKOUT_URL);
                }
            }
        }
        else if (requestAction.equalsIgnoreCase("checkout_submit")) {
            /*******************************************************************
             * When user clicks fills out purchasing info and hit submit
             ******************************************************************/
            String sline1;
            String sline2;
            String scity;
            String sstate;
            String szipString;
            
            String bline1;
            String bline2;
            String bcity;
            String bstate;
            String bzipString;
            boolean isSameAddress;
            
            String homePhoneNumber;
            boolean homeIsPrimary;
            
            String cellPhoneNumber;
            boolean cellIsPrimary;
            
            String cardType;
            String cardNumber;
            String cardMonth;
            String cardYear;
            String nameOnCard;
            
            sline1 = request.getParameter("sline1");
            if (sline1 == null) {
                sline1 = "";
            }
            sline2 = request.getParameter("sline2");
            if (sline2 == null) {
                sline2 = "";
            }
            scity = request.getParameter("scity");
            if (scity == null) {
                scity = "";
            }
            sstate = request.getParameter("sstate").toUpperCase();
            if (sstate == null) {
                sstate = "";
            }
            szipString = request.getParameter("szip");
            if (szipString == null) {
                szipString = "";
            }
            
            isSameAddress = stringToBoolean(request.getParameter("isSameAddress"));
            
            if(isSameAddress) {
                bline1 = sline1;
                bline2 = sline2;
                bcity = scity;
                bstate = sstate;
                bzipString = szipString;
            }
            else {
                bline1 = request.getParameter("bline1");
                if (bline1 == null) {
                    bline1 = "";
                }
                bline2 = request.getParameter("bline2");
                if (bline2 == null) {
                    bline2 = "";
                }
                bcity = request.getParameter("bcity");
                if (bcity == null) {
                    bcity = "";
                }
                bstate = request.getParameter("bstate").toUpperCase();
                if (bstate == null) {
                    bstate = "";
                }
                bzipString = request.getParameter("bzip");
                if (bzipString == null)
                    bzipString = "";
            }
            
            homePhoneNumber = request.getParameter("homePhone");
            if (homePhoneNumber == null) {
                homePhoneNumber= "";
            }
            homeIsPrimary = stringToBoolean(request.getParameter("homeIsPrimary"));
            
            cellPhoneNumber = request.getParameter("cellPhone");
            if (cellPhoneNumber == null) {
                cellPhoneNumber= "";
            }
            cellIsPrimary = stringToBoolean(request.getParameter("cellIsPrimary"));
            
            cardType = request.getParameter("cardType");
            if (cardType == null) {
                cardType = "";
            }
            cardNumber = request.getParameter("cardNumber");
            if (cardNumber == null) {
                cardNumber = "";
            }
            cardMonth = request.getParameter("cardMonth");
            if (cardMonth == null) {
                cardMonth = "";
            }
            cardYear = request.getParameter("cardYear");
            if (cardYear == null) {
                cardYear = "";
            }
            nameOnCard = request.getParameter("nameOnCard");
            if (nameOnCard == null) {
                nameOnCard = "";
            }
            
            // Validate 
            Boolean[] isShipError = validateAddress(sline1, sline2, scity, sstate, szipString);
            Boolean[] isBillError = validateAddress(bline1, bline2, bcity, bstate, bzipString);
            Boolean[] isPhoneError = validatePhone(homePhoneNumber, homeIsPrimary, cellPhoneNumber, cellIsPrimary);
            Boolean[] isCreditError = validateCreditCard(cardType, cardNumber, cardMonth, cardYear, nameOnCard);
           
            // Populate the AddressBeans
            AddressBean shipAddress = new AddressBean(sline1, sline2, scity, sstate);
            AddressBean billAddress = new AddressBean(bline1, bline2, bcity, bstate);
            PhoneBean homePhone = new PhoneBean(homePhoneNumber, homeIsPrimary, "home");
            PhoneBean cellPhone = new PhoneBean(cellPhoneNumber, cellIsPrimary, "cell");
            CreditCardBean creditCard = new CreditCardBean(cardType, cardNumber, cardMonth, cardYear, nameOnCard);
            
            // If zip codes are correctly formatted, add them to beans
            if (!isShipError[4]) {
                System.out.println(Integer.parseInt(szipString));
                shipAddress.setZip(Integer.parseInt(szipString));
            }
            if (!isBillError[4]) {
                billAddress.setZip(Integer.parseInt(bzipString));
            }
            billAddress.setIsSame(isSameAddress);
            
            session.setAttribute("shipAddress", shipAddress);
            session.setAttribute("billAddress", billAddress);
            session.setAttribute("homePhone", homePhone);
            session.setAttribute("cellPhone", cellPhone);
            session.setAttribute("creditCard", creditCard);
            
            if(falseIfAllFalse(isShipError) || falseIfAllFalse(isBillError) || falseIfAllFalse(isPhoneError) || falseIfAllFalse(isCreditError)) {
                request.setAttribute("isShipError", isShipError);
                request.setAttribute("isBillError", isBillError);
                request.setAttribute("isPhoneError", isPhoneError);
                request.setAttribute("isCreditError", isCreditError);
                dispatcher = getServletContext().getRequestDispatcher(CART_CHECKOUT_URL);
            }
            else {
                dispatcher = getServletContext().getRequestDispatcher(ORDER_CONFIRM_URL);
            }
            
        }
        else if (requestAction.equalsIgnoreCase("confirm_order")) {
            /*******************************************************************
             * When user clicks fills out purchasing info to complete an order
             ******************************************************************/
            UserAccountBean userAccount = (UserAccountBean) session.getAttribute("userAccount");
            if (userAccount == null) {
                userAccount = new UserAccountBean();
            }
            AddressBean shipAddress = (AddressBean) session.getAttribute("shipAddress");
            if (shipAddress == null) {
                shipAddress = new AddressBean();
            }
            AddressBean billAddress = (AddressBean) session.getAttribute("billAddress");
            if (billAddress == null) {
                billAddress = new AddressBean();
            }
            PhoneBean homePhone = (PhoneBean) session.getAttribute("homePhone");
            if(homePhone == null) { 
                homePhone = new PhoneBean(); 
            }
            PhoneBean cellPhone = (PhoneBean) session.getAttribute("cellPhone");
            if(cellPhone == null) { 
                cellPhone = new PhoneBean(); 
            }
            CreditCardBean creditCard = (CreditCardBean) session.getAttribute("creditCard");
            if(creditCard == null) { 
                creditCard = new CreditCardBean(); 
            }
            if (shoppingCart.getNumberItemsInCart() != 0) {
                
                try {
                    String sqlQuery;
                    PreparedStatement preparedStatement;
                    ResultSet resultSet;

                    // Query current UserID
                    sqlQuery = "SELECT user_id FROM users WHERE username = ?";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setString(1, userAccount.getUserName());
                    resultSet = preparedStatement.executeQuery();
                    resultSet.first();
                    int userID = resultSet.getInt("user_id");


                    // Check to see if the shipping address is already in user_addresses table
                    sqlQuery = "SELECT address_id "
                            + "FROM user_addresses "
                            + "WHERE user_id = ? "
                            + "AND ship_to = 'y' "
                            + "AND line1 = ? "
                            + "AND city = ? "
                            + "AND state = ? "
                            + "AND zip5 = ? "
                            + "AND (line2 = ? OR (line2 IS NULL AND ? IS NULL))";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setInt(1, userID);
                    preparedStatement.setString(2, shipAddress.getLine1());
                    preparedStatement.setString(3, shipAddress.getCity());
                    preparedStatement.setString(4, shipAddress.getState());
                    preparedStatement.setInt(5, shipAddress.getZip());
                    if (!shipAddress.getLine2().equals("")) {
                        preparedStatement.setString(6, shipAddress.getLine2());
                        preparedStatement.setString(7, shipAddress.getLine2());
                    } else {
                        preparedStatement.setNull(6, Types.NULL);
                        preparedStatement.setNull(7, Types.NULL);
                    }
                    resultSet = preparedStatement.executeQuery();
                    
                    int shipAddressID = -1;
                    if (resultSet.first()) {
                        shipAddressID = resultSet.getInt("address_id");
                    }

                    // Add shipping address to user_addresses table
                    if (shipAddressID < 1) {
                        // Find most current address_id plus one
                        sqlQuery = "SELECT MAX(address_id) FROM user_addresses";
                        Statement statement = connection.createStatement();
                        resultSet = statement.executeQuery(sqlQuery);
                        shipAddressID = 1;
                        if (resultSet.first()) {
                            shipAddressID += resultSet.getInt(1);
                        }

                        sqlQuery = "INSERT INTO user_addresses (address_id, user_id, bill_to, ship_to, line1, line2, city, state, zip5)\n"
                                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        preparedStatement = connection.prepareStatement(sqlQuery);
                        preparedStatement.setInt(1, shipAddressID);
                        preparedStatement.setInt(2, userID);
                        if (billAddress.getIsSame()) {
                            preparedStatement.setString(3, "y");
                        } else {
                            preparedStatement.setString(3, "n");
                        }
                        preparedStatement.setString(4, "y");
                        preparedStatement.setString(5, shipAddress.getLine1());
                        if (!shipAddress.getLine2().equals("")) {
                            preparedStatement.setString(6, shipAddress.getLine2());
                        } else {
                            preparedStatement.setString(6, null);
                        }
                        preparedStatement.setString(7, shipAddress.getCity());
                        preparedStatement.setString(8, shipAddress.getState());
                        preparedStatement.setInt(9, shipAddress.getZip());
                        preparedStatement.executeUpdate();
                    }

                    // Check to see if the billing address is already in user_addresses table
                    sqlQuery = "SELECT address_id "
                            + "FROM user_addresses "
                            + "WHERE user_id = ? "
                            + "AND bill_to = 'y' "
                            + "AND line1 = ? "
                            + "AND city = ? "
                            + "AND state = ? "
                            + "AND zip5 = ? "
                            + "AND (line2 = ? OR (line2 IS NULL AND ? IS NULL))";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setInt(1, userID);
                    preparedStatement.setString(2, billAddress.getLine1());
                    preparedStatement.setString(3, billAddress.getCity());
                    preparedStatement.setString(4, billAddress.getState());
                    preparedStatement.setInt(5, billAddress.getZip());
                    if (!billAddress.getLine2().equals("")) {
                        preparedStatement.setString(6, billAddress.getLine2());
                        preparedStatement.setString(7, billAddress.getLine2());
                    } else {
                        preparedStatement.setNull(6, Types.NULL);
                        preparedStatement.setNull(7, Types.NULL);
                    }
                    resultSet = preparedStatement.executeQuery();
                    int billAddressID = -1;
                    if (resultSet.first()) {
                        billAddressID = resultSet.getInt("address_id");
                    }

                    // Add billing address to user_address table
                    if (billAddressID < 1 && !billAddress.getIsSame()) {
                        // Find most current address_id plus one
                        sqlQuery = "SELECT MAX(address_id) FROM user_addresses";
                        Statement statement = connection.createStatement();
                        resultSet = statement.executeQuery(sqlQuery);
                        billAddressID = 1;
                        if (resultSet.first()) {
                            billAddressID += resultSet.getInt(1);
                        }

                        sqlQuery = "INSERT INTO user_addresses (address_id, user_id, bill_to, ship_to, line1, line2, city, state, zip5)\n"
                                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        preparedStatement = connection.prepareStatement(sqlQuery);
                        preparedStatement.setInt(1, billAddressID);
                        preparedStatement.setInt(2, userID);
                        preparedStatement.setString(3, "y");
                        if (billAddress.getIsSame()) {
                            preparedStatement.setString(4, "y");
                        } else {
                            preparedStatement.setString(4, "n");
                        }
                        preparedStatement.setString(5, billAddress.getLine1());
                        if (!billAddress.getLine2().equals("")) {
                            preparedStatement.setString(6, billAddress.getLine2());
                        } else {
                            preparedStatement.setString(6, null);
                        }
                        preparedStatement.setString(7, billAddress.getCity());
                        preparedStatement.setString(8, billAddress.getState());
                        preparedStatement.setInt(9, billAddress.getZip());
                        preparedStatement.executeUpdate();
                    }

                    // Check to see if the home phone is already in the phones table
                    sqlQuery = "SELECT phone_id "
                            + "FROM phones "
                            + "WHERE phone_number = ? "
                            + "AND type = 'home' "
                            + "AND user_id = ? "
                            + "AND is_primary = ?";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setString(1, homePhone.getPhone());
                    preparedStatement.setInt(2, userID);
                    if (homePhone.getIsPrimary()) {
                        preparedStatement.setString(3, "y");
                    } else {
                        preparedStatement.setString(3, "n");
                    }
                    resultSet = preparedStatement.executeQuery();
                    int homePhoneID = -1;
                    if (resultSet.first()) {
                        homePhoneID = resultSet.getInt("phone_id");
                    }

                    // Add home phone to phones
                    if (homePhoneID < 1 && !homePhone.getPhone().equals("")) {
                        // Find most current phone_id plus one
                        sqlQuery = "SELECT MAX(phone_id) FROM phones";
                        Statement statement = connection.createStatement();
                        resultSet = statement.executeQuery(sqlQuery);
                        homePhoneID = 1;
                        if (resultSet.first()) {
                            homePhoneID += resultSet.getInt(1);
                        }

                        sqlQuery = "INSERT INTO phones (phone_id, phone_number, type, user_id, is_primary)\n"
                                + "VALUES (?, ?, ?, ?, ?)";
                        preparedStatement = connection.prepareStatement(sqlQuery);
                        preparedStatement.setInt(1, homePhoneID);
                        preparedStatement.setString(2, homePhone.getPhone());
                        preparedStatement.setString(3, homePhone.getPhoneType());
                        preparedStatement.setInt(4, userID);
                        if (homePhone.getIsPrimary()) {
                            preparedStatement.setString(5, "y");
                        } else {
                            preparedStatement.setString(5, "n");
                        }
                        preparedStatement.executeUpdate();
                    }

                    // Check to see if the cell phone is already in the phones table
                    sqlQuery = "SELECT phone_id "
                            + "FROM phones "
                            + "WHERE phone_number = ? "
                            + "AND type = 'cell' "
                            + "AND user_id = ? "
                            + "AND is_primary = ?";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setString(1, cellPhone.getPhone());
                    preparedStatement.setInt(2, userID);
                    if (cellPhone.getIsPrimary()) {
                        preparedStatement.setString(3, "y");
                    } else {
                        preparedStatement.setString(3, "n");
                    }
                    resultSet = preparedStatement.executeQuery();
                    int cellPhoneID = -1;
                    if (resultSet.first()) {
                        cellPhoneID = resultSet.getInt("phone_id");
                    }

                    // Add cell phone to phones
                    if (cellPhoneID < 1 && !cellPhone.getPhone().equals("")) {
                        // Find most current phone_id plus one
                        sqlQuery = "SELECT MAX(phone_id) FROM phones";
                        Statement statement = connection.createStatement();
                        resultSet = statement.executeQuery(sqlQuery);
                        cellPhoneID = 1;
                        if (resultSet.first()) {
                            cellPhoneID += resultSet.getInt(1);
                        }

                        sqlQuery = "INSERT INTO phones (phone_id, phone_number, type, user_id, is_primary)\n"
                                + "VALUES (?, ?, ?, ?, ?)";
                        preparedStatement = connection.prepareStatement(sqlQuery);
                        preparedStatement.setInt(1, cellPhoneID);
                        preparedStatement.setString(2, cellPhone.getPhone());
                        preparedStatement.setString(3, cellPhone.getPhoneType());
                        preparedStatement.setInt(4, userID);
                        if (cellPhone.getIsPrimary()) {
                            preparedStatement.setString(5, "y");
                        } else {
                            preparedStatement.setString(5, "n");
                        }
                        preparedStatement.executeUpdate();
                    }

                    // Check to see if the credit card is already in the credit_cards table
                    sqlQuery = "SELECT credit_card_id "
                            + "FROM credit_cards "
                            + "WHERE number = ? "
                            + "AND user_id = ? "
                            + "AND type = ? "
                            + "AND expiration_month = ? "
                            + "AND expiration_year = ? "
                            + "AND name_on_card = ?";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setString(1, creditCard.getCardNumber());
                    preparedStatement.setInt(2, userID);
                    preparedStatement.setString(3, creditCard.getCardType());
                    preparedStatement.setString(4, creditCard.getCardMonth());
                    preparedStatement.setString(5, creditCard.getCardYear());
                    preparedStatement.setString(6, creditCard.getNameOnCard());
                    resultSet = preparedStatement.executeQuery();
                    int creditCardID = -1;
                    if (resultSet.first()) {
                        creditCardID = resultSet.getInt("credit_card_id");
                    }
                    

                    // Add credit card to credit_cards
                    if (creditCardID < 1 && !creditCard.getCardNumber().equals("")) {


                        // Find most current credit_card_id plus one
                        sqlQuery = "SELECT MAX(credit_card_id) FROM credit_cards";
                        Statement statement = connection.createStatement();
                        resultSet = statement.executeQuery(sqlQuery);
                        creditCardID = 1;
                        if (resultSet.first()) {
                            creditCardID += resultSet.getInt(1);
                        }

                        sqlQuery = "INSERT INTO credit_cards (credit_card_id, number, user_id, type, expiration_month, expiration_year, name_on_card)\n"
                                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
                        preparedStatement = connection.prepareStatement(sqlQuery);
                        preparedStatement.setInt(1, creditCardID);
                        preparedStatement.setString(2, creditCard.getCardNumber());
                        preparedStatement.setInt(3, userID);
                        preparedStatement.setString(4, creditCard.getCardType());
                        preparedStatement.setString(5, creditCard.getCardMonth());
                        preparedStatement.setString(6, creditCard.getCardYear());
                        preparedStatement.setString(7, creditCard.getNameOnCard());
                        preparedStatement.executeUpdate();
                        
                    }
                    
                    

                    // Find most current order_id plus one
                    sqlQuery = "SELECT MAX(order_id) FROM orders";
                    Statement statement = connection.createStatement();
                    resultSet = statement.executeQuery(sqlQuery);
                    int orderID = 1;
                    if (resultSet.first()) {
                        orderID += resultSet.getInt(1);
                    }

                    // Add order to orders
                    sqlQuery = "INSERT INTO orders (order_id, user_id, order_date, merchandise_cost, tax_cost, total_cost, bill_address_id, ship_address_id, home_phone_id, cell_phone_id, credit_card_id)\n"
                            + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?, ?, ?, ?, ?)";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setInt(1, orderID);
                    preparedStatement.setInt(2, userID);
                    preparedStatement.setBigDecimal(3, new BigDecimal(shoppingCart.getSubtotal()));
                    preparedStatement.setBigDecimal(4, new BigDecimal(shoppingCart.getTax()));
                    preparedStatement.setBigDecimal(5, new BigDecimal(shoppingCart.getTotal()));
                    preparedStatement.setInt(6, billAddressID);
                    preparedStatement.setInt(7, shipAddressID);
                    if (homePhoneID < 1) {
                        preparedStatement.setNull(8, Types.NULL);
                    } else {
                        preparedStatement.setInt(8, homePhoneID);
                    }
                    if (cellPhoneID < 1) {
                        preparedStatement.setNull(9, Types.NULL);
                    } else {
                        preparedStatement.setInt(8, cellPhoneID);
                    }
                    preparedStatement.setInt(10, creditCardID);
                    preparedStatement.executeUpdate();
                    
                    
                    // Add each ordered item to order_lines
                    sqlQuery = "INSERT INTO order_lines (order_id, product_id, line_item_cost)\n"
                            + "VALUES (?, ?, ?)";
                    preparedStatement = connection.prepareStatement(sqlQuery);
                    for (OrderItem item : shoppingCart.getItems()) {
                        preparedStatement.setInt(1, orderID);
                        preparedStatement.setInt(2, item.getProductId());
                        preparedStatement.setBigDecimal(3, new BigDecimal(item.getCost()));
                        preparedStatement.executeUpdate();
                    }

                   
                    request.setAttribute("orderID", String.valueOf(orderID));
                    sendEmail(request, userAccount, shoppingCart, shipAddress, billAddress, homePhone, cellPhone, creditCard, orderID);
                } catch (SQLException ex) {
                    Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        
            if (shoppingCart.getNumberItemsInCart() != 0) {
                ShoppingCartBean confirmedCart = new ShoppingCartBean();
                confirmedCart.setItems(shoppingCart.getItems());
                request.setAttribute("confirmedCart", confirmedCart);

                shoppingCart = new ShoppingCartBean();
                dispatcher = getServletContext().getRequestDispatcher(ORDER_CONFIRMED_URL);
            }
            else {
                dispatcher = getServletContext().getRequestDispatcher("/index");
            }
        }
        else if (requestAction.equalsIgnoreCase("edit")) {
            /*******************************************************************
             * When user clicks fills out purchasing info to complete an order
             ******************************************************************/
            dispatcher = getServletContext().getRequestDispatcher(CART_CHECKOUT_URL);
        }
        else if (requestAction.equalsIgnoreCase("viewCart")) {
            /*******************************************************************
             * When user clicks Show Cart, route them to cart content form
             ******************************************************************/
            dispatcher = getServletContext().getRequestDispatcher(CART_CONTENT_URL);
        }
        
        /***********************************************************************
         * Closing the connection object
         **********************************************************************/
        try {
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // forward via the dispatcher
        session.setAttribute("shoppingCart", shoppingCart);
        dispatcher.forward(request, response);
    }

    /**
     * Validates the Strings inputs and return a boolean[] of errors
     */
    private Boolean[] validateAddress(String line1, String line2, String city, String state, String zip) {
        Boolean[] hasError = new Boolean[5];
        Arrays.fill(hasError, Boolean.FALSE);
        
        // address line1 has error if it's empty
        hasError[0] = line1.isEmpty();
        
        // address line2 can be whatever it wants
        hasError[1] = false;
        
        // address city has error if it's empty or has non-alphabetical characters
        if (city.isEmpty())
            hasError[2] = true;
        else {
            hasError[2] = false;
            char[] chars = city.toCharArray();
            for (char c : chars) {
                if (!Character.isLetter(c)) {
                    hasError[2] = true;
                    break;
                }
            }
        }
        
        // address state has error if it does not have 2 characters, or has non-alphabetical characters
        if (state.length() != 2)
            hasError[3] = true;
        else {
            hasError[3] = false;
            char[] chars = state.toCharArray();
            for (char c : chars) {
                if (!Character.isLetter(c)) {
                    hasError[3] = true;
                    break;
                }
            }
        }
        
        // address zip has error if it does not have 5 characters, or has non-numerical characters
        if (zip.length() != 5)
            hasError[4] = true;
        else {
            hasError[4] = false;
            char[] chars = zip.toCharArray();
            for (char c : chars) {
                if (!Character.isDigit(c)) {
                    hasError[4] = true;
                    break;
                }
            }
        }
                
        return hasError;
    }
    
    private Boolean[] validatePhone(String homePhoneNumber, boolean homeIsPrimary, String cellPhoneNumber, boolean cellIsPrimary) {
        Boolean[] hasError = new Boolean[4];
        Arrays.fill(hasError, Boolean.FALSE);
        
        // Both home and cell cannot be blank
        if(homePhoneNumber.equals("") && cellPhoneNumber.equals("")) {
            hasError[0] = true;
            hasError[2] = true;
        }
        
        // Both home and cell are listed as primary
        if(homeIsPrimary && cellIsPrimary) {
            hasError[1] = true;
            hasError[3] = true;
        }
        
        return hasError;
    }
    
    private Boolean[] validateCreditCard(String cardType, String cardNumber, String cardMonth, String cardYear, String nameOnCard) {
        Boolean[] hasError = new Boolean[4];
        Arrays.fill(hasError, Boolean.FALSE);
        
        // If no card type selected
        if(cardType == null || cardType.equals("")) { 
            hasError[0] = true; 
        }
        
        // If no card number entered
        if(cardNumber == null || cardNumber.equals("")) { 
            hasError[1] = true;
        }
        // If card number entered isn't 16 characters long
        else if(cardNumber.length() != 16) {
            hasError[1] = true;
        }
        // If card number entered isn't numeric
        else if(!isNumeric(cardNumber)) {
            hasError[1] = true;
        }
        
        // If month or year aren't entered
        if(cardMonth == null || cardMonth.equals("") || cardYear == null || cardYear.equals("")) { 
            hasError[2] = true; 
        }
        // If month or year aren't length 2
        else if(cardMonth.length() != 2 || cardYear.length() != 2) { 
            hasError[2] = true; 
        }
        // If month or year aren't numeric
        else if(!isNumeric(cardMonth) || !isNumeric(cardYear)) {
            hasError[2] = true;
        }
        
        // If no name on card entered
        if(nameOnCard == null || nameOnCard.equals("")) { 
            hasError[3] = true;
        }
        
        return hasError;
    }
    
    //This is a functional confirmation emailing method. DO NOT DELETE!
    private void sendEmail(HttpServletRequest request, UserAccountBean userAccount, 
            ShoppingCartBean shoppingCart, AddressBean shipAddress, AddressBean billAddress, 
            PhoneBean homePhone, PhoneBean cellPhone, CreditCardBean creditCard, int orderID) {
        DecimalFormat df = new DecimalFormat("#.00");
        
        // send email to user
        String to = userAccount.getEmailAddress();
        String from = "Jonathan Sage <jsage8@gmail.com>";
        String subject = "Order Confirmation";

        String body = 
            "<h2 style='font-size: 150%; font-weight: bold; padding-top: 0px; margin-top: 0px; color: #FAA51A;'>" + userAccount.getFirstName() + " Your Order Has Been Placed!</h2>\n" +
            "<p>Your order number is " + orderID + ".</p>\n" +
            "<h2 style='font-size: 150%; font-weight: bold; padding-top: 0px; margin-top: 0px; color: #FAA51A;'>Your Order</h2>\n" +
            "<table style='width: 100%; border-collapse: collapse; margin-top: 10px; margin-bottom: 10px; background-color: #FFFFFF;' bgcolor='#FFFFFF'><tbody>\n";
        for (int i = 0; i < shoppingCart.getNumberItemsInCart(); i++) {
            body +=
            "    <tr>\n" +
            "        <td style='padding: 2px 10px; border: 1px solid #c8c8c8;'><img src=\"http://tunebazaar.selfip.com/" + shoppingCart.getItems().get(i).getAlbumInfo().getFilePath() + "\" width='75px'></td>\n" +
            "        <td style='padding: 2px 10px; border: 1px solid #c8c8c8;'>" + shoppingCart.getItems().get(i).getAlbumInfo().getArtistName() + " - " + shoppingCart.getItems().get(i).getAlbumInfo().getAlbumName() + "</td>\n" +
            "        <td style='padding: 2px 10px; border: 1px solid #c8c8c8;'>" + df.format(shoppingCart.getItems().get(i).getCost()) + "</td>\n" +
            "    </tr>\n";
        }
        body +=
            "    <tr>\n" +
            "        <td colspan='2' align='right' style='padding: 2px 10px; border: 1px solid #c8c8c8;'><b>Subtotal:</b></td>\n" +
            "        <td style='padding: 2px 10px; border: 1px solid #c8c8c8;'>" + df.format(shoppingCart.getSubtotal()) + "</td>\n" +
            "    </tr>\n" +
            "    <tr>\n" +
            "        <td colspan='2' align='right' style='padding: 2px 10px; border: 1px solid #c8c8c8;'><b>Tax:</b></td>\n" +
            "        <td style='padding: 2px 10px; border: 1px solid #c8c8c8;'>" + df.format(shoppingCart.getTax()) + "</td>\n" +
            "    </tr>\n" +
            "    <tr>\n" +
            "        <td colspan='2' align='right' style='padding: 2px 10px; border: 1px solid #c8c8c8;'><b>Total:</b></td>\n" +
            "        <td style='padding: 2px 10px; border: 1px solid #c8c8c8;'>" + df.format(shoppingCart.getTotal()) + "</td>\n" +
            "    </tr>\n" +
            "</tbody></table>\n" +

            "<h2 style='font-size: 150%; font-weight: bold; padding-top: 0px; margin-top: 0px; color: #FAA51A;'>Shipping Address</h2>\n" +
            "<p>" + userAccount.getFirstName() + " " + userAccount.getMiddleInitial() + " " + userAccount.getLastName() + "</p>\n" +
            "<p>" + shipAddress.getLine1() + "</p>\n";
        if(!shipAddress.getLine2().equals("")) {  
            body += "<p>" + shipAddress.getLine2() + "</p>\n";
        }      
        body +=
            "<p>" + shipAddress.getCity() + ", " + shipAddress.getState() + " " + shipAddress.getZip() + "</p>\n" +

            "<h2 style='font-size: 150%; font-weight: bold; padding-top: 0px; margin-top: 0px; color: #FAA51A;'>Billing Address</h2>\n" +
            "<p>" + userAccount.getFirstName() + " " + userAccount.getMiddleInitial() + " " + userAccount.getLastName() + "</p>\n" +
            "<p>" + billAddress.getLine1() + "</p>\n";
        if(!billAddress.getLine2().equals("")) {  
            body += "<p>" + billAddress.getLine2() + "</p>\n";
        }      
        body +=
            "<p>" + billAddress.getCity() + ", " + billAddress.getState() + " " + billAddress.getZip() + "</p>\n" +

            "<h2 style='font-size: 150%; font-weight: bold; padding-top: 0px; margin-top: 0px; color: #FAA51A;'>Contact</h2>\n";
        if(!homePhone.getPhone().equals("")) {
            body += "<p>Home Phone: " + homePhone.getPhone() + "</p>\n";
        }
        if(!cellPhone.getPhone().equals("")) {
            body += "<p>Cell Phone: " + cellPhone.getPhone() + "</p>\n";
        }
        body +=
            "<h2 style='font-size: 150%; font-weight: bold; padding-top: 0px; margin-top: 0px; color: #FAA51A;'>Payment Information</h2>\n" +
            "<p>Credit Card Type: " + creditCard.getCardType() + "</p>\n" +
            "<p>Credit Card Number: xxxxxxxxxxxx" + creditCard.getCardNumber().substring(creditCard.getCardNumber().length() - 4) + "</p>\n" +
            "<p>Card Expiration Date: " + creditCard.getCardMonth() + "/" + creditCard.getCardYear() + "</p>\n" +
            "<p>Name on Card: " + creditCard.getNameOnCard() + "</p>\n";

        
        boolean isBodyHTML = true;

        try {
            MailHelper.sendMail(to, from, subject, body, isBodyHTML);
        }
        catch(MessagingException e) {
            String errorMsg = 
                    "ERROR: Unable to send email. " +
                    "Check Tomcat logs for details.<br>" +
                    "NOTE: You may need to configure your system " +
                    "as described in chapter 15.<br>" +
                    "ERROR MESSAGE: " + e.getMessage();
            request.setAttribute("errorMessage", errorMsg);
            this.log(
                    "Unable to send email. \n" +
                    "Here is the email you tried to send: \n" +
                    "==========================================\n" +
                    "To: " + to + "\n" +
                    "From: " + from + "\n" +
                    "Subject: " + subject + "\n" +
                    body + "\n\n"       
                    );
        }
    }
    
    
    private boolean falseIfAllFalse(Boolean[] array) {
        for(Boolean b : array) {
            if(b) {
                return true;
            }
        }
        return false;
    }
    
    private boolean stringToBoolean(String string) {
        if(string != null) {
            return true;
        }
        else {
            return false;
        }
    }
    
    private static boolean isNumeric(String str) {
        try {
            Double.parseDouble(str);
        }
        catch(NumberFormatException e) {
              return false;
        }
        return true;
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
