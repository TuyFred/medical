<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Telemedicine Record</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Create Telemedicine Record</h2>
        <form action="create-telemedicine.jsp" method="post">
            <div class="form-group">
                <label for="user_id">User ID:</label>
                <input type="number" class="form-control" id="user_id" name="user_id" required>
            </div>
            <div class="form-group">
                <label for="doctor_id">Doctor ID:</label>
                <input type="number" class="form-control" id="doctor_id" name="doctor_id" required>
            </div>
            <div class="form-group">
                <label for="record_date">Record Date:</label>
                <input type="date" class="form-control" id="record_date" name="record_date" required>
            </div>
            <div class="form-group">
                <label for="diagnosis">Diagnosis:</label>
                <textarea class="form-control" id="diagnosis" name="diagnosis" required></textarea>
            </div>
            <div class="form-group">
                <label for="treatment">Treatment:</label>
                <textarea class="form-control" id="treatment" name="treatment" required></textarea>
            </div>
            <div class="form-group">
                <label for="notes">Notes:</label>
                <textarea class="form-control" id="notes" name="notes"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Create</button>
        </form>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                String dbUser = "root";
                String dbPassword = "";

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String sql = "INSERT INTO telemedicine (user_id, doctor_id, record_date, diagnosis, treatment, notes) VALUES (?, ?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("user_id")));
                    pstmt.setInt(2, Integer.parseInt(request.getParameter("doctor_id")));
                    pstmt.setDate(3, Date.valueOf(request.getParameter("record_date")));
                    pstmt.setString(4, request.getParameter("diagnosis"));
                    pstmt.setString(5, request.getParameter("treatment"));
                    pstmt.setString(6, request.getParameter("notes"));

                    int row = pstmt.executeUpdate();
                    if (row > 0) {
                        out.println("<div class='alert alert-success mt-3'>Record created successfully!</div>");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            }
        %>
    </div>
</body>
</html>
