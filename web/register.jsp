<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="wfscript.js"></script>
        <title>WithFriends - Registration</title>
    </head>
    <body>
        <h1>Registration</h1>
        <form method="post" action="register">
            First Name: <input type="text" name="fname" /> <br />
            Last Name: <input type="text" name="lname" /> <br />
            <input type="radio" name="sex" value="M">Male
            <input type="radio" name="sex" value="F">Female<br />
            Email: <input type="email" name="email" /> <br />
            Password: <input type="password" name="password" /> <br />
            Birthday: <input type="date" name="dob"> <br />
            Address: <input type="text" name="address" /> <br />
            City: <input type="text" name="city" /> <br />
            State: <input type="text" name="state" /> <br />
            Zip Code: <input type="number" name="zipcode" /> <br />
            Telephone: <input type="number" name="telephone" /> <br />
            <button type="submit">Sign up</button>
        </form>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>