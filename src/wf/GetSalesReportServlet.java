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

@WebServlet(name = "GetSalesReportServlet", urlPatterns = {"/salesreport"})
public class GetSalesReportServlet extends HttpServlet {

    private static String dbUsername = "cse305";
    private static String dbPassward = "cse305";
    private static String connectionString = "jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false";
    private static Connection connection;
    private ResultSet data;
    private ArrayList<Sale> resultsales = new ArrayList<>(10);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String desiredMonth = request.getParameter("getsalesreportform");
        User u = (User)session.getAttribute("user");
        resultsales.clear();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM sales WHERE MONTH(SalesDateTime ) = ?");
            ps.setString(1, request.getParameter("getsalesreportform"));

            data = ps.executeQuery();
                
            while(data.next()) {
                Sale newsale = new Sale();
                newsale.setTransactionId(data.getString("TransactionId"));
                newsale.setCustomerId(data.getString("CustomerId"));
                newsale.setAccountNumber(data.getString("AccountNumber"));
                newsale.setSalesDateTime(data.getString("SalesDateTime"));
                newsale.setAdId(data.getString("ADId"));
                newsale.setUnits(data.getString("Units"));
                System.out.println("Transation Id: " + data.getString("TransactionId"));
                System.out.println("Customer Id: " + data.getString("CustomerId"));
                System.out.println("Account Number of Employee overseeing: " + data.getString("AccountNumber"));
                System.out.println("Date and Time of Sale: " + data.getString("SalesDateTime"));
                System.out.println("Advertisement ID: " + data.getString("ADId"));
                System.out.println("Number of Units: " + data.getString("Units"));
                resultsales.add(newsale);
            }
             session.setAttribute("saleresults", resultsales);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
               RequestDispatcher rs = request.getRequestDispatcher("salesreport.jsp");
            rs.forward(request, response);
        }
    }
}
