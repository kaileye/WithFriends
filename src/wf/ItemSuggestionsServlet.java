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

@WebServlet(name = "ItemSuggestionsServlet", urlPatterns = {"/itemsuggestions"})
public class ItemSuggestionsServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    private ArrayList<Advertisements> recads= new ArrayList<>(25);
    private ArrayList<Type> typecount = new ArrayList<>(25);
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gettransactionsearch = request.getParameter("itemsuggestionsform");
        User u = (User)session.getAttribute("user");
        typecount.clear();
        recads.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT s.*, A.ItemName, A.UnitPrice, A.AvailableUnits, A.Type FROM sales s INNER JOIN advertisements A on A.ADId = s.ADId WHERE s.CustomerId = ?");
            ps.setString(1, gettransactionsearch);
            data = ps.executeQuery();
                
            while(data.next()) 
            {
                Advertisements newad = new Advertisements();
                newad.setAdId(data.getString("ADId"));
                newad.setItemName(data.getString("ItemName"));
                newad.setType(data.getString("Type"));
                newad.setUnitPrice(data.getString("UnitPrice"));
                newad.setAvailableUnits(data.getString("AvailableUnits"));
                recads.add(newad);
                Type ntype = new Type();
                 boolean typecheck = false;
                ntype.setTypeName(data.getString("Type"));
                    if (typecount.size() == 0){ ntype.addTypeCount();
                            typecount.add(ntype);}
                   
                    else for (int t = 0; t<typecount.size();t++)
                        {
                            if (typecount.get(t).getTypeName().equalsIgnoreCase(ntype.getTypeName())) {typecheck = true; typecount.get(t).addTypeCount();}
                        
                        }
                    if (typecheck = false) {ntype.addTypeCount();
                            typecount.add(ntype);}
            }
            
           
            
            for (int p = 0; p < typecount.size(); p++)
                {
                    if (p+1 < typecount.size())
                    
                        {
                            for (int v = p+1;v< typecount.size(); v++)
                                {
                                    if(typecount.get(p).getTypeCount()<typecount.get(v).getTypeCount())
                                        {
                                        Type j = typecount.get(v);
                                        typecount.set(v, typecount.get(p));
                                        typecount.set(p, j);
                                        }
                                }
                        }
                }
          
            recads.clear();
          
            
                        ps = connection.prepareStatement("SELECT * FROM advertisements A WHERE A.Type = ?");
                        String prepare = typecount.get(0).getTypeName();
                        ps.setString(1, prepare);
                        data = ps.executeQuery();
                           
                                            while(data.next()) 
                                {
                                    Advertisements newad = new Advertisements();
                                    newad.setAdId(data.getString("ADId"));
                                    newad.setItemName(data.getString("ItemName"));
                                    newad.setType(data.getString("Type"));
                                    newad.setCompany(data.getString("Company"));
                                    newad.setUnitPrice(data.getString("UnitPrice"));
                                    newad.setAvailableUnits(data.getString("AvailableUnits"));
                                    recads.add(newad);
                                }
                        
            for (int av = 0; av < recads.size(); av++)
                {
                    if(recads.get(av).getAvailableUnits().equalsIgnoreCase("0"))
                    {recads.remove(av);}
                }
            
           
            
            
             session.setAttribute("recommendads", recads);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("recommendads.jsp");
            rs.forward(request, response);
        }
    }
}