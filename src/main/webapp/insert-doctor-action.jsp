<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Doctor Action</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center; /* Center the text and elements on the page */
            background-color: #f8f9fa;
            margin-top: 50px;
        }
        h3 {
            color: #28a745;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String specialty = request.getParameter("specialty");
        String email = request.getParameter("email");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

            String sql = "INSERT INTO doctors (first_name, last_name, specialty, email) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, specialty);
            pstmt.setString(4, email);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                out.println("<h3>Doctor information inserted successfully!</h3>");
            } else {
                out.println("<h3>Failed to insert doctor information!</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    <a href="doctor-team.jsp">Back to Doctor Team</a>
</body>
</html>
