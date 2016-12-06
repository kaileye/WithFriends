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

@WebServlet(name = "RichestRepServlet", urlPatterns = {"/richestrep"})
public class RichestRepServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    private ArrayList<Sale> allsales = new ArrayList<>(55);
   private ArrayList<User> resultrichestrep = new ArrayList<>(20);
private ArrayList<User> arraytopass = new ArrayList<>(1);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        resultrichestrep.clear();
        allsales.clear();
        arraytopass.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName, A.UnitPrice, A.Type, A.EmployeeId FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId");
            
            data = ps.executeQuery();
                
            while(data.next()) {
                 Sale newsale = new Sale();
                                                newsale.setTransactionId(data.getString("TransactionId"));
                                                newsale.setCustomerId(data.getString("CustomerId"));
                                                newsale.setEmployeeId(data.getString("EmployeeId"));
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
                                                for (int i = 0; i < resultrichestrep.size(); i++)
                                                {
                                                    if (resultrichestrep.get(i).getEmployeeId().equalsIgnoreCase(newsale.getEmployeeId()))
                                                        {resultrichestrep.get(i).addToRevenueGenerated(newsale.getSumOfSaleString());
                                                        checker = true;
                                                        }
                                  
                                                }
                                                if  (!(checker))
                                                        {
                                                            User newemployee = new User();
                                                            newemployee.setEmployeeId(newsale.getEmployeeId());
                                                            newemployee.addToRevenueGenerated(newsale.getSumOfSaleString());
                                                            resultrichestrep.add(newemployee);
                                                        }
                                                
            }
            
            /**
                                                        *
                                                        goes through the array to find the employee with highest sum
                                                        */
            
            
            int high = 0;
            String highs = "";
            String richestrepid = "0";
            for (int i = 0; i < resultrichestrep.size(); i++)
            {
                if (resultrichestrep.get(i).getRevenueGeneratedInt() > high)
                    {
                        high = resultrichestrep.get(i).getRevenueGeneratedInt();
                        richestrepid = resultrichestrep.get(i).getEmployeeId();
                        highs = resultrichestrep.get(i).getRevenueGenerated();
                    }
            }
            
            
                 /**
                                                        *
                                                       takes the most revenue generating employee's id and searches db for him
                                                        */
            
            PreparedStatement ps2 = connection.prepareStatement("SELECT * FROM users x WHERE x.UserId = ?");
            ps2.setString(1, richestrepid);
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
            
            
             session.setAttribute("RichestRepResults", arraytopass);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("richestrep.jsp");
            rs.forward(request, response);
        }
    }
}