package wf;

import wf.userbean.User;

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

/**
 * Created by MrYY on 11/28/16.
 */
@WebServlet(name = "FriendUnfriendServlet", urlPatterns = {"/friendunfriend"})
public class FriendUnfriendServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String status = request.getParameter("status");
        String reid = request.getParameter("reid");
        if (status.equals("1")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
                PreparedStatement ps = connection.prepareStatement("DELETE FROM FriendsRequests WHERE RequestId=?");
                ps.setString(1, reid);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                request.getRequestDispatcher("friend.jsp").forward(request, response);
            }
        }
    }
}
