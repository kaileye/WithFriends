package wf;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/register"})
public class RegistrationServlet extends HttpServlet {
    
    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String sex = request.getParameter("sex");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String telephone = request.getParameter("telephone");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("INSERT INTO users(FirstName, LastName, sex,EmailId, PWD, DOB, Address, City, State, Zipcode, Telephone, AccountCreationDate, Preference) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, sex);
            ps.setString(4, email);
            ps.setString(5, password);
            ps.setString(6, dob);
            ps.setString(7, address);
            ps.setString(8, city);
            ps.setString(9, state);
            ps.setString(10, zipcode);
            ps.setString(11, telephone);
            ps.setString(12, date.toString());
            ps.setString(13, request.getParameter("preferences"));
            int i = ps.executeUpdate();
            if (i > 0) {
                request.setAttribute("success", true);
                data = ps.getGeneratedKeys();
                if (data.next()){
                    ps = connection.prepareStatement("INSERT INTO pages(OwnerId, PostCount, PageType) VALUES (?,?,?)");
                    ps.setString(1, data.getString(1));
                    ps.setString(2, "0");
                    ps.setString(3, "user");
                    ps.executeUpdate();
                    
                    ps = connection.prepareStatement("INSERT INTO UsersAccounts(UserId, AccountNumber) VALUES (?,?)");
                    ps.setString(1, data.getString(1));
                    ps.setString(2, request.getParameter("accountnumber"));
                    ps.executeUpdate();
                }
            } 
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("success", false);
        } finally {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
