<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Retrieve form parameters
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Database connection setup
    String dbURL = "jdbc:mysql://localhost:3306/patient_portal"; // Updated database name
    String dbUser = "root"; // Update with actual DB username
    String dbPassword = ""; // Update with actual DB password
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        // SQL query to insert data
        String sql = "INSERT INTO users (first_name, last_name, email, password, role) VALUES (?, ?, ?, ?, 'patient')";
        
        // Create prepared statement
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, email);
        pstmt.setString(4, password); // In a real application, hash the password
        
        // Execute the query
        int rowsInserted = pstmt.executeUpdate();
        
        // Check if the insertion was successful
        if (rowsInserted > 0) {
            // Successful registration message
            response.sendRedirect("login.jsp");
        } else {
            // Handle insertion failure
            out.println("<html><body><p>Registration failed. Please try again.</p></body></html>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<html><body><p>Error: " + e.getMessage() + "</p></body></html>");
    } finally {
        // Close resources
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
