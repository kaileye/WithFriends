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

@WebServlet(name = "CommentServlet", urlPatterns = {"/comment"})
public class CommentServlet extends HttpServlet {

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
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("INSERT INTO comments(PosterId, PosterName, PostId, PostDateTime, Content) VALUES(?,?,?,?,?)");
            ps.setString(1, u.getUserId());
            ps.setString(2, u.getFirstname() + " " + u.getLastname());
            ps.setString(3, request.getParameter("post"));
            ps.setString(4, currentTimestamp.toString());
            ps.setString(5, request.getParameter("comment"));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
            rs.forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
