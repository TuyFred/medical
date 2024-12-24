<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Appointment</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 500px; /* Reduced form width */
            margin: 50px auto;
            padding: 15px; /* Reduced padding */
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px; /* Optional: Add some rounding to the form */
        }
        .form-group i {
            margin-right: 8px;
        }
        .form-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2 class="text-center"><i class="fas fa-calendar-alt"></i> Manage Appointment</h2>
            <form action="appointment-process.jsp" method="post">
                
                <div class="form-group">
                    <label for="user"><i class="fas fa-user"></i> User</label>
                    <select class="form-control" id="user" name="user_id" required>
                        <option value="">Select a User</option>
                        <%
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;

                            try {
                                String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                                String dbUser = "root";
                                String dbPassword = "";

                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                                String sql = "SELECT id, first_name FROM users";
                                stmt = conn.prepareStatement(sql);
                                rs = stmt.executeQuery();

                                while (rs.next()) {
                                    String userId = rs.getString("id");
                                    String username = rs.getString("first_name");
                        %>
                                    <option value="<%= userId %>"><%= username %></option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                                try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="patientName"><i class="fas fa-user"></i> Patient Name</label>
                    <input type="text" class="form-control" id="patientName" name="patientName" placeholder="Enter Patient Name" required>
                </div>

                <div class="form-group">
                    <label for="doctor"><i class="fas fa-user-md"></i> Doctor</label>
                    <select class="form-control" id="doctor" name="doctorId" required>
                        <option value="">Select a Doctor</option>
                        <%
                            try {
                                String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
                                String dbUser = "root";
                                String dbPassword = "";

                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                                String sql = "SELECT id, first_name FROM doctors";
                                stmt = conn.prepareStatement(sql);
                                rs = stmt.executeQuery();

                                while (rs.next()) {
                                    String doctorId = rs.getString("id");
                                    String doctorName = rs.getString("first_name");
                        %>
                                    <option value="<%= doctorId %>"><%= doctorName %></option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                                try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="appointmentDate"><i class="fas fa-calendar-day"></i> Appointment Date</label>
                    <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" required>
                </div>
                <div class="form-group">
                    <label for="appointmentTime"><i class="fas fa-clock"></i> Appointment Time</label>
                    <input type="time" class="form-control" id="appointmentTime" name="appointmentTime" required>
                </div>
                <div class="form-group">
                    <label for="reason"><i class="fas fa-notes-medical"></i> Reason</label>
                    <input type="text" class="form-control" id="reason" name="reason" placeholder="Enter Reason" required>
                </div>
                <div class="form-group">
                    <input type="hidden" id="status" name="status" value="Pending">
                </div>
                
                <div class="form-footer">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Appointment</button>
                    <a href="patientDashboard.jsp" class="btn btn-warning"><i class="fas fa-arrow-left"></i> Go Back</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
