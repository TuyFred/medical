<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession Session = request.getSession(false); // Use lowercase for session variable
    if (Session == null || Session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve user information from the session
    String userEmail = (String) Session.getAttribute("email");
    String userName = null;

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", ""); // Update with correct credentials

        String sql = "SELECT first_name, last_name FROM users WHERE email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, userEmail);
        rs = stmt.executeQuery();

        if (rs.next()) {
            userName = rs.getString("first_name") + " " + rs.getString("last_name");
            session.setAttribute("patientName", userName); // Store patient name in session
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #007bff;
        }
        .navbar-brand {
            color: white;
            margin: 0 auto;
        }
        .sidebar {
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #343a40;
            padding-top: 20px;
            width: 200px;
        }
        .sidebar a {
            color: white;
            display: block;
            padding: 10px;
            text-decoration: none;
            margin: 10px 0;
        }
        .sidebar a:hover {
            background-color: #007bff;
        }
        .main-content {
            margin-left: 220px;
            padding: 20px;
        }
        .card {
            margin: 20px 0;
        }
        .search-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container d-flex justify-content-center">
            <a class="navbar-brand" href="#">Online Medical Facility</a>
            <form action="logout.jsp" method="post" class="form-inline ml-auto">
                <button class="btn btn-danger my-2 my-sm-0" type="submit"><i class="fas fa-sign-out-alt"></i> Logout</button>
            </form>
        </div>
    </nav>

    <div class="sidebar">
        <a href="patientDashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="createappointment.jsp"><i class="fas fa-calendar-alt"></i> Create Appointment</a>
        <a href="ViewRecords.jsp"><i class="fas fa-file-medical-alt"></i> View result</a>
        <a href="view-doctors.jsp"><i class="fas fa-user-md"></i>available Doctors</a>
        
        
    </div>

    <div class="main-content">
        <div class="search-bar">
            <form action="SearchAppointments.jsp" method="get" class="d-flex">
                <input type="text" class="form-control" name="searchQuery" placeholder="Search appointments">
                <button type="submit" class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
            </form>
            <a href="DownloadRecords.jsp" class="btn btn-outline-secondary"><i class="fas fa-download"></i> Download</a>
        </div>

        <h1 class="text-center">Welcome, <%= userName != null ? userName : "Patient" %></h1> 

        <div class="card">
            <div class="card-header text-center">
                Your Appointments 
            </div>
            <div class="card-body">
                <%
                    try {
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", ""); // Update with correct credentials

                        String sql = "SELECT * FROM appointments WHERE patient_email = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, userEmail);
                        rs = stmt.executeQuery();

                        if (!rs.next()) {
                            out.println("<p class='text-center'>No appointments scheduled yet.</p>");
                        } else {
                            out.println("<table class='table table-bordered'>");
                            out.println("<thead class='thead-dark'><tr><th>Date</th><th>Time</th><th>Doctor</th><th>Reason</th></tr></thead>");
                            out.println("<tbody>");
                            do {
                                out.println("<tr>");
                                out.println("<td>" + rs.getString("appointment_date") + "</td>");
                                out.println("<td>" + rs.getString("appointment_time") + "</td>");
                                out.println("<td>" + rs.getString("doctor") + "</td>");
                                out.println("<td>" + rs.getString("reason") + "</td>");
                                out.println("</tr>");
                            } while (rs.next());
                            out.println("</tbody>");
                            out.println("</table>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>
