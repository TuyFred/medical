<%@ page import="java.io.*, java.sql.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%
    // Set the response content type to application/pdf
    response.setContentType("application/pdf");

    // Set the content disposition to indicate a file attachment with the specified name
    response.setHeader("Content-Disposition", "attachment; filename=doctor-list.pdf");

    // Create a new Document object
    Document document = new Document();

    try {
        // Initialize PDF writer
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Add a title to the document
        document.add(new Paragraph("Doctors List"));
        document.add(new Paragraph(" ")); // Empty line

        // Connect to the database
        String dbURL = "jdbc:mysql://localhost:3306/patient_portal";
        String dbUser = "root";
        String dbPassword = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            String sql = "SELECT * FROM doctors";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // Add table headers
            PdfPTable table = new PdfPTable(5); // 5 columns
            table.addCell("ID");
            table.addCell("First Name");
            table.addCell("Last Name");
            table.addCell("Specialty");
            table.addCell("Email");

            // Add data to the table
            while (rs.next()) {
                table.addCell(String.valueOf(rs.getInt("id")));
                table.addCell(rs.getString("first_name"));
                table.addCell(rs.getString("last_name"));
                table.addCell(rs.getString("specialty"));
                table.addCell(rs.getString("email"));
            }

            // Add the table to the document
            document.add(table);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        document.close();
    }
%>
