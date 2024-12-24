<%@ page import="java.io.*, java.sql.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%
    // Get the appointment ID from the request
    String appointmentId = request.getParameter("id");

    // Database connection variables
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Database connection setup
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

        // SQL query to fetch the appointment details
        String sql = "SELECT id, patient_name, doctor_id, appointment_date, appointment_time, reason, status FROM appointments WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, appointmentId);
        rs = pstmt.executeQuery();

        // Set the content type for PDF file download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment;filename=appointment_" + appointmentId + ".pdf");

        // Create a Document object
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());

        // Open the document
        document.open();

        // Add content to the PDF
        if (rs.next()) {
            document.add(new Paragraph("Appointment Details"));
            document.add(new Paragraph(" "));

            document.add(new Paragraph("ID: " + rs.getInt("id")));
            document.add(new Paragraph("Patient Name: " + rs.getString("patient_name")));
            document.add(new Paragraph("Doctor ID: " + rs.getInt("doctor_id")));
            document.add(new Paragraph("Appointment Date: " + rs.getDate("appointment_date")));
            document.add(new Paragraph("Appointment Time: " + rs.getTime("appointment_time")));
            document.add(new Paragraph("Reason: " + rs.getString("reason")));
            document.add(new Paragraph("Status: " + rs.getString("status")));
        } else {
            document.add(new Paragraph("No appointment found with ID: " + appointmentId));
        }

        // Close the document
        document.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close database resources
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
