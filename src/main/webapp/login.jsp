<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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
            max-width: 350px;
            margin: 40px auto;
            padding: 15px;
            background: rgba(0, 0, 0, 0.7);
            border-radius: 8px;
        }
        .form-container h2 {
            margin-top: 0;
            color: #fff;
        }
        .form-container .form-group label {
            color: #fff;
        }
        .form-container .form-control {
            background: #fff;
            border: 1px solid #ddd;
            color: #000;
        }
        .form-container .btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .form-container .btn:hover {
            background-color: #0056b3;
        }
        .form-container .link {
            text-align: center;
            margin-top: 15px;
        }
        .form-container .link a {
            color: #17a2b8;
            text-decoration: none;
        }
        .form-container .link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2 class="text-center"><i class="fas fa-sign-in-alt"></i> Login Here</h2>
            <form action="login-process.jsp" method="post">
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email:</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="role"><i class="fas fa-user-cog"></i> Role:</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" id="role-patient" name="role" value="patient" checked>
                        <label class="form-check-label" for="role-patient">
                            Patient
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" id="role-admin" name="role" value="admin">
                        <label class="form-check-label" for="role-admin">
                            Admin
                        </label>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
                <div class="link mt-3">
                    <p>Don't have an account? <a href="register.jsp">Sign up here</a></p>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
