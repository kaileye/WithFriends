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

@WebServlet(name = "ActiveItemServlet", urlPatterns = {"/activeitems"})
public class ActiveItemServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    
    private ArrayList<Advertisements> allads = new ArrayList<>(35);
     private ArrayList<Advertisements> nodupes = new ArrayList<>(25);


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        allads.clear();
        
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, A.UnitPrice, A.Type, A.EmployeeId, A.Company FROM sales s INNER JOIN advertisements A on A.ADId = s.ADId");
            
            data = ps.executeQuery();
                
            while(data.next()) {
                 Advertisements newad = new Advertisements();
                                                newad.setAdId(data.getString("ADId"));
                                                newad.setTemp(data.getString("Units"));
                                                allads.add(newad);
                                                
                                                 boolean checker = false;
                                                for (int i = 0; i < nodupes.size(); i++)
                                                {
                                                    if (nodupes.get(i).getAdId().equalsIgnoreCase(newad.getAdId()))
                                                        {nodupes.get(i).addToActivity(newad.getTemp());
                                                        checker = true;
                                                        }
                                  
                                                }
                                                if  (!(checker))
                                                        {
                                                            Advertisements nodupeAd = new Advertisements();
                                                            nodupeAd.setAdId(newad.getAdId());
                                                            nodupeAd.setCompany(data.getString("Company"));
                                                            nodupeAd.setType(data.getString("Type"));
                                                            nodupeAd.setItemName(data.getString("ItemName"));
                                                            nodupeAd.addToActivity(newad.getTemp());
                                                            nodupes.add(nodupeAd);
                                                        }
                                                
                                                
            }
           
            for (int i = 0; i <nodupes.size(); i++)
                {
                    if ( i+1 <nodupes.size())
                    {   for (int k = i+1; k <nodupes.size(); k++)
                         {
                            if( nodupes.get(i).getActivityInt() < nodupes.get(k).getActivityInt() )
                                {
                                    Advertisements tempad = nodupes.get(i);
                                    nodupes.set(i, nodupes.get(k));
                                    nodupes.set(k, tempad);
                                }
                        }
                    }
                }
            
          
            
             session.setAttribute("ActiveItemResults", nodupes);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("activeitems.jsp");
            rs.forward(request, response);
        }
    }
}