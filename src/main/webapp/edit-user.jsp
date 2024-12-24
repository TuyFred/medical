<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group i {
            margin-right: 10px;
        }
        h1 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1 class="text-center"><i class="fas fa-user-edit"></i> Edit User</h1>
            <%
                int id = Integer.parseInt(request.getParameter("id"));
                String firstName = "";
                String lastName = "";
                String email = "";
                String role = "";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
                    String sql = "SELECT * FROM users WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, id);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        firstName = rs.getString("first_name");
                        lastName = rs.getString("last_name");
                        email = rs.getString("email");
                        role = rs.getString("role");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Failed to retrieve user.</div>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            %>
            <form action="update-user.jsp" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="form-group">
                    <label for="first_name"><i class="fas fa-user"></i> First Name:</label>
                    <input type="text" class="form-control" id="first_name" name="first_name" value="<%= firstName %>" required>
                </div>
                <div class="form-group">
                    <label for="last_name"><i class="fas fa-user"></i> Last Name:</label>
                    <input type="text" class="form-control" id="last_name" name="last_name" value="<%= lastName %>" required>
                </div>
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
                </div>
                <div class="form-group">
                    <label for="role"><i class="fas fa-user-tag"></i> Role:</label>
                    <select class="form-control" id="role" name="role" required>
                        <option value="patient" <%= role.equals("patient") ? "selected" : "" %>>Patient</option>
                        <option value="admin" <%= role.equals("admin") ? "selected" : "" %>>Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-block"><i class="fas fa-save"></i> Update</button>
            </form>
            <a href="index.html" class="btn btn-secondary btn-block mt-2"><i class="fas fa-arrow-left"></i> Back to Home</a>
        </div>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
