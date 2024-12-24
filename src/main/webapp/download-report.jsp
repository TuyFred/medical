<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%@ page language="java" contentType="application/pdf; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

        String sql = "SELECT * FROM appointments WHERE id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        rs = stmt.executeQuery();

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=appointment_report_" + id + ".pdf");

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document();
        PdfWriter.getInstance(document, baos);
        document.open();

        document.add(new Paragraph("Appointment Report\n", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16)));

        if (rs.next()) {
            document.add(new Paragraph("ID: " + id));
            document.add(new Paragraph("Patient Name: " + rs.getString("patient_name")));
            document.add(new Paragraph("Doctor: " + rs.getString("doctor")));
            document.add(new Paragraph("Date: " + rs.getDate("appointment_date")));
            document.add(new Paragraph("Time: " + rs.getTime("appointment_time")));
            document.add(new Paragraph("Reason: " + rs.getString("reason")));
            document.add(new Paragraph("Status: " + rs.getString("status")));
        } else {
            document.add(new Paragraph("No data available for the provided ID."));
        }

        document.close();
        baos.writeTo(response.getOutputStream());

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manage-appointment.jsp?error=" + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>


