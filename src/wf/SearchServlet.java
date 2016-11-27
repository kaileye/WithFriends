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

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    private ArrayList<User> resultUsers = new ArrayList<>(10);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String searchFname = request.getParameter("q");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM Users WHERE FirstName=?");
            ps.setString(1, searchFname);
            data = ps.executeQuery();
            while(data.next()) {
                User newUser = new User();
                newUser.setFirstname(data.getString("FirstName"));
                newUser.setLastname(data.getString("LastName"));
                newUser.setSex(data.getString("sex"));
                newUser.setEmail(data.getString("EmailId"));
                resultUsers.add(newUser);
            }
            session.setAttribute("sresults", resultUsers);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher("searchresults.jsp").forward(request, response);
        }
    }

}
