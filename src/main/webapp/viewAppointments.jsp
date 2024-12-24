<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Appointments</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h2>View Appointments</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Appointment ID</th>
                <th>Patient Name</th>
                <th>Doctor Name</th>
                <th>Appointment Date</th>
                <th>Appointment Time</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    // Load MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    // Establish connection to the database
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
                    
                    // Create statement object
                    stmt = conn.createStatement();
                    // Execute SQL query to retrieve appointment data
                    String sql = "SELECT a.appointment_id, p.name AS patient_name, " +
                                 "CONCAT(d.first_name, ' ', d.last_name) AS doctor_name, " +
                                 "a.appointment_date, a.appointment_time " +
                                 "FROM appointments a " +
                                 "JOIN patients p ON a.patient_id = p.id " +
                                 "JOIN doctors d ON a.doctor_id = d.id";
                    rs = stmt.executeQuery(sql);

                    // Iterate over the result set to display the data in the table
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("appointment_id") %></td>
                <td><%= rs.getString("patient_name") %></td>
                <td><%= rs.getString("doctor_name") %></td>
                <td><%= rs.getDate("appointment_date") %></td>
                <td><%= rs.getTime("appointment_time") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close all database resources
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>
</body>
</html>
