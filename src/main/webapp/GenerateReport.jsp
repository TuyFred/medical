<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Reports - Admin Dashboard</title>
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
        <a href="GenerateReport.jsp" class="active"><i class="fas fa-file-alt"></i> Generate Report</a>
        <a href="Settings.jsp"><i class="fas fa-cogs"></i> Settings</a>
        <a href="logout.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="content">
        <div class="container">
            <h2>Generate Reports</h2>
            <p>Select a report type and date range to generate the report.</p>

            <!-- Report Type Selection -->
            <div class="card">
                <div class="card-body">
                    <h5>Select Report Type</h5>
                    <form action="generateReport.jsp" method="post">
                        <div class="form-group">
                            <label for="reportType">Report Type:</label>
                            <select class="form-control" id="reportType" name="reportType" required>
                                <option value="activities">Activities for user</option>
                                <option value="infant_care_services">activity for patient</option>
                                <option value="services">Report</option>
                            </select>
                        </div>

                        <!-- Date Range Selection -->
                        <div class="form-group">
                            <label for="startDate">Start Date:</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                        </div>
                        <div class="form-group">
                            <label for="endDate">End Date:</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate Report</button>
                    </form>
                </div>
            </div>

            <!-- Report Display -->
            <div class="card">
                <div class="card-body">
                    <h5>Generated Report</h5>
                    <!-- Report Table -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Date</th>
                                <th>Activity</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Example Row -->
                            <tr>
                                <td>1</td>
                                <td>2023-08-15</td>
                                <td>patient</td>
                                <td>my information.</td>
                            </tr>
                            <!-- More Rows can be dynamically generated here -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
