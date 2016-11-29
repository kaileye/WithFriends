package wf;

import wf.userbean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.Calendar;

/**
 * Created by Yida Yuan on 11/28/16.
 */
@WebServlet(name = "DeleteMessageServlet", urlPatterns = {"/deletemessage"})
public class DeleteMessageServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String msgid = request.getParameter("msgid");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("DELETE FROM Messages WHERE MessageId=?");
            ps.setString(1, msgid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(request.getParameter("pg")).forward(request, response);
        }
    }
}
