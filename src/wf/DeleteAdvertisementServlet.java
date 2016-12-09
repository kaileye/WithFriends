package wf;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import wf.userbean.User;

/**
 *
 * @author danie
 */
@WebServlet(name = "DeleteAdvertisementServlet", urlPatterns = {"/deletead"})
public class DeleteAdvertisementServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    
    @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps2 = connection.prepareStatement("SELECT * FROM advertisements WHERE ADId = ?");
            boolean employeeprivelage = false;
            ps2.setString(1, request.getParameter("getdeletead"));
            data = ps2.executeQuery();
            while(data.next())
                {if(data.getString("EmployeeId").equalsIgnoreCase(u.getEmployeeId()))
                        {employeeprivelage = true;}
                    }
            PreparedStatement ps = connection.prepareStatement("UPDATE advertisements SET AvailableUnits = ? WHERE ADId = ?");
            ps.setString(1, "0");
            ps.setString(2, request.getParameter("getdeletead"));
            if(employeeprivelage)
            {ps.executeUpdate();}
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            RequestDispatcher rs = request.getRequestDispatcher(request.getParameter("pg"));
            rs.forward(request, response);
        }
    }
}