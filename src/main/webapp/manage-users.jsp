<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
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
        .navbar .nav-link:hover {
            color: #e0e0e0;
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
        table {
            margin-bottom: 20px;
        }
        .btn-edit, .btn-delete {
            font-size: 14px;
        }
    </style>
    <script>
        function searchUsers() {
            let input = document.getElementById("searchInput");
            let filter = input.value.toLowerCase();
            let table = document.getElementById("usersTable");
            let tr = table.getElementsByTagName("tr");

            for (let i = 1; i < tr.length; i++) {
                let td = tr[i].getElementsByTagName("td");
                let match = false;
                for (let j = 0; j < td.length - 2; j++) {
                    if (td[j]) {
                        if (td[j].innerHTML.toLowerCase().indexOf(filter) > -1) {
                            match = true;
                        }
                    }
                }
                if (match) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">OMFS Admin Dashboard</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="settings.jsp"><i class="fas fa-cogs"></i> Settings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
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
        <div class="container">
            <h2>Manage Users</h2>
            <div class="alert alert-info">
                <strong>Total Users:</strong> 
                <% 
                    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                    String dbUser = "root";
                    String dbPassword = "";

                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                        String countSql = "SELECT COUNT(*) FROM users";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(countSql);
                        if (rs.next()) {
                            int userCount = rs.getInt(1);
                            out.println(userCount);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                    }
                %>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <input type="text" id="searchInput" onkeyup="searchUsers()" class="form-control" placeholder="Search users...">
                </div>
                <div class="col-md-6 text-right">
                    <a href="DownloadRecords.jsp" class="btn btn-primary">
                        <i class="fas fa-download"></i> Download PDF
                    </a>
                </div>
            </div>

            <table id="usersTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                            String sql = "SELECT * FROM users";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);
                            int count = 1;
                            while (rs.next()) {
                                String id = rs.getString("id");
                                String firstName = rs.getString("first_name");
                                String lastName = rs.getString("last_name");
                                String email = rs.getString("email");
                                String password = rs.getString("password");
                    %>
                    <tr>
                        <td><%= count++ %></td>
                        <td><%= firstName %></td>
                        <td><%= lastName %></td>
                        <td><%= email %></td>
                        <td><%= password %></td>
                        <td>
                            <a href="edit-user.jsp?id=<%= id %>" class="btn btn-warning btn-sm btn-edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="delete-user.jsp?id=<%= id %>" class="btn btn-danger btn-sm btn-delete" onclick="return confirm('Are you sure you want to delete this user?');">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <tr>
                        <td colspan="6">Error: <%= e.getMessage() %></td>
                    </tr>
                    <% 
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
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
