<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/wfcss.css" rel="stylesheet">
        <script src="wfscript.js"></script>
        <title>WithFriends - Registration</title>
    </head>
    <body>
        <div class="align-center">
            <img src="images/logo.png" height="20%" width="20%">
        </div>
        <form method="post" action="register">
            <div class="container">
                <div class="row">
                    <div class="form_bg2">
                        <h2 class="text-center">Register</h2>
                        <div class="form-group">
                            <input type="text" class="form-control" name="fname" placeholder="First Name"/> <br />
                            <input type="text" class="form-control" name="lname" placeholder="Last Name"/> <br />
                            <label class="radio-inline"><input type="radio" name="sex" value="M">Male</label>
                            <label class="radio-inline"><input type="radio" name="sex" value="F">Female</label><br /><br />
                            <input type="email" class="form-control" name="email" placeholder="Email"/> <br />
                            <input type="password" class="form-control" name="password" placeholder="Password"/> <br />
                            <input type="date" class="form-control" name="dob" placeholder="Birthday"> <br />
                            <input type="text" class="form-control" name="address" placeholder="Address"/> <br />
                            <input type="text" class="form-control" name="city" placeholder="City"/> <br />
                            <input type="text" class="form-control" name="state" placeholder="State"/> <br />
                            <input type="number" class="form-control" name="zipcode" placeholder="Zip Code"/> <br />
                            <input type="number" class="form-control" name="telephone" placeholder="Telephone"/> <br />
                        </div>
                        <div class="align-center">
                            <button class="btn btn-default" type="submit">Sign Up</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>