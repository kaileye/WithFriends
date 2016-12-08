<%-- 
    Document   : salesreport
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
        
            <%-- Below = all advertisements. results based off: 
                        session.setAttribute("allads", allAdvertisements); 
                  in ShowAllAdvertisements.java
            --%>
            
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                            <h4 class="text-center">All Advertisements</h4>
                            
                            <div class="panel-body">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>AD ID</th>
                                    <th>Employee ID</th>
                                    <th>AD Type</th>
                                    <th>Date AD was created</th>
                                    <th>Company</th>
                                    <th>Item Name</th>
                                    <th>Description</th>
                                    <th>Price per Unit</th>
                                    <th># Of Available Units</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="alladverts" items="${allads}">
                                    <tr>
                                        <td>${alladverts.adId}</td>
                                        <td>${alladverts.employeeId}</td>
                                        <td>${alladverts.type}</td>
                                        <td>${alladverts.postDateTime}</td>
                                        <td>${alladverts.company}</td>
                                        <td>${alladverts.itemName}</td>
                                        <td>${alladverts.content}</td>
                                        <td>${alladverts.unitPrice}</td>
                                        <td>${alladverts.availableUnits}</td>
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
