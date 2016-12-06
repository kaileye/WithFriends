package wf;

import wf.userbean.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author danie
 */

@WebServlet(name = "RichestCustomerServlet", urlPatterns = {"/richestcus"})
public class RichestCustomerServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    private ArrayList<Sale> allsales = new ArrayList<>(55);
   private ArrayList<User> resultrichestcus = new ArrayList<>(20);
private ArrayList<User> arraytopass = new ArrayList<>(1);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        resultrichestcus.clear();
        arraytopass.clear();
        allsales.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName, A.UnitPrice, A.Type FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId");
            
            data = ps.executeQuery();
                
            while(data.next()) {
                 Sale newsale = new Sale();
                                                newsale.setTransactionId(data.getString("TransactionId"));
                                                newsale.setCustomerId(data.getString("CustomerId"));
                                                newsale.setAccountNumber(data.getString("AccountNumber"));
                                                newsale.setSalesDateTime(data.getString("SalesDateTime"));
                                                newsale.setAdId(data.getString("ADId"));
                                                newsale.setUnits(data.getString("Units"));
                                                newsale.setItemName(data.getString("ItemName"));
                                                newsale.setFirstName(data.getString("FirstName"));
                                                newsale.setLastName(data.getString("LastName"));
                                                newsale.setUnitPrice(data.getString("UnitPrice"));
                                                newsale.setAdType(data.getString("Type"));
                                                newsale.generateSumOfSaleString();
                                                allsales.add(newsale);
                                                
                                                /**
                                                        *
                                                        * Checker is for checking if employee from the sale above exists in array (resultrichestrep)
                                                        * goes through the array to see if element.employee id is equal to this sale.employeeid
                                                        * If it is: add rev of sale to sum of revenue generated for employee
                                                        * If not and employee doesnt exist in array: create employee in array and add sum
                                                        */
                                                boolean checker = false;
                                                for (int i = 0; i < resultrichestcus.size(); i++)
                                                {
                                                    if (resultrichestcus.get(i).getUserId().equalsIgnoreCase(newsale.getCustomerId()))
                                                        {resultrichestcus.get(i).addToRevenueGenerated(newsale.getSumOfSaleString());
                                                        checker = true;
                                                        }
                                  
                                                }
                                                if  (!(checker))
                                                        {
                                                            User newcus = new User();
                                                            newcus.setUserId(newsale.getCustomerId());
                                                            newcus.addToRevenueGenerated(newsale.getSumOfSaleString());
                                                            resultrichestcus.add(newcus);
                                                        }
                                                
            }
            
            /**
                                                        *
                                                        goes through the array to find the employee with highest sum
                                                        */
            
            
            int high = 0;
            String highs = "";
            String richestcusid = "0";
            for (int i = 0; i < resultrichestcus.size(); i++)
            {
                if (resultrichestcus.get(i).getRevenueGeneratedInt() > high)
                    {
                        high = resultrichestcus.get(i).getRevenueGeneratedInt();
                        richestcusid = resultrichestcus.get(i).getUserId();
                        highs = resultrichestcus.get(i).getRevenueGenerated();
                    }
            }
            
            
                 /**
                                                        *
                                                       takes the most revenue generating employee's id and searches db for him
                                                        */
            
            PreparedStatement ps2 = connection.prepareStatement("SELECT * FROM users x WHERE x.UserId = ?");
            ps2.setString(1, richestcusid);
            data = ps2.executeQuery();
            while(data.next()) 
                {
                    User finaluser = new User();
                    finaluser.setUserId(data.getString("UserId"));
                    finaluser.setRevenueGenerated(highs);
                    finaluser.setFirstname(data.getString("FirstName"));
                    finaluser.setLastname(data.getString("LastName"));
                    arraytopass.add(finaluser);
                }
            
            
             session.setAttribute("RichestCusResults", arraytopass);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("richestcus.jsp");
            rs.forward(request, response);
        }
    }
}