package wf;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import wf.userbean.User;

@WebServlet(name = "BuyItemServlet", urlPatterns = {"/buyitem"})
public class BuyItemServlet extends HttpServlet {

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
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
        String units = request.getParameter("units");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM advertisements WHERE ADId = ? AND AvailableUnits >= ?");
            ps.setString(1, request.getParameter("advertisementid"));
            ps.setString(2, request.getParameter("units"));
            data = ps.executeQuery();
            if (data.next()) {
                ps = connection.prepareStatement("UPDATE advertisements SET AvailableUnits = AvailableUnits - ? WHERE ADId = ?");
                ps.setString(1, units);
                ps.setString(2, request.getParameter("advertisementid"));
                ps.executeUpdate();
                ps = connection.prepareStatement("INSERT INTO sales(CustomerId, AccountNumber, SalesDateTime, ADId, Units) VALUES (?,?,?,?,?)");
                ps.setString(1, u.getUserId());
                ps.setString(2, request.getParameter("accountnumber"));
                ps.setString(3, currentTimestamp.toString());
                ps.setString(4, request.getParameter("advertisementid"));
                ps.setString(5, request.getParameter("units"));
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            RequestDispatcher rs = request.getRequestDispatcher(request.getParameter("pg"));
            rs.forward(request, response);
        }
    }
}