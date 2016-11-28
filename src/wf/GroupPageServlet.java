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

@WebServlet(name = "GroupPageServlet", urlPatterns = {"/grouppage"})
public class GroupPageServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        
        String groupId = request.getParameter("group");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM groupsmembers WHERE GroupId=? AND UserId=?");
            ps.setString(1, groupId);
            ps.setString(2, u.getUserId());
            data = ps.executeQuery();
            if (!data.next()) {
                request.setAttribute("member", false);
            } else {
                request.setAttribute("member", true);
                request.setAttribute("groupid", groupId);
                ps = connection.prepareStatement("SELECT PageId FROM pages WHERE GroupId=?");
                ps.setString(1, groupId);
                data = ps.executeQuery();
                if (data.next()){
                    request.setAttribute("pageid", data.getInt(1));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            RequestDispatcher rs = request.getRequestDispatcher("grouppage.jsp");
            rs.forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        
        String groupId = request.getParameter("group");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM groupsmembers WHERE GroupId=? AND UserId=?");
            ps.setString(1, groupId);
            ps.setString(2, u.getUserId());
            data = ps.executeQuery();
            if (!data.next()) {
                request.setAttribute("member", false);
            } else {
                request.setAttribute("member", true);
                request.setAttribute("groupid", groupId);
                ps = connection.prepareStatement("SELECT PageId FROM pages WHERE GroupId=?");
                ps.setString(1, groupId);
                data = ps.executeQuery();
                if (data.next()){
                    request.setAttribute("pageid", data.getInt(1));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            RequestDispatcher rs = request.getRequestDispatcher("grouppage.jsp");
            rs.forward(request, response);
        }
    }
}