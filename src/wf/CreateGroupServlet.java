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

@WebServlet(name = "CreateGroupServlet", urlPatterns = {"/creategroup"})
public class CreateGroupServlet extends HttpServlet {

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
            PreparedStatement ps = connection.prepareStatement("INSERT INTO groups(GroupName, Type, OwnerId) VALUES(?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, request.getParameter("groupname"));
            ps.setString(2, request.getParameter("grouptype"));
            ps.setString(3, u.getUserId());
            int i = ps.executeUpdate();
            if (i > 0) {
                data = ps.getGeneratedKeys();
                if (data.next()) {
                    ps = connection.prepareStatement("INSERT INTO pages(GroupId, PostCount, PageType) VALUES(?,?,?)");
                    ps.setString(1, data.getString(1));
                    ps.setString(2, "0");
                    ps.setString(3, "group");
                    ps.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            RequestDispatcher rs = request.getRequestDispatcher(request.getParameter("pg"));
            rs.forward(request, response);
        }
    }
}
