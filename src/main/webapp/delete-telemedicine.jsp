<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Telemedicine Session</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Delete Telemedicine Session</h2>
        <%
            String sessionId = request.getParameter("session_id");
            if (sessionId != null) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                    String dbUser = "root";
                    String dbPassword = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String sql = "DELETE FROM telemedicine WHERE session_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(sessionId));

                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<p>Session deleted successfully!</p>");
                    } else {
                        out.println("<p>Error deleting session!</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
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
