<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/wfcss.css" rel="stylesheet">
        <script src="wfscript.js"></script>
        <title>WithFriends - Log In or Sign Up</title>
    </head>
    <body>
        <jsp:useBean id="USER" scope="session" class="wf.userbean.User" />
        <% session.setAttribute("user", USER); %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:if test="${loggedin == false || empty loggedin}">
        <div class="align-center">
            <img src="images/logo.png" height="20%" width="20%">
        </div>
        <form action="login" method="POST">
            <div class="container">
                <div class="row">
                    <div class="form_bg">
                        <h2 class="text-center">Please sign in</h2>
                        <br/>
                        <div class="form-group">
                            <input type="email" class="form-control" id="uname" name="username" placeholder="Email">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" id="pwd" name="password" placeholder="Password">
                        </div>
                        <c:if test="${validlogin == false}">
                            <span id="loginInvalid" style="color:red; font-size:12px">The information you entered is incorrect</span>
                        </c:if>
                        <c:if test="${validlogin == true || empty validlogin}">
                            <br />
                        </c:if>
                        <div class="align-center">
                            <button type="submit" class="btn btn-default" id="login">Log In</button>
                        </div>
                        <a href="register.jsp">Register</a>
                    </div>
                </div>
            </div>
        </form>
        </c:if>
        <c:if test="${loggedin == true}">
            <%@ include file="navigation.jsp" %>
            <div class="container">
                <div class="row">
                    <div class="col-sm-4" class="form-control custom-control">
                        <form action="post" method="POST">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <textarea class="form-control" rows="5" cols="60" style="resize:none" placeholder="What's on your mind?"></textarea>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <button type="submit" class="btn pull-right">Post</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-sm-8" class="form-control custom-control">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="text-center">Wall</h4>
                            </div>
                            <div class="panel-body">
                                Blah blah blah.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>