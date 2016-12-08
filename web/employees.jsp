<!DOCTYPE html>
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
        
        <sql:query dataSource="${wfdb}" var="employees">
            SELECT E.EmployeeId
            FROM Employees E
            WHERE E.EmployeeId=${USER.userId};
        </sql:query>
            
        <c:if test="${employees.rowCount == 0}">
            <c:redirect url="index.jsp"></c:redirect>
        </c:if>
            
        <div class="container">
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="text-center">Employee Specific Actions</h4>
                    </div>
                    <div class="panel-body">
                        <BODY>
                                           <H1>Produce a list of item suggestions for a given customer</H1>
                                           <FORM ACTION="itemsuggestions" METHOD="POST">
                                               Please enter customer id:
                                               <INPUT TYPE="TEXT" NAME="itemsuggestionsform">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                                       <BODY>
                                           <H1>Enter Customer's ID to get their Groups</H1>
                                           <FORM ACTION="customergrouphistory" METHOD="POST">
                                               Please enter ID of Customer
                                               <INPUT TYPE="TEXT" NAME="getcustomergrouphistory">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                                       <BODY>
                                           <H1>Enter Customer's ID to get their account history</H1>
                                           <FORM ACTION="customeraccounthistory" METHOD="POST">
                                               Please enter ID of Customer
                                               <INPUT TYPE="TEXT" NAME="getcustomeraccounthistory">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                                       <BODY>
                                           <H1>Produce a list of most active items</H1>
                                                <form action="activeitemsE" method="POST">
                                                        <BR>
                                               <INPUT TYPE="SUBMIT" value="activeitems">
                                                </form>
                                       </BODY>
                                       <BODY>
                                           <H1>Enter a Company Name to produce their mailing list</H1>
                                           <FORM ACTION="companymailinglist" METHOD="POST">
                                               Please enter name of Company
                                               <INPUT TYPE="TEXT" NAME="getcompanymailinglist">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                                       <BODY>
                                           <H1>Create an Advertisement</H1>
                                           <FORM ACTION="createad" METHOD="POST">
                                               Please enter Advertisement Type:
                                               <INPUT TYPE="TEXT" NAME="createadtype">
                                               Please enter Company of Ad:
                                               <INPUT TYPE="TEXT" NAME="createadcompany">
                                               Please enter Item Name:
                                               <INPUT TYPE="TEXT" NAME="createadname">
                                               please enter Content of AD:
                                               <INPUT TYPE="TEXT" NAME="createadcontent">
                                                please enter price of each unit:
                                               <INPUT TYPE="TEXT" NAME="createadprice">
                                               please enter number of units:
                                               <INPUT TYPE="TEXT" NAME="createdunits">
                                               <input type="hidden" name="pg" value="index.jsp">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                                        <BODY>
                                           <H1>Delete Advertisement</H1>
                                           <FORM ACTION="deletead" METHOD="POST">
                                               Please enter ID of ad to delete
                                               <INPUT TYPE="TEXT" NAME="getdeletead">
                                       
                                               <input type="hidden" name="pg" value="index.jsp">
                                               <BR>
                                               <INPUT TYPE="SUBMIT" value="Submit">
                                               
                                           </FORM>
                                       </BODY>
                </div>
            </div>
        </div>
    </body>
</html>
