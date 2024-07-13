<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="images/favicon.png" sizes="80x80">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="style2.css">
    <title>Time Tracker - Employee Dashboard</title>
</head>
<body>
    <header class="header">
        <div class="header__container">
            <a href="./employee_dashboard.php" class="header__logo logo">Time Tracker</a>
            <h3 class="page__name text__color">Welcome, <%= session.getAttribute("username") %></h3>
            <div class="header__search">
                <input type="search" onfocus="clearPageRefreshInterval()" onchange="setPageRefreshIntervalIfSearchBarIsEmpty(event)" placeholder="Search" class="header__input">
                <i class="fas fa-search header__icon"></i>
            </div>
            <div class="header__toggle">
                <i class="fas fa-bars nav__icon" id="header-toggle"></i>
            </div>
        </div>
    </header>
    <div class="nav" id="navbar">
        <nav class="nav__container">
            <div class="">
                <a href="./employee_dashboard.php" class="nav__link nav__logo">
                    <i class="fas fa-university fa-2x text__color"></i>
                    <span class="nav__logo-name text__color">Time Tracker</span>
                </a>
                <div class="nav__list">
                    <div class="nav__items">
                        <a href="./employee_dashboard.php" class="nav__link">
                            <i class="fas fa-tachometer-alt nav__icon"></i>
                            <span class="nav__name">Dashboard</span>
                        </a>
                        <a href="add.jsp" class="nav__link">
                            <i class="fas fa-tasks nav__icon"></i>
                            <span class="nav__name">Tasks</span>
                        </a>
                        <a href="fetch.jsp" class="nav__link">
                            <i class="fas fa-clipboard nav__icon"></i>
                            <span class="nav__name">Timesheets</span>
                        </a>
                        <a href="./leave_requests.php" class="nav__link">
                            <i class="far fa-calendar-alt nav__icon"></i>
                            <span class="nav__name">Leave Requests</span>
                        </a>
                        <a href="./chat.php" class="nav__link">
                            <i class="fas fa-comments nav__icon"></i>
                            <span class="nav__name">Chat</span>
                        </a>
                        <a href="./payments.php" class="nav__link">
                            <i class="fas fa-money-check-alt nav__icon"></i>
                            <span class="nav__name">Payments</span>
                        </a>
                        <a href="logout.jsp" class="nav__link">
                            <i class="fas fa-sign-out-alt nav__icon"></i>
                            <span class="nav__name">Logout</span>
                        </a>
                    </div>
                </div>
            </div>
        </nav>
    </div>
    <div class="containerok">
    <div class="small-container">
        
    </div>
</div>

    <script src="./javascript/main.js"></script>
    <script src="./javascript/notices.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
