<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String user_id = "", doctor_id = "", record_date = "", diagnosis = "", treatment = "", notes = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        if (request.getMethod().equalsIgnoreCase("GET")) {
            String sql = "SELECT * FROM medical_records WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user_id = rs.getString("user_id");
                doctor_id = rs.getString("doctor_id");
                record_date = rs.getString("record_date");
                diagnosis = rs.getString("diagnosis");
                treatment = rs.getString("treatment");
                notes = rs.getString("notes");
            }
        } else if (request.getMethod().equalsIgnoreCase("POST")) {
            String sql = "UPDATE medical_records SET user_id=?, doctor_id=?, record_date=?, diagnosis=?, treatment=?, notes=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(request.getParameter("user_id")));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("doctor_id")));
            pstmt.setDate(3, Date.valueOf(request.getParameter("record_date")));
            pstmt.setString(4, request.getParameter("diagnosis"));
            pstmt.setString(5, request.getParameter("treatment"));
            pstmt.setString(6, request.getParameter("notes"));
            pstmt.setInt(7, Integer.parseInt(id));

            int row = pstmt.executeUpdate();
            if (row > 0) {
                response.sendRedirect("view-telemedicine.jsp");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!-- HTML form for updating the record -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Telemedicine Record</title>
</head>
<body>
    <h2>Update Telemedicine Record</h2>
    <form method="post">
        <label for="user_id">User ID:</label>
        <input type="text" id="user_id" name="user_id" value="<%= user_id %>" required><br><br>

        <label for="doctor_id">Doctor ID:</label>
        <input type="text" id="doctor_id" name="doctor_id" value="<%= doctor_id %>" required><br><br>

        <label for="record_date">Record Date:</label>
        <input type="date" id="record_date" name="record_date" value="<%= record_date %>" required><br><br>

        <label for="diagnosis">Diagnosis:</label>
        <textarea id="diagnosis" name="diagnosis" required><%= diagnosis %></textarea><br><br>

        <label for="treatment">Treatment:</label>
        <textarea id="treatment" name="treatment" required><%= treatment %></textarea><br><br>

        <label for="notes">Notes:</label>
        <textarea id="notes" name="notes"><%= notes %></textarea><br><br>

        <input type="submit" value="Update Record">
    </form>
</body>
</html>
