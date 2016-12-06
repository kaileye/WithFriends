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

@WebServlet(name = "CustomerItemSearchServlet", urlPatterns = {"/customeritemsearch"})
public class CustomerItemSearchServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
   private ArrayList<Sale> resultsales = new ArrayList<>(25);
private ArrayList<User> cuslist = new ArrayList<>(25);
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gettransactionsearch = request.getParameter("getcustomeritemsearch");
        User u = (User)session.getAttribute("user");
        cuslist.clear();
        resultsales.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId WHERE s.ADId = ?");
            ps.setString(1, gettransactionsearch);
            data = ps.executeQuery();
                
            while(data.next()) {
                Sale newsale = new Sale();
                newsale.setCustomerId(data.getString("CustomerId"));
                resultsales.add(newsale);
            }
            
            ps = connection.prepareStatement("SELECT * FROM users");
            data = ps.executeQuery();
            while(data.next()) {
                for (int k = 0;  k < resultsales.size(); k ++)
                { 
                  String thisKId = resultsales.get(k).getCustomerId();
                  if (thisKId.equalsIgnoreCase(data.getString("UserId")))
                    { 
                        
                        boolean checker = false;
                        for(int p = 0; p <cuslist.size(); p++)
                        
                            {
                                if (cuslist.get(p).getUserId().equals(data.getString("UserId")))
                                    {checker = true;}
                            }
                        
                        
                        if (!(checker))
                        {User yesuser = new User();
                        yesuser.setUserId(data.getString("UserId"));
                        yesuser.setFirstname(data.getString("FirstName"));
                        yesuser.setLastname(data.getString("LastName"));
                        cuslist.add(yesuser);}
                    }
                  
                   
                
                }
            }
            
            
            
            
            
             session.setAttribute("SearchItemCusResults", cuslist);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("cusitemsearch.jsp");
            rs.forward(request, response);
        }
    }
}