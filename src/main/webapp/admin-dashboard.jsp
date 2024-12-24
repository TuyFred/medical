<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    // Check if session exists and user is logged in
    HttpSession Session = request.getSession(false);
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
        }
        .navbar {
            background-color: #007bff; /* Blue background color */
        }
        .navbar .navbar-brand,
        .navbar .nav-link {
            color: #fff; /* White text color */
        }
        .navbar .nav-link:hover {
            color: #e0e0e0; /* Slightly lighter text color on hover */
        }
        .sidebar {
            height: 100vh;
            background: #343a40;
            padding-top: 20px;
            position: fixed;
            width: 220px;
        }
        .sidebar a {
            color: #fff;
            padding: 15px;
            display: block;
            text-decoration: none;
            font-size: 16px;
        }
        .sidebar a:hover {
            background: #495057;
        }
        .content {
            margin-left: 240px;
            padding: 20px;
        }
        .card {
            margin-bottom: 20px;
        }
        .card-body i {
            font-size: 24px;
        }
        .card-body h5 {
            margin-top: 10px;
            font-size: 18px;
        }
        .card-body p {
            font-size: 16px;
        }
        .card-body .btn {
            font-size: 16px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">OMFS Admin Dashboard</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <!-- This space is reserved for the Logout button in the sidebar -->
            </ul>
        </div>
    </nav>

    <div class="sidebar">
        <a href="admin-dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="manage-users.jsp"><i class="fas fa-users"></i> Manage Users</a>
        <a href="manage-appointment.jsp"><i class="fas fa-calendar-check"></i> Manage Appointments</a>
        <a href="manage-contacts.jsp"><i class="fas fa-envelope"></i> Manage Contacts</a>
        <a href="list-doctors.jsp"><i class="fas fa-flask"></i> Manage Doctors</a>
        <a href="GenerateReport.jsp"><i class="fas fa-file-alt"></i> Generate Report</a>
        <a href="Settings.jsp"><i class="fas fa-cogs"></i> Settings</a>
        <a href="logout.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="content">
        <div class="container">
            <h2>Welcome, Admin!</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card border-primary">
                        <div class="card-body text-center">
                            <i class="fas fa-user-friends text-primary"></i>
                            <h5 class="card-title mt-3">Total Patients</h5>
                            <p class="card-text">
                                <% 
                                    // Database connection setup
                                    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                                    String dbUser = "root";
                                    String dbPassword = "";

                                    Connection conn = null;
                                    Statement stmt = null;
                                    ResultSet rs = null;

                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                                        String sql = "SELECT COUNT(*) AS total FROM users";
                                        stmt = conn.createStatement();
                                        rs = stmt.executeQuery(sql);
                                        if (rs.next()) {
                                            out.print("<span class='badge badge-primary'>" + rs.getInt("total") + "</span>");
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                                        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                                        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                                    }
                                %>
                            </p>
                            <a href="manage-users.jsp" class="btn btn-primary">View Patients</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-success">
                        <div class="card-body text-center">
                            <i class="fas fa-calendar-day text-success"></i>
                            <h5 class="card-title mt-3">Upcoming Appointments</h5>
                            <p class="card-text">
                                <% 
                                    try {
                                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                                        String sql = "SELECT COUNT(*) AS total FROM appointments WHERE appointment_date >= CURDATE()";
                                        stmt = conn.createStatement();
                                        rs = stmt.executeQuery(sql);
                                        if (rs.next()) {
                                            out.print("<span class='badge badge-success'>" + rs.getInt("total") + "</span>");
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                                        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                                        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                                    }
                                %>
                            </p>
                            <a href="manage-appointment.jsp" class="btn btn-success">View Appointments</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-info">
                        <div class="card-body text-center">
                            <i class="fas fa-video text-info"></i>
                            <h5 class="card-title mt-3">Ongoing Telemedicine</h5>
                            <p class="card-text">
                                <% 
                                    try {
                                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                                        String sql = "SELECT COUNT(*) AS total FROM telemedicine WHERE start_time <= NOW() AND end_time >= NOW()";
                                        stmt = conn.createStatement();
                                        rs = stmt.executeQuery(sql);
                                        if (rs.next()) {
                                            out.print("<span class='badge badge-info'>" + rs.getInt("total") + "</span>");
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                                        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                                        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                                    }
                                %>
                            </p>
                            <a href="manage-telemedicine.jsp" class="btn btn-info">View Sessions</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
