<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="application/pdf" %>

<%
    // Retrieve the appointment ID from the request
    String appointmentId = request.getParameter("id");

    // Set up the PDF response
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=appointment_" + appointmentId + ".pdf");

    // Initialize variables for database connection
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Initialize PDF document
    Document document = new Document();

    try {
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Add document title
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
        Paragraph title = new Paragraph("Appointment Details", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" ")); // Add a blank line

        // Fetch appointment data from the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

        String sql = "SELECT id, patient_name, doctor_id, appointment_date, appointment_time, reason, status FROM appointments WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(appointmentId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Add appointment details to the PDF
            document.add(new Paragraph("Appointment ID: " + rs.getInt("id")));
            document.add(new Paragraph("Patient Name: " + rs.getString("patient_name")));
            document.add(new Paragraph("Doctor ID: " + rs.getInt("doctor_id")));
            document.add(new Paragraph("Date: " + rs.getDate("appointment_date")));
            document.add(new Paragraph("Time: " + rs.getTime("appointment_time")));
            document.add(new Paragraph("Reason: " + rs.getString("reason")));
            document.add(new Paragraph("Status: " + rs.getString("status")));
        } else {
            document.add(new Paragraph("No appointment found with ID: " + appointmentId));
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}

        document.close();
    }
%>
