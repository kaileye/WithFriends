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

@WebServlet(name = "ShowAllAdvertisementsServlet", urlPatterns = {"/showallads"})
public class ShowAllAdvertisements extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    private ArrayList<Advertisements> allAdvertisements = new ArrayList<>(20);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("user");
        allAdvertisements.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM advertisements");
            

            data = ps.executeQuery();
                
            while(data.next()) {
                Advertisements ad = new Advertisements();
                ad.setAdId(data.getString("ADId"));
                ad.setEmployeeId(data.getString("EmployeeId"));
                ad.setType(data.getString("Type"));
                ad.setPostDateTime(data.getString("PostDateTime"));
                ad.setCompany(data.getString("Company"));
                ad.setItemName(data.getString("ItemName"));
                ad.setContent(data.getString("Content"));
                ad.setUnitPrice(data.getString("UnitPrice"));
                ad.setAvailableUnits(data.getString("AvailableUnits"));
               
                allAdvertisements.add(ad);
            }
             session.setAttribute("allads", allAdvertisements);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("displayallads.jsp");
            rs.forward(request, response);
        }
    }
}
