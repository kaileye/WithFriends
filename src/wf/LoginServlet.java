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
import javax.servlet.annotation.WebServlet;

/**
 * Created by Yida Yuan on 11/21/16.
 */
@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private String query;
    private static Connection connection;
    private static Statement command;
    private ResultSet data;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("doPost");
        String inputUname = request.getParameter("username");
        String inputPWD = request.getParameter("password");
        if(inputUname.equals("") || inputPWD.equals("")) {
            // Empty inputs
            response.sendRedirect("index.html");
        }

        try { 
            //test whether username and password is in the data base or not.
            ServletContext sContext = this.getServletContext();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            command = connection.createStatement();
            query = "SELECT EmailID, PWD FROM withfriends_users WHERE EmailId = '" + inputUname + "' AND PWD = '" + inputPWD + "'";
            data = command.executeQuery(query); 
            if (data.next()) {
                System.out.println("Horray");
            } else {
                System.out.println("Boo");
            }
        } catch(Exception e) {
            e.printStackTrace();
        } 
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
