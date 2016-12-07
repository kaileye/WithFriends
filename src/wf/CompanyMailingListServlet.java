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

@WebServlet(name = "CompanyMailingListServlet", urlPatterns = {"/companymailinglist"})
public class CompanyMailingListServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
   private ArrayList<User> resultusers = new ArrayList<>(25);

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gettransactionsearch = request.getParameter("getcompanymailinglist");
        User u = (User)session.getAttribute("user");
        
        
        resultusers.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, U.FirstName, U.LastName, U.EmailID FROM sales s INNER JOIN users U on U.UserId = s.CustomerId LEFT JOIN advertisements A on A.ADId = s.ADId WHERE A.Company = ?");
            ps.setString(1, gettransactionsearch);
            data = ps.executeQuery();
                
            while(data.next()) 
            {
                User newuser = new User();
                newuser.setEmail(data.getString("EmailID"));
                newuser.setFirstname(data.getString("FirstName"));
                newuser.setLastname(data.getString("LastName"));
                boolean check = false;
                for (int i = 0; i < resultusers.size(); i++)
                    {
                        if (resultusers.get(i).getEmail().equals(data.getString("EmailID")))
                            {check = true;}
                    }
                if (!(check)){resultusers.add(newuser);}
                
                // the for loop eliminates duplicates to repvent emails being sent to the same email twice or more times.
            }
            
          
          
            
            
            
            
            
             session.setAttribute("companymailingResults", resultusers);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("companymailing.jsp");
            rs.forward(request, response);
        }
    }
}