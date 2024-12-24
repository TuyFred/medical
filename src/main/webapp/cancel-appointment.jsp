<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cancel Appointment</title>
</head>
<body>
    <%
        int id = Integer.parseInt(request.getParameter("id"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

            String sql = "UPDATE appointments SET status='Cancelled' WHERE id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("manage-appointment.jsp");
            } else {
                response.sendRedirect("manage-appointment.jsp?error=Unable to cancel appointment");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-appointment.jsp?error=" + e.getMessage());
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    %>
</body>
</html>
