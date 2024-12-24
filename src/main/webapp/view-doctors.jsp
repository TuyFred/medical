<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Doctors</title>
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
        .table {
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .table th {
            background-color: #007bff;
            color: white;
        }
        .table td, .table th {
            padding: 15px;
            text-align: center;
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
        <a href="ViewRecords.jsp"><i class="fas fa-file-medical-alt"></i> View Records</a>
        <a href="view-doctors.jsp"><i class="fas fa-user-md"></i> Available Doctors</a>
    </div>

    <div class="main-content">
        <div class="search-bar">
            <form action="view-doctors.jsp" method="get" class="d-flex">
                <input type="text" class="form-control" name="searchQuery" placeholder="Search by Doctor's Name or Specialty">
                <button type="submit" class="btn btn-outline-secondary"><i class="fas fa-search"></i> Search</button>
            </form>
        </div>

        <div class="card">
            <div class="card-header text-center">
                List of Doctors
            </div>
            <div class="card-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Specialty</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;

                            try {
                                String searchQuery = request.getParameter("searchQuery");
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

                                String sql = "SELECT * FROM doctors";
                                if (searchQuery != null && !searchQuery.isEmpty()) {
                                    sql += " WHERE first_name LIKE ? OR last_name LIKE ? OR specialty LIKE ?";
                                    stmt = conn.prepareStatement(sql);
                                    String queryParam = "%" + searchQuery + "%";
                                    stmt.setString(1, queryParam);
                                    stmt.setString(2, queryParam);
                                    stmt.setString(3, queryParam);
                                } else {
                                    stmt = conn.prepareStatement(sql);
                                }

                                rs = stmt.executeQuery();

                                if (!rs.next()) {
                                    out.println("<tr><td colspan='5' class='text-center'>No doctors found.</td></tr>");
                                } else {
                                    do {
                                        int id = rs.getInt("id");
                                        String firstName = rs.getString("first_name");
                                        String lastName = rs.getString("last_name");
                                        String specialty = rs.getString("specialty");
                                        String email = rs.getString("email");
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= firstName %></td>
                            <td><%= lastName %></td>
                            <td><%= specialty %></td>
                            <td><%= email %></td>
                        </tr>
                        <%
                                    } while (rs.next());
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
</body>
</html>
