<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/h.jpg');
            background-size: cover;
            background-position: center;
            color: #fff;
            margin: 0;
            padding: 0;
        }
        .form-container {
            max-width: 350px; /* Reduced max-width for a smaller form */
            margin: 50px auto;
            padding: 15px; /* Reduced padding */
            background: rgba(0, 0, 0, 0.7);
            border-radius: 8px;
        }
        .form-container h2 {
            margin-top: 0;
            color: #fff;
            font-size: 25px; /* Adjusted font size */
        }
        .form-container .form-group {
            position: relative;
        }
        .form-container .form-group i {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            color: #666;
        }
        .form-container .form-control {
            padding-left: 35px; /* Adjusted padding for the icon */
            font-size: 14px; /* Smaller font size */
        }
        .form-container button {
            width: 100%;
            padding: 8px; /* Reduced padding for buttons */
            border: none;
            border-radius: 4px;
            background-color: #28a745;
            color: #fff;
            font-size: 15px; /* Adjusted font size */
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #218838;
        }
        .form-container .link {
            text-align: center;
            margin-top: 15px;
        }
        .form-container .link a {
            color: #17a2b8;
            text-decoration: none;
            font-size: 14px; /* Adjusted font size */
        }
        .form-container .link a:hover {
            text-decoration: underline;
        }
        .back-home {
            margin-top: 15px;
            text-align: center;
        }
        .back-home a {
            color: #fff;
            text-decoration: none;
            display: inline-block;
            padding: 5px 10px;
            background-color: #007bff;
            border-radius: 4px;
            font-size: 12px; /* Smaller font size for the button */
        }
        .back-home a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2 class="text-center">Register Here</h2>
            <form action="register-process.jsp" method="post">
                <div class="form-group">
                    <i class="fas fa-user"></i>
                    <label for="first-name">First Name:</label>
                    <input type="text" id="first-name" name="first_name" class="form-control" required>
                </div>
                <div class="form-group">
                    <i class="fas fa-user"></i>
                    <label for="last-name">Last Name:</label>
                    <input type="text" id="last-name" name="last_name" class="form-control" required>
                </div>
                <div class="form-group">
                    <i class="fas fa-envelope"></i>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <i class="fas fa-lock"></i>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-success">Register</button>
                <div class="link mt-3">
                    <p>Already have an account? <a href="login.jsp">Login here</a></p>
                </div>
            </form>
            <div class="back-home">
                <a href="index.html"><i class="fas fa-home"></i> Back to Home</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
