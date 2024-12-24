<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("email");
    if (username == null) {
%>
    <script>
        alert('You must be logged in to access this page!');
        window.location.href = 'login.jsp';
    </script>
<%
    } else {
        String userId = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
            pstmt = conn.prepareStatement("SELECT id FROM users WHERE email = ?");
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                userId = rs.getString("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException ignored) {}
            }
            if (pstmt != null) {
                try { pstmt.close(); } catch (SQLException ignored) {}
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException ignored) {}
            }
        }
%>
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
        .table th, .table td {
            vertical-align: middle;
        }
        .btn-group .btn {
            margin-right: 5px;
            font-size: 9px;
            padding: 5px 10px;
        }
        .btn-group {
            display: flex;
            align-items: center;
            justify-content: flex-start;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="patientDashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="createappointment.jsp"><i class="fas fa-calendar-alt"></i> Create Appointment</a>
        <a href="ViewRecords.jsp"><i class="fas fa-file-medical-alt"></i> View result</a>
        <a href="view-doctors.jsp"><i class="fas fa-user-md"></i>available Doctors</a>
        
        
    </div>

    <!-- Content -->
    <div class="content">
        <div class="container">
            <h2>MY Appointments</h2>
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
                    <button id="download-all-appointments" class="btn btn-info"><i class="fas fa-download"></i> Download All Data</button>
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
                    </tr>
                </thead>
                <tbody id="appointmentsTable">
                    <%
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
                            pstmt = conn.prepareStatement("SELECT id, patient_name, doctor_id, appointment_date, appointment_time, reason, status FROM appointments WHERE user_id = ?");
                            pstmt.setString(1, userId);
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
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) {
                                try { rs.close(); } catch (SQLException ignored) {}
                            }
                            if (pstmt != null) {
                                try { pstmt.close(); } catch (SQLException ignored) {}
                            }
                            if (conn != null) {
                                try { conn.close(); } catch (SQLException ignored) {}
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#searchButton").on("click", function() {
                var value = $("#search").val().toLowerCase();
                $("#appointmentsTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $("#download-all-appointments").on("click", function() {
                window.location.href = 'download-all-appointments.jsp';
            });
        });
    </script>
</body>
</html>
<%
    }
%>
