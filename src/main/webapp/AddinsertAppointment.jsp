<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Appointment</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-5">Insert Appointment</h2>
        <% 
            String statusMessage = "";
            if (request.getMethod().equalsIgnoreCase("post")) {
                String user_id = request.getParameter("user_id");
                String patient_name = request.getParameter("patient_name");
                String doctor_id = request.getParameter("doctor_id");
                String doctor_name = request.getParameter("doctor");
                String appointment_date = request.getParameter("appointment_date");
                String appointment_time = request.getParameter("appointment_time");
                String reason = request.getParameter("reason");
                String status = request.getParameter("status");

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    // Print parameters for debugging
                    out.println("Debugging Parameters:");
                    out.println("user_id: " + user_id);
                    out.println("patient_name: " + patient_name);
                    out.println("doctor_id: " + doctor_id);
                    out.println("doctor_name: " + doctor_name);
                    out.println("appointment_date: " + appointment_date);
                    out.println("appointment_time: " + appointment_time);
                    out.println("reason: " + reason);
                    out.println("status: " + status);

                    // Load the JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Connect to the database
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal","root","");

                    // Prepare SQL statement
                    String sql = "INSERT INTO appointments (user_id, patient_name, doctor_id, doctor, appointment_date, appointment_time, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(user_id));
                    pstmt.setString(2, patient_name);
                    pstmt.setInt(3, Integer.parseInt(doctor_id));
                    pstmt.setString(4, doctor_name);
                    pstmt.setDate(5, java.sql.Date.valueOf(appointment_date));
                    pstmt.setTime(6, java.sql.Time.valueOf(appointment_time));
                    pstmt.setString(7, reason);
                    pstmt.setString(8, status);

                    // Execute the update
                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        statusMessage = "Appointment successfully added!";
                    } else {
                        statusMessage = "Error adding appointment.";
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    statusMessage = "Error: JDBC Driver not found.";
                } catch (SQLException e) {
                    e.printStackTrace();
                    statusMessage = "SQL Error: " + e.getMessage();
                } catch (Exception e) {
                    e.printStackTrace();
                    statusMessage = "Error: " + e.getMessage();
                } finally {
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
        <% if (!statusMessage.isEmpty()) { %>
            <div class="alert alert-info"><%= statusMessage %></div>
        <% } %>
        <form action="AddinsertAppointment.jsp" method="post" class="mt-3">
            <div class="form-group">
                <label for="user_id">User</label>
                <select class="form-control" id="user_id" name="user_id" required>
                    <option value="" disabled selected>Select User</option>
                    <% 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal","root","");
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT id, first_name FROM users");
                            while (rs.next()) {
                    %>
                                <option value="<%= rs.getInt("id") %>"><%= rs.getString("first_name") %></option>
                    <% 
                            }
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="patient_name">Patient Name</label>
                <input type="text" class="form-control" id="patient_name" name="patient_name" required>
            </div>
            <div class="form-group">
                <label for="doctor_id">Doctor</label>
                <select class="form-control" id="doctor_id" name="doctor_id" required>
                    <option value="" disabled selected>Select Doctor</option>
                    <% 
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT id, first_name FROM doctors");
                            while (rs.next()) {
                    %>
                                <option value="<%= rs.getInt("id") %>"><%= rs.getString("first_name") %></option>
                    <% 
                            }
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="doctor">Doctor Name</label>
                <input type="text" class="form-control" id="doctor" name="doctor" required>
            </div>
            <div class="form-group">
                <label for="appointment_date">Appointment Date</label>
                <input type="date" class="form-control" id="appointment_date" name="appointment_date" required>
            </div>
            <div class="form-group">
                <label for="appointment_time">Appointment Time</label>
                <input type="time" class="form-control" id="appointment_time" name="appointment_time" required>
            </div>
            <div class="form-group">
                <label for="reason">Reason</label>
                <textarea class="form-control" id="reason" name="reason" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select class="form-control" id="status" name="status" required>
                    <option value="Pending">Pending</option>
                    <option value="Approved">Approved</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Appointment</button>
        </form>
    </div>
</body>
</html>
