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

@WebServlet(name = "LikeCommentServlet", urlPatterns = {"/likecomment"})
public class LikeCommentServlet extends HttpServlet {

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
        String action = request.getParameter("likecomment");
        String commentId = request.getParameter("comment");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionString, dbUsername, dbPassward);
            PreparedStatement ps = connection.prepareStatement("SELECT Opinion FROM likecomment WHERE UserId=? AND CommentId=?");
            ps.setString(1, u.getUserId());
            ps.setString(2, commentId);
            data = ps.executeQuery();
            if ("like".equals(action)) {
                if (data.next()) {
                    String opinion = data.getString(1);
                    if ("unlike".equals(opinion)) {
                        ps = connection.prepareStatement("UPDATE comments SET Likes=Likes+2 WHERE CommentId=?");
                        ps.setString(1, commentId);
                        ps.executeUpdate();
                        ps = connection.prepareStatement("UPDATE likecomment SET Opinion='like' WHERE UserId=? AND CommentId=?");
                        ps.setString(1, u.getUserId());
                        ps.setString(2, commentId);
                        ps.executeUpdate();
                    } else if ("like".equals(opinion)) {
                        ps = connection.prepareStatement("UPDATE comments SET Likes=Likes-1 WHERE CommentId=?");
                        ps.setString(1, commentId);
                        ps.executeUpdate();
                        ps = connection.prepareStatement("DELETE FROM likecomment WHERE CommentId=? AND UserId=?");
                        ps.setString(1, commentId);
                        ps.setString(2, u.getUserId());
                        ps.executeUpdate();
                    }
                } else {
                    ps = connection.prepareStatement("UPDATE comments SET Likes=Likes+1 WHERE CommentId=?");
                    ps.setString(1, commentId);
                    ps.executeUpdate();
                    ps = connection.prepareStatement("INSERT INTO likecomment(UserId, CommentId, Opinion) VALUES(?,?,?)");
                    ps.setString(1, u.getUserId());
                    ps.setString(2, commentId);
                    ps.setString(3, "like");
                    ps.executeUpdate();
                }
            } else if ("unlike".equals(action)) {
                if (data.next()) {
                    String opinion = data.getString(1);
                    if ("like".equals(opinion)) {
                        ps = connection.prepareStatement("UPDATE comments SET Likes=Likes-2 WHERE CommentId=?");
                        ps.setString(1, commentId);
                        ps.executeUpdate();
                        ps = connection.prepareStatement("UPDATE likecomment SET Opinion='unlike' WHERE UserId=? AND CommentId=?");
                        ps.setString(1, u.getUserId());
                        ps.setString(2, commentId);
                        ps.executeUpdate();
                    } else if ("unlike".equals(opinion)) {
                        ps = connection.prepareStatement("UPDATE comments SET Likes=Likes+1 WHERE CommentId=?");
                        ps.setString(1, commentId);
                        ps.executeUpdate();
                        ps = connection.prepareStatement("DELETE FROM likecomment WHERE CommentId=? AND UserId=?");
                        ps.setString(1, commentId);
                        ps.setString(2, u.getUserId());
                        ps.executeUpdate();
                    }
                } else {
                    ps = connection.prepareStatement("UPDATE comments SET Likes=Likes-1 WHERE CommentId=?");
                    ps.setString(1, commentId);
                    ps.executeUpdate();
                    ps = connection.prepareStatement("INSERT INTO likecomment(UserId, CommentId, Opinion) VALUES(?,?,?)");
                    ps.setString(1, u.getUserId());
                    ps.setString(2, commentId);
                    ps.setString(3, "unlike");
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
