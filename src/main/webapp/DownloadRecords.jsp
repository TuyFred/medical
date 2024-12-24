<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>
<%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    // Set response content type to PDF
    response.setContentType("application/pdf");

    // Set the response header to prompt the user to download the file
    response.setHeader("Content-Disposition", "attachment; filename=users_records.pdf");

    // Create the PDF document
    Document document = new Document();
    try {
        // Get the OutputStream to write the PDF content
        OutputStream pdfOut = response.getOutputStream();

        // Initialize PDF writer
        PdfWriter.getInstance(document, pdfOut);

        // Open the document
        document.open();

        // Add title
        document.add(new Paragraph("Users Records", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Font.BOLD, BaseColor.BLACK)));
        document.add(new Paragraph(" "));
        
        // Create a table with the appropriate number of columns
        PdfPTable table = new PdfPTable(5); // 5 columns: First Name, Last Name, Email, Password, Actions
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);

        // Set column widths
        float[] columnWidths = {1f, 2f, 2f, 3f, 1f};
        table.setWidths(columnWidths);

        // Add table headers
        table.addCell("No");
        table.addCell("First Name");
        table.addCell("Last Name");
        table.addCell("Email");
        table.addCell("Password");

        // Connect to the database and retrieve user data
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        String sql = "SELECT * FROM users";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        int count = 1;
        while (rs.next()) {
            // Add rows to the table
            table.addCell(String.valueOf(count++));
            table.addCell(rs.getString("first_name"));
            table.addCell(rs.getString("last_name"));
            table.addCell(rs.getString("email"));
            table.addCell(rs.getString("password"));
        }

        // Add table to document
        document.add(table);
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        document.close();
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
