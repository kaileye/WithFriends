package wf;

import wf.userbean.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SendMessageServlet", urlPatterns = {"/sendmessage"})
public class SendMessageServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String receiverid = request.getParameter("receiverid");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        User u = (User)session.getAttribute("user");
        Timestamp currentTimestamp = new Timestamp(Calendar.getInstance().getTime().getTime());
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("INSERT INTO Messages (SentDateTime, Subject, Content, SenderId, ReceiverId) VALUES (?,?,?,?,?)");
            ps.setString(1, currentTimestamp.toString());
            ps.setString(2, subject);
            ps.setString(3, content);
            ps.setString(4, u.getUserId());
            ps.setString(5, receiverid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(request.getParameter("pg")).forward(request, response);
        }
    }
}
