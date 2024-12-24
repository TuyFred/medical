<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Appointments</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .main-content {
            margin: 20px;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <h1>Search Appointments</h1>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String searchQuery = request.getParameter("searchQuery");
            String patientName = (String) session.getAttribute("patientName");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "username", "password");

                String sql = "SELECT * FROM appointments WHERE patient_name = ? AND (appointment_date LIKE ? OR doctor LIKE ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, patientName);
                stmt.setString(2, "%" + searchQuery + "%");
                stmt.setString(3, "%" + searchQuery + "%");
                rs = stmt.executeQuery();

                if (!rs.next()) {
                    out.println("<p>No appointments found.</p>");
                } else {
                    out.println("<table class='table'>");
                    out.println("<thead><tr><th>Date</th><th>Time</th><th>Doctor</th><th>Reason</th></tr></thead>");
                    out.println("<tbody>");
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("appointment_date") + "</td>");
                        out.println("<td>" + rs.getString("appointment_time") + "</td>");
                        out.println("<td>" + rs.getString("doctor") + "</td>");
                        out.println("<td>" + rs.getString("reason") + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</tbody></table>");
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
</body>
</html>
