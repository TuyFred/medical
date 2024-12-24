<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Processing</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .result-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="result-container">
            <h2>Appointment Processing</h2>
            <%
                String message = "";
                String userId = request.getParameter("user_id"); // Get the user_id from the form
                String patientName = request.getParameter("patientName");
                String doctorId = request.getParameter("doctorId"); // Make sure this matches the foreign key column
                String appointmentDate = request.getParameter("appointmentDate");
                String appointmentTime = request.getParameter("appointmentTime");
                String reason = request.getParameter("reason");
                String status = request.getParameter("status");

                if (patientName != null && !patientName.isEmpty() && userId != null && !userId.isEmpty()) {
                    Connection conn = null;
                    PreparedStatement stmt = null;

                    try {
                        // Database connection details
                        String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                        String dbUser = "root";
                        String dbPassword = "";

                        // Load database driver
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                        // SQL query to insert appointment details
                        String sql = "INSERT INTO appointments (user_id, patient_name, doctor_id, appointment_date, appointment_time, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, userId);
                        stmt.setString(2, patientName);
                        stmt.setString(3, doctorId); // This should be the ID that exists in the doctors table
                        stmt.setString(4, appointmentDate);
                        stmt.setString(5, appointmentTime);
                        stmt.setString(6, reason);
                        stmt.setString(7, status);

                        // Execute the query
                        int rowsAffected = stmt.executeUpdate();
                        if (rowsAffected > 0) {
                            message = "Appointment saved successfully!";
                        } else {
                            message = "Failed to save appointment.";
                        }

                    } catch (Exception e) {
                        message = "Error occurred: " + e.getMessage();
                    } finally {
                        // Close resources
                        try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                } else {
                    message = "Patient name and user ID are required.";
                }
            %>
            <p><%= message %></p>
            <a href="patientDashboard.jsp" class="btn btn-primary">Back to Form</a>
        </div>
    </div>
    
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>