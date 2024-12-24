<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Retrieve form parameters
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Database connection setup
    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
    String dbUser = "root";
    String dbPassword = "";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        // SQL query to check user credentials
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        
        // Create prepared statement
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        
        // Execute the query
        rs = pstmt.executeQuery();
        
        // Check if user exists
        if (rs.next()) {
            // Get user role
            String role = rs.getString("role");

            // Set session attribute for logged-in user
            HttpSession userSession = request.getSession();
            userSession.setAttribute("email", email);
            userSession.setAttribute("role", role);
            
            // Redirect based on role
            if ("admin".equals(role)) {
                response.sendRedirect("admin-dashboard.jsp");
            } else if ("patient".equals(role)) {
                response.sendRedirect("patientDashboard.jsp");
            } else {
                // Role not recognized
                response.setContentType("text/html");
                out.println("<html><body>");
                out.println("<h2>Login Failed</h2>");
                out.println("<p>Invalid role. <a href='login.jsp'>Try again</a>.</p>");
                out.println("</body></html>");
            }
        } else {
            // Login failed message
            response.setContentType("text/html");
            out.println("<html><body>");
            out.println("<h2>Login Failed</h2>");
            out.println("<p>Invalid email or password. <a href='login.jsp'>Try again</a>.</p>");
            out.println("</body></html>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.setContentType("text/html");
        out.println("<html><body><p>Error: " + e.getMessage() + "</p></body></html>");
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
