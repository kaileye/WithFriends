<%-- 
    Document   : richestrep
    Created on : Dec 4, 2016, 7:53:53 PM
    Author     : danie
--%>


<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
     <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/wfcss.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/wfscript.js"></script>
        <title>WithFriends</title>
    </head>
    <body>
        
         <%-- Below = testing for logged in: 
                        If (logged in) = false : redirect to index.
                        if logged in: testing for (IS Manager)
                           If (Is Manager) = false : redirect to index.
              
            --%>
        
        <c:if test="${loggedin == false || empty loggedin}">
            <c:redirect url="index.jsp"></c:redirect>
        </c:if>
        <%@ include file="navigation.jsp" %>
        <sql:setDataSource var="wfdb" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false"
            user="cse305"  password="cse305"/>
        
        <sql:query dataSource="${wfdb}" var="managers">
            SELECT M.ManagerId
            FROM Managers M
            WHERE M.UserId=${USER.userId};
        </sql:query>
            
        <c:if test="${managers.rowCount == 0}">
            <c:redirect url="index.jsp"></c:redirect>
        </c:if>
        
            <%-- Below = code
            --%>
            
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                            <h4 class="text-center">Determine which customer representative generated most total revenue</h4>
                            
                            <div class="panel-body">
                            <table class="table table-hover">
                               <thead>
                                <tr>
                                    <th>Employee ID</th>
                                    <th>Employee First Name</th>
                                    <th>Employee Last Name</th>
                                    <th>Revenue Generated</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="richestrepresult" items="${RichestRepResults}">
                                    <tr>
                                        <td>${richestrepresult.userId}</td>
                                        <td>${richestrepresult.firstname}</td>
                                        <td>${richestrepresult.lastname}</td>
                                        <td>${richestrepresult.revenueGenerated}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                            
                            
                            
                            
                        </div>
                        </div>
                    </div>
                </div>
            </div>
                    
           
          
        
             
        
        
    </body>
</html>
