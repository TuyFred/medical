<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Process Appointment</title>
</head>
<body>
    <%
        String userId = request.getParameter("userId");
        String patientName = request.getParameter("patientName");
        String doctor = request.getParameter("doctor");
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");
        String reason = request.getParameter("reason");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

            String sql = "INSERT INTO appointments (user_id, patient_name, doctor, appointment_date, appointment_time, reason) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(userId));
            stmt.setString(2, patientName);
            stmt.setString(3, doctor);
            stmt.setDate(4, Date.valueOf(appointmentDate));
            stmt.setTime(5, Time.valueOf(appointmentTime + ":00"));
            stmt.setString(6, reason);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("createappointment.jsp?error=Unable to create appointment");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("createappointment.jsp?error=" + e.getMessage());
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    %>
</body>
</html>
