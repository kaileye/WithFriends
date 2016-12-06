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

@WebServlet(name = "GetCustomerGroupsServlet", urlPatterns = {"/customergrouphistory"})
public class GetCustomerGroupsServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
   private ArrayList<Group> resultgroups = new ArrayList<>(35);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gettransactionsearch = request.getParameter("getcustomergrouphistory");
        User u = (User)session.getAttribute("user");
        resultgroups.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM groupsmembers m LEFT JOIN groups g on g.GroupId = m.GroupId WHERE m.UserId = ?");
            ps.setString(1, gettransactionsearch);

            data = ps.executeQuery();
                
            while(data.next()) {
                Group newgroup = new Group();
                newgroup.setGroupId(data.getString("GroupId"));
                newgroup.setGroupName(data.getString("GroupName"));
                newgroup.setType(data.getString("Type"));
                newgroup.setOwnerId(data.getString("OwnerId"));
                resultgroups.add(newgroup);
            }
            
      
            
            
             session.setAttribute("customergrouphistory", resultgroups);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("customergrouphistory.jsp");
            rs.forward(request, response);
        }
    }
}