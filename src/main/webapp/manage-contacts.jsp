<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Contacts</title>
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
        .table {
            background: #fff;
            border-radius: 5px;
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
        <a href="list-doctors.jsp"><i class="fas fa-flask"></i> Manage doctors</a>
        <a href="GenerateReport.jsp"><i class="fas fa-file-alt"></i> Generate Report</a>
        <a href="Settings.jsp"><i class="fas fa-cogs"></i> Settings</a>
        <a href="logout.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="content">
        <div class="container mt-4">
            <h2>Contact Messages</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Message</th>
                        <th>Date Submitted</th>
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
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                            String sql = "SELECT * FROM contacts ORDER BY id DESC";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("message") %></td>
                            <td><%= rs.getTimestamp("created_at") %></td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
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
