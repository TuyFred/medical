<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Telemedicine Session</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Telemedicine Session Details</h2>
        <%
            String sessionId = request.getParameter("session_id");
            if (sessionId != null) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                    String dbUser = "root";
                    String dbPassword = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String sql = "SELECT t.session_id, d.name AS doctor_name, p.name AS patient_name, t.start_time, t.end_time, t.notes " +
                                 "FROM telemedicine t " +
                                 "JOIN doctors d ON t.doctor_id = d.doctor_id " +
                                 "JOIN patients p ON t.patient_id = p.patient_id " +
                                 "WHERE t.session_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(sessionId));
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
        %>
                        <table class="table table-bordered mt-4">
                            <tr><th>Session ID</th><td><%= rs.getInt("session_id") %></td></tr>
                            <tr><th>Doctor Name</th><td><%= rs.getString("doctor_name") %></td></tr>
                            <tr><th>Patient Name</th><td><%= rs.getString("patient_name") %></td></tr>
                            <tr><th>Start Time</th><td><%= rs.getTimestamp("start_time") %></td></tr>
                            <tr><th>End Time</th><td><%= rs.getTimestamp("end_time") %></td></tr>
                            <tr><th>Notes</th><td><%= rs.getString("notes") %></td></tr>
                        </table>
        <%
                    } else {
                        out.println("<p>Session not found!</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            } else {
                out.println("<p>Invalid session ID!</p>");
            }
        %>
        <a href="manage-telemedicine.jsp" class="btn btn-primary mt-4">Back to Manage Telemedicine</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
