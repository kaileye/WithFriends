<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="wfscript.js"></script>
        <style>
        body {
            background: #3b5998;
        }

        .form_bg {
            background-color:#eee;
            color:#666;
            padding:20px;
            border-radius:10px;
            position: absolute;
            border:1px solid #fff;
            margin: auto;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 320px;
            height: 280px;
        }

        .align-center {
            text-align:center;
        }
        </style>
        <title>WithFriends</title>
    </head>
    <body>
        <div class="align-center">
            <img src="images/logo.png" height="20%" width="20%">
        </div>
        <form action="login" method="POST">
            <div class="container">
                <div class="row">
                    <div class="form_bg">
                        <form>
                            <h2 class="text-center">Please sign in</h2>
                            <br/>
                            <div class="form-group">
                                <input type="email" class="form-control" id="uname" name="username" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" id="pwd" name="password" placeholder="Password">
                            </div>
                            <br/>
                            <div class="align-center">
                                <button type="submit" class="btn btn-default" id="login">Login</button>
                            </div>
                            <a href="register.jsp">Register</a>
                        </form>
                    </div>
                </div>
            </div>
        </form>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>