<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete User</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <%
            int id = Integer.parseInt(request.getParameter("id"));

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
                String sql = "DELETE FROM users WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                pstmt.executeUpdate();

                out.println("<div class='alert alert-success'>User deleted successfully!</div>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Failed to delete user.</div>");
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
        <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to dashboard</a>
    </div>
</body>
</html>
