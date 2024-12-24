<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Online Medical Facility</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .contact-form {
            margin: 50px auto;
            padding: 30px;
            max-width: 600px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.1);
        }
        .contact-form h2 {
            margin-bottom: 30px;
            font-size: 28px;
            color: #343a40;
            font-weight: 700;
        }
        .contact-form .form-group label {
            font-weight: 600;
            color: #495057;
        }
        .contact-form .form-control {
            border-radius: 5px;
        }
        .contact-form .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 5px;
            padding: 10px 20px;
        }
        .contact-form .btn-primary i {
            margin-right: 5px;
        }
        .back-to-home {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
        .back-to-home a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }
        .back-to-home a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="contact-form">
            <h2><i class="fas fa-envelope"></i> Contact Us</h2>
            <form action="processContact.jsp" method="post">
                <div class="form-group">
                    <label for="name"><i class="fas fa-user"></i> Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                </div>
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="message"><i class="fas fa-comment"></i> Message</label>
                    <textarea class="form-control" id="message" name="message" rows="5" placeholder="Write your message" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Send Message</button>
            </form>
            <div class="back-to-home">
                <a href="index.html"><i class="fas fa-arrow-left"></i> Back to Home</a>
            </div>
        </div>
    </div>
</body>
</html>
