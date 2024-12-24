<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Appointments</title>
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
        .content {
            margin-left: 240px;
            padding: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .btn-group .btn {
            margin-right: 5px;
            font-size: 9px;
            padding: 5px 10px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">OMFS Admin Dashboard</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto"></ul>
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
            <h2>Manage Appointments</h2>
            <div class="row mb-3">
                <div class="col-md-8">
                    <div class="input-group">
                        <input type="text" id="search" class="form-control" placeholder="Search appointments...">
                        <div class="input-group-append">
                            <button id="searchButton" class="btn btn-primary"><i class="fas fa-search"></i></button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-right">
                    <a href="download-all-appointments.jsp" class="btn btn-info"><i class="fas fa-download"></i> Download All Data</a>
                </div>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient Name</th>
                        <th>Doctor ID</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="appointmentsTable">
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

                            String sql = "SELECT id, patient_name, doctor_id, appointment_date, appointment_time, reason, status FROM appointments";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String patientName = rs.getString("patient_name");
                                int doctorId = rs.getInt("doctor_id");
                                Date appointmentDate = rs.getDate("appointment_date");
                                Time appointmentTime = rs.getTime("appointment_time");
                                String reason = rs.getString("reason");
                                String status = rs.getString("status");

                                out.println("<tr>");
                                out.println("<td>" + id + "</td>");
                                out.println("<td>" + patientName + "</td>");
                                out.println("<td>" + doctorId + "</td>");
                                out.println("<td>" + appointmentDate + "</td>");
                                out.println("<td>" + appointmentTime + "</td>");
                                out.println("<td>" + reason + "</td>");
                                out.println("<td>" + status + "</td>");
                                out.println("<td>");
                                out.println("<div class='btn-group'>");
                                out.println("<a href='confirm-appointment.jsp?id=" + id + "' class='btn btn-primary btn-sm' onclick='return confirm(\"Are you sure you want to confirm this appointment?\");'><i class='fas fa-check'></i> Confirm</a>");
                                out.println("<a href='cancel-appointment.jsp?id=" + id + "' class='btn btn-warning btn-sm' onclick='return confirm(\"Are you sure you want to cancel this appointment?\");'><i class='fas fa-times'></i> Cancel</a>");
                                out.println("<a href='delete-appointment.jsp?id=" + id + "' class='btn btn-danger btn-sm' onclick='return confirm(\"Are you sure you want to delete this appointment?\");'><i class='fas fa-trash'></i> Delete</a>");
                                out.println("<a href='download.jsp?id=" + id + "' class='btn btn-success btn-sm'><i class='fas fa-download'></i> Download</a>");
                                out.println("</div>");
                                out.println("</td>");
                                out.println("</tr>");
                            }

                        } catch (ClassNotFoundException | SQLException e) {
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
</body>
</html>
