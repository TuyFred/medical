<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Telemedicine</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
        }
        .navbar {
            background-color: #007bff;
        }
        .navbar .navbar-brand,
        .navbar .nav-link {
            color: #fff;
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
        .table thead {
            background: #007bff;
            color: #fff;
        }
        .table tbody tr:hover {
            background: #e9ecef;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">OMFS Admin Dashboard</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <!-- Space reserved for logout button if needed -->
            </ul>
        </div>
    </nav>

    <div class="sidebar">
        <a href="admin-dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="manage-users.jsp"><i class="fas fa-users"></i> Manage Users</a>
        <a href="manage-appointment.jsp"><i class="fas fa-calendar-check"></i> Manage Appointments</a>
        <a href="manage-telemedicine.jsp"><i class="fas fa-video"></i> Manage Telemedicine</a>
        <a href="manage-lab-results.jsp"><i class="fas fa-flask"></i> Manage Lab Results</a>
        <a href="manage-medical-records.jsp"><i class="fas fa-notes-medical"></i> Manage Medical Records</a>
        <a href="Settings.jsp"><i class="fas fa-cogs"></i> Settings</a>
        <a href="logout.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="content">
        <div class="container">
            <h2>Manage Telemedicine Sessions</h2>
            <a href="download-telemedicine-pdf" class="btn btn-primary mb-4">Download as PDF</a>
            <table class="table table-bordered mt-4">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient ID</th>
                        <th>Doctor ID</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                        String dbUser = "root";
                        String dbPassword = "";

                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            // Load MySQL JDBC Driver
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            // Establish connection
                            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            // SQL query to fetch telemedicine data
                            String sql = "SELECT * FROM telemedicine";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            // Iterate through the result set
                            while (rs.next()) {
                    %>
                                <tr>
                                    <td><%= rs.getInt("id") %></td>
                                    <td><%= rs.getInt("user_id") %></td>
                                    <td><%= rs.getInt("doctor_id") %></td>
                                    <td><%= rs.getTimestamp("start_time") %></td>
                                    <td><%= rs.getTimestamp("end_time") %></td>
                                    <td><%= rs.getString("status") %></td>
                                    <td>
                                        <a href="view-telemedicine.jsp?id=<%= rs.getInt("id") %>" class="btn btn-info btn-sm">View</a>
                                        <a href="start-telemedicine.jsp?id=<%= rs.getInt("id") %>" class="btn btn-success btn-sm">Start</a>
                                        <a href="end-telemedicine.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm">End</a>
                                    </td>
                                </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            // Clean up resources
                            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
