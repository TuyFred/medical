<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Appointments</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .navbar {
            background-color: #007bff;
            display: flex;
            justify-content: center;
        }

        .navbar .navbar-brand {
            color: white;
        }

        .main-content {
            margin: 20px;
        }

        .card {
            margin: 20px 0;
        }

        .form-control {
            max-width: 500px;
            margin: auto;
            font-size: 0.875rem; /* Reduced font size */
        }

        .form-group label {
            font-size: 0.875rem; /* Reduced font size */
        }

        .table {
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="#">Online Medical Facility</a>
    </nav>

    <div class="main-content">
        <h1>Your Appointments</h1>
        
        <div class="card">
            <div class="card-header">
                Appointment List
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Doctor</th>
                            <th>Reason</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;
                            String patientName = (String) session.getAttribute("patientName");
                            
                            try {
                                // Load the MySQL JDBC driver
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                // Establish the database connection
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/", "username", "");

                                // Prepare and execute the SQL query
                                String sql = "SELECT * FROM appointments WHERE patient_name = ?";
                                stmt = conn.prepareStatement(sql);
                                stmt.setString(1, patientName);
                                rs = stmt.executeQuery();
                                
                                // Iterate through the result set
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("appointment_date") %></td>
                            <td><%= rs.getString("appointment_time") %></td>
                            <td><%= rs.getString("doctor") %></td>
                            <td><%= rs.getString("reason") %></td>
                        </tr>
                        <% 
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
