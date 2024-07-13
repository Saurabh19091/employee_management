<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Time Tracker Manager</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="images/login.jpeg" />
    <style>
        body {
            background: #F4C2C2;
        }
        .panel-heading {
            background: linear-gradient(to bottom, #ffffff, #99ccff);
        }
        .ok {
            color: black;
        }
        .panel-heading, .panel-primary>.panel-heading {
            color: black;
        }
    </style>
</head>
<body>
    <div style="padding:10px; margin:10px;">
        <div class="panel panel-primary">
            <div class="panel-heading"><b class="ok">Time Tracker Manager</b></div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="panel panel-success">
                            <div class="panel-heading"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Signin with your existing Account</div>
                            <div class="panel-body">
                                <form class="form-horizontal" action="login" method="post">
                                    <div class="form-group">
                                        <label for="Email" class="col-sm-3 control-label">Email</label>
                                        <div class="col-sm-10">
                                            <input type="email" class="form-control" id="Email" placeholder="Email" name="email" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="Password" class="col-sm-3 control-label">Password</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control" id="Password" placeholder="Password" name="password" required>
                                        </div>
                                    </div>
                                    <!-- Display error message if login fails -->
                                    <!-- Use JavaScript to handle form submission -->
                                    <button type="submit" class="btn btn-primary">Sign in</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <img src="images/login.jpeg" alt="..." class="img-thumbnail img-responsive">
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading ok"><span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span> New user? Create your free Account</div>
                            <div class="panel-body">
                                <form class="form-horizontal" action="register" method="post">
                                    <div class="form-group">
                                        <label for="fname" class="col-sm-2 control-label" >Full Name</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="fname" name="username" autocomplete="off" required placeholder="Write your full name here">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="name" class="col-sm-2 control-label">Email</label>
                                        <div class="col-sm-10">
                                            <input type="email" id="name" name="email" class="form-control"  autocomplete="off" required placeholder="Email">
                                            <div id="disp"></div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                                        <div class="col-sm-10">
                                            <input type="password" name="password" class="form-control" id="inputPassword3" required placeholder="Password">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success">Create My Account</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="alert alert-info" role="alert">
            <p><strong>Daily Expense Manager</strong> is a simple java Application with multi-user level. It designed to help individual or business budget, track and possibly control your expenses. It supports tracking of both your expenses and income. This expense management system provides an integrated set of features to help you to manage your expenses and cash flow. It provides the ability to group your income/expenses into categories and lets you set a budget and track expenses in the category.</p>
            <a href="https://khatabook.com/?utm_source=google&utm_medium=search_ads&utm_campaign=brand-gen_kw&gad_source=1&gclid=CjwKCAiAopuvBhBCEiwAm8jaMcLmSQ-cu5SQmBFAgIpsXwmSifknCsPWthpAhXBpqIgoFzcFX1ZQrRoCUyIQAvD_BwE" class="alert-link">Don't Know how to use!, click here.</a>
        </div>
    </div>
    <script src="js/jquery-1.11.0.min.js"></script>
</body>
</html>
