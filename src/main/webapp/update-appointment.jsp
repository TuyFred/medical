<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String action = request.getParameter("action");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", ""); // Update username and password

        String sql = "";
        if ("approve".equals(action)) {
            sql = "UPDATE appointments SET status = 'approved' WHERE id = ?";
        } else if ("cancel".equals(action)) {
            sql = "UPDATE appointments SET status = 'canceled' WHERE id = ?";
        }

        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(id));
        int rows = stmt.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            out.println("<p>Failed to update appointment.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>
