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

@WebServlet(name = "CompanySearchServlet", urlPatterns = {"/companysearch"})
public class CompanySearchServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
   private ArrayList<Advertisements> resultsales = new ArrayList<>(25);

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gettransactionsearch = request.getParameter("getcompanysearch");
        User u = (User)session.getAttribute("user");
        
        resultsales.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM advertisements a WHERE a.Company = ?");
            ps.setString(1, gettransactionsearch);
            data = ps.executeQuery();
                
            while(data.next()) 
            {
                Advertisements newad = new Advertisements();
                newad.setAdId(data.getString("ADId"));
                newad.setItemName(data.getString("ItemName"));
                newad.setType(data.getString("Type"));
                newad.setUnitPrice(data.getString("UnitPrice"));
                newad.setCompany(data.getString("Company"));
                resultsales.add(newad);
            }
            
          
          
            
            
            
            
            
             session.setAttribute("companysearchResults", resultsales);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("companysearch.jsp");
            rs.forward(request, response);
        }
    }
}