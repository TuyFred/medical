<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String specialty = request.getParameter("specialty");
    String email = request.getParameter("email");

    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        String sql = "UPDATE doctors SET first_name=?, last_name=?, specialty=?, email=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, specialty);
        pstmt.setString(4, email);
        pstmt.setInt(5, Integer.parseInt(id));

        int row = pstmt.executeUpdate();
        if (row > 0) {
            response.sendRedirect("list-doctors.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
