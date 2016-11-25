package wf;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

/**
 * Created by Yida Yuan on 11/21/16.
 */
@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private static Statement command;
    private ResultSet data;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String inputUname = request.getParameter("username");
        String inputPWD = request.getParameter("password");
        if(inputUname.equals("") || inputPWD.equals("")) {
            // Empty inputs
            response.sendRedirect("index.jsp");
        }

        try { 
            //test whether username and password is in the data base or not.
            ServletContext sContext = this.getServletContext();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps =connection.prepareStatement("SELECT EmailId, PWD FROM withfriends_users WHERE EmailId=? and PWD=?");
            ps.setString(1, inputUname);
            ps.setString(2, inputPWD);
            data =ps.executeQuery();
            if (data.next()) {
                session.setAttribute("loggedin", true);
                RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
                rs.forward(request, response);
            } else {
                request.setAttribute("validlogin", false);
                RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
                rs.forward(request, response);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } 
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
