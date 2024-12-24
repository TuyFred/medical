package insertAppointmentServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/insertAppointment")
public class InsertAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_id = request.getParameter("user_id");
        String patient_name = request.getParameter("patient_name");
        String doctor_id = request.getParameter("doctor_id");
        String appointment_date = request.getParameter("appointment_date");
        String appointment_time = request.getParameter("appointment_time");
        String reason = request.getParameter("reason");
        String status = request.getParameter("status");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");

            String sql = "INSERT INTO appointments (user_id, patient_name, doctor_id, doctor, appointment_date, appointment_time, reason, status) VALUES (?, ?, ?, (SELECT name FROM doctors WHERE id = ?), ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(user_id));
            pstmt.setString(2, patient_name);
            pstmt.setInt(3, Integer.parseInt(doctor_id));
            pstmt.setInt(4, Integer.parseInt(doctor_id)); // Fix this line if needed
            pstmt.setDate(5, java.sql.Date.valueOf(appointment_date));
            pstmt.setTime(6, java.sql.Time.valueOf(appointment_time));
            pstmt.setString(7, reason);
            pstmt.setString(8, status);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("insertAppointment.jsp?status=success");
            } else {
                response.sendRedirect("insertAppointment.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("insertAppointment.jsp?status=error");
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
