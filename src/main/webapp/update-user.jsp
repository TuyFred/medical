<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update User</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email");
            String role = request.getParameter("role");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
                String sql = "UPDATE users SET first_name = ?, last_name = ?, email = ?, role = ? WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, firstName);
                pstmt.setString(2, lastName);
                pstmt.setString(3, email);
                pstmt.setString(4, role);
                pstmt.setInt(5, id);
                pstmt.executeUpdate();

                out.println("<div class='alert alert-success'>User updated successfully!</div>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Failed to update user.</div>");
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
        <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</body>
</html>
