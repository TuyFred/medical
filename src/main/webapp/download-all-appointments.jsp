<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="application/pdf" %>

<%
    // Setting up the PDF response
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=appointments.pdf");

    Document document = new Document();
    try {
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Add document title
        Font font = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
        Paragraph title = new Paragraph("Appointment List", font);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" ")); // Add a blank line

        // Create a table with 7 columns
        PdfPTable table = new PdfPTable(7);
        table.setWidthPercentage(100);

        // Add table headers
        table.addCell("ID");
        table.addCell("Patient Name");
        table.addCell("Doctor ID");
        table.addCell("Date");
        table.addCell("Time");
        table.addCell("Reason");
        table.addCell("Status");

        // Fetch data from the database
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
            String sql = "SELECT id, patient_name, doctor_id, appointment_date, appointment_time, reason, status FROM appointments";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                table.addCell(String.valueOf(rs.getInt("id")));
                table.addCell(rs.getString("patient_name"));
                table.addCell(String.valueOf(rs.getInt("doctor_id")));
                table.addCell(rs.getDate("appointment_date").toString());
                table.addCell(rs.getTime("appointment_time").toString());
                table.addCell(rs.getString("reason"));
                table.addCell(rs.getString("status"));
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }

        // Add the table to the document
        document.add(table);

    } catch (DocumentException e) {
        e.printStackTrace();
    } finally {
        document.close();
    }
%>
