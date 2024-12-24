<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Processing Appointment</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4"><i class="fas fa-calendar-check"></i> Processing Appointment</h2>
        <%
        String message = "";
        String userId = request.getParameter("user_id");
        String patientName = request.getParameter("patient_name");
        String doctorId = request.getParameter("doctor_id");
        String doctor = request.getParameter("doctor");
        String appointmentDate = request.getParameter("appointment_date");
        String appointmentTime = request.getParameter("appointment_time");
        String reason = request.getParameter("reason");

        if (userId != null && patientName != null && doctorId != null && doctor != null &&
            appointmentDate != null && appointmentTime != null && reason != null) {

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/", "username", "");

                String sql = "INSERT INTO appointments (user_id, patient_name, doctor_id, doctor, appointment_date, appointment_time, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(userId));
                stmt.setString(2, patientName);
                stmt.setInt(3, Integer.parseInt(doctorId));
                stmt.setString(4, doctor);
                stmt.setDate(5, Date.valueOf(appointmentDate));
                stmt.setTime(6, Time.valueOf(appointmentTime));
                stmt.setString(7, reason);

                int result = stmt.executeUpdate();
                if (result > 0) {
                    message = "<div class='alert alert-success'>Appointment added successfully!</div>";
                } else {
                    message = "<div class='alert alert-danger'>Failed to add appointment.</div>";
                }
            } catch (Exception e) {
                message = "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>";
            } finally {
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        } else {
            message = "<div class='alert alert-danger'>All fields are required.</div>";
        }
        %>
        <div class="text-center">
            <%= message %>
            <br>
            <a href="appointment.jsp" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Go Back</a>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
