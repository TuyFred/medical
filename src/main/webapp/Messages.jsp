<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages</title>
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
        <h1>Your Messages</h1>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String patientName = (String) session.getAttribute("patientName");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "username", "password");

                String sql = "SELECT * FROM messages WHERE patient_name = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, patientName);
                rs = stmt.executeQuery();

                if (!rs.next()) {
                    out.println("<p>No messages found.</p>");
                } else {
                    out.println("<table class='table'>");
                    out.println("<thead><tr><th>Date</th><th>Message</th></tr></thead>");
                    out.println("<tbody>");
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("message_date") + "</td>");
                        out.println("<td>" + rs.getString("message_content") + "</td>");
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
