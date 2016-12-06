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

@WebServlet(name = "FindCustomerHistory", urlPatterns = {"/customeraccounthistory"})
public class FindCustomerHistory extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
   private ArrayList<Sale> resultsales = new ArrayList<>(20);
   private ArrayList<Post> resultposts = new ArrayList<>(35);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gettransactionsearch = request.getParameter("getcustomeraccounthistory");
        User u = (User)session.getAttribute("user");
        resultsales.clear();
        resultposts.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId WHERE s.CustomerId = ?");
            ps.setString(1, gettransactionsearch);

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
              
                resultsales.add(newsale);
            }
            
            //Adding User's Post History
            PreparedStatement ps2 = connection.prepareStatement("SELECT * FROM posts WHERE PosterId = ?");
            ps2.setString(1, gettransactionsearch);

            data = ps2.executeQuery();
            
            while(data.next()) {
                Post newpost = new Post();
                newpost.setPosterId(data.getString("PosterId"));
                newpost.setPostId(data.getString("PostId"));
                newpost.setPageId(data.getString("PageId"));
                newpost.setPostDateTime(data.getString("PostDateTime"));
                newpost.setContent(data.getString("Content"));
                resultposts.add(newpost);
            }
            
            
             session.setAttribute("customeraccounthistory", resultsales);
             session.setAttribute("customerposthistory", resultposts);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("customerhistory.jsp");
            rs.forward(request, response);
        }
    }
}