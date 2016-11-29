package wf;

import wf.userbean.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "GroupRequestServlet", urlPatterns = {"/grouprequest"})
public class GroupRequestServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM groupsmembers WHERE GroupId=? AND UserId=?");
            ps.setString(1, request.getParameter("groupid"));
            ps.setString(2, request.getParameter("receiverid"));
            data = ps.executeQuery();
            if (data.next()) {
                request.setAttribute("alreadygroup", true);
            } else {
                ps = connection.prepareStatement("INSERT INTO groupsrequests (SenderId, GroupId, ReceiverId, Content) VALUES (?,?,?,?)");
                ps.setString(1, u.getUserId());
                ps.setString(2, request.getParameter("groupid"));
                ps.setString(3, request.getParameter("receiverid"));
                ps.setString(4, request.getParameter("content"));
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(request.getParameter("sr")).forward(request, response);
        }
    }
}
