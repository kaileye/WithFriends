package wf;

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
    private static String connectionString = "jdbc:mysql://localhost:3306/cse305?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private static Statement command;
    private static ResultSet data;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String inputUname = request.getParameter("username");
        String inputPWD = request.getParameter("password");
        if(inputUname.equals("") || inputPWD.equals("")) {
            // Empty inputs
            response.sendRedirect("index.html");
        }

        try {
            //test whether username and password is in the data base or not.
            ServletContext sContext = this.getServletContext();
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            command = connection.createStatement();
            data = command.executeQuery("SELECT EmailID, PWD FROM WithFriends_Users");
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                do {
                    String currUname = data.getString(1);
                    String currPWD = data.getString(2);
                    if (inputUname.equals(currUname) && inputPWD.equals(currPWD))

                    System.out.println(data.getString(1) + " " + data.getString(2));
                } while (data.next());
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
