<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Telemedicine Session</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Edit Telemedicine Session</h2>
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

                    String sql = "SELECT * FROM telemedicine WHERE session_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(sessionId));
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
        %>
                        <form action="edit-telemedicine.jsp" method="post">
                            <input type="hidden" name="session_id" value="<%= rs.getInt("session_id") %>">
                            <div class="form-group">
                                <label for="doctor_id">Doctor ID:</label>
                                <input type="text" class="form-control" id="doctor_id" name="doctor_id" value="<%= rs.getInt("doctor_id") %>" required>
                            </div>
                            <div class="form-group">
                                <label for="patient_id">Patient ID:</label>
                                <input type="text" class="form-control" id="patient_id" name="patient_id" value="<%= rs.getInt("patient_id") %>" required>
                            </div>
                            <div class="form-group">
                                <label for="start_time">Start Time:</label>
                                <input type="datetime-local" class="form-control" id="start_time" name="start_time" value="<%= rs.getTimestamp("start_time").toLocalDateTime().toString().replace("T", " ") %>" required>
                            </div>
                            <div class="form-group">
                                <label for="end_time">End Time:</label>
                                <input type="datetime-local" class="form-control" id="end_time" name="end_time" value="<%= rs.getTimestamp("end_time").toLocalDateTime().toString().replace("T", " ") %>" required>
                            </div>
                            <div class="form-group">
                                <label for="notes">Notes:</label>
                                <textarea class="form-control" id="notes" name="notes" rows="3" required><%= rs.getString("notes") %></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Update Session</button>
                        </form>
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
    </div>

    <%
        // Handle form submission to update the telemedicine session
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String doctorId = request.getParameter("doctor_id");
            String patientId = request.getParameter("patient_id");
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");
            String notes = request.getParameter("notes");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                String dbUser = "root";
                String dbPassword = "";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                String sql = "UPDATE telemedicine SET doctor_id = ?, patient_id = ?, start_time = ?, end_time = ?, notes = ? WHERE session_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(doctorId));
                pstmt.setInt(2, Integer.parseInt(patientId));
                pstmt.setTimestamp(3, Timestamp.valueOf(startTime));
                pstmt.setTimestamp(4, Timestamp.valueOf(endTime));
                pstmt.setString(5, notes);
                pstmt.setInt(6, Integer.parseInt(sessionId));

                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    out.println("<p>Session updated successfully!</p>");
                } else {
                    out.println("<p>Error updating session!</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        }
    %>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
