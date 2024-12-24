<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Admin Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
            margin: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .message {
            margin-bottom: 20px;
            font-size: 1.2rem;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            font-size: 1rem;
            color: #ffffff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            String adminEmail = request.getParameter("adminEmail");
            String newPassword = request.getParameter("newPassword");

            String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
            String dbUser = "root";
            String dbPassword = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                String sql = "UPDATE users SET password = ? WHERE email = ? AND role = 'admin'";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, newPassword);
                statement.setString(2, adminEmail);

                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    out.println("<p class='message'>Password changed successfully!</p>");
                } else {
                    out.println("<p class='message'>Admin user not found or email is incorrect.</p>");
                }

                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='message'>An error occurred while changing the password.</p>");
            }
        %>
        <a href="admin-dashboard.jsp" class="btn">Go Back to Dashboard</a>
    </div>
</body>
</html>
