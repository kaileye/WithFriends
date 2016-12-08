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
        <sql:query dataSource="${wfdb}" var="advertisements">
            SELECT A.* FROM advertisements A, users U WHERE U.UserId = ${USER.userId} AND U.preference = A.type AND A.AvailableUnits > 0 ORDER BY A.PostDateTime DESC;
        </sql:query>
        <sql:query dataSource="${wfdb}" var="accounts">
            SELECT * FROM usersaccounts WHERE UserId = ${USER.userId};
        </sql:query>
        <c:forEach var="advertisement" items="${advertisements.rows}">
        <div class="jumbotron">
            <div class="container">
                <h1>${advertisement.ItemName} - ${advertisement.Company}</h1>
                <p>${advertisement.Content}</p>
                <button class="btn btn-primary btn-lg itembuyer" value="${advertisement.ADId}">$${advertisement.UnitPrice}</button>  ${advertisement.availableunits} units available
            </div>
        </div>
        </c:forEach>
        <div id="buyitemdialog" class="dialog" title="Buy Item">
            <form action="buyitem" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="advertisement.jsp">
                            <input type="hidden" name="advertisementid" class="advertisementid" value="">
                            Units: <input type="number" name="units" required="required">
                            Account: 
                            <select name="accountnumber" required="required">
                                <c:forEach var="account" items="${accounts.rows}">
                                    <option value="${account.AccountNumber}">${account.AccountNumber}</option>
                                </c:forEach>
                            </select> 
                            <br /><br />
                            <button type="submit" class="btn pull-right">Buy</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script>
        $("#buyitemdialog").dialog({
            autoOpen: false,
            width: "auto"
        });
        
        
        $(".itembuyer").click(function () {
            $("#buyitemdialog").dialog("open");
            $(".advertisementid").val($(this).val());
        });
        </script>
    </body>
</html>
