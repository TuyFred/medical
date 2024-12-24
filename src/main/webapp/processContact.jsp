<%@ page import="java.sql.*" %>
<% 
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

        String sql = "INSERT INTO contacts (name, email, message) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, message);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            out.println("<p>Thank you for contacting us. We will get back to you shortly.</p>");
        } else {
            out.println("<p>There was an error processing your request. Please try again later.</p>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>There was an error: " + e.getMessage() + "</p>");
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) { }
        try { if (conn != null) conn.close(); } catch (Exception e) { }
    }
%>
<a href="contact.jsp">Back to Contact Page</a>
