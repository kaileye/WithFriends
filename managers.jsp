<%-- 
    Document   : managers
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
            
        <div class="container">
            
            <%-- Monthly Sales Form (searching for sales in a desired month --%>
            
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="text-center">Manager Exclusive Actions</h4>
                    </div>
                                                                <BODY>
                                           <H1>Monthly Sales Report</H1>
                                           <FORM ACTION="salesreport" METHOD="POST">
                                               Please enter month (numerically):
                                               <INPUT TYPE="TEXT" NAME="getsalesreportform">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                                       <BODY>
                                           <H1>See List of all Advertisements</H1>
                                                <form action="showallads" method="POST">
                                                        <BR>
                                               <INPUT TYPE="SUBMIT" value="Show All Ads">
                                                </form>
                                       </BODY>
                                       <BODY>
                                           <H1>Search all Transactions by User Name or Item Name</H1>
                                           <FORM ACTION="transactionsearch" METHOD="POST">
                                               Please enter name (either of Product or Customer):
                                               <INPUT TYPE="TEXT" NAME="gettransactionsearch">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>

                                       <BODY>
                                           <H1>Produce a summary listing of revenue generated by a particular item, item type, or customer</H1>
                                           <FORM ACTION="revenuesearch" METHOD="POST">
                                               Please enter ID of Item, ID of Customer, or name of Item Type (ie: #, #, or String)
                                               <INPUT TYPE="TEXT" NAME="getrevenuesearch">
                                               <row></row>
                                               Please enter search type (Accepted Answers: "ItemID", "Type", "CustomerID"):
                                               <INPUT TYPE="TEXT" NAME="getrevenuesearchtype">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                                       <BODY>
                                           <H1>See which customer representative generated most total revenue</H1>
                                                <form action="richestrep" method="POST">
                                                        <BR>
                                               <INPUT TYPE="SUBMIT" value="richestrep">
                                                </form>
                                       </BODY>
                                        <BODY>
                                           <H1>Determine which customer generated most total revenue</H1>
                                                <form action="richestcus" method="POST">
                                                        <BR>
                                               <INPUT TYPE="SUBMIT" value="richestcus">
                                                </form>
                                       </BODY>
                    <div class="panel-body">
                    </div>
                </div>
            </div>
            
            
 
        </div>
    </body>
</html>
