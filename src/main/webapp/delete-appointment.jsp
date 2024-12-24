<%@ page import="java.sql.*" %>
<%
    String appointmentId = request.getParameter("id");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

        String sql = "DELETE FROM appointments WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(appointmentId));

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            out.println("Appointment deleted successfully.");
        } else {
            out.println("No appointment found with ID: " + appointmentId);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<!-- Button to go back to the Dashboard -->
<div style="margin-top: 20px;">
    <a href="admin-dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
</div>
