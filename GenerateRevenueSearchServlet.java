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

@WebServlet(name = "GenerateRevenueSearchServlet", urlPatterns = {"/revenuesearch"})
public class GenerateRevenueSearchServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
   private ArrayList<Sale> resultsales = new ArrayList<>(10);
private ArrayList<Sale> resultsalestotal = new ArrayList<>(1);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String getrevenuesearch = request.getParameter("getrevenuesearch");
        User u = (User)session.getAttribute("user");
        resultsales.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            if(request.getParameter("getrevenuesearchtype").equalsIgnoreCase("ItemID") )
                            {
                                        PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName, A.UnitPrice, A.Type FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId WHERE s.ADId = ?");
                                            ps.setString(1, getrevenuesearch);
        
                                            data = ps.executeQuery();
                                            Sale totalsale = new Sale();
                                        
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
                                                totalsale.addColumnTotal(newsale.getSumOfSaleString());
                                                resultsales.add(newsale);
                                            }
                                            resultsalestotal.add(totalsale);
                            }
            
            
            
            if(request.getParameter("getrevenuesearchtype").equalsIgnoreCase("Type") )
                            {
                                        PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName, A.UnitPrice, A.Type FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId WHERE a.Type = ?");
                                            ps.setString(1, getrevenuesearch);
        
                                            data = ps.executeQuery();
                                            Sale totalsale = new Sale();

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
                                                totalsale.addColumnTotal(newsale.getSumOfSaleString());
                                                resultsales.add(newsale);
                                            }
                                            resultsalestotal.add(totalsale);
                            }
            
            
            if(request.getParameter("getrevenuesearchtype").equalsIgnoreCase("CustomerID") )
                            {
                                PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName, A.UnitPrice, A.Type FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId WHERE s.CustomerId = ?");
                                            ps.setString(1, getrevenuesearch);
        
                                            data = ps.executeQuery();
                                            Sale totalsale = new Sale();

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
                                                totalsale.addColumnTotal(newsale.getSumOfSaleString());
                                                resultsales.add(newsale);
                                            }
                                            resultsalestotal.add(totalsale);
                                            
                                
                            }
            
            
            else if (!(request.getParameter("getrevenuesearchtype").equalsIgnoreCase("CustomerID")) && (request.getParameter("getrevenuesearchtype").equalsIgnoreCase("Type") ) && (request.getParameter("getrevenuesearchtype").equalsIgnoreCase("ItemID") ))
                            {
                                Sale newsale = new Sale();
                                                newsale.setTransactionId("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setCustomerId("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setAccountNumber("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setSalesDateTime("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setAdId("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setUnits("0");
                                                newsale.setItemName("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setFirstName("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setLastName("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.setUnitPrice("0");
                                                newsale.setAdType("ERROR ACCEPTING REQUEST TYPE");
                                                newsale.generateSumOfSaleString();
                                                resultsales.add(newsale);
                                               
                                                
                                
                            }
            
            
            
            
            
            
             session.setAttribute("GenerateRevenueSearchResults", resultsales);
             session.setAttribute("GenerateRevenueSearchResultsTotal", resultsalestotal);
             
        } catch (Exception e) {
            e.printStackTrace();
            
            
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("revenuesearch.jsp");
            rs.forward(request, response);
        }
    }
}