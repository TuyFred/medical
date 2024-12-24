<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Doctor</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Edit Doctor</h2>
        <%
            String id = request.getParameter("id");
            String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
            String dbUser = "root";
            String dbPassword = "";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String firstName = "", lastName = "", specialty = "", email = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                String sql = "SELECT * FROM doctors WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(id));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    firstName = rs.getString("first_name");
                    lastName = rs.getString("last_name");
                    specialty = rs.getString("specialty");
                    email = rs.getString("email");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
        <form action="edit-doctor-action.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <div class="form-group">
                <label for="first_name">First Name</label>
                <input type="text" class="form-control" id="first_name" name="first_name" value="<%= firstName %>" required>
            </div>
            <div class="form-group">
                <label for="last_name">Last Name</label>
                <input type="text" class="form-control" id="last_name" name="last_name" value="<%= lastName %>" required>
            </div>
            <div class="form-group">
                <label for="specialty">Specialty</label>
                <input type="text" class="form-control" id="specialty" name="specialty" value="<%= specialty %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Doctor</button>
        </form>
    </div>
</body>
</html>
