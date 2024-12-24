<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Appointment</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
        }
        form .form-group {
            margin-bottom: 15px;
        }
        .btn {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Add Appointment</h2>
    <form action="addAppointment.jsp" method="post" class="needs-validation" novalidate>
        <div class="form-group">
            <label for="patient_name">Patient Name:</label>
            <input type="text" class="form-control" id="patient_name" name="patient_name" required>
            <div class="invalid-feedback">Please enter the patient's name.</div>
        </div>
        <div class="form-group">
            <label for="doctor_name">Doctor Name:</label>
            <input type="text" class="form-control" id="doctor_name" name="doctor_name" required>
            <div class="invalid-feedback">Please enter the doctor's name.</div>
        </div>
        <div class="form-group">
            <label for="appointment_date">Appointment Date:</label>
            <input type="date" class="form-control" id="appointment_date" name="appointment_date" required>
            <div class="invalid-feedback">Please select an appointment date.</div>
        </div>
        <div class="form-group">
            <label for="appointment_time">Appointment Time:</label>
            <input type="time" class="form-control" id="appointment_time" name="appointment_time" required>
            <div class="invalid-feedback">Please select an appointment time.</div>
        </div>
        <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Add Appointment</button>
    </form>

    <%
        if(request.getMethod().equalsIgnoreCase("POST")) {
            String patientName = request.getParameter("patient_name");
            String doctorName = request.getParameter("doctor_name");
            String appointmentDate = request.getParameter("appointment_date");
            String appointmentTime = request.getParameter("appointment_time");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient_portal", "root", "");
                
                String sql = "INSERT INTO appointments (patient_name, doctor_name, appointment_date, appointment_time) VALUES (?, ?, ?, ?)";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, patientName);
                statement.setString(2, doctorName);
                statement.setDate(3, Date.valueOf(appointmentDate));
                statement.setTime(4, Time.valueOf(appointmentTime));

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<div class='alert alert-success mt-4'>Appointment added successfully!</div>");
                } else {
                    out.println("<div class='alert alert-danger mt-4'>Error adding appointment.</div>");
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger mt-4'>Error: " + e.getMessage() + "</div>");
            }
        }
    %>

    <script>
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</body>
</html>
