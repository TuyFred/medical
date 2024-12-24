<%@ page import="java.sql.*" %>
<%@ page import="com.itextpdf.text.Document" %>
<%@ page import="com.itextpdf.text.DocumentException" %>
<%@ page import="com.itextpdf.text.PageSize" %>
<%@ page import="com.itextpdf.text.pdf.PdfPCell" %>
<%@ page import="com.itextpdf.text.pdf.PdfPTable" %>
<%@ page import="com.itextpdf.text.pdf.PdfWriter" %>
<%@ page language="java" contentType="application/pdf; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Set the content type to PDF and the header for the file download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"appointments.pdf\"");

        // Initialize the PDF document and writer
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

        // Execute the query to retrieve all appointment data
        String sql = "SELECT id, patient_name, doctor_id, appointment_date, appointment_time, reason, status FROM appointments";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        // Create a table and add headers
        PdfPTable table = new PdfPTable(7); // 7 columns
        table.setWidthPercentage(100); // Full-width table
        table.addCell("ID");
        table.addCell("Patient Name");
        table.addCell("Doctor ID");
        table.addCell("Date");
        table.addCell("Time");
        table.addCell("Reason");
        table.addCell("Status");

        // Add rows to the table
        while (rs.next()) {
            table.addCell(String.valueOf(rs.getInt("id")));
            table.addCell(rs.getString("patient_name"));
            table.addCell(String.valueOf(rs.getInt("doctor_id")));
            table.addCell(rs.getDate("appointment_date").toString());
            table.addCell(rs.getTime("appointment_time").toString());
            table.addCell(rs.getString("reason"));
            table.addCell(rs.getString("status"));
        }

        // Add the table to the document
        document.add(table);
        document.close();
    } catch (DocumentException de) {
        // Handle PDF document specific exceptions
        de.printStackTrace();
    } catch (SQLException se) {
        // Handle database errors
        se.printStackTrace();
    } catch (ClassNotFoundException cnfe) {
        // Handle class not found exceptions
        cnfe.printStackTrace();
    } finally {
        // Ensure resources are closed
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
